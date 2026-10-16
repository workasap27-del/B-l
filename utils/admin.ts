// Pilotage : forme des indicateurs renvoyés par la base, et petites fonctions de calcul et de mise en forme.

export interface AdminStats {
  from: string | null
  accounts: { total: number, clients: number, pros: number, new: number, newClients: number, newPros: number, prevNew: number }
  fiches: { total: number, new: number, withServices: number, withBooking: number, atHome: number }
  bookings: {
    total: number, confirmed: number, cancelled: number, noShow: number, disputed: number, konyela: number, atHome: number
    gmv: number, deposits: number, avgBasket: number, avgLeadHours: number, clients: number, pros: number
  }
  previous: { total: number, gmv: number, cancelled: number, clients: number }
  loyalty: { clients: number, once: number, twoToThree: number, fourPlus: number, avgPerClient: number }
  reviews: { total: number, period: number, avg: number }
  daily: { d: string, bookings: number, signups: number, gmv: number }[]
  byCategory: { cat: string, bookings: number, gmv: number, clients: number }[]
  byCommune: { commune: string, bookings: number, gmv: number }[]
  fichesByCommune: { commune: string, fiches: number }[]
  byWeekday: { dow: number, bookings: number }[]
  byHour: { h: number, bookings: number }[]
  topPros: { id: string, name: string, commune: string, bookings: number, gmv: number, cancelled: number, rating: number | null }[]
  topServices: { name: string, cat: string, bookings: number, avg_price: number }[]
}

export interface AdminEvent {
  id: number
  at: string
  kind: string
  actor: string
  role: string
  pro: string
  detail: Record<string, unknown>
}

/** Part en pourcentage, arrondie, 0 si le total est nul. */
export function rate(part: number, total: number): number {
  return total > 0 ? Math.round((part / total) * 100) : 0
}

/** Évolution par rapport à la période précédente, ou null quand la comparaison n'a pas de sens. */
export function trend(current: number, previous: number): { pct: number, up: boolean } | null {
  if (!previous) return null
  const pct = Math.round(((current - previous) / previous) * 100)
  return { pct: Math.abs(pct), up: pct >= 0 }
}

export const EVENT_KINDS: Record<string, string> = {
  inscription: 'Inscriptions',
  role: 'Changements de profil',
  fiche_creee: 'Fiches publiées',
  fiche_modifiee: 'Fiches modifiées',
  prestation_ajoutee: 'Prestations ajoutées',
  prestation_modifiee: 'Prestations modifiées',
  prestation_retiree: 'Prestations retirées',
  konyela_publie: 'Créneaux Konyéla',
  reservation: 'Réservations',
  annulation: 'Annulations',
  absence: 'Absences',
  litige: 'Contestations',
  avis: 'Avis',
}

const money = (v: unknown) => `${Number(v ?? 0).toLocaleString('fr-FR', { maximumFractionDigits: 2 })} €`

/** Ce qui s'est passé, en une phrase courte. */
export function eventText(e: AdminEvent): string {
  const d = e.detail
  switch (e.kind) {
    case 'inscription': return d.role === 'pro' ? 'Inscription, compte prestataire' : 'Inscription, compte client·e'
    case 'role': return d.role === 'pro' ? 'Passe en compte prestataire' : 'Repasse en compte client·e'
    case 'fiche_creee': return `Fiche publiée${d.commune ? `, ${String(d.commune)}` : ''}`
    case 'fiche_modifiee': return 'Fiche modifiée'
    case 'prestation_ajoutee': return `Prestation ajoutée : ${String(d.name ?? '')} (${money(d.price)})`
    case 'prestation_modifiee': return `Prestation modifiée : ${String(d.name ?? '')}${d.active === false ? ' (désactivée)' : ''}`
    case 'prestation_retiree': return `Prestation retirée : ${String(d.name ?? '')}`
    case 'konyela_publie': return `Créneau Konyéla publié à -${String(d.discount ?? '')} %`
    case 'reservation': return `Réservation de ${money(d.price)}${d.mode === 'konyela' ? ', Konyéla' : ''}${d.place === 'client' ? ', à domicile' : ''}`
    case 'annulation': {
      const h = Number(d.hoursBefore ?? 0)
      const when = h >= 48 ? `${Math.round(h / 24)} jours avant` : h > 0 ? `${h} h avant` : 'après l\'heure prévue'
      return `Annulation par ${d.by === 'client' ? 'le/la client·e' : 'le/la prestataire'}, ${when}`
    }
    case 'absence': return d.who === 'client' ? 'Absence du/de la client·e signalée' : 'Absence du/de la prestataire signalée'
    case 'litige': return 'Contestation ouverte'
    case 'avis': return `Avis publié : ${String(d.stars ?? '')}/5`
    default: return e.kind
  }
}

/** Tableau prêt pour Excel en français : point-virgule, virgule décimale, BOM pour les accents. */
export function toCsv(rows: Record<string, unknown>[], columns: { key: string, label: string }[]): string {
  const cell = (v: unknown): string => {
    if (v === null || v === undefined) return ''
    const s = typeof v === 'number' ? String(v).replace('.', ',') : String(v)
    return /[;"\n\r]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s
  }
  const lines = [columns.map(c => cell(c.label)).join(';'), ...rows.map(r => columns.map(c => cell(r[c.key])).join(';'))]
  return `﻿${lines.join('\r\n')}\r\n`
}
