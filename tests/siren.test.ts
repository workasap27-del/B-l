import { describe, expect, it } from 'vitest'
import { validSiren } from '../utils/siren'

describe('validSiren', () => {
  it('accepte de vrais SIREN, avec ou sans espaces', () => {
    expect(validSiren('552032534')).toBe(true)
    expect(validSiren('552 032 534')).toBe(true)
  })
  it('refuse une mauvaise clé', () => {
    expect(validSiren('123456789')).toBe(false)
    expect(validSiren('552032535')).toBe(false)
  })
  it('refuse une longueur ou des caractères incorrects', () => {
    expect(validSiren('55203253')).toBe(false)
    expect(validSiren('55203253a')).toBe(false)
    expect(validSiren('')).toBe(false)
  })
})
