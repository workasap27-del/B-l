import { describe, expect, it } from 'vitest'
import { buildMail, longWhen } from '../utils/emails'
import type { MailData } from '../utils/emails'

const base: MailData = {
  kind: 'confirmation', bookingId: 'b1', toName: 'Inès', proId: 'kaz', proName: 'Kaz a Zong', proPhone: '0690 11 22 33',
  serviceName: 'Pose gel', startsAt: '2026-10-20T18:00:00.000Z', place: 'pro', price: 55, clientName: 'Inès', commune: 'Les Abymes', quartier: 'Raizet',
}

describe('e-mails de service', () => {
  it('donne l\'heure de la Guadeloupe', () => {
    expect(longWhen('2026-10-20T18:00:00.000Z')).toBe('mardi 20 octobre à 14h00')
  })
  it('confirme le rendez-vous à la personne qui réserve', () => {
    const m = buildMail(base, 'https://vladi.gp')
    expect(m.subject).toBe('C\'est réservé : Pose gel chez Kaz a Zong')
    expect(m.text).toContain('Pose gel, mardi 20 octobre à 14h00, chez Kaz a Zong, Raizet, Les Abymes.')
    expect(m.text).toContain('https://vladi.gp/rdv')
    expect(m.html).toContain('href="https://vladi.gp/rdv"')
  })
  it('prévient le prestataire avec le téléphone et l\'adresse à domicile', () => {
    const m = buildMail({ ...base, kind: 'nouvelle_reservation', place: 'client', clientAddress: '12 rue des Palmiers', clientPhone: '0690 00 00 00' }, 'https://vladi.gp')
    expect(m.text).toContain('à domicile : 12 rue des Palmiers')
    expect(m.text).toContain('Téléphone : 0690 00 00 00')
  })
  it('échappe le HTML venu des fiches', () => {
    const m = buildMail({ ...base, proName: '<b>Kaz</b>' }, 'https://vladi.gp')
    expect(m.html).not.toContain('<b>Kaz</b>')
    expect(m.html).toContain('&lt;b&gt;Kaz&lt;/b&gt;')
  })
  it('a un sujet pour chaque e-mail', () => {
    for (const kind of ['confirmation', 'nouvelle_reservation', 'annulation_pro', 'annulation_client', 'rappel_veille', 'rappel_2h', 'avis'] as const) {
      expect(buildMail({ ...base, kind }, 'https://vladi.gp').subject.length, kind).toBeGreaterThan(10)
    }
  })
})
