import { describe, expect, it } from 'vitest'
import { fitSize } from '../utils/image'

describe('réduction des photos', () => {
  it('ne grandit jamais une petite photo', () => {
    expect(fitSize(800, 600, 1600)).toEqual({ w: 800, h: 600 })
  })
  it('garde les proportions et limite le plus grand côté', () => {
    expect(fitSize(4032, 3024, 1600)).toEqual({ w: 1600, h: 1200 })
    expect(fitSize(3024, 4032, 1600)).toEqual({ w: 1200, h: 1600 })
  })
})
