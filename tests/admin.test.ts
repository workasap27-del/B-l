import { describe, expect, it } from 'vitest'
import { eventText, rate, toCsv, trend } from '../utils/admin'

describe('indicateurs de pilotage', () => {
  it('calcule une part sans diviser par zéro', () => {
    expect(rate(1, 4)).toBe(25)
    expect(rate(3, 0)).toBe(0)
  })
  it('compare à la période précédente', () => {
    expect(trend(15, 10)).toEqual({ pct: 50, up: true })
    expect(trend(5, 10)).toEqual({ pct: 50, up: false })
    expect(trend(4, 0)).toBeNull()
  })
})

describe('journal', () => {
  const base = { id: 1, at: '2026-10-16T12:00:00Z', actor: 'Inès', role: 'client', pro: 'Kaz Ongles' }
  it('décrit une annulation tardive par le/la client·e', () => {
    expect(eventText({ ...base, kind: 'annulation', detail: { by: 'client', hoursBefore: 5 } })).toBe('Annulation par le/la client·e, 5 h avant')
  })
  it('décrit une réservation Konyéla à domicile', () => {
    expect(eventText({ ...base, kind: 'reservation', detail: { price: 42.5, mode: 'konyela', place: 'client' } })).toBe('Réservation de 42,5 €, Konyéla, à domicile')
  })
})

describe('export tableur', () => {
  it('produit un CSV lisible par Excel en français', () => {
    const csv = toCsv([{ a: 'Salon "Doux"', b: 12.5 }, { a: 'Ligne;2', b: null }], [{ key: 'a', label: 'Nom' }, { key: 'b', label: 'Prix' }])
    expect(csv.startsWith('﻿Nom;Prix\r\n')).toBe(true)
    expect(csv).toContain('"Salon ""Doux""";12,5')
    expect(csv).toContain('"Ligne;2";')
  })
})
