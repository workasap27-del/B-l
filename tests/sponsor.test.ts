import { describe, expect, it } from 'vitest'
import { withSponsored } from '../utils/sponsor'

const hits = ['a', 'b', 'c', 'd', 'e', 'f'].map(id => ({ pro: { id } }))

describe('mise en avant', () => {
  it('place au plus deux fiches sponsorisées, en 1re et 4e position', () => {
    const out = withSponsored(hits, new Set(['e', 'f', 'c']))
    expect(out.map(h => h.pro.id)).toEqual(['c', 'a', 'b', 'e', 'd', 'f'])
    expect(out.filter(h => h.sponsored).map(h => h.pro.id)).toEqual(['c', 'e'])
  })
  it('n\'ajoute jamais une fiche absente des résultats', () => {
    expect(withSponsored(hits, new Set(['z'])).map(h => h.pro.id)).toEqual(['a', 'b', 'c', 'd', 'e', 'f'])
  })
  it('garde toutes les fiches', () => {
    expect(withSponsored(hits, new Set(['b'])).length).toBe(6)
  })
})
