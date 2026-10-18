// Accès à la base Supabase : comptes, fiches des vrais prestataires, réservations, créneaux Konyéla, avis.
// Ce fichier ne garde aucun état : il lit et écrit, puis useVladi range les résultats.
import { createClient } from '@supabase/supabase-js'
import type { SupabaseClient } from '@supabase/supabase-js'
import type { Category, Pro, Service } from '~/data/pros'
import { fromIso, toIso } from '~/utils/time'
import type { AdminEvent, AdminStats } from '~/utils/admin'

let client: SupabaseClient | null = null
let tried = false

/** Client Supabase, ou null si l'appli tourne sans base (tests, développement hors ligne). */
export function sb(): SupabaseClient | null {
  if (tried) return client
  tried = true
  const cfg = useRuntimeConfig().public as { supabaseUrl?: string, supabaseKey?: string }
  if (!cfg.supabaseUrl || !cfg.supabaseKey) return null
  client = createClient(cfg.supabaseUrl, cfg.supabaseKey, {
    auth: { persistSession: true, autoRefreshToken: true, storageKey: 'vladi-auth' },
  })
  return client
}

export interface Profile {
  id: string
  email: string
  name: string
  role: 'client' | 'pro'
  phone?: string
}

export interface RemoteBooking {
  id: string
  proId: string
  sid: string
  date: string
  time: number
  dur: number
  price: number
  deposit: number
  fee: number
  mode: 'classic' | 'lm'
  status: 'confirmed' | 'cancelled'
  place: 'pro' | 'client'
  address?: string
  clientId: string
  clientName: string
  clientPhone?: string
  note?: string
  arrivedAt?: number
  confirmedAt?: number
  lateBy?: number
  waitUntil?: number
  noShow?: 'client' | 'pro'
  disputed?: boolean
}

export interface RemoteSlot {
  id: string
  proId: string
  sid: string
  date: string
  time: number
  disc: number
}

export interface RemoteReview {
  bookingId: string
  proId: string
  clientId: string
  stars: number
  body: string
  date: string
}

/** Message d'erreur compréhensible à partir d'une erreur Supabase. */
export function readable(e: unknown): string {
  const msg = (e as { message?: string })?.message ?? String(e)
  if (/Invalid login credentials/i.test(msg)) return 'E-mail ou mot de passe incorrect.'
  if (/already registered|already been registered/i.test(msg)) return 'Un compte existe déjà avec cet e-mail. Connecte-toi.'
  if (/Password should be at least/i.test(msg)) return 'Le mot de passe doit faire au moins 8 caractères.'
  const wait = msg.match(/after (\d+) seconds?/i)
  if (wait) return `Pour ta sécurité, patiente ${wait[1]} secondes avant de réessayer.`
  if (/rate limit|too many/i.test(msg)) return 'Trop de tentatives. Réessaie dans quelques minutes.'
  if (/Email not confirmed/i.test(msg)) return 'Confirme d\'abord ton adresse avec le lien reçu par e-mail.'
  if (/Unable to validate email|invalid format|is invalid/i.test(msg)) return 'Cette adresse e-mail n\'est pas valide.'
  if (/same as the old password/i.test(msg)) return 'Choisis un mot de passe différent de l\'ancien.'
  if (/Error sending|sending (confirmation|recovery)/i.test(msg)) return 'Envoi de l\'e-mail impossible pour le moment. Réessaie plus tard.'
  if (/session.*missing|not authenticated|JWT/i.test(msg)) return 'Ta session a expiré. Reconnecte-toi.'
  if (/bookings_client_no_overlap/i.test(msg)) return 'Tu as déjà un rendez-vous à cette heure.'
  if (/bookings_no_overlap|exclusion/i.test(msg)) return 'Ce créneau vient d\'être pris. Choisis-en un autre.'
  if (/pros_one_per_owner/i.test(msg)) return 'Ton compte a déjà une fiche.'
  if (/siren/i.test(msg)) return 'Le numéro SIREN doit faire 9 chiffres.'
  if (/Failed to fetch|NetworkError/i.test(msg)) return 'Pas de connexion. Vérifie ton réseau et réessaie.'
  return msg
}

// Comptes -------------------------------------------------------------------

export async function signUp(input: { email: string, password: string, name: string, role: 'client' | 'pro', phone?: string }) {
  const c = sb()!
  const { data, error } = await c.auth.signUp({
    email: input.email.trim(),
    password: input.password,
    options: { data: { display_name: input.name.trim(), role: input.role, phone: input.phone?.trim() ?? '' } },
  })
  if (error) throw error
  if (!data.session) throw new Error('Compte créé. Vérifie tes e-mails pour l\'activer, puis connecte-toi.')
}

export async function signIn(email: string, password: string) {
  const { error } = await sb()!.auth.signInWithPassword({ email: email.trim(), password })
  if (error) throw error
}

export async function signOut() {
  await sb()?.auth.signOut()
}

export async function resetPassword(email: string) {
  const { error } = await sb()!.auth.resetPasswordForEmail(email.trim(), { redirectTo: `${location.origin}/nouveau-mot-de-passe` })
  if (error) throw error
}

export async function loadProfile(): Promise<Profile | null> {
  const c = sb()
  if (!c) return null
  const { data: { session } } = await c.auth.getSession()
  if (!session) return null
  const { data } = await c.from('profiles').select('*').eq('id', session.user.id).maybeSingle()
  return {
    id: session.user.id,
    email: session.user.email ?? '',
    name: data?.display_name ?? session.user.email?.split('@')[0] ?? '',
    role: data?.role === 'pro' ? 'pro' : 'client',
    phone: data?.phone ?? undefined,
  }
}

export async function updateProfile(id: string, fields: { name?: string, phone?: string, role?: 'client' | 'pro' }) {
  const row: Record<string, unknown> = {}
  if (fields.name !== undefined) row.display_name = fields.name.trim()
  if (fields.phone !== undefined) row.phone = fields.phone.trim() || null
  if (fields.role !== undefined) row.role = fields.role
  const { error } = await sb()!.from('profiles').update(row).eq('id', id)
  if (error) throw error
}

// Prestataires --------------------------------------------------------------

interface ProRow {
  id: string, owner_id: string | null, name: string, owner_name: string | null, kind: Pro['kind'], siren: string | null, phone: string | null,
  photo_url: string | null, places: string[], travel_fee_eur: number | string, commune: string, quartier: string | null, lat: number, lng: number,
  categories: string[], tags: string[], about: string | null, opens_at: number, closes_at: number, closed_weekdays: number[], hue: number,
  services?: { id: string, code: string, name: string, duration_min: number, price_eur: number | string, active: boolean }[]
}

function mapPro(r: ProRow): Pro {
  const services: Service[] = (r.services ?? [])
    .filter(s => s.active)
    .sort((a, b) => a.code.localeCompare(b.code, 'fr', { numeric: true }))
    .map(s => ({ id: s.id, n: s.name, d: s.duration_min, p: Number(s.price_eur) }))
  return {
    id: r.id, name: r.name, owner: r.owner_name ?? undefined, kind: r.kind, where: r.places, travel: Number(r.travel_fee_eur) || 0,
    commune: r.commune, quartier: r.quartier ?? '', lat: r.lat, lng: r.lng,
    cats: (r.categories.length ? r.categories : ['soins']) as Category[], tags: r.tags ?? [],
    rating: 0, nrev: 0, open: r.opens_at, close: r.closes_at, closed: r.closed_weekdays ?? [], fill: 0, h: r.hue,
    about: r.about ?? '', services, real: true, ownerId: r.owner_id ?? undefined, photo: r.photo_url ?? undefined,
    phone: r.phone ?? undefined, siren: r.siren ?? undefined,
  }
}

export async function loadPros(): Promise<{ pros: Pro[], ratings: Record<string, { rating: number, count: number }> }> {
  const c = sb()
  if (!c) return { pros: [], ratings: {} }
  const [{ data, error }, { data: rt }] = await Promise.all([
    c.from('pros').select('*, services(*)').eq('is_demo', false),
    c.from('pro_ratings').select('*'),
  ])
  if (error) throw error
  const ratings: Record<string, { rating: number, count: number }> = {}
  for (const r of rt ?? []) ratings[r.pro_id] = { rating: Number(r.rating), count: Number(r.review_count) }
  return { pros: (data as ProRow[]).filter(p => (p.services ?? []).some(s => s.active)).map(mapPro), ratings }
}

export async function loadMyPro(userId: string): Promise<Pro | null> {
  const { data } = await sb()!.from('pros').select('*, services(*)').eq('owner_id', userId).maybeSingle()
  return data ? mapPro(data as ProRow) : null
}

export interface ProInput {
  id?: string
  name: string
  ownerName: string
  kind: Pro['kind']
  siren: string
  phone: string
  places: string[]
  travel: number
  commune: string
  quartier: string
  lat: number
  lng: number
  cats: Category[]
  about: string
  open: number
  close: number
  closed: number[]
  services: { id?: string, n: string, d: number, p: number }[]
}

function slug(name: string): string {
  const base = name.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '').slice(0, 30) || 'pro'
  return `${base}-${Math.random().toString(36).slice(2, 6)}`
}

/** Crée ou met à jour la fiche du compte connecté et ses prestations. Renvoie l'identifiant de la fiche. */
export async function saveMyPro(userId: string, f: ProInput): Promise<string> {
  const c = sb()!
  const row = {
    owner_id: userId, name: f.name.trim(), owner_name: f.ownerName.trim() || null, kind: f.kind, siren: f.siren.replace(/\s/g, ''),
    phone: f.phone.trim() || null, places: f.places, travel_fee_eur: f.travel, commune: f.commune, quartier: f.quartier.trim() || null,
    lat: f.lat, lng: f.lng, categories: f.cats, tags: [], about: f.about.trim() || null, opens_at: f.open, closes_at: f.close,
    closed_weekdays: f.closed, hue: Math.floor(Math.random() * 360),
  }
  let id = f.id
  if (id) {
    const { error } = await c.from('pros').update(row).eq('id', id)
    if (error) throw error
  } else {
    id = slug(f.name)
    const { error } = await c.from('pros').insert({ id, ...row })
    if (error) throw error
  }
  // Prestations : mise à jour des existantes, ajout des nouvelles, retrait (désactivation) des autres.
  const { data: existing } = await c.from('services').select('id, code').eq('pro_id', id)
  const keep = new Set(f.services.filter(s => s.id).map(s => s.id))
  let n = Math.max(0, ...(existing ?? []).map(s => Number.parseInt(s.code, 10) || 0))
  for (const s of f.services) {
    const fields = { name: s.n.trim(), duration_min: s.d, price_eur: s.p, active: true }
    const { error } = s.id
      ? await c.from('services').update(fields).eq('id', s.id)
      : await c.from('services').insert({ pro_id: id, code: String(++n), ...fields })
    if (error) throw error
  }
  const gone = (existing ?? []).filter(s => !keep.has(s.id)).map(s => s.id)
  if (gone.length) await c.from('services').update({ active: false }).in('id', gone)
  return id
}

// Disponibilités ------------------------------------------------------------

/** Plages occupées de tous les vrais prestataires sur deux semaines, rangées par prestataire et par jour. */
export async function loadBusy(fromDate: string, days = 15): Promise<Record<string, Record<string, [number, number][]>>> {
  const c = sb()
  if (!c) return {}
  const { data, error } = await c.rpc('busy_all', { p_from: toIso(fromDate, 0), p_to: toIso(fromDate, days * 1440) })
  if (error) throw error
  const out: Record<string, Record<string, [number, number][]>> = {}
  for (const r of (data ?? []) as { pro_id: string, starts_at: string, ends_at: string }[]) {
    const a = fromIso(r.starts_at)
    const b = fromIso(r.ends_at)
    const end = b.date === a.date ? b.min : 1440
    ;((out[r.pro_id] ??= {})[a.date] ??= []).push([a.min, end])
  }
  return out
}

export async function loadOpenSlots(): Promise<RemoteSlot[]> {
  const c = sb()
  if (!c) return []
  const { data } = await c.from('konyela_slots').select('*').eq('status', 'open').gte('starts_at', new Date().toISOString())
  return (data ?? []).map((r) => {
    const t = fromIso(r.starts_at)
    return { id: r.id, proId: r.pro_id, sid: r.service_id, date: t.date, time: t.min, disc: r.discount_pct }
  })
}

export async function publishSlot(proId: string, sid: string, date: string, time: number, disc: number) {
  const { error } = await sb()!.from('konyela_slots').insert({ pro_id: proId, service_id: sid, starts_at: toIso(date, time), discount_pct: disc })
  if (error) throw error
}

export async function removeSlot(id: string) {
  const { error } = await sb()!.from('konyela_slots').delete().eq('id', id)
  if (error) throw error
}

// Réservations --------------------------------------------------------------

interface BookingRow {
  id: string, pro_id: string, service_id: string, client_id: string, client_name: string, client_phone: string | null, client_note: string | null,
  starts_at: string, ends_at: string, price_eur: number | string, deposit_eur: number | string, mode: 'classic' | 'konyela',
  status: 'confirmed' | 'cancelled', place: 'pro' | 'client', client_address: string | null, travel_fee_eur: number | string,
  arrived_at: string | null, arrival_confirmed_at: string | null, late_minutes: number | null, wait_until: string | null,
  no_show: 'client' | 'pro' | null, disputed_at: string | null
}

function mapBooking(r: BookingRow): RemoteBooking {
  const a = fromIso(r.starts_at)
  const min = (iso: string | null) => (iso ? fromIso(iso).min : undefined)
  return {
    id: r.id, proId: r.pro_id, sid: r.service_id, date: a.date, time: a.min,
    dur: Math.round((new Date(r.ends_at).getTime() - new Date(r.starts_at).getTime()) / 60000),
    price: Number(r.price_eur), deposit: Number(r.deposit_eur), fee: Number(r.travel_fee_eur),
    mode: r.mode === 'konyela' ? 'lm' : 'classic', status: r.status, place: r.place, address: r.client_address ?? undefined,
    clientId: r.client_id, clientName: r.client_name, clientPhone: r.client_phone ?? undefined, note: r.client_note ?? undefined,
    arrivedAt: min(r.arrived_at), confirmedAt: min(r.arrival_confirmed_at), lateBy: r.late_minutes ?? undefined,
    waitUntil: min(r.wait_until), noShow: r.no_show ?? undefined, disputed: !!r.disputed_at,
  }
}

/** Les réservations visibles par le compte : les siennes comme cliente, et celles reçues par sa fiche. */
export async function loadBookings(): Promise<RemoteBooking[]> {
  const c = sb()
  if (!c) return []
  const since = new Date(Date.now() - 60 * 86400000).toISOString()
  const { data, error } = await c.from('bookings').select('*').gte('starts_at', since).order('starts_at')
  if (error) throw error
  return (data as BookingRow[]).map(mapBooking)
}

export async function createBooking(input: {
  clientId: string, clientName: string, clientPhone?: string, note?: string, proId: string, sid: string,
  date: string, time: number, dur: number, place: 'pro' | 'client', address?: string,
}): Promise<RemoteBooking> {
  const start = toIso(input.date, input.time)
  const { data, error } = await sb()!.from('bookings').insert({
    pro_id: input.proId, service_id: input.sid, client_id: input.clientId, client_name: input.clientName,
    client_phone: input.clientPhone || null, client_note: input.note?.trim() || null,
    starts_at: start, ends_at: new Date(new Date(start).getTime() + input.dur * 60000).toISOString(),
    // Prix, acompte et frais sont recalculés par la base.
    price_eur: 0, deposit_eur: 0, place: input.place, client_address: input.address ?? null,
  }).select().single()
  if (error) throw error
  return mapBooking(data as BookingRow)
}

export async function bookSlot(input: { slotId: string, place: 'pro' | 'client', address?: string, clientName: string, clientPhone?: string, note?: string }): Promise<RemoteBooking> {
  const { data, error } = await sb()!.rpc('book_konyela_slot', {
    p_slot: input.slotId, p_place: input.place, p_address: input.address ?? null,
    p_client_name: input.clientName, p_client_phone: input.clientPhone || null, p_client_note: input.note?.trim() || null,
  })
  if (error) throw error
  return mapBooking(data as BookingRow)
}

/** Champs que la base laisse modifier : annulation et suivi d'arrivée. */
export async function updateBooking(id: string, date: string, f: {
  status?: 'cancelled', arrivedAt?: number, confirmedAt?: number, lateBy?: number, waitUntil?: number, noShow?: 'client' | 'pro', disputed?: boolean
}) {
  const row: Record<string, unknown> = {}
  if (f.status) row.status = f.status
  if (f.arrivedAt !== undefined) row.arrived_at = toIso(date, f.arrivedAt)
  if (f.confirmedAt !== undefined) row.arrival_confirmed_at = toIso(date, f.confirmedAt)
  if (f.lateBy !== undefined) row.late_minutes = f.lateBy
  if (f.waitUntil !== undefined) row.wait_until = toIso(date, f.waitUntil)
  if (f.noShow) row.no_show = f.noShow
  if (f.disputed) row.disputed_at = new Date().toISOString()
  const { error } = await sb()!.from('bookings').update(row).eq('id', id)
  if (error) throw error
}

// Avis ----------------------------------------------------------------------

export async function loadReviews(proId?: string, clientId?: string): Promise<RemoteReview[]> {
  const c = sb()
  if (!c) return []
  let q = c.from('reviews').select('*').order('created_at', { ascending: false }).limit(50)
  if (proId) q = q.eq('pro_id', proId)
  if (clientId) q = q.eq('client_id', clientId)
  const { data } = await q
  return (data ?? []).map(r => ({ bookingId: r.booking_id, proId: r.pro_id, clientId: r.client_id, stars: r.stars, body: r.body ?? '', date: r.created_at }))
}

export async function addReview(input: { bookingId: string, proId: string, clientId: string, stars: number, body: string }) {
  const { error } = await sb()!.from('reviews').insert({ booking_id: input.bookingId, pro_id: input.proId, client_id: input.clientId, stars: input.stars, body: input.body.trim() || null })
  if (error) throw error
}

export function onAuthChange(fn: (event: string) => void) {
  sb()?.auth.onAuthStateChange(event => fn(event))
}

/** Enregistre un nouveau mot de passe pour la personne connectée (après le lien reçu par e-mail). */
export async function setPassword(password: string) {
  const { error } = await sb()!.auth.updateUser({ password })
  if (error) throw error
}

// Registre officiel des entreprises ------------------------------------------

export interface Company { siren: string, name: string, active: boolean, city: string, activity: string }

/** Cherche une entreprise dans l'annuaire officiel (data.gouv.fr). Renvoie null si le SIREN n'existe pas, lève une erreur si le service est injoignable. */
export async function lookupCompany(siren: string): Promise<Company | null> {
  const res = await fetch(`https://recherche-entreprises.api.gouv.fr/search?q=${encodeURIComponent(siren)}&page=1&per_page=1`)
  if (!res.ok) throw new Error('registre')
  const j = await res.json() as { results?: { siren: string, nom_complet: string, etat_administratif?: string, siege?: { libelle_commune?: string, activite_principale?: string } }[] }
  const r = j.results?.find(x => x.siren === siren)
  if (!r) return null
  return { siren: r.siren, name: r.nom_complet, active: r.etat_administratif !== 'C', city: r.siege?.libelle_commune ?? '', activity: r.siege?.activite_principale ?? '' }
}

// Pilotage (propriétaires de l'appli) ---------------------------------------------

/** Le compte connecté fait-il partie des propriétaires ? Faux tant que la base ne connaît pas le pilotage. */
export async function isAdmin(): Promise<boolean> {
  const c = sb()
  if (!c) return false
  const { data, error } = await c.rpc('is_admin')
  return !error && data === true
}

export async function adminStats(days: number): Promise<AdminStats> {
  const { data, error } = await sb()!.rpc('admin_stats', { p_days: days })
  if (error) throw error
  return data as AdminStats
}

export async function adminEvents(limit = 150, kind?: string): Promise<AdminEvent[]> {
  const { data, error } = await sb()!.rpc('admin_events', { p_limit: limit, p_kind: kind ?? null })
  if (error) throw error
  return (data ?? []).map((e: Record<string, unknown>) => ({
    id: Number(e.id), at: String(e.at), kind: String(e.kind),
    actor: (e.actor_name as string | null) ?? '', role: (e.actor_role as string | null) ?? '',
    pro: (e.pro_name as string | null) ?? '', detail: (e.detail as Record<string, unknown>) ?? {},
  }))
}

export async function adminBookings(days: number): Promise<Record<string, unknown>[]> {
  const { data, error } = await sb()!.rpc('admin_bookings', { p_days: days })
  if (error) throw error
  return data ?? []
}
