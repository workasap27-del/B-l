import { describe, expect, it } from 'vitest'
import { googleCalendarUrl, icsText } from '../utils/ics'

const e = { id: 'abc', title: 'Pose gel, Kaz a Zong', date: '2026-10-20', time: 14 * 60, dur: 90, place: 'Raizet, Les Abymes', details: 'Réservé sur VLADI' }

describe('ajout à l\'agenda', () => {
  it('écrit l\'heure de la Guadeloupe en temps universel', () => {
    const t = icsText(e, new Date('2026-10-01T00:00:00Z'))
    expect(t).toContain('DTSTART:20261020T180000Z')
    expect(t).toContain('DTEND:20261020T193000Z')
    expect(t).toContain('SUMMARY:Pose gel\\, Kaz a Zong')
    expect(t).toContain('TRIGGER:-PT2H')
  })
  it('prépare le lien Google Agenda', () => {
    expect(googleCalendarUrl(e)).toContain('dates=20261020T180000Z%2F20261020T193000Z')
  })
})
