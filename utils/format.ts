// Petits formats d'affichage.
export function fr(n: number): string {
  return String(n).replace('.', ',')
}

/** "45 min", "1 h 30", "2 h" */
export function duration(min: number): string {
  if (min < 60) return `${min} min`
  const h = Math.floor(min / 60)
  const m = min % 60
  return m ? `${h} h ${String(m).padStart(2, '0')}` : `${h} h`
}

/** Statut d'un prestataire affiché sans accord de genre : "Indépendant·e". */
export function kindLabel(kind: string): string {
  return kind === 'Indépendante' || kind === 'Indépendant' ? 'Indépendant·e' : kind
}

export function capitalize(s: string): string {
  return s.charAt(0).toUpperCase() + s.slice(1)
}
