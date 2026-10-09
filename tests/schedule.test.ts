import { describe, expect, it } from 'vitest'
import { PROS } from '../data/pros'
import { addDays, dayLabel, diffDays, discounted, freeStarts, gaps, hm, isClosed, simulatedAppointments } from '../utils/schedule'

const kaz = PROS.find(p => p.id === 'kaz')!
const names = PROS.map(p => p.name)

describe('dates', () => {
  it('ajoute des jours en passant le mois', () => {
    expect(addDays('2026-10-30', 3)).toBe('2026-11-02')
    expect(diffDays('2026-10-09', '2026-10-12')).toBe(3)
  })
  it('nomme les jours proches', () => {
    expect(dayLabel('2026-10-10', '2026-10-10')).toBe("aujourd'hui")
    expect(dayLabel('2026-10-11', '2026-10-10')).toBe('demain')
    expect(dayLabel('2026-10-13', '2026-10-10')).toBe('mar. 13 oct.')
  })
  it('formate les heures', () => {
    expect(hm(605)).toBe('10h05')
  })
})

describe('agenda', () => {
  it('ferme le dimanche chez Kaz a Zong', () => {
    expect(isClosed(kaz, '2026-10-11')).toBe(true)
    expect(freeStarts(kaz, '2026-10-11', 30, [])).toEqual([])
  })
  it('ne propose aucun créneau qui chevauche un rendez-vous', () => {
    const starts = freeStarts(kaz, '2026-10-10', 60, [[600, 690]])
    expect(starts).toContain(540)
    expect(starts).not.toContain(570)
    expect(starts).not.toContain(660)
    expect(starts).toContain(690)
  })
  it("respecte l'heure minimale et la fermeture", () => {
    const starts = freeStarts(kaz, '2026-10-10', 90, [], 1000)
    expect(starts[0]).toBe(1020)
    expect(starts.at(-1)).toBe(1050)
  })
  it('simule le même agenda à chaque appel, sans chevauchement', () => {
    const a = simulatedAppointments(kaz, '2026-10-10')
    expect(simulatedAppointments(kaz, '2026-10-10')).toEqual(a)
    for (let i = 1; i < a.length; i++) expect(a[i].a).toBeGreaterThanOrEqual(a[i - 1].b)
    for (const x of a) expect(x.b).toBeLessThanOrEqual(kaz.close)
  })
  it('trouve les trous entre les rendez-vous', () => {
    expect(gaps(kaz, [[540, 600], [660, 1140]])).toEqual([[600, 660]])
  })
  it('arrondit le prix remisé', () => {
    expect(discounted(kaz.services[0], 30)).toBe(39)
  })
})

describe('catalogue', () => {
  it('couvre toute la Guadeloupe sans doublon', () => {
    expect(PROS.length).toBeGreaterThan(120)
    expect(new Set(names).size).toBe(names.length)
    expect(new Set(PROS.map(p => p.id)).size).toBe(PROS.length)
    expect(new Set(PROS.map(p => p.commune)).size).toBeGreaterThanOrEqual(30)
  })
  it('donne à chaque prestataire des prestations réservables dans ses horaires', () => {
    for (const p of PROS) {
      expect(p.services.length).toBeGreaterThanOrEqual(4)
      expect(new Set(p.services.map(s => s.id)).size).toBe(p.services.length)
      for (const s of p.services) {
        expect(s.p).toBeGreaterThan(0)
        expect(s.d).toBeLessThanOrEqual(p.close - p.open)
      }
    }
  })
})
