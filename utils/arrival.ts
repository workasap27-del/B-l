// Suivi de l'arrivée le jour du rendez-vous : signalement, confirmation, retard, absence, désaccord.
// Celui qui se déplace signale son arrivée, l'autre confirme. Pas de géolocalisation : un désaccord part au service client.

/** Minutes d'attente prévues après l'heure du rendez-vous, avant de pouvoir déclarer une absence. */
export const TOLERANCE = 15
/** Le bouton "Je suis là" apparaît 30 minutes avant l'heure. */
export const OPEN_BEFORE = 30
/** Délai de traitement d'un désaccord par le service client, en heures. */
export const DISPUTE_HOURS = 48

export interface ArrivalFields {
  time: number
  status: 'confirmed' | 'cancelled'
  /** heure à laquelle celui qui se déplace a signalé son arrivée */
  arrivedAt?: number
  /** heure à laquelle l'autre a confirmé */
  confirmedAt?: number
  /** retard annoncé, en minutes */
  lateBy?: number
  /** attente prolongée jusqu'à cette heure par celui qui attend */
  waitUntil?: number
  /** absence déclarée : de la cliente, ou du prestataire qui devait venir */
  noShow?: 'client' | 'pro'
  disputed?: boolean
}

export type ArrivalState =
  | 'hors' | 'avant' | 'attendu' | 'retard_annonce' | 'en_retard' | 'depasse'
  | 'a_confirmer' | 'arrive' | 'absent' | 'litige'

/** Heure limite d'attente : l'heure du rendez-vous plus la tolérance, ou plus si l'attente a été prolongée. */
export function deadline(b: ArrivalFields): number {
  return b.waitUntil ?? b.time + TOLERANCE
}

export function arrivalState(b: ArrivalFields, now: number, isToday: boolean): ArrivalState {
  if (!isToday || b.status !== 'confirmed') return 'hors'
  if (b.disputed) return 'litige'
  if (b.noShow) return 'absent'
  if (b.confirmedAt !== undefined) return 'arrive'
  if (b.arrivedAt !== undefined) return 'a_confirmer'
  if (now < b.time - OPEN_BEFORE) return 'avant'
  if (now <= b.time) return b.lateBy ? 'retard_annonce' : 'attendu'
  if (now <= deadline(b)) return b.lateBy ? 'retard_annonce' : 'en_retard'
  return 'depasse'
}

/** Un retard annoncé ne peut pas dépasser la tolérance : au-delà, mieux vaut annuler ou reporter. */
export function clampLate(minutes: number): number {
  return Math.max(5, Math.min(TOLERANCE, Math.round(minutes / 5) * 5))
}
