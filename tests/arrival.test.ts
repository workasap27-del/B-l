import { describe, expect, it } from 'vitest'
import { arrivalState, clampLate, deadline, TOLERANCE } from '../utils/arrival'
import type { ArrivalFields } from '../utils/arrival'

const rdv = (extra: Partial<ArrivalFields> = {}): ArrivalFields => ({ time: 600, status: 'confirmed', ...extra })

describe('arrivée le jour du rendez-vous', () => {
  it('ne concerne que les rendez-vous confirmés du jour', () => {
    expect(arrivalState(rdv(), 600, false)).toBe('hors')
    expect(arrivalState(rdv({ status: 'cancelled' }), 600, true)).toBe('hors')
  })
  it('suit la chronologie sans signalement', () => {
    expect(arrivalState(rdv(), 500, true)).toBe('avant')
    expect(arrivalState(rdv(), 575, true)).toBe('attendu')
    expect(arrivalState(rdv(), 610, true)).toBe('en_retard')
    expect(arrivalState(rdv(), 600 + TOLERANCE, true)).toBe('en_retard')
    expect(arrivalState(rdv(), 600 + TOLERANCE + 1, true)).toBe('depasse')
  })
  it('affiche le retard annoncé, sans repousser la limite', () => {
    expect(arrivalState(rdv({ lateBy: 10 }), 590, true)).toBe('retard_annonce')
    expect(arrivalState(rdv({ lateBy: 10 }), 612, true)).toBe('retard_annonce')
    expect(arrivalState(rdv({ lateBy: 10 }), 620, true)).toBe('depasse')
  })
  it('laisse celui qui attend prolonger son attente', () => {
    const b = rdv({ waitUntil: 600 + TOLERANCE + 15 })
    expect(deadline(b)).toBe(630)
    expect(arrivalState(b, 625, true)).toBe('en_retard')
    expect(arrivalState(b, 631, true)).toBe('depasse')
  })
  it('passe par la confirmation de l\'autre partie', () => {
    expect(arrivalState(rdv({ arrivedAt: 598 }), 700, true)).toBe('a_confirmer')
    expect(arrivalState(rdv({ arrivedAt: 598, confirmedAt: 600 }), 700, true)).toBe('arrive')
  })
  it('donne la priorité au désaccord puis à l\'absence', () => {
    expect(arrivalState(rdv({ arrivedAt: 598, noShow: 'client', disputed: true }), 700, true)).toBe('litige')
    expect(arrivalState(rdv({ noShow: 'client' }), 700, true)).toBe('absent')
  })
  it('borne le retard annoncé à la tolérance', () => {
    expect(clampLate(135)).toBe(TOLERANCE)
    expect(clampLate(1)).toBe(5)
    expect(clampLate(12)).toBe(10)
  })
})
