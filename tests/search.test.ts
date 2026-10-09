import { describe, expect, it } from 'vitest'
import { PROS } from '../data/pros'
import { allowedPlaces, travelFee } from '../utils/places'
import { normalize, searchPros } from '../utils/search'

const names = (q: string) => searchPros(PROS, q).map(h => h.pro.name)

describe('recherche par prestation', () => {
  it('trouve Zombi quand on cherche des cils, alors que son nom n\'en dit rien', () => {
    for (const q of ['cils', 'cil', 'CILS', 'extension de cils', 'faux cils', 'rehaussement', 'sourcils']) {
      expect(names(q), q).toContain('Zombi')
    }
  })
  it('montre les prestations qui correspondent', () => {
    const hit = searchPros(PROS, 'rehaussement').find(h => h.pro.name === 'Zombi')!
    expect(hit.services.map(s => s.n)).toEqual(['Rehaussement + teinture'])
  })
  it('ne remonte pas un barbier pour une recherche de cils', () => {
    expect(names('cils')).not.toContain('Barber Lakou')
    for (const h of searchPros(PROS, 'cils')) expect(h.pro.cats.includes('cils') || h.services.length > 0, h.pro.name).toBe(true)
  })
  it('ignore les accents et le pluriel', () => {
    expect(normalize('Épilation  Sourcils!')).toBe('epilation sourcils')
    expect(names('epilation').length).toBe(names('épilation').length)
    expect(names('ongle').length).toBe(names('ongles').length)
    expect(names('ongles').length).toBeGreaterThan(20)
  })
  it('combine prestation et commune', () => {
    const hits = searchPros(PROS, 'tresses gosier')
    expect(hits.length).toBeGreaterThan(0)
    for (const h of hits) expect(h.pro.commune).toBe('Le Gosier')
  })
  it('trouve toujours par le nom', () => {
    expect(names('zombi')).toEqual(['Zombi'])
    expect(names('hibiscus')).toContain('Salon Hibiscus')
  })
  it('ne renvoie rien pour une prestation qui n\'existe pas', () => {
    expect(names('plomberie')).toEqual([])
  })
})

describe('lieux de prestation', () => {
  it('donne à chaque prestataire au moins un lieu', () => {
    for (const p of PROS) expect(allowedPlaces(p).length, p.name).toBeGreaterThan(0)
  })
  it('ne facture un déplacement que si le prestataire se déplace', () => {
    for (const p of PROS) if (!allowedPlaces(p).includes('client')) expect(travelFee(p)).toBe(0)
    expect(travelFee(PROS.find(p => p.id === 'kaz')!)).toBe(5)
  })
  it('propose les deux lieux chez une bonne partie des prestataires', () => {
    expect(PROS.filter(p => allowedPlaces(p).length === 2).length).toBeGreaterThan(40)
    expect(PROS.filter(p => allowedPlaces(p).includes('client')).length).toBeGreaterThan(60)
  })
})

describe('distances', () => {
  it('place chaque prestataire près du centre de sa commune', async () => {
    const { communePoint, haversineKm, inGuadeloupe } = await import('../utils/geo')
    for (const p of PROS) {
      expect(haversineKm(p, communePoint(p.commune)), p.name).toBeLessThan(2)
      expect(inGuadeloupe(p), p.name).toBe(true)
    }
  })
  it('calcule des distances plausibles', async () => {
    const { communePoint, roadKm, formatKm, inGuadeloupe, driveMinutes } = await import('../utils/geo')
    const d = roadKm(communePoint('Les Abymes'), communePoint('Basse-Terre'))
    expect(d).toBeGreaterThan(40)
    expect(d).toBeLessThan(75)
    expect(roadKm(communePoint('Les Abymes'), communePoint('Pointe-à-Pitre'))).toBeLessThan(8)
    expect(formatKm(0.42)).toBe('400 m')
    expect(formatKm(3.26)).toBe('3,3 km')
    expect(formatKm(27.4)).toBe('27 km')
    expect(driveMinutes(35)).toBe(60)
    expect(inGuadeloupe({ lat: 49.2, lng: 1.0 })).toBe(false)
  })
  it('trie les résultats du plus proche au plus loin', async () => {
    const { communePoint, roadKm } = await import('../utils/geo')
    const from = communePoint('Basse-Terre')
    const dist = (p: (typeof PROS)[number]) => roadKm(from, p)
    const hits = searchPros(PROS, '', dist)
    expect(hits[0].pro.commune).toBe('Basse-Terre')
    for (let i = 1; i < hits.length; i++) expect(dist(hits[i].pro)).toBeGreaterThanOrEqual(dist(hits[i - 1].pro))
  })
})
