// État de l'appli en mode démo : tout vit dans le navigateur (localStorage).
// Pour passer à Supabase, ce fichier est le seul point à remplacer : les pages n'appellent que ses fonctions.
import { computed, reactive, ref, watch } from 'vue'
import { DEMO_CLIENT, DEMO_PRO_ID, KONYELA_SEEDS, PROS, REVIEW_TEXTS, RULES, CLIENT_NAMES } from '~/data/pros'
import type { Pro, Review, Service } from '~/data/pros'
import { addDays, ceil30, dateKey, discounted, freeStarts, gaps, hash, isClosed, rng, simulatedAppointments } from '~/utils/schedule'
import type { Interval } from '~/utils/schedule'

export interface Booking {
  id: number
  proId: string
  sid: string
  date: string
  time: number
  dur: number
  price: number
  deposit: number
  mode: 'classic' | 'lm'
  status: 'confirmed' | 'cancelled'
  reviewed: boolean
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
}

const STORAGE_KEY = 'bel-v1'

function blank(): State {
  return { bookings: [], slots: [], fav: { kaz: true, reg: true }, reviews: {}, seq: 100, seededFor: '', sim: null, unseen: 0 }
}

const state = reactive<State>(blank())
const clock = ref(new Date())
const toastMessage = ref('')
let toastTimer: ReturnType<typeof setTimeout> | undefined
let started = false

const today = computed(() => dateKey(clock.value))
const nowMin = computed(() => state.sim ?? clock.value.getHours() * 60 + clock.value.getMinutes())

function pro(id: string): Pro | undefined {
  return PROS.find(p => p.id === id)
}

function service(p: Pro, sid: string): Service | undefined {
  return p.services.find(x => x.id === sid)
}

function baseReviews(p: Pro): Review[] {
  const r = rng(hash(`rev${p.id}`))
  return REVIEW_TEXTS[p.cats[0]].map((t, i) => ({
    a: CLIENT_NAMES[Math.floor(r() * CLIENT_NAMES.length)],
    s: i === 1 && p.rating < 4.7 ? 4 : 5,
    t,
  }))
}

function reviewsOf(p: Pro): Review[] {
  return [...(state.reviews[p.id] ?? []), ...baseReviews(p)]
}

function ratingOf(p: Pro): { rating: number, count: number } {
  const mine = state.reviews[p.id] ?? []
  const sum = p.rating * p.nrev + mine.reduce((a, r) => a + r.s, 0)
  const count = p.nrev + mine.length
  return { rating: Math.round((sum / count) * 10) / 10, count }
}

/** Intervalles occupés chez un pro un jour donné : agenda simulé, réservations de l'appli, créneaux Konyéla en ligne. */
function taken(p: Pro, date: string): Interval[] {
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
  return state.slots
    .filter(s => s.status === 'open' && s.date === today.value && s.time >= nowMin.value + 10 && (!proId || s.proId === proId))
    .sort((a, b) => a.time - b.time)
}

/** Créneaux Konyéla de démonstration du jour, recalculés quand le jour ou l'heure simulée change. */
function seedSlots(force = false) {
  const key = `${today.value}|${state.sim ?? 'réel'}`
  if (!force && state.seededFor === key) return
  state.slots = state.slots.filter(s => s.date === today.value && (s.by === 'pro' || s.status === 'booked'))
  KONYELA_SEEDS.forEach(([proId, sid, disc], i) => {
    const p = pro(proId)
    const sv = p && service(p, sid)
    if (!p || !sv) return
    const options = starts(p, today.value, sv.d).filter(t => t <= nowMin.value + 270)
    if (!options.length) return
    state.slots.push({ id: `s${today.value}-${i}`, proId, sid, date: today.value, time: options[Math.min(i % 2, options.length - 1)], disc, status: 'open', by: 'seed' })
  })
  state.seededFor = key
}

function seedBookings() {
  // Un rendez-vous passé (pour tester l'avis) et un à venir.
  const reg = pro('reg')!
  let past = addDays(today.value, -1)
  while (isClosed(reg, past)) past = addDays(past, -1)
  const lift = service(reg, 'd')!
  state.bookings.push({ id: ++state.seq, proId: 'reg', sid: 'd', date: past, time: 1020, dur: lift.d, price: lift.p, deposit: Math.round(lift.p * RULES.depositRate), mode: 'classic', status: 'confirmed', reviewed: false })
  const hib = pro('hib')!
  const brush = service(hib, 'a')!
  for (let n = 3; n < 10; n++) {
    const date = addDays(today.value, n)
    const free = starts(hib, date, brush.d).filter(t => t >= 600)
    if (free.length) {
      state.bookings.push({ id: ++state.seq, proId: 'hib', sid: 'a', date, time: free[0], dur: brush.d, price: brush.p, deposit: Math.round(brush.p * RULES.depositRate), mode: 'classic', status: 'confirmed', reviewed: false })
      break
    }
  }
}

function isDone(b: Booking): boolean {
  return b.status === 'confirmed' && (b.date < today.value || (b.date === today.value && b.time + b.dur <= nowMin.value))
}

function minutesUntil(b: Booking): number {
  const days = Math.round((new Date(`${b.date}T00:00:00`).getTime() - new Date(`${today.value}T00:00:00`).getTime()) / 86400000)
  return days * 1440 + b.time - nowMin.value
}

/** Acompte remboursé si la réservation classique est annulée plus de 24 h avant. */
function refundable(b: Booking): boolean {
  return b.mode !== 'lm' && minutesUntil(b) > RULES.freeCancelHours * 60
}

function book(input: { proId: string, sid: string, date: string, time: number, slotId?: string }): Booking | null {
  const p = pro(input.proId)
  const sv = p && service(p, input.sid)
  if (!p || !sv) return null
  let price = sv.p
  if (input.slotId) {
    const slot = state.slots.find(s => s.id === input.slotId)
    if (!slot || slot.status !== 'open' || slot.time < nowMin.value + 10) return null
    slot.status = 'booked'
    price = discounted(sv, slot.disc)
  } else if (!starts(p, input.date, sv.d).includes(input.time)) {
    return null
  }
  const b: Booking = { id: ++state.seq, proId: p.id, sid: sv.id, date: input.date, time: input.time, dur: sv.d, price, deposit: Math.round(price * RULES.depositRate), mode: input.slotId ? 'lm' : 'classic', status: 'confirmed', reviewed: false }
  state.bookings.push(b)
  if (p.id === DEMO_PRO_ID) state.unseen++
  return b
}

function cancel(id: number) {
  const b = state.bookings.find(x => x.id === id)
  if (b) b.status = 'cancelled'
}

function addReview(bookingId: number, stars: number, text: string) {
  const b = state.bookings.find(x => x.id === bookingId)
  if (!b || b.reviewed) return
  const list = state.reviews[b.proId] ?? (state.reviews[b.proId] = [])
  list.unshift({ a: DEMO_CLIENT.name, s: stars, t: text.trim() || 'Sans commentaire.' })
  b.reviewed = true
}

function toggleFav(id: string) {
  state.fav[id] = !state.fav[id]
}

/** Agenda du pro de démo : rendez-vous, réservations de l'appli, créneaux Konyéla, trous. */
function agenda(date: string): AgendaItem[] {
  const p = pro(DEMO_PRO_ID)!
  if (isClosed(p, date)) return []
  const items: AgendaItem[] = simulatedAppointments(p, date).map(x => ({ a: x.a, b: x.b, kind: 'rdv', who: x.who, what: x.what, price: x.price }))
  for (const b of state.bookings) {
    if (b.proId === p.id && b.date === date && b.status === 'confirmed') {
      items.push({ a: b.time, b: b.time + b.dur, kind: 'app', who: DEMO_CLIENT.name, what: service(p, b.sid)?.n, price: b.price, deposit: b.deposit, mode: b.mode })
    }
  }
  for (const s of state.slots) {
    if (s.proId === p.id && s.date === date && s.status === 'open' && (date !== today.value || s.time >= nowMin.value + 10)) {
      const sv = service(p, s.sid)!
      items.push({ a: s.time, b: s.time + sv.d, kind: 'lm', what: sv.n, disc: s.disc, id: s.id })
    }
  }
  for (const [a, b] of gaps(p, items.map(i => [i.a, i.b] as Interval))) items.push({ a, b, kind: 'gap' })
  return items.sort((x, y) => x.a - y.a)
}

/** Première heure à laquelle un créneau Konyéla peut démarrer dans un trou. */
function earliestIn(gapStart: number): number {
  return ceil30(Math.max(gapStart, nowMin.value + 30))
}

function publishSlot(sid: string, time: number, disc: number): boolean {
  const p = pro(DEMO_PRO_ID)!
  const sv = service(p, sid)
  if (!sv || !starts(p, today.value, sv.d).includes(time)) return false
  state.slots.push({ id: `p${++state.seq}`, proId: p.id, sid, date: today.value, time, disc, status: 'open', by: 'pro' })
  return true
}

function removeSlot(id: string) {
  state.slots = state.slots.filter(s => s.id !== id)
}

function setSim(minutes: number | null) {
  state.sim = minutes === null ? null : Math.max(0, Math.min(minutes, 23 * 60 + 30))
  seedSlots()
}

function toast(message: string) {
  toastMessage.value = message
  clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toastMessage.value = '' }, 2800)
}

function reset() {
  Object.assign(state, blank())
  seedBookings()
  seedSlots(true)
}

function start() {
  if (started) return
  started = true
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) Object.assign(state, blank(), JSON.parse(raw))
  } catch { /* stockage indisponible : on repart de zéro */ }
  if (!state.bookings.length && !state.seededFor) seedBookings()
  seedSlots()
  watch(state, () => {
    try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)) } catch { /* ignore */ }
  }, { deep: true })
  setInterval(() => { clock.value = new Date() }, 30000)
  watch(today, () => seedSlots())
}

export function useBel() {
  start()
  return {
    state, today, nowMin, toastMessage,
    pros: PROS, pro, service, reviewsOf, ratingOf,
    starts, openSlots, isDone, refundable, minutesUntil,
    book, cancel, addReview, toggleFav,
    agenda, earliestIn, publishSlot, removeSlot,
    setSim, toast, reset,
  }
}
