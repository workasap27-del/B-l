import { describe, expect, it } from 'vitest'
import type { Pro } from '../data/pros'
import { servesCommune, travelZone } from '../utils/places'
import { communePoint, nearestCommune } from '../utils/geo'

const base = { where: ['À domicile'] } as unknown as Pro

describe('zone de déplacement à domicile', () => {
  it('sans liste : partout en Guadeloupe', () => {
    expect(travelZone(base)).toEqual([])
    expect(servesCommune(base, 'Deshaies')).toBe(true)
  })
  it('avec liste : seulement ces communes', () => {
    const p = { ...base, zone: ['Le Gosier', 'Les Abymes'] } as Pro
    expect(servesCommune(p, 'Le Gosier')).toBe(true)
    expect(servesCommune(p, 'Basse-Terre')).toBe(false)
  })
  it('ne se déplace pas : aucune commune, même avec une liste', () => {
    const p = { where: ['Au salon'], zone: ['Le Gosier'] } as unknown as Pro
    expect(servesCommune(p, 'Le Gosier')).toBe(false)
    expect(travelZone(p)).toEqual([])
  })
  it('retrouve la commune d\'une position', () => {
    expect(nearestCommune(communePoint('Sainte-Anne'))).toBe('Sainte-Anne')
    expect(nearestCommune({ lat: 16.243, lng: -61.53 })).toBe('Pointe-à-Pitre')
  })
})
