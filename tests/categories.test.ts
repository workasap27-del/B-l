import { describe, expect, it } from 'vitest'
import { CATEGORIES, PROS, REVIEW_TEXTS } from '../data/pros'
import type { Category } from '../data/pros'
import { PHOTO_POOLS, CATEGORY_COVER } from '../utils/photos'
import { searchPros } from '../utils/search'
import { CAT_ICON, CAT_SHORT, readCategories } from '../utils/cats'
import { suggestedServices } from '../data/generate'

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
  it('il y a exactement les 19 catégories de la liste, dans l\'ordre', () => {
    expect(ids).toEqual(['visage', 'maquillage', 'epilation', 'cils', 'coiffure', 'barbier', 'locks', 'ongles', 'pieds', 'corps', 'massage', 'minceur', 'bronzage', 'dermo', 'tatouage', 'piercing', 'medecine', 'evenements', 'formations'])
    expect(CATEGORIES.find(c => c[0] === 'coiffure')?.[1]).toBe('Cheveux femmes')
    expect(CATEGORIES.find(c => c[0] === 'barbier')?.[1]).toBe('Cheveux hommes et barber')
  })
  it('chaque catégorie a un nom court et une icône', () => {
    for (const c of ids) {
      expect(CAT_SHORT[c], c).toBeTruthy()
      expect(CAT_ICON[c], c).toBeTruthy()
    }
  })
  it('chaque métier se trouve par ses mots courants', () => {
    for (const q of ['tatouage', 'tattoo', 'piercing', 'massage', 'pédicure', 'épilation', 'microblading', 'minceur', 'drainage', 'bronzage', 'mariage', 'atelier', 'peeling', 'locks', 'gommage']) {
      expect(searchPros(PROS, q).length, q).toBeGreaterThan(0)
    }
  })
  it('chaque catégorie propose des prestations courantes à la création d\'une fiche', () => {
    for (const c of ids) expect(suggestedServices(c).length, c).toBeGreaterThan(2)
  })
  it('les tresses sont des coiffures, les locks ont leur catégorie', () => {
    expect(PROS.every(p => !p.cats.includes('locks') || p.tags.some(t => /locks/i.test(t)) || p.services.some(s => /locks/i.test(s.n)))).toBe(true)
    expect(PROS.find(p => p.id === 'tre')?.cats).toEqual(['coiffure', 'locks'])
  })
  it('les métiers ajoutés ont des types d\'établissement adaptés', () => {
    expect(PROS.filter(p => p.cats[0] === 'tatouage').every(p => p.kind === 'Studio' || p.kind.startsWith('Indépendant'))).toBe(true)
    expect(PROS.some(p => p.kind === 'Hôtel')).toBe(false)
  })
  it('les identifiants sont uniques et les anciennes fiches n\'ont pas bougé', () => {
    expect(new Set(PROS.map(p => p.id)).size).toBe(PROS.length)
    expect(PROS.find(p => p.id === 'g001')).toBeTruthy()
  })
  it('aucun libellé de lieu genré', () => {
    expect(PROS.some(p => p.where.some(w => w === 'Chez elle' || w === 'Chez lui'))).toBe(false)
  })
  it('les fiches réelles aux anciennes catégories restent affichables avant la mise à jour de la base', () => {
    expect(readCategories(['tresses', 'coiffure', 'soins', 'ongles'])).toEqual(['coiffure', 'locks', 'visage', 'epilation', 'ongles'])
    expect(readCategories(['spa'])).toEqual(['massage', 'corps'])
    expect(readCategories(['hotel'])).toEqual(['massage'])
    expect(readCategories([])).toEqual(['visage'])
    expect(readCategories(['inconnue'])).toEqual(['visage'])
  })
})
