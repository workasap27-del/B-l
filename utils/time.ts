// L'appli vit à l'heure de la Guadeloupe (UTC-4, sans changement d'heure), quel que soit le fuseau du téléphone.
// En base, les rendez-vous sont des instants (timestamptz) ; dans l'appli, une date AAAA-MM-JJ et des minutes depuis minuit.

export const GP_OFFSET = '-04:00'
const OFFSET_MS = -4 * 3600 * 1000

const pad = (n: number) => String(n).padStart(2, '0')

/** Date et minutes en Guadeloupe pour un instant donné. */
export function gpParts(d: Date): { date: string, min: number } {
  const g = new Date(d.getTime() + OFFSET_MS)
  return {
    date: `${g.getUTCFullYear()}-${pad(g.getUTCMonth() + 1)}-${pad(g.getUTCDate())}`,
    min: g.getUTCHours() * 60 + g.getUTCMinutes(),
  }
}

/** Instant ISO correspondant à une date et une heure en Guadeloupe. */
export function toIso(date: string, min: number): string {
  const base = new Date(`${date}T00:00:00${GP_OFFSET}`).getTime()
  return new Date(base + min * 60000).toISOString()
}

export function fromIso(iso: string): { date: string, min: number } {
  return gpParts(new Date(iso))
}
