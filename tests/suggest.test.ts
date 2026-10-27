import { describe, expect, it } from 'vitest'
import { suggestCats, suggestSoins } from '../utils/suggest'
import type { SoinSuggestion } from '../utils/suggest'

const soins: SoinSuggestion[] = [
  { name: 'Pose gel', cat: 'ongles' },
  { name: 'Pose gel + couleur', cat: 'ongles' },
  { name: 'pose gel', cat: 'ongles' },
  { name: 'Extension de cils', cat: 'cils' },
  { name: 'Épilation sourcils', cat: 'cils' },
  { name: 'Maquillage mariée', cat: 'maquillage' },
]

describe('suggestions de soins', () => {
  it('trouve par début de mot, sans accents ni doublons', () => {
    expect(suggestSoins('epil', soins).map(s => s.name)).toEqual(['Épilation sourcils'])
    expect(suggestSoins('pose ge', soins).map(s => s.name)).toEqual(['Pose gel', 'Pose gel + couleur'])
  })
  it('met en premier ce qui commence par la saisie', () => {
    expect(suggestSoins('cils', soins).map(s => s.name)).toEqual(['Extension de cils'])
    expect(suggestSoins('ma', soins)[0].name).toBe('Maquillage mariée')
  })
  it('ne propose rien pour une saisie vide', () => {
    expect(suggestSoins('  ', soins)).toEqual([])
  })
})

describe('suggestions de catégories', () => {
  it('reconnaît le nom affiché', () => {
    expect(suggestCats('tat', [['tatouage', 'Tatouage'], ['massage', 'Massage']])).toEqual(['tatouage'])
    expect(suggestCats('barb', [['barbier', 'Cheveux hommes et barber'], ['coiffure', 'Cheveux femmes']])).toEqual(['barbier'])
  })
})
