import { describe, expect, it } from 'vitest'
import { CATEGORIES, PROS, REVIEW_TEXTS } from '../data/pros'
import type { Category } from '../data/pros'
import { PHOTO_POOLS, CATEGORY_COVER } from '../utils/photos'
import { searchPros } from '../utils/search'

const ids = CATEGORIES.map(c => c[0]).filter(c => c !== 'all') as Category[]

describe('catégories', () => {
  it('chaque catégorie a ses photos, ses avis et au moins une fiche', () => {
    for (const c of ids) {
      expect(PHOTO_POOLS[c].length, c).toBeGreaterThan(5)
      expect(CATEGORY_COVER[c], c).toBeGreaterThan(0)
      expect(REVIEW_TEXTS[c].length, c).toBeGreaterThan(4)
      expect(PROS.some(p => p.cats.includes(c)), c).toBe(true)
    }
  })
  it('les nouveaux métiers se trouvent par leurs mots courants', () => {
    for (const q of ['tatouage', 'tattoo', 'piercing', 'massage', 'spa', 'hôtel', 'piscine']) {
      expect(searchPros(PROS, q).length, q).toBeGreaterThan(0)
    }
  })
  it('les nouveaux métiers ont des types d\'établissement adaptés', () => {
    const kinds = new Set(PROS.filter(p => p.cats[0] === 'hotel').map(p => p.kind))
    expect([...kinds]).toEqual(['Hôtel'])
    expect(PROS.filter(p => p.cats[0] === 'tatouage').every(p => p.kind === 'Studio' || p.kind.startsWith('Indépendant'))).toBe(true)
  })
  it('les identifiants sont uniques et les anciennes fiches n\'ont pas bougé', () => {
    expect(new Set(PROS.map(p => p.id)).size).toBe(PROS.length)
    expect(PROS.find(p => p.id === 'g001')).toBeTruthy()
  })
  it('aucun libellé de lieu genré', () => {
    expect(PROS.some(p => p.where.some(w => w === 'Chez elle' || w === 'Chez lui'))).toBe(false)
  })
})
