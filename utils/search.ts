// Recherche de prestataires par ce qu'ils font, pas seulement par leur nom.
import type { Category, Pro, Service } from '~/data/pros'

/** Mots que les gens tapent pour chaque métier, même s'ils ne figurent dans aucun nom de prestation. */
const KEYWORDS: Record<Category, string> = {
  ongles: 'ongles ongle manucure pédicure vernis gel nails onglerie mains pieds capsules french',
  cils: 'cils cil extensions faux-cils lash regard sourcils rehaussement brow',
  coiffure: 'coiffure coiffeur coiffeuse cheveux coupe brushing couleur coloration lissage mèches boucles',
  tresses: 'tresses nattes braids locks dreadlocks vanilles tissage perruque',
  maquillage: 'maquillage make-up makeup maquilleuse mariée teint',
  soins: 'soins visage épilation cire massage gommage esthétique esthéticienne spa',
  barbier: 'barbier barbe barber homme dégradé rasage',
}

export interface SearchHit {
  pro: Pro
  /** prestations qui correspondent à la recherche, à afficher sur la carte */
  services: Service[]
  score: number
}

/** Minuscules, sans accents ni ponctuation. */
export function normalize(text: string): string {
  return text.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, ' ').trim()
}

/** "cils" et "cil", "ongles" et "ongle" doivent se retrouver. */
function stem(word: string): string {
  return word.length > 3 ? word.replace(/[sx]$/, '') : word
}

function words(text: string): string[] {
  return normalize(text).split(' ').filter(Boolean).map(stem)
}

const has = (list: string[], token: string) => list.some(w => w.startsWith(token))

/** Petits mots sans intérêt pour la recherche ("extension de cils", "coupe pour homme"). */
const STOP = new Set(['de', 'des', 'du', 'd', 'la', 'le', 'les', 'l', 'un', 'une', 'a', 'au', 'aux', 'et', 'ou', 'en', 'pour', 'avec', 'sur', 'chez', 'mes', 'me', 'je', 'veux', 'cherche'])

export function searchPros(pros: Pro[], query: string): SearchHit[] {
  const tokens = words(query).filter(t => !STOP.has(t))
  if (!tokens.length) return pros.map(pro => ({ pro, services: [], score: 0 }))
  const hits: SearchHit[] = []
  for (const pro of pros) {
    const identity = words([pro.name, pro.owner ?? '', pro.commune, pro.quartier, pro.kind].join(' '))
    const trade = words([...pro.cats.map(c => `${c} ${KEYWORDS[c]}`), ...pro.tags].join(' '))
    const lines = pro.services.map(s => ({ s, w: words(s.n) }))
    let score = 0
    let all = true
    const matched = new Set<Service>()
    for (const t of tokens) {
      const inService = lines.filter(l => has(l.w, t))
      inService.forEach(l => matched.add(l.s))
      if (inService.length) score += 3
      else if (has(trade, t)) score += 2
      else if (has(identity, t)) score += 1
      else {
        all = false
        break
      }
    }
    if (!all) continue
    // Les prestations qui contiennent tous les mots passent devant celles qui n'en contiennent qu'un.
    const ranked = [...matched].sort((a, b) => count(b) - count(a))
    hits.push({ pro, services: ranked.length ? ranked.slice(0, 3) : score > tokens.length ? pro.services.slice(0, 2) : [], score })
    function count(s: Service) {
      const w = words(s.n)
      return tokens.filter(t => has(w, t)).length
    }
  }
  return hits.sort((a, b) => b.score - a.score || a.pro.dist - b.pro.dist)
}
