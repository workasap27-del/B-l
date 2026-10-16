// Photos des fiches de démonstration : photos libres de droits de Pexels (licence Pexels, usage commercial autorisé),
// choisies par métier. Un vrai prestataire peut avoir sa propre photo ; sinon il reçoit une photo de son métier.
import type { Category, Pro } from '~/data/pros'
import { hash } from '~/data/random'

export const PHOTO_POOLS: Record<Category, number[]> = {
  ongles: [16041439, 16041434, 7755221, 34930138, 37816588, 10401643, 4783335, 7446915, 18112333, 6135685, 4677849, 6135686, 998405, 34930139, 3997375, 30576970, 7446914],
  cils: [36930354, 7755523, 5128222, 6135662, 33637609, 8554941, 8558536, 38194468, 33723106, 7755650, 5128267, 21412169, 7755525, 5128234],
  coiffure: [36587243, 12275480, 7388967, 7389084, 7388920, 3993137, 7750115, 9146943, 8834018, 7388936, 7388923, 7389092, 30081801, 38300035, 7388926, 7388929],
  tresses: [39350589, 38285109, 5301538, 13767165, 11515382, 10810251, 34191088, 7607802, 8638585, 8973502, 4708719, 5301531, 4972222, 7190007, 10574707],
  maquillage: [11041338, 10698021, 39190651, 6870490, 39190657, 6878698, 39190650, 4910940, 31495767, 7815774, 39190654],
  soins: [36436447, 6187305, 30809943, 7581075, 12115040, 7446659, 3865548, 6978043, 12932911, 6663600],
  tatouage: [39626958, 2928342, 28991664, 35833278, 7005667, 14086379, 28991534, 7005723, 35645871, 8865959],
  piercing: [36587165, 7400019, 4857708, 7400018, 32275806, 13575093, 6924156, 10082804, 30875755],
  massage: [7233264, 38407786, 6629530, 6628701, 37719545, 6628649, 19388385, 6628601, 5888099, 37719540, 29821658, 6629556],
  spa: [6634828, 18161061, 9146381, 19329538, 18120173, 18408806, 36989815, 32203052, 6127261, 9483565],
  hotel: [34496701, 34496715, 33803734, 37729825, 97083, 8765693, 18285958, 2259226, 14841129, 32334284, 12652920, 14025024],
  barbier: [18503633, 4625626, 4625632, 33461079, 34702982, 4351727, 12464840, 18503604, 7697358, 12464837, 7447146, 19664864, 35157693, 7451207, 39089561],
}

/** Photo qui illustre chaque catégorie sur l'accueil. */
export const CATEGORY_COVER: Record<Category, number> = {
  ongles: 6135686, cils: 5128222, coiffure: 7388936, tresses: 11515382, maquillage: 39190651, soins: 7581075, barbier: 4625626,
  tatouage: 39626958, piercing: 7400019, massage: 7233264, spa: 6634828, hotel: 34496701,
}

export function pexels(id: number, w: number, h: number): string {
  return `https://images.pexels.com/photos/${id}/pexels-photo-${id}.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=${w}&h=${h}`
}

/** Identifiant de la photo d'un prestataire : toujours le même pour une fiche donnée. */
export function photoId(p: Pick<Pro, 'id' | 'cats'>): number {
  const pool = PHOTO_POOLS[p.cats[0]] ?? PHOTO_POOLS.coiffure
  return pool[hash(`photo${p.id}`) % pool.length]
}

/** Adresse de la photo, en deux tailles pour les écrans haute densité. */
export function photoSrc(p: Pick<Pro, 'id' | 'cats' | 'photo'>, w: number, h: number): { src: string, srcset: string } {
  if (p.photo) return { src: p.photo, srcset: '' }
  const id = photoId(p)
  return { src: pexels(id, w, h), srcset: `${pexels(id, w, h)} 1x, ${pexels(id, w * 2, h * 2)} 2x` }
}
