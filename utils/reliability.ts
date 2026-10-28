// Indicateur de fiabilité d'une cliente ou d'un client : des faits, jamais de note ni de commentaire.

export interface Reliability { done: number, noShows: number, lateCancels: number, late: number }

const WORDS = {
  fr: { first: 'Première réservation sur VLADI', done: ['rendez-vous honoré', 'rendez-vous honorés'], noShow: ['absence', 'absences'], none: 'aucune absence', late: ['annulation tardive', 'annulations tardives'] },
  en: { first: 'First booking on VLADI', done: ['appointment kept', 'appointments kept'], noShow: ['no-show', 'no-shows'], none: 'no no-shows', late: ['late cancellation', 'late cancellations'] },
} as const

const plural = (n: number, w: readonly [string, string]) => `${n} ${n > 1 ? w[1] : w[0]}`

export function reliabilityText(r: Reliability, lang: 'fr' | 'en' = 'fr'): string {
  const w = WORDS[lang]
  if (!r.done && !r.noShows && !r.lateCancels) return w.first
  const parts = [plural(r.done, w.done)]
  parts.push(r.noShows ? plural(r.noShows, w.noShow) : w.none)
  if (r.lateCancels) parts.push(plural(r.lateCancels, w.late))
  return parts.join(', ')
}

/** À surveiller : deux absences ou plus, ou trois annulations tardives, sur douze mois. */
export function needsCare(r: Reliability): boolean {
  return r.noShows >= 2 || r.lateCancels >= 3
}

export function readReliability(raw: unknown): Reliability {
  const o = (raw ?? {}) as Record<string, unknown>
  return { done: Number(o.done) || 0, noShows: Number(o.noShows) || 0, lateCancels: Number(o.lateCancels) || 0, late: Number(o.late) || 0 }
}
