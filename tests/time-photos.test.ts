import { describe, expect, it } from 'vitest'
import { fromIso, gpParts, toIso } from '../utils/time'
import { PHOTO_POOLS, photoId, photoSrc } from '../utils/photos'
import { PROS } from '../data/pros'

describe('heure de la Guadeloupe', () => {
  it('convertit un instant en date et minutes locales', () => {
    expect(gpParts(new Date('2026-10-16T02:30:00Z'))).toEqual({ date: '2026-10-15', min: 22 * 60 + 30 })
    expect(gpParts(new Date('2026-10-15T13:00:00Z'))).toEqual({ date: '2026-10-15', min: 9 * 60 })
  })
  it('fait l\'aller-retour sans décalage', () => {
    for (const [d, m] of [['2026-10-15', 540], ['2026-12-31', 1410], ['2026-03-29', 0]] as [string, number][]) {
      expect(fromIso(toIso(d, m))).toEqual({ date: d, min: m })
    }
    expect(toIso('2026-10-15', 600)).toBe('2026-10-15T14:00:00.000Z')
  })
})

describe('photos', () => {
  it('donne à chaque fiche une photo de son métier, toujours la même', () => {
    for (const p of PROS) {
      expect(PHOTO_POOLS[p.cats[0]]).toContain(photoId(p))
      expect(photoId(p)).toBe(photoId(p))
    }
  })
  it('varie les photos entre les fiches', () => {
    const used = new Set(PROS.map(photoId))
    expect(used.size).toBeGreaterThan(60)
  })
  it('respecte la photo choisie par le prestataire', () => {
    expect(photoSrc({ id: 'x', cats: ['ongles'], photo: 'https://exemple.gp/a.jpg' }, 400, 300).src).toBe('https://exemple.gp/a.jpg')
    expect(photoSrc({ id: 'x', cats: ['ongles'] }, 400, 300).srcset).toContain('w=800')
  })
})
