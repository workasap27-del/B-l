// État de l'appli. Deux sources :
// - les fiches de démonstration et leurs réservations, qui vivent dans le navigateur (localStorage) ;
// - les vrais comptes, fiches et réservations, qui vivent dans Supabase (composables/useBackend.ts).
// Les pages n'appellent que les fonctions de ce fichier, sans savoir d'où viennent les données.
import { computed, reactive, ref, watch } from 'vue'
import { DEMO_CLIENT, DEMO_PRO_ID, PROS, REVIEW_TEXTS, RULES, CLIENT_NAMES } from '~/data/pros'
import { hash, rng } from '~/data/random'
import type { Pro, Review, Service } from '~/data/pros'
import { PHOTO_POOLS, pexels } from '~/utils/photos'
import { shrinkImage } from '~/utils/image'
import { readReliability } from '~/utils/reliability'
import type { Reliability } from '~/utils/reliability'
import { addDays, ceil30, discounted, freeStarts, gaps, isClosed, simulatedAppointments, spansOverlap } from '~/utils/schedule'
import type { Interval, Span } from '~/utils/schedule'
import { allowedPlaces, proPlace, travelFee } from '~/utils/places'
import type { Place } from '~/utils/places'
import { arrivalState, clampLate, deadline, TOLERANCE } from '~/utils/arrival'
import type { ArrivalFields } from '~/utils/arrival'
import { communePoint, inGuadeloupe, roadKm } from '~/utils/geo'
import type { LatLng } from '~/utils/geo'
import { gpParts } from '~/utils/time'
import { cleanSiren, validSiren } from '~/utils/siren'
import * as api from '~/composables/useBackend'
import type { Profile, RemoteBooking, RemoteReview } from '~/composables/useBackend'

export interface Booking extends ArrivalFields {
  id: string
  proId: string
  sid: string
  date: string
  time: number
  dur: number
  /** total à payer, frais de déplacement compris */
  price: number
  deposit: number
  mode: 'classic' | 'lm'
  status: 'confirmed' | 'cancelled'
  reviewed: boolean
  /** chez le prestataire ou chez la cliente */
  place: Place
  address?: string
  /** frais de déplacement compris dans le prix */
  fee: number
  /** ce que la cliente signale au prestataire */
  note?: string
  /** réservation enregistrée dans la base (vrai prestataire) */
  real?: boolean
  clientId?: string
  clientName?: string
  clientPhone?: string
}

export interface Slot {
  id: string
  proId: string
  sid: string
  date: string
  time: number
  disc: number
  status: 'open' | 'booked'
  by: 'seed' | 'pro'
  real?: boolean
}

export interface AgendaItem {
  a: number
  b: number
  kind: 'rdv' | 'app' | 'lm' | 'gap'
  who?: string
  what?: string
  price?: number
  deposit?: number
  mode?: 'classic' | 'lm'
  disc?: number
  id?: string
  place?: Place
  address?: string
  bookingId?: string
  phone?: string
  note?: string
}

interface State {
  bookings: Booking[]
  slots: Slot[]
  fav: Record<string, boolean>
  reviews: Record<string, Review[]>
  seq: number
  seededFor: string
  /** heure simulée en minutes depuis minuit, ou null pour l'heure réelle */
  sim: number | null
  /** réservations reçues par le pro de démo et pas encore vues */
  unseen: number
  /** dernière adresse saisie pour une prestation à domicile */
  address: string
  /** charte graphique en test */
  charte: string
  /** thème visuel complet du mode présentation (accueil, recherche, fiches, réservation) */
  theme: string
  /** d'où l'on mesure les distances : la position du téléphone ou le centre d'une commune */
  pos: LatLng & { label: string, gps: boolean }
  /** mode démonstration : fiches fictives visibles (ouvert par le lien ?demo=1, fermé par ?demo=0) */
  demo: boolean
  /** présentation : masquer le prochain rendez-vous sur l'accueil */
  demoNoRdv: boolean
}

const STORAGE_KEY = 'vladi-v3'

function blank(): State {
  return {
    bookings: [], slots: [], fav: {}, reviews: {}, seq: 100, seededFor: '', sim: null, unseen: 0, address: '',
    charte: 'noir', theme: 'terracotta', pos: { ...communePoint(DEMO_CLIENT.commune), label: DEMO_CLIENT.commune, gps: false }, demo: false, demoNoRdv: false,
  }
}

const state = reactive<State>(blank())

/** Ce qui vient de la base : jamais enregistré dans le navigateur. */
const remote = reactive({
  online: false,
  loading: true,
  profile: null as Profile | null,
  pros: [] as Pro[],
  ratings: {} as Record<string, { rating: number, count: number }>,
  myPro: null as Pro | null,
  bookings: [] as Booking[],
  slots: [] as Slot[],
  busy: {} as Record<string, Record<string, [number, number][]>>,
  reviews: {} as Record<string, RemoteReview[]>,
  photos: {} as Record<string, api.ProPhoto[]>,
  reviewed: [] as string[],
  /** vrai quand la personne arrive depuis le lien de réinitialisation du mot de passe */
  recovery: false,
  /** compte propriétaire de l'appli : accès au pilotage */
  admin: false,
})

const clock = ref(new Date())
const toastMessage = ref('')
let toastTimer: ReturnType<typeof setTimeout> | undefined
let started = false

const today = computed(() => gpParts(clock.value).date)
const nowMin = computed(() => state.sim ?? gpParts(clock.value).min)

/** Tous les prestataires visibles : les vrais, plus les fiches fictives en mode démonstration. */
const catalogue = computed<Pro[]>(() => [...remote.pros, ...(state.demo ? PROS : [])])

function pro(id: string): Pro | undefined {
  return remote.pros.find(p => p.id === id) ?? (remote.myPro?.id === id ? remote.myPro : undefined) ?? PROS.find(p => p.id === id)
}

function service(p: Pro, sid: string): Service | undefined {
  return p.services.find(x => x.id === sid)
}

function isMine(p: Pro): boolean {
  return !!remote.profile && p.ownerId === remote.profile.id
}

// Avis ----------------------------------------------------------------------

function baseReviews(p: Pro): Review[] {
  const r = rng(hash(`rev${p.id}`))
  const pool = [...REVIEW_TEXTS[p.cats[0]]]
  return [0, 1, 2].map(i => ({
    a: CLIENT_NAMES[Math.floor(r() * CLIENT_NAMES.length)],
    s: i === 1 && p.rating < 4.7 ? 4 : 5,
    t: pool.splice(Math.floor(r() * pool.length), 1)[0],
  }))
}

function reviewsOf(p: Pro): Review[] {
  if (p.real) return (remote.reviews[p.id] ?? []).map(r => ({ id: r.id, a: 'Avis vérifié', s: r.stars, t: r.body || 'Sans commentaire.', reply: r.reply || undefined }))
  return [...(state.reviews[p.id] ?? []), ...baseReviews(p)]
}

function ratingOf(p: Pro): { rating: number, count: number } {
  if (p.real) return remote.ratings[p.id] ?? { rating: 0, count: 0 }
  const mine = state.reviews[p.id] ?? []
  const sum = p.rating * p.nrev + mine.reduce((a, r) => a + r.s, 0)
  const count = p.nrev + mine.length
  return { rating: Math.round((sum / count) * 10) / 10, count }
}

async function loadReviewsFor(p: Pro) {
  if (!p.real || !remote.online) return
  remote.reviews[p.id] = await api.loadReviews(p.id)
}

/** Réponse du prestataire à un avis de sa fiche. */
async function replyToReview(p: Pro, reviewId: string, text: string): Promise<boolean> {
  try {
    await api.replyReview(reviewId, text)
    await loadReviewsFor(p)
    toast(text.trim() ? 'Réponse publiée' : 'Réponse retirée')
    return true
  }
  catch (e) {
    toast(api.readable(e))
    return false
  }
}

// Photos des fiches -------------------------------------------------------------

/** Galerie d'une fiche : photos déposées (fiches réelles) ou photos du métier (fiches de démonstration). */
function photosOf(p: Pro): { id: string, url: string, thumb: string }[] {
  if (p.real) return (remote.photos[p.id] ?? []).map(x => ({ id: x.id, url: x.url, thumb: x.url }))
  const pool = PHOTO_POOLS[p.cats[0]] ?? []
  const start = hash(`gal${p.id}`) % Math.max(pool.length, 1)
  return Array.from({ length: Math.min(6, pool.length) }, (_, i) => pool[(start + i * 2) % pool.length])
    .filter((x, i, all) => all.indexOf(x) === i)
    .map(id => ({ id: String(id), url: pexels(id, 1200, 1200), thumb: pexels(id, 320, 320) }))
}

async function loadPhotosFor(p: Pro) {
  if (!p.real || !remote.online) return
  remote.photos[p.id] = await api.loadPhotos(p.id)
}

/** Ajoute des photos à la fiche du compte, réduites dans le navigateur (1600 px, JPEG, sans données de localisation). */
async function addPhotos(files: File[]): Promise<number> {
  const p = remote.myPro
  if (!p) return 0
  const list = remote.photos[p.id] ?? (remote.photos[p.id] = [])
  let added = 0
  for (const f of files) {
    if (list.length >= 12) {
      toast('Douze photos au plus par fiche')
      break
    }
    if (!/^image\//.test(f.type)) continue
    try {
      const blob = await shrinkImage(f, 1600, 0.82)
      const photo = await api.uploadPhoto(p.id, blob, list.length)
      list.push(photo)
      added++
      if (!p.photo) {
        await api.setCover(p.id, photo.url)
        p.photo = photo.url
      }
    }
    catch (e) {
      toast(api.readable(e))
      break
    }
  }
  if (added) toast(added > 1 ? `${added} photos ajoutées` : 'Photo ajoutée')
  return added
}

async function removePhoto(photo: api.ProPhoto) {
  const p = remote.myPro
  if (!p) return
  try {
    await api.deletePhoto(photo)
    remote.photos[p.id] = (remote.photos[p.id] ?? []).filter(x => x.id !== photo.id)
    if (p.photo === photo.url) {
      const next = remote.photos[p.id][0]?.url ?? null
      await api.setCover(p.id, next)
      p.photo = next ?? undefined
    }
    toast('Photo retirée')
  }
  catch (e) {
    toast(api.readable(e))
  }
}

async function makeCover(photo: api.ProPhoto) {
  const p = remote.myPro
  if (!p) return
  try {
    await api.setCover(p.id, photo.url)
    p.photo = photo.url
    const live = remote.pros.find(x => x.id === p.id)
    if (live) live.photo = photo.url
    toast('Photo de couverture changée')
  }
  catch (e) {
    toast(api.readable(e))
  }
}

// Fiabilité et blocage ---------------------------------------------------------------

const trustCache = reactive<Record<string, Reliability>>({})

/** Fiabilité de la personne qui a fait une réservation reçue par le prestataire. */
async function reliabilityFor(b: Booking): Promise<Reliability | null> {
  if (!b.real) return null
  if (trustCache[b.id]) return trustCache[b.id]
  try {
    trustCache[b.id] = readReliability(await api.clientReliability(b.id))
    return trustCache[b.id]
  }
  catch {
    return null
  }
}

async function myReliability(): Promise<Reliability | null> {
  if (!remote.online || !account.value) return null
  try {
    return readReliability(await api.myReliability())
  }
  catch {
    return null
  }
}

const blocked = ref<string[]>([])
async function loadBlocked() {
  blocked.value = remote.myPro ? await api.loadBlocks(remote.myPro.id) : []
}
async function setBlocked(clientId: string, on: boolean) {
  const p = remote.myPro
  if (!p) return
  try {
    if (on) await api.blockClient(p.id, clientId)
    else await api.unblockClient(p.id, clientId)
    blocked.value = on ? [...new Set([...blocked.value, clientId])] : blocked.value.filter(x => x !== clientId)
    toast(on ? 'Cette personne ne pourra plus réserver chez toi' : 'Blocage levé')
  }
  catch (e) {
    toast(api.readable(e))
  }
}

/** Compte une visite de fiche, une fois par session et par fiche. */
function countView(p: Pro) {
  if (!p.real || !remote.online) return
  const key = `vladi-vue-${p.id}`
  try {
    if (sessionStorage.getItem(key)) return
    sessionStorage.setItem(key, '1')
  }
  catch { /* navigation privée : on compte quand même */ }
  void api.trackView(p.id)
}

// Signalements -------------------------------------------------------------------

async function reportContent(input: { proId?: string, reviewId?: string, reason: string }): Promise<boolean> {
  if (!remote.online || !account.value) {
    toast('Connecte-toi pour signaler un contenu')
    return false
  }
  try {
    await api.report(input)
    toast('Merci, ton signalement a été transmis')
    return true
  }
  catch (e) {
    toast(api.readable(e))
    return false
  }
}

// Disponibilités ------------------------------------------------------------

/** Intervalles occupés chez un pro un jour donné. */
function taken(p: Pro, date: string): Interval[] {
  if (p.real) return [...(remote.busy[p.id]?.[date] ?? [])]
  const out: Interval[] = simulatedAppointments(p, date).map(x => [x.a, x.b])
  for (const b of state.bookings) {
    if (b.proId === p.id && b.date === date && b.status === 'confirmed') out.push([b.time, b.time + b.dur])
  }
  for (const s of state.slots) {
    if (s.proId === p.id && s.date === date && s.status === 'open') out.push([s.time, s.time + (service(p, s.sid)?.d ?? 30)])
  }
  return out
}

function starts(p: Pro, date: string, duration: number): number[] {
  if (date < today.value) return []
  return freeStarts(p, date, duration, taken(p, date), date === today.value ? nowMin.value + 30 : 0)
}

function openSlots(proId?: string): Slot[] {
  const demo = state.demo ? state.slots : []
  return [...remote.slots, ...demo]
    .filter(s => s.status === 'open' && s.date === today.value && s.time >= nowMin.value + 10 && (!proId || s.proId === proId) && !!pro(s.proId))
    .sort((a, b) => a.time - b.time)
}

/** Créneaux Konyéla des fiches d'exemple, recalculés quand le jour ou l'heure simulée change. */
function seedSlots(force = false) {
  const key = `${today.value}|${state.sim ?? 'réel'}`
  if (!force && state.seededFor === key) return
  state.slots = state.slots.filter(s => s.date === today.value && (s.by === 'pro' || s.status === 'booked'))
  // Chaque jour, environ un prestataire sur cinq libère un créneau de dernière minute.
  PROS.forEach((p, i) => {
    if (p.id === DEMO_PRO_ID) return
    const h = hash(`${today.value}|k|${p.id}`)
    if (h % 5 !== 0) return
    const sv = p.services[(h >>> 4) % p.services.length]
    const options = starts(p, today.value, sv.d).filter(t => t <= nowMin.value + 270)
    if (!options.length) return
    state.slots.push({ id: `s${today.value}-${p.id}`, proId: p.id, sid: sv.id, date: today.value, time: options[Math.min(i % 2, options.length - 1)], disc: [20, 25, 30, 40][(h >>> 8) % 4], status: 'open', by: 'seed' })
  })
  state.seededFor = key
}

function seedBookings() {
  // Un rendez-vous passé (pour tester l'avis) et un à venir, chez des fiches d'exemple.
  const reg = pro('reg')!
  let past = addDays(today.value, -1)
  while (isClosed(reg, past)) past = addDays(past, -1)
  const lift = service(reg, 'd')!
  state.bookings.push({ id: `l${++state.seq}`, proId: 'reg', sid: 'd', date: past, time: 1020, dur: lift.d, price: lift.p, deposit: Math.round(lift.p * RULES.depositRate), mode: 'classic', status: 'confirmed', reviewed: false, place: 'pro', fee: 0 })
  const hib = pro('hib')!
  const brush = service(hib, 'a')!
  for (let n = 3; n < 10; n++) {
    const date = addDays(today.value, n)
    const free = starts(hib, date, brush.d).filter(t => t >= 600)
    if (free.length) {
      state.bookings.push({ id: `l${++state.seq}`, proId: 'hib', sid: 'a', date, time: free[0], dur: brush.d, price: brush.p, deposit: Math.round(brush.p * RULES.depositRate), mode: 'classic', status: 'confirmed', reviewed: false, place: 'pro', fee: 0 })
      break
    }
  }
}

// Position et distances -----------------------------------------------------

/** Distance estimée par la route entre l'utilisateur et le prestataire, en km. */
function km(p: Pro): number {
  return roadKm(state.pos, p)
}

function setCommune(name: string) {
  state.pos = { ...communePoint(name), label: name, gps: false }
}

/** Demande la position du téléphone. Renvoie un message d'erreur lisible, ou null si tout va bien. */
function locate(): Promise<string | null> {
  return new Promise((resolve) => {
    if (typeof navigator === 'undefined' || !navigator.geolocation) return resolve("La localisation n'est pas disponible sur cet appareil.")
    navigator.geolocation.getCurrentPosition(
      (g) => {
        const here = { lat: g.coords.latitude, lng: g.coords.longitude }
        if (!inGuadeloupe(here)) return resolve("Tu n'es pas en Guadeloupe en ce moment : choisis une commune pour voir les distances.")
        state.pos = { ...here, label: 'Ma position', gps: true }
        resolve(null)
      },
      () => resolve('Position refusée ou introuvable. Choisis une commune à la place.'),
      { enableHighAccuracy: false, timeout: 8000, maximumAge: 300000 },
    )
  })
}

/** Position du téléphone pour une fiche (sans la garder comme point de départ des distances). */
function currentPosition(): Promise<LatLng | null> {
  return new Promise((resolve) => {
    if (typeof navigator === 'undefined' || !navigator.geolocation) return resolve(null)
    navigator.geolocation.getCurrentPosition(
      g => resolve({ lat: g.coords.latitude, lng: g.coords.longitude }),
      () => resolve(null),
      { enableHighAccuracy: true, timeout: 10000 },
    )
  })
}

/** Les prochains créneaux libres d'une prestation, sur une semaine. */
function nextSlots(p: Pro, sv: Service, count = 3): { date: string, time: number }[] {
  const out: { date: string, time: number }[] = []
  for (let n = 0; n < 7 && out.length < count; n++) {
    const date = addDays(today.value, n)
    for (const time of starts(p, date, sv.d)) {
      out.push({ date, time })
      if (out.length >= count) break
    }
  }
  return out
}

/** "Ouvert, ferme à 19h00", "Ouvre à 9h00", "Fermé aujourd'hui". */
function openStatus(p: Pro): { open: boolean, text: string } {
  if (isClosed(p, today.value)) return { open: false, text: "Fermé aujourd'hui" }
  if (nowMin.value < p.open) return { open: false, text: `Ouvre à ${hmText(p.open)}` }
  if (nowMin.value < p.close) return { open: true, text: `Ouvert jusqu'à ${hmText(p.close)}` }
  return { open: false, text: 'Fermé pour ce soir' }
}

function hmText(t: number): string {
  const m = t % 60
  return `${Math.floor(t / 60)}h${m < 10 ? '0' : ''}${m}`
}

// Réservations --------------------------------------------------------------

function fromRemote(r: RemoteBooking): Booking {
  return { ...r, reviewed: remote.reviewed.includes(r.id), real: true }
}

/** Réservations de la personne connectée. Rien sans compte, et les réservations fictives seulement en démonstration. */
const myBookings = computed<Booking[]>(() => (remote.profile
  ? [...(state.demo ? state.bookings : []), ...remote.bookings.filter(b => b.clientId === remote.profile?.id)]
  : []))

function isDone(b: Booking): boolean {
  return b.status === 'confirmed' && (!!b.noShow || b.disputed === true || b.date < today.value || (b.date === today.value && b.time + b.dur <= nowMin.value))
}

function minutesUntil(b: Booking): number {
  const days = Math.round((new Date(`${b.date}T00:00:00`).getTime() - new Date(`${today.value}T00:00:00`).getTime()) / 86400000)
  return days * 1440 + b.time - nowMin.value
}

/** Acompte remboursé si la réservation classique est annulée plus de 24 h avant. */
function refundable(b: Booking): boolean {
  return b.mode !== 'lm' && minutesUntil(b) > RULES.freeCancelHours * 60
}

/** Où se passera le rendez-vous, en clair. */
function placeLabel(b: Booking): string {
  const p = pro(b.proId)
  if (b.place === 'client') return `À domicile${b.address ? ` · ${b.address}` : ''}`
  return p ? `${proPlace(p) ?? 'Sur place'} · ${p.quartier ? `${p.quartier}, ` : ''}${p.commune}` : 'Sur place'
}

function findBooking(id: string): Booking | undefined {
  return state.bookings.find(x => x.id === id) ?? remote.bookings.find(x => x.id === id)
}

export interface BookInput { proId: string, sid: string, date: string, time: number, slotId?: string, place: Place, address?: string, note?: string, replaceId?: string }

/** Rendez-vous à venir de la personne connectée qui chevauche cette plage, s'il y en a un. */
function clashWith(span: Span): Booking | undefined {
  return myBookings.value.find(b => b.status === 'confirmed' && !isDone(b) && spansOverlap(b, span))
}

/** Réserve. Renvoie la réservation, ou un message d'erreur ('connexion' si un compte est nécessaire, 'chevauchement' si un autre rendez-vous tombe à la même heure). */
async function book(input: BookInput): Promise<{ booking?: Booking, error?: string }> {
  const sv0 = pro(input.proId) && service(pro(input.proId)!, input.sid)
  const clash = sv0 && remote.profile ? clashWith({ date: input.date, time: input.time, dur: sv0.d }) : undefined
  if (clash) {
    // Deux rendez-vous à la même heure sont impossibles : il faut remplacer l'ancien ou choisir une autre heure.
    if (input.replaceId !== clash.id) return { error: 'chevauchement' }
    if (!(await change(clash.id, { status: 'cancelled' }))) return { error: 'L\'ancien rendez-vous n\'a pas pu être annulé. Réessaie.' }
  }
  const res = await bookNew(input)
  // Si la nouvelle réservation échoue, l'ancien rendez-vous de présentation est rétabli.
  if (clash && !res.booking && !clash.real) clash.status = 'confirmed'
  return res
}

async function bookNew(input: BookInput): Promise<{ booking?: Booking, error?: string }> {
  const p = pro(input.proId)
  const sv = p && service(p, input.sid)
  if (!p || !sv) return { error: 'Prestation introuvable.' }
  if (isMine(p)) return { error: 'C\'est ta propre fiche : tu ne peux pas réserver chez toi.' }
  if (!allowedPlaces(p).includes(input.place)) return { error: 'Ce lieu n\'est pas proposé par ce prestataire.' }
  const address = input.place === 'client' ? (input.address ?? '').trim() : undefined
  if (input.place === 'client' && (!address || address.length < 5)) return { error: 'Indique ton adresse.' }
  if (!remote.profile) return { error: 'connexion' }
  if (address) state.address = address

  if (p.real) {
    const me = remote.profile
    try {
      const r = input.slotId
        ? await api.bookSlot({ slotId: input.slotId, place: input.place, address, clientName: me.name, clientPhone: me.phone, note: input.note })
        : await api.createBooking({ clientId: me.id, clientName: me.name, clientPhone: me.phone, note: input.note, proId: p.id, sid: sv.id, date: input.date, time: input.time, dur: sv.d, place: input.place, address })
      const b = fromRemote(r)
      remote.bookings.push(b)
      void refreshAvailability()
      void api.notifyBooking(b.id)
      return { booking: b }
    }
    catch (e) {
      void refreshAvailability()
      return { error: api.readable(e) }
    }
  }

  // Fiche d'exemple : tout reste dans le navigateur.
  const fee = input.place === 'client' ? travelFee(p) : 0
  let price = sv.p
  if (input.slotId) {
    const slot = state.slots.find(s => s.id === input.slotId)
    if (!slot || slot.status !== 'open' || slot.time < nowMin.value + 10) return { error: 'Ce créneau vient de partir. Choisis-en un autre.' }
    slot.status = 'booked'
    price = discounted(sv, slot.disc)
  }
  else if (!starts(p, input.date, sv.d).includes(input.time)) {
    return { error: 'Ce créneau vient de partir. Choisis-en un autre.' }
  }
  price += fee
  const b: Booking = { id: `l${++state.seq}`, proId: p.id, sid: sv.id, date: input.date, time: input.time, dur: sv.d, price, deposit: Math.round(price * RULES.depositRate), mode: input.slotId ? 'lm' : 'classic', status: 'confirmed', reviewed: false, place: input.place, address, fee, note: input.note?.trim() || undefined }
  state.bookings.push(b)
  if (p.id === DEMO_PRO_ID) state.unseen++
  return { booking: b }
}

/** Applique une modification à une réservation, dans la base si elle y est. */
async function change(id: string, f: Partial<Pick<Booking, 'status' | 'arrivedAt' | 'confirmedAt' | 'lateBy' | 'waitUntil' | 'noShow' | 'disputed'>>): Promise<boolean> {
  const b = findBooking(id)
  if (!b) return false
  if (b.real) {
    try {
      await api.updateBooking(id, b.date, { ...f, status: f.status === 'cancelled' ? 'cancelled' : undefined })
    }
    catch (e) {
      toast(api.readable(e))
      return false
    }
  }
  Object.assign(b, f)
  if (b.real && f.status) void refreshAvailability()
  if (b.real && f.status === 'cancelled') void api.notifyBooking(b.id)
  return true
}

/** Qui se déplace : le client ou la cliente quand ça se passe chez le/la prestataire, le/la prestataire quand il ou elle vient à domicile. */
function traveler(b: Booking): 'client' | 'pro' {
  return b.place === 'client' ? 'pro' : 'client'
}
function arrival(b: Booking) {
  return arrivalState(b, nowMin.value, b.date === today.value)
}
const signalArrival = (id: string) => findBooking(id)?.arrivedAt === undefined && change(id, { arrivedAt: nowMin.value })
const confirmArrival = (id: string) => findBooking(id)?.arrivedAt !== undefined && change(id, { confirmedAt: nowMin.value })
const announceLate = (id: string, minutes: number) => change(id, { lateBy: clampLate(minutes) })
function waitMore(id: string) {
  const b = findBooking(id)
  return b && change(id, { waitUntil: deadline(b) + TOLERANCE })
}
function declareNoShow(id: string) {
  const b = findBooking(id)
  return b && change(id, { noShow: traveler(b) })
}
const dispute = (id: string) => change(id, { disputed: true })
const cancel = (id: string) => change(id, { status: 'cancelled' })

async function addReview(bookingId: string, stars: number, text: string) {
  const b = findBooking(bookingId)
  if (!b || b.reviewed) return
  if (b.real) {
    try {
      await api.addReview({ bookingId, proId: b.proId, clientId: remote.profile!.id, stars, body: text })
      remote.reviewed.push(bookingId)
      const p = pro(b.proId)
      if (p) await loadReviewsFor(p)
      const { ratings } = await api.loadPros()
      remote.ratings = ratings
    }
    catch (e) {
      toast(api.readable(e))
      return
    }
  }
  else {
    const list = state.reviews[b.proId] ?? (state.reviews[b.proId] = [])
    list.unshift({ a: firstName.value, s: stars, t: text.trim() || 'Sans commentaire.' })
  }
  b.reviewed = true
}

function toggleFav(id: string) {
  state.fav[id] = !state.fav[id]
}

// Espace prestataire --------------------------------------------------------

/** Fiche gérée dans l'espace pro : celle du compte connecté, sinon (en démonstration) la fiche fictive. */
const workPro = computed<{ pro: Pro, demo: boolean }>(() =>
  remote.myPro ? { pro: remote.myPro, demo: false } : { pro: PROS.find(p => p.id === DEMO_PRO_ID)!, demo: true },
)

/** Réservations reçues par la fiche du compte connecté. */
const proBookings = computed(() => remote.myPro ? remote.bookings.filter(b => b.proId === remote.myPro!.id) : [])

function agenda(date: string): AgendaItem[] {
  const { pro: p, demo } = workPro.value
  if (isClosed(p, date)) return []
  const items: AgendaItem[] = []
  if (demo) {
    for (const x of simulatedAppointments(p, date)) items.push({ a: x.a, b: x.b, kind: 'rdv', who: x.who, what: x.what, price: x.price })
    for (const b of state.bookings) {
      if (b.proId === p.id && b.date === date && b.status === 'confirmed') {
        items.push({ a: b.time, b: b.time + b.dur, kind: 'app', who: firstName.value, what: service(p, b.sid)?.n, price: b.price, deposit: b.deposit, mode: b.mode, place: b.place, address: b.address, bookingId: b.id, note: b.note })
      }
    }
  }
  else {
    for (const b of proBookings.value) {
      if (b.date === date && b.status === 'confirmed') {
        items.push({ a: b.time, b: b.time + b.dur, kind: 'app', who: b.clientName || 'Client·e', what: service(p, b.sid)?.n ?? 'Prestation', price: b.price, deposit: b.deposit, mode: b.mode, place: b.place, address: b.address, bookingId: b.id, phone: b.clientPhone, note: b.note })
      }
    }
  }
  const slots = demo ? state.slots : remote.slots
  for (const s of slots) {
    if (s.proId === p.id && s.date === date && s.status === 'open' && (date !== today.value || s.time >= nowMin.value + 10)) {
      const sv = service(p, s.sid)
      if (sv) items.push({ a: s.time, b: s.time + sv.d, kind: 'lm', what: sv.n, disc: s.disc, id: s.id })
    }
  }
  for (const [a, b] of gaps(p, items.map(i => [i.a, i.b] as Interval))) items.push({ a, b, kind: 'gap' })
  return items.sort((x, y) => x.a - y.a)
}

/** Première heure à laquelle un créneau Konyéla peut démarrer dans un trou. */
function earliestIn(gapStart: number): number {
  return ceil30(Math.max(gapStart, nowMin.value + 30))
}

async function publishSlot(sid: string, time: number, disc: number): Promise<boolean> {
  const { pro: p, demo } = workPro.value
  const sv = service(p, sid)
  if (!sv || !starts(p, today.value, sv.d).includes(time)) return false
  if (demo) {
    state.slots.push({ id: `p${++state.seq}`, proId: p.id, sid, date: today.value, time, disc, status: 'open', by: 'pro' })
    return true
  }
  try {
    await api.publishSlot(p.id, sid, today.value, time, disc)
    await refreshAvailability()
    return true
  }
  catch (e) {
    toast(api.readable(e))
    return false
  }
}

async function removeSlot(id: string) {
  const s = remote.slots.find(x => x.id === id)
  if (s) {
    try {
      await api.removeSlot(id)
      await refreshAvailability()
    }
    catch (e) {
      toast(api.readable(e))
    }
    return
  }
  state.slots = state.slots.filter(x => x.id !== id)
}

/** Mes créneaux Konyéla du jour (fiche gérée dans l'espace pro). */
const mySlots = computed(() => {
  const { pro: p, demo } = workPro.value
  return (demo ? state.slots : remote.slots).filter(s => s.proId === p.id && s.date === today.value).sort((a, b) => a.time - b.time)
})

// Comptes -------------------------------------------------------------------

const account = computed(() => remote.profile)
/** L'espace prestataire n'a rien à montrer : pas de fiche, et pas de démonstration en cours. */
const needsFiche = computed(() => !remote.myPro && !state.demo)
const firstName = computed(() => (remote.profile?.name ?? DEMO_CLIENT.firstName).split(' ')[0])

async function register(input: { email: string, password: string, name: string, role: 'client' | 'pro', phone?: string }): Promise<string | null> {
  try {
    await api.signUp(input)
    await refresh()
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

async function login(email: string, password: string): Promise<string | null> {
  try {
    await api.signIn(email, password)
    await refresh()
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

async function logout() {
  await api.signOut()
  remote.profile = null
  remote.myPro = null
  remote.bookings = []
  remote.reviewed = []
  remote.admin = false
}

async function newPassword(password: string): Promise<string | null> {
  try {
    await api.setPassword(password)
    remote.recovery = false
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

async function forgotPassword(email: string): Promise<string | null> {
  try {
    await api.resetPassword(email)
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

async function saveProfile(fields: { name?: string, phone?: string }): Promise<string | null> {
  if (!remote.profile) return 'Connecte-toi d\'abord.'
  try {
    await api.updateProfile(remote.profile.id, fields)
    await refresh()
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

/** Vérifie un SIREN dans le registre officiel. Renvoie l'entreprise, ou un message d'erreur lisible. */
async function checkSiren(raw: string): Promise<{ company?: api.Company, error?: string }> {
  const siren = cleanSiren(raw)
  if (!validSiren(siren)) return { error: 'Ce SIREN n\'est pas valide : vérifie les 9 chiffres.' }
  try {
    const company = await api.lookupCompany(siren)
    if (!company) return { error: 'Aucune entreprise immatriculée avec ce SIREN.' }
    if (!company.active) return { error: `${company.name} est cessée d'activité au registre : on ne peut pas publier cette fiche.` }
    return { company }
  }
  catch {
    return { error: 'Le registre des entreprises ne répond pas. Réessaie dans un instant.' }
  }
}

async function saveMyPro(f: api.ProInput): Promise<string | null> {
  if (!remote.profile) return 'Connecte-toi d\'abord.'
  try {
    await api.saveMyPro(remote.profile.id, f)
    if (remote.profile.role !== 'pro') await api.updateProfile(remote.profile.id, { role: 'pro' })
    await refresh()
    return null
  }
  catch (e) {
    return api.readable(e)
  }
}

// Chargement ----------------------------------------------------------------

async function refreshAvailability() {
  if (!remote.online) return
  try {
    const [busy, slots] = await Promise.all([api.loadBusy(today.value), api.loadOpenSlots()])
    remote.busy = busy
    remote.slots = slots.map(s => ({ ...s, status: 'open', by: 'pro', real: true }))
  }
  catch { /* réseau indisponible : on garde les dernières données */ }
}

/** Recharge tout ce qui vient de la base. */
async function refresh() {
  if (!api.sb()) {
    remote.loading = false
    return
  }
  remote.online = true
  try {
    const [profile, catalogueData] = await Promise.all([api.loadProfile(), api.loadPros()])
    remote.profile = profile
    remote.pros = catalogueData.pros
    remote.ratings = catalogueData.ratings
    if (profile) {
      const [myPro, bookings, mine, admin] = await Promise.all([api.loadMyPro(profile.id), api.loadBookings(), api.loadReviews(undefined, profile.id), api.isAdmin()])
      remote.admin = admin
      remote.myPro = myPro
      if (myPro) void api.loadPhotos(myPro.id).then((ph) => { remote.photos[myPro.id] = ph })
      remote.reviewed = mine.map(r => r.bookingId)
      remote.bookings = bookings.map(fromRemote)
    }
    else {
      remote.myPro = null
      remote.bookings = []
      remote.admin = false
    }
    await refreshAvailability()
  }
  catch { /* réseau indisponible : on garde ce qui est déjà affiché */ }
  finally {
    remote.loading = false
  }
}

function setSim(minutes: number | null) {
  state.sim = minutes === null ? null : Math.max(0, Math.min(minutes, 23 * 60 + 30))
  seedSlots()
}

function toast(message: string) {
  toastMessage.value = message
  clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toastMessage.value = '' }, 3200)
}

function reset() {
  const keep = { charte: state.charte, theme: state.theme, pos: state.pos }
  Object.assign(state, blank(), keep)
  seedBookings()
  seedSlots(true)
}

function start() {
  if (started) return
  started = true
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) {
      const saved = JSON.parse(raw)
      Object.assign(state, blank(), saved)
      if (!saved.pos || typeof saved.pos.lat !== 'number') state.pos = blank().pos
      // Une réservation dont la fiche d'exemple n'existe plus est écartée.
      state.bookings = state.bookings.filter(b => PROS.some(x => x.id === b.proId && x.services.some(v => v.id === b.sid)))
      state.slots = state.slots.filter(k => PROS.some(x => x.id === k.proId && x.services.some(v => v.id === k.sid)))
    }
  }
  catch { /* stockage indisponible : on repart de zéro */ }
  // Lien de présentation : ?demo=1 ouvre le mode démonstration, ?demo=0 le ferme.
  const flag = new URLSearchParams(window.location.search).get('demo')
  if (flag === '1') state.demo = true
  if (flag === '0') state.demo = false
  if (state.demo && !state.bookings.length) seedBookings()
  watch(() => state.demo, (on) => { if (on && !state.bookings.length) seedBookings() })
  seedSlots()
  watch(state, () => {
    try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)) }
    catch { /* ignore */ }
  }, { deep: true })
  // Premier enregistrement : le lien ?demo=1 et le thème survivent à une navigation par adresse.
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)) }
  catch { /* ignore */ }
  setInterval(() => { clock.value = new Date() }, 30000)
  watch(today, () => seedSlots())
  void refresh()
  api.onAuthChange((event) => {
    if (event === 'PASSWORD_RECOVERY') remote.recovery = true
    void refresh()
  })
  // Les réservations et les créneaux bougent : on recharge régulièrement.
  setInterval(() => {
    if (remote.profile) void api.loadBookings().then((b) => { remote.bookings = b.map(fromRemote) }).catch(() => {})
    void refreshAvailability()
  }, 60000)
}

export function useVladi() {
  start()
  return {
    state, remote, today, nowMin, toastMessage,
    pros: catalogue, pro, service, isMine, reviewsOf, ratingOf, loadReviewsFor, replyToReview,
    photosOf, loadPhotosFor, addPhotos, removePhoto, makeCover, reportContent,
    reliabilityFor, myReliability, blocked, loadBlocked, setBlocked, countView,
    starts, openSlots, isDone, refundable, minutesUntil, myBookings, findBooking,
    book, clashWith, cancel, addReview, toggleFav, placeLabel,
    km, setCommune, locate, currentPosition, nextSlots, openStatus,
    traveler, arrival, signalArrival, confirmArrival, announceLate, waitMore, declareNoShow, dispute,
    workPro, proBookings, agenda, earliestIn, publishSlot, removeSlot, mySlots,
    account, needsFiche, firstName, register, login, logout, forgotPassword, newPassword, saveProfile, saveMyPro, checkSiren, refresh,
    setSim, toast, reset,
  }
}
