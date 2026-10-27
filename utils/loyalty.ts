// Fidélité : progression vers le prochain palier et crédit gagné, à partir du nombre de rendez-vous honorés.
import { LOYALTY } from '~/data/pros'

export interface LoyaltyState { visits: number, earned: number, next: { visits: number, credit: number, left: number }, inCycle: number, cycle: number }

export function loyaltyState(visits: number, referrals = 0, rules = LOYALTY): LoyaltyState {
  const cycle = Math.max(...rules.tiers.map(t => t.visits))
  const perCycle = rules.tiers.reduce((a, t) => a + t.credit, 0)
  const inCycle = visits % cycle
  const earned = Math.floor(visits / cycle) * perCycle + rules.tiers.filter(t => t.visits <= inCycle).reduce((a, t) => a + t.credit, 0) + referrals * rules.referralCredit
  const nextTier = rules.tiers.find(t => t.visits > inCycle) ?? rules.tiers[0]
  return { visits, earned, inCycle, cycle, next: { ...nextTier, left: nextTier.visits - inCycle } }
}
