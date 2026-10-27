import { describe, expect, it } from 'vitest'
import { loyaltyState } from '../utils/loyalty'

const rules = { enabled: true, tiers: [{ visits: 5, credit: 5 }, { visits: 10, credit: 10 }], referralCredit: 5 }

describe('fidélité', () => {
  it('compte les rendez-vous jusqu\'au prochain palier', () => {
    const s = loyaltyState(3, 0, rules)
    expect(s.earned).toBe(0)
    expect(s.next).toEqual({ visits: 5, credit: 5, left: 2 })
  })
  it('ajoute le crédit à chaque palier et recommence le cycle', () => {
    expect(loyaltyState(5, 0, rules).earned).toBe(5)
    expect(loyaltyState(10, 0, rules).earned).toBe(15)
    expect(loyaltyState(10, 0, rules).next).toEqual({ visits: 5, credit: 5, left: 5 })
    expect(loyaltyState(17, 0, rules).earned).toBe(20)
  })
  it('ajoute le parrainage', () => {
    expect(loyaltyState(0, 2, rules).earned).toBe(10)
  })
})
