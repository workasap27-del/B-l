// Règles du mot de passe, d'après la recommandation de la CNIL (délibération 2022-100) :
// 12 caractères minimum, avec majuscule, minuscule, chiffre et caractère spécial.

export interface PasswordRule { label: string, ok: boolean }

/** Mots trop courants pour figurer dans un mot de passe. */
const WEAK = ['motdepasse', 'password', 'azerty', 'qwerty', '123456', 'vladi', 'guadeloupe', 'soleil', 'bonjour', 'admin']

const plain = (s: string) => s.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '')

export function passwordRules(p: string): PasswordRule[] {
  return [
    { label: '12 caractères minimum', ok: p.length >= 12 },
    { label: 'Une majuscule', ok: /\p{Lu}/u.test(p) },
    { label: 'Une minuscule', ok: /\p{Ll}/u.test(p) },
    { label: 'Un chiffre', ok: /\d/.test(p) },
    { label: 'Un caractère spécial (! ? @ # …)', ok: /[^\p{L}\d]/u.test(p) },
  ]
}

/** Message d'erreur, ou chaîne vide si le mot de passe est accepté. */
export function passwordError(p: string, email = ''): string {
  const missing = passwordRules(p).filter(r => !r.ok)
  if (missing.length) return `Mot de passe trop faible : ${missing.map(r => r.label.replace(/ \(.*\)$/, '').toLowerCase()).join(', ')}.`
  const low = plain(p)
  if (WEAK.some(w => low.includes(w))) return 'Mot de passe trop facile à deviner : évite les mots courants comme « azerty » ou « motdepasse ».'
  const user = plain(email.split('@')[0] ?? '')
  if (user.length >= 4 && low.includes(user)) return 'Le mot de passe ne doit pas contenir ton adresse e-mail.'
  if (/(.)\1{3,}/.test(p)) return 'Mot de passe trop facile à deviner : évite de répéter le même caractère.'
  return ''
}

/** Solidité de 0 (vide) à 4 (solide), pour la jauge. */
export function passwordStrength(p: string, email = ''): number {
  if (!p) return 0
  const ok = passwordRules(p).filter(r => r.ok).length
  if (ok < 5) return ok <= 2 ? 1 : 2
  if (passwordError(p, email)) return 2
  return p.length >= 16 ? 4 : 3
}

export const STRENGTH_LABEL = ['', 'Faible', 'Moyen', 'Solide', 'Très solide']
