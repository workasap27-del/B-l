import { describe, expect, it } from 'vitest'
import { needsCare, readReliability, reliabilityText } from '../utils/reliability'

describe('fiabilité', () => {
  it('présente une première réservation sans jugement', () => {
    expect(reliabilityText(readReliability({}))).toBe('Première réservation sur VLADI')
  })
  it('résume les faits', () => {
    expect(reliabilityText({ done: 12, noShows: 0, lateCancels: 0, late: 1 })).toBe('12 rendez-vous honorés, aucune absence')
    expect(reliabilityText({ done: 1, noShows: 2, lateCancels: 1, late: 0 })).toBe('1 rendez-vous honoré, 2 absences, 1 annulation tardive')
  })
  it('signale à partir de deux absences ou trois annulations tardives', () => {
    expect(needsCare({ done: 5, noShows: 1, lateCancels: 2, late: 0 })).toBe(false)
    expect(needsCare({ done: 5, noShows: 2, lateCancels: 0, late: 0 })).toBe(true)
    expect(needsCare({ done: 5, noShows: 0, lateCancels: 3, late: 0 })).toBe(true)
  })
})
