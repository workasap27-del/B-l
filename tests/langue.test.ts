import { readdirSync, readFileSync, statSync } from 'node:fs'
import { join } from 'node:path'
import { describe, expect, it } from 'vitest'
import { EN } from '../locales/en'
import { translate } from '../composables/useLang'

// Toute phrase passée à t(), translate() ou toast() doit avoir sa traduction anglaise.
const ROOT = join(__dirname, '..')
const SKIP = ['node_modules', '.nuxt', '.output', 'tests', 'server', '.git']
// Pages réservées à l'équipe, aux prestataires de Guadeloupe ou à valeur juridique : en français seulement.
const FRENCH_ONLY = ['pilotage.vue', 'cgu.vue', 'confidentialite.vue', 'mentions-legales.vue', 'espace-pro']

function files(dir: string): string[] {
  return readdirSync(dir).flatMap((f) => {
    const p = join(dir, f)
    if (SKIP.includes(f)) return []
    if (statSync(p).isDirectory()) return files(p)
    return /\.(vue|ts)$/.test(f) ? [p] : []
  })
}

describe('traduction anglaise', () => {
  it('chaque texte traduisible a sa version anglaise', () => {
    const missing: string[] = []
    for (const f of files(ROOT)) {
      if (FRENCH_ONLY.some(x => f.includes(x)) || f.endsWith('locales/en.ts')) continue
      const src = readFileSync(f, 'utf8')
      const keys = [
        ...[...src.matchAll(/(?<![\w.])(?:t|translate|toast)\(\s*'((?:\\.|[^'\\])*)'/g)].map(m => m[1]),
        // Branches d'une condition passée directement : t(x ? 'Oui' : 'Non')
        ...[...src.matchAll(/(?<![\w.])(?:t|translate|toast)\(\s*[\w.!=<> ]+\?\s*'((?:\\.|[^'\\])*)'\s*:\s*'((?:\\.|[^'\\])*)'/g)].flatMap(m => [m[1], m[2]]),
        // Textes marqués pour une traduction différée : tr('…')
        ...[...src.matchAll(/(?<![\w.])tr\(\s*'((?:\\.|[^'\\])*)'/g)].map(m => m[1]),
      ]
      for (const k of keys) {
        const key = k.replace(/\\'/g, '\'')
        if (/[A-Za-zÀ-ÿ]/.test(key) && !(key in EN)) missing.push(`${f.replace(ROOT, '')} : ${key}`)
      }
    }
    expect(missing).toEqual([])
  })
  it('remplace les variables dans les deux langues', () => {
    expect(translate('Ouvre à {h}', { h: '9h00' }, 'fr')).toBe('Ouvre à 9h00')
    expect(translate('Ouvre à {h}', { h: '9h00' }, 'en')).toBe('Opens at 9h00')
  })
  it('garde les mêmes variables en anglais', () => {
    for (const [fr, en] of Object.entries(EN)) {
      const vars = (s: string) => [...s.matchAll(/\{(\w+)\}/g)].map(x => x[1]).sort().join(',')
      expect(vars(en), fr).toBe(vars(fr))
    }
  })
  it('n\'utilise pas de tiret long', () => {
    expect(Object.values(EN).filter(v => /[—–]/.test(v))).toEqual([])
  })
})
