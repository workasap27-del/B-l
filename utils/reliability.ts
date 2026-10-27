// Indicateur de fiabilité d'une cliente ou d'un client : des faits, jamais de note ni de commentaire.

export interface Reliability { done: number, noShows: number, lateCancels: number, late: number }

const plural = (n: number, one: string, many: string) => `${n} ${n > 1 ? many : one}`

export function reliabilityText(r: Reliability): string {
  if (!r.done && !r.noShows && !r.lateCancels) return 'Première réservation sur VLADI'
  const parts = [plural(r.done, 'rendez-vous honoré', 'rendez-vous honorés')]
  parts.push(r.noShows ? plural(r.noShows, 'absence', 'absences') : 'aucune absence')
  if (r.lateCancels) parts.push(plural(r.lateCancels, 'annulation tardive', 'annulations tardives'))
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
