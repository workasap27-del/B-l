// Logique d'agenda, sans dépendance à Vue : dates, créneaux libres, occupation simulée.
import type { Pro, Service } from '~/data/pros'
import { CLIENT_NAMES } from '~/data/pros'
import { hash, rng } from '~/data/random'

export type Interval = [start: number, end: number]

export interface Appointment {
  a: number
  b: number
  who: string
  what: string
  price: number
}

const DAY_NAMES = ['dim.', 'lun.', 'mar.', 'mer.', 'jeu.', 'ven.', 'sam.']
const MONTHS = ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.']

export function dateKey(d: Date): string {
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${d.getFullYear()}-${m}-${day}`
}

export function parseKey(key: string): Date {
  const [y, m, d] = key.split('-').map(Number)
  return new Date(y, m - 1, d)
}

export function addDays(key: string, n: number): string {
  const d = parseKey(key)
  d.setDate(d.getDate() + n)
  return dateKey(d)
}

export function diffDays(from: string, to: string): number {
  return Math.round((parseKey(to).getTime() - parseKey(from).getTime()) / 86400000)
}

export function weekday(key: string): number {
  return parseKey(key).getDay()
}

/** "aujourd'hui", "demain", "hier" ou "mar. 13 oct." */
export function dayLabel(key: string, today: string): string {
  const n = diffDays(today, key)
  if (n === 0) return "aujourd'hui"
  if (n === 1) return 'demain'
  if (n === -1) return 'hier'
  const d = parseKey(key)
  return `${DAY_NAMES[d.getDay()]} ${d.getDate()} ${MONTHS[d.getMonth()]}`
}

export function dayChip(key: string, today: string): string {
  const n = diffDays(today, key)
  if (n === 0) return "Aujourd'hui"
  if (n === 1) return 'Demain'
  const d = parseKey(key)
  return `${DAY_NAMES[d.getDay()]} ${d.getDate()}`
}

/** "Auj.", "Dem." ou "mar." : pour les créneaux affichés en petit. */
export function shortDay(key: string, today: string): string {
  const n = diffDays(today, key)
  if (n === 0) return 'Auj.'
  if (n === 1) return 'Dem.'
  return DAY_NAMES[parseKey(key).getDay()]
}

/** Jour de la semaine, numéro du jour et mois abrégés, pour les pastilles de date. */
export function dateParts(key: string): { dow: string, day: number, month: string } {
  const d = parseKey(key)
  return { dow: DAY_NAMES[d.getDay()].replace('.', ''), day: d.getDate(), month: MONTHS[d.getMonth()].replace('.', '') }
}

export const WEEK = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']

export function hm(t: number): string {
  const h = Math.floor(t / 60)
  const m = t % 60
  return `${h}h${m < 10 ? '0' : ''}${m}`
}

export function euro(n: number): string {
  return `${String(Math.round(n * 100) / 100).replace('.', ',')} €`
}

export function ceil30(x: number): number {
  return Math.ceil(x / 30) * 30
}

export function isClosed(pro: Pro, date: string): boolean {
  return pro.closed.includes(weekday(date))
}

/**
 * Rendez-vous déjà pris en dehors de l'appli, simulés de façon stable pour un pro et un jour donnés.
 * En production, cette fonction est remplacée par la lecture de la table des réservations.
 */
export function simulatedAppointments(pro: Pro, date: string): Appointment[] {
  if (isClosed(pro, date)) return []
  const r = rng(hash(`${pro.id}|${date}`))
  const out: Appointment[] = []
  let t = pro.open
  while (t < pro.close - 29) {
    if (r() < pro.fill) {
      const sv = pro.services[Math.floor(r() * pro.services.length)]
      const end = Math.min(pro.close, t + ceil30(sv.d))
      out.push({ a: t, b: end, who: CLIENT_NAMES[Math.floor(r() * CLIENT_NAMES.length)], what: sv.n, price: sv.p })
      t = end
    } else {
      t += [30, 60, 90][Math.floor(r() * 3)]
    }
  }
  return out
}

/** Heures de début possibles pour une prestation, par pas de 30 minutes. */
export function freeStarts(pro: Pro, date: string, duration: number, taken: Interval[], notBefore = 0): number[] {
  if (isClosed(pro, date)) return []
  const out: number[] = []
  for (let t = ceil30(pro.open); t + duration <= pro.close; t += 30) {
    if (t < notBefore) continue
    if (!taken.some(([a, b]) => t < b && t + duration > a)) out.push(t)
  }
  return out
}

/** Trous d'au moins 30 minutes entre les intervalles occupés. */
export function gaps(pro: Pro, taken: Interval[]): Interval[] {
  const sorted = [...taken].sort((x, y) => x[0] - y[0])
  const out: Interval[] = []
  let t = pro.open
  for (const [a, b] of sorted) {
    if (a - t >= 30) out.push([t, a])
    t = Math.max(t, b)
  }
  if (pro.close - t >= 30) out.push([t, pro.close])
  return out
}

export function discounted(service: Service, percent: number): number {
  return Math.round((service.p * (100 - percent)) / 100)
}
