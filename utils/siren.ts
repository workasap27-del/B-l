// Contrôle d'un numéro SIREN : 9 chiffres dont le dernier est une clé de Luhn.

/** Retire les espaces et ne garde que les chiffres. */
export function cleanSiren(s: string): string {
  return s.replace(/\s/g, '')
}

export function validSiren(raw: string): boolean {
  const s = cleanSiren(raw)
  if (!/^\d{9}$/.test(s)) return false
  let sum = 0
  for (let i = 0; i < 9; i++) {
    let d = Number(s[8 - i])
    if (i % 2 === 1) {
      d *= 2
      if (d > 9) d -= 9
    }
    sum += d
  }
  return sum % 10 === 0
}
