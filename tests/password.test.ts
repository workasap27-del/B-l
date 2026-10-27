import { describe, expect, it } from 'vitest'
import { passwordError, passwordRules, passwordStrength } from '../utils/password'

describe('mot de passe', () => {
  it('exige 12 caractères, majuscule, minuscule, chiffre et caractère spécial', () => {
    expect(passwordError('court1!A')).toMatch(/12 caractères/)
    expect(passwordError('toutenminuscule1!')).toMatch(/majuscule/)
    expect(passwordError('TOUTENMAJUSCULE1!')).toMatch(/minuscule/)
    expect(passwordError('SansChiffreIci!')).toMatch(/chiffre/)
    expect(passwordError('SansSpecial1234')).toMatch(/caractère spécial/)
    expect(passwordError('Kanne-a-sik-2026')).toBe('')
  })
  it('accepte les lettres accentuées', () => {
    expect(passwordRules('Élodie-ka-dansé9').every(r => r.ok)).toBe(true)
  })
  it('refuse les mots courants, l\'adresse e-mail et les répétitions', () => {
    expect(passwordError('Azerty-2026-ok!')).toMatch(/deviner/)
    expect(passwordError('Motdepasse-2026')).toMatch(/deviner/)
    expect(passwordError('Laurine-971-Gwada', 'laurine@mail.com')).toMatch(/adresse e-mail/)
    expect(passwordError('Aaaaa-bonne-971')).toMatch(/répéter/)
  })
  it('donne une solidité de 0 à 4', () => {
    expect(passwordStrength('')).toBe(0)
    expect(passwordStrength('abc')).toBe(1)
    expect(passwordStrength('Kanne-a-sik-2026')).toBe(4)
    expect(passwordStrength('Kanne-sik-26')).toBe(3)
  })
})
