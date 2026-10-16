import { describe, expect, it } from 'vitest'
import { readable } from '../composables/useBackend'

describe('readable (erreurs en français)', () => {
  it('traduit le délai de sécurité avec les secondes', () => {
    const m = readable(new Error('For security purposes, you can only request this after 53 seconds.'))
    expect(m).toBe('Pour ta sécurité, patiente 53 secondes avant de réessayer.')
  })
  it('traduit les erreurs courantes', () => {
    expect(readable(new Error('Invalid login credentials'))).toMatch(/incorrect/)
    expect(readable(new Error('Email not confirmed'))).toMatch(/Confirme/)
    expect(readable(new Error('Error sending recovery email'))).toMatch(/impossible/)
  })
  it('ne laisse pas d\'anglais pour le délai', () => {
    expect(readable(new Error('after 1 second'))).not.toMatch(/security/)
  })
})
