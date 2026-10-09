// Où a lieu la prestation : chez le prestataire (salon, institut, son domicile) ou chez la cliente.
import type { Pro } from '~/data/pros'

export type Place = 'pro' | 'client'

const AT_CLIENT = 'À domicile'

/** Le prestataire reçoit-il chez lui, dans son salon ou son institut ? Renvoie le libellé, sinon null. */
export function proPlace(p: Pro): string | null {
  return p.where.find(w => w !== AT_CLIENT) ?? null
}

export function goesToClient(p: Pro): boolean {
  return p.where.includes(AT_CLIENT)
}

export function travelFee(p: Pro): number {
  return goesToClient(p) ? (p.travel ?? 0) : 0
}

export function allowedPlaces(p: Pro): Place[] {
  const out: Place[] = []
  if (proPlace(p)) out.push('pro')
  if (goesToClient(p)) out.push('client')
  return out
}

/** Libellé court pour les fiches et les cartes. */
export function placeBadges(p: Pro): string[] {
  const out: string[] = []
  const here = proPlace(p)
  if (here) out.push(here)
  if (goesToClient(p)) out.push('Se déplace chez toi')
  return out
}
