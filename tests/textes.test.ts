import { readdirSync, readFileSync, statSync } from 'node:fs'
import { join } from 'node:path'
import { describe, expect, it } from 'vitest'

// L'appli est en production : aucun texte visible ne doit parler de tests, de données fictives ou d'exemple,
// ni s'adresser au seul féminin.
const INTERDITS: [RegExp, string][] = [
  [/\btests?\b|\btester\b/i, 'test'],
  [/fictiv/i, 'fictif'],
  [/d'exemple|\bexemple\b/i, 'exemple'],
  [/simul[ée]/i, 'simulé'],
  [/\bclientes?\b/, 'cliente'],
  [/(?<!civile )\bprofessionnelles?\b/, 'professionnelle'],
  [/chez elle\b/i, 'chez elle'],
  [/[–—]/, 'tiret long'],
]

function vueFiles(dir: string): string[] {
  return readdirSync(dir).flatMap((f) => {
    const p = join(dir, f)
    return statSync(p).isDirectory() ? vueFiles(p) : p.endsWith('.vue') ? [p] : []
  })
}

/** Texte visible d'un composant : le gabarit, sans les commentaires ni les attributs techniques. */
function visible(src: string): string {
  const start = src.indexOf('<template>')
  const end = src.lastIndexOf('</template>')
  if (start < 0) return ''
  return src.slice(start, end)
    .replace(/<!--[\s\S]*?-->/g, '')
    .replace(/\s(?:id|for|class|key|to|href|v-[\w:.-]+|:[\w-]+|@[\w.-]+)="[^"]*"/g, '')
}

describe('textes visibles', () => {
  const root = join(__dirname, '..')
  const files = [...vueFiles(join(root, 'pages')), ...vueFiles(join(root, 'components')), ...vueFiles(join(root, 'layouts'))]
  for (const file of files) {
    it(file.replace(root, ''), () => {
      const text = visible(readFileSync(file, 'utf8'))
      for (const [re, name] of INTERDITS) {
        const m = text.match(re)
        expect(m, `${name} : « ${m ? text.slice(Math.max(0, m.index! - 40), m.index! + 40).replace(/\s+/g, ' ') : ''} »`).toBeNull()
      }
    })
  }
})

describe('nom des communes dans les phrases', () => {
  it('met le bon article', async () => {
    const { inCommune } = await import('../utils/format')
    expect(inCommune('Les Abymes')).toBe('aux Abymes')
    expect(inCommune('Le Gosier')).toBe('au Gosier')
    expect(inCommune('La Désirade')).toBe('à La Désirade')
    expect(inCommune('Baie-Mahault')).toBe('à Baie-Mahault')
  })
})
