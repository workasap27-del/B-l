// Positions et distances. Les coordonnées des communes sont approximatives (centre du bourg).

export interface LatLng { lat: number, lng: number }

export const COMMUNE_COORDS: Record<string, [number, number]> = {
  'Les Abymes': [16.2706, -61.5046],
  'Pointe-à-Pitre': [16.2411, -61.5331],
  'Baie-Mahault': [16.2674, -61.5854],
  'Le Gosier': [16.2064, -61.4930],
  'Petit-Bourg': [16.1914, -61.5903],
  'Sainte-Anne': [16.2264, -61.3794],
  'Le Moule': [16.3310, -61.3470],
  'Sainte-Rose': [16.3324, -61.6977],
  'Capesterre-Belle-Eau': [16.0434, -61.5650],
  'Basse-Terre': [15.9958, -61.7292],
  "Morne-à-l'Eau": [16.3320, -61.4570],
  'Lamentin': [16.2710, -61.6330],
  'Saint-François': [16.2523, -61.2740],
  'Saint-Claude': [16.0260, -61.7020],
  'Goyave': [16.1360, -61.5740],
  'Petit-Canal': [16.3810, -61.4870],
  'Port-Louis': [16.4190, -61.5310],
  'Gourbeyre': [15.9930, -61.6920],
  'Trois-Rivières': [15.9760, -61.6450],
  'Bouillante': [16.1300, -61.7690],
  'Deshaies': [16.3050, -61.7940],
  'Pointe-Noire': [16.2310, -61.7880],
  'Vieux-Habitants': [16.0590, -61.7650],
  'Anse-Bertrand': [16.4720, -61.5090],
  'Baillif': [16.0200, -61.7460],
  'Grand-Bourg': [15.8840, -61.3140],
  'Capesterre-de-Marie-Galante': [15.8960, -61.2210],
  'Saint-Louis': [15.9560, -61.3150],
  'Vieux-Fort': [15.9500, -61.7030],
  'Terre-de-Haut': [15.8670, -61.5830],
  'Terre-de-Bas': [15.8500, -61.6400],
  'La Désirade': [16.3030, -61.0780],
}

export const GUADELOUPE_CENTER: LatLng = { lat: 16.2, lng: -61.55 }

export function communePoint(name: string): LatLng {
  const c = COMMUNE_COORDS[name] ?? COMMUNE_COORDS['Les Abymes']
  return { lat: c[0], lng: c[1] }
}

/** Distance à vol d'oiseau, en km. */
export function haversineKm(a: LatLng, b: LatLng): number {
  const rad = (x: number) => (x * Math.PI) / 180
  const dLat = rad(b.lat - a.lat)
  const dLng = rad(b.lng - a.lng)
  const h = Math.sin(dLat / 2) ** 2 + Math.cos(rad(a.lat)) * Math.cos(rad(b.lat)) * Math.sin(dLng / 2) ** 2
  return 6371 * 2 * Math.asin(Math.sqrt(h))
}

/** Estimation de la distance par la route : vol d'oiseau majoré de 30 %. Ce n'est pas un calcul d'itinéraire. */
export function roadKm(a: LatLng, b: LatLng): number {
  return haversineKm(a, b) * 1.3
}

export function formatKm(km: number): string {
  if (km < 1) return `${Math.max(50, Math.round((km * 1000) / 50) * 50)} m`
  if (km < 10) return `${String(Math.round(km * 10) / 10).replace('.', ',')} km`
  return `${Math.round(km)} km`
}

/** Temps de trajet en voiture, estimé à 35 km/h de moyenne. */
export function driveMinutes(km: number): number {
  return Math.max(2, Math.round((km / 35) * 60))
}

/** L'utilisateur est-il en Guadeloupe (ou tout près) ? Sinon sa position GPS ne sert à rien ici. */
export function inGuadeloupe(p: LatLng): boolean {
  return haversineKm(p, GUADELOUPE_CENTER) < 120
}

/** Lien d'itinéraire vers une application de cartes. */
export function directionsUrl(to: LatLng): string {
  return `https://www.google.com/maps/dir/?api=1&destination=${to.lat.toFixed(5)},${to.lng.toFixed(5)}`
}
