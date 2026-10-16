// Suggestions de la barre de recherche : soins et catégories qui correspondent à ce qui est tapé.
import type { Category } from '~/data/pros'
import { normalize } from './search'

export interface SoinSuggestion { name: string, cat: Category }

/** Ce que la recherche renvoie au formulaire : un texte, une catégorie ou « à domicile ». */
export interface SearchPick { label: string, q?: string, cat?: Category | 'domicile' }

/** Vrai si chaque mot tapé commence un mot du texte ("pose ge" trouve "Pose gel"). */
function matches(text: string, query: string): boolean {
  const words = normalize(text).split(' ')
  return normalize(query).split(' ').filter(Boolean).every(t => words.some(w => w.startsWith(t)))
}

/** Soins correspondant à la saisie, sans doublon, ceux qui commencent par la saisie d'abord, puis les plus courts. */
export function suggestSoins(query: string, soins: SoinSuggestion[], limit = 8): SoinSuggestion[] {
  const q = normalize(query)
  if (!q) return []
  const seen = new Set<string>()
  const out: (SoinSuggestion & { rank: number })[] = []
  for (const s of soins) {
    const key = normalize(s.name)
    if (seen.has(key) || !matches(s.name, query)) continue
    seen.add(key)
    out.push({ ...s, rank: (key.startsWith(q) ? 0 : 1000) + key.length })
  }
  return out.sort((a, b) => a.rank - b.rank).slice(0, limit).map(({ name, cat }) => ({ name, cat }))
}

/** Catégories dont le nom ou le nom long correspond à la saisie. */
export function suggestCats(query: string, labels: [Category, string][]): Category[] {
  if (!normalize(query)) return []
  return labels.filter(([c, label]) => matches(label, query) || matches(c, query)).map(([c]) => c)
}
