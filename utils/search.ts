// Recherche de prestataires par ce qu'ils font, pas seulement par leur nom.
import type { Category, Pro, Service } from '~/data/pros'

/** Mots que les gens tapent pour chaque métier, même s'ils ne figurent dans aucun nom de prestation. */
const KEYWORDS: Record<Category, string> = {
  visage: 'soins visage soin visage peau nettoyage hydrafacial gommage masque anti-age éclat esthétique esthéticienne institut beauté',
  maquillage: 'maquillage make-up makeup maquilleuse mariée teint soirée shooting mise en beauté',
  epilation: 'épilation epilation cire cire tiède jambes maillot aisselles sourcils fil lumière pulsée laser',
  cils: 'cils cil extensions faux-cils lash regard sourcils rehaussement brow',
  coiffure: 'coiffure coiffeur coiffeuse cheveux coupe brushing couleur coloration lissage mèches boucles tresses nattes braids box braids vanilles tissage perruque défrisage chignon femme',
  barbier: 'barbier barbe barber homme hommes dégradé rasage coupe homme contours',
  locks: 'locks dreadlocks retwist départ de locks microlocks entretien locks cheveux crépus naturels',
  ongles: 'ongles ongle manucure vernis gel nails onglerie mains capsules french nail art semi-permanent',
  pieds: 'pieds pédicure pedicure beauté des pieds vernis talons ongles des pieds soin des pieds podologie',
  corps: 'soins du corps corps gommage enveloppement hammam spa sauna jacuzzi bain balnéo bien-être esthétique corporelle',
  massage: 'massage masseur masseuse relaxation détente réflexologie pierres chaudes californien prénatal dos sportif bien-être',
  minceur: 'minceur amincissement palper-rouler cellulite drainage lymphatique modelage silhouette cryolipolyse sculptant',
  bronzage: 'bronzage bronzer solaire autobronzant spray tan cabine uv hâle beauté solaire',
  dermo: 'maquillage permanent dermopigmentation microblading micropigmentation sourcils lèvres eye-liner pigmentation',
  tatouage: 'tatouage tatouages tatoo tattoo tatoueur tatoueuse encre ink flash lettrage cover-up fine-line',
  piercing: 'piercing percing perçage perceur bijou oreille nez septum nombril cartilage hélix',
  medecine: 'médecine esthétique medecine injections botox acide hyaluronique peeling mésothérapie détatouage laser consultation médecin',
  evenements: 'mariage mariée évènement événement soirée baptême cérémonie invitée demoiselles d\'honneur coiffure maquillage à domicile',
  formations: 'formation atelier cours consultation conseil auto-maquillage stage initiation apprendre',
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

export function searchPros(pros: Pro[], query: string, distance: (p: Pro) => number = () => 0): SearchHit[] {
  const tokens = words(query).filter(t => !STOP.has(t))
  if (!tokens.length) return pros.map(pro => ({ pro, services: [], score: 0 })).sort((a, b) => distance(a.pro) - distance(b.pro))
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
  return hits.sort((a, b) => b.score - a.score || distance(a.pro) - distance(b.pro))
}

/** Reconnaît, au nom d'une prestation, la catégorie à laquelle elle appartient (sans accents, en minuscules). */
const SERVICE_PATTERNS: Record<Category, RegExp> = {
  visage: /\bvisage\b|nettoyage de peau|hydrafacial|soin eclat/,
  maquillage: /maquillage(?! permanent)|make ?up/,
  epilation: /epilation|\bcire\b/,
  cils: /\bcils?\b|sourcil|\blash|rehaussement|\bbrow/,
  coiffure: /brushing|coupe femme|coloration|\bmeches\b|balayage|lissage|tresse|braids|vanille|nattes|chignon|defrisage|perruque|tissage|coiffure|boucles|wash and go|shampoing/,
  barbier: /\bbarbe\b|degrade|coupe homme|rasage|contours/,
  locks: /\blocks?\b|retwist|dread/,
  ongles: /\bongle|pose gel|remplissage gel|capsule|manucure|nail|semi permanent mains|baby boomer|\bfrench\b/,
  pieds: /\bpieds?\b|pedicure|talon/,
  corps: /gommage|enveloppement|hammam|sauna|soin du corps|\bcorps\b|\bspa\b|bain a remous/,
  massage: /massage|reflexologie/,
  minceur: /minceur|palper|cellulite|drainage|silhouette|sculptant|cryolipolyse/,
  bronzage: /bronzage|autobronzant|spray tan/,
  dermo: /microblading|sourcils poudres|maquillage permanent|eye liner permanent|dermopigmentation|micropigmentation/,
  tatouage: /tatouage|tattoo|cover up|flash/,
  piercing: /piercing|percage/,
  medecine: /injection|botox|hyaluronique|mesotherapie|peeling medical|laser|detatouage/,
  evenements: /mariee|mariage|ceremonie|bapteme|demoiselle|invitee|evenement|carnaval/,
  formations: /atelier|formation|\bcours\b|initiation|consultation (colorimetrie|routine)/,
}

/** Prestations d'une fiche qui relèvent d'une catégorie, même si la fiche n'est pas rangée dans cette catégorie. */
export function servicesInCat(p: Pro, cat: Category): Service[] {
  const re = SERVICE_PATTERNS[cat]
  return re ? p.services.filter(s => re.test(normalize(s.n))) : []
}

/** Une fiche fait partie d'une catégorie si elle y est rangée, ou si elle propose au moins une prestation de cette catégorie. */
export function inCategory(p: Pro, cat: Category): boolean {
  return p.cats.includes(cat) || servicesInCat(p, cat).length > 0
}
