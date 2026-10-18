import { describe, expect, it } from 'vitest'
import { spansOverlap } from '~/utils/schedule'

const rdv = { date: '2026-10-20', time: 16 * 60, dur: 60 }

describe('chevauchement de rendez-vous', () => {
  it('refuse la même heure', () => {
    expect(spansOverlap(rdv, { date: '2026-10-20', time: 16 * 60, dur: 45 })).toBe(true)
  })
  it('refuse un début au milieu d\'un rendez-vous', () => {
    expect(spansOverlap(rdv, { date: '2026-10-20', time: 16 * 60 + 30, dur: 30 })).toBe(true)
    expect(spansOverlap(rdv, { date: '2026-10-20', time: 15 * 60 + 30, dur: 45 })).toBe(true)
  })
  it('accepte juste après ou juste avant', () => {
    expect(spansOverlap(rdv, { date: '2026-10-20', time: 17 * 60, dur: 30 })).toBe(false)
    expect(spansOverlap(rdv, { date: '2026-10-20', time: 15 * 60, dur: 60 })).toBe(false)
  })
  it('accepte un autre jour à la même heure', () => {
    expect(spansOverlap(rdv, { date: '2026-10-21', time: 16 * 60, dur: 60 })).toBe(false)
  })
})
