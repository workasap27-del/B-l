// Fabrique un catalogue fictif de prestataires pour toute la Guadeloupe.
// Le résultat est toujours le même (hasard à graine fixe), donc les liens et les réservations de test restent valides.
import { rng } from './random'
import type { Category, Pro, Service } from './pros'
import { COMMUNE_COORDS } from '../utils/geo'

/** Commune, (ancien repère de distance, inutilisé), quartiers, nombre de prestataires fictifs. */
const COMMUNES: [string, number, string[], number][] = [
  ['Les Abymes', 2, ['Raizet', 'Grand-Camp', 'Dothémare', 'Boisripeaux', 'Chauvel', 'Petit-Pérou'], 15],
  ['Pointe-à-Pitre', 4, ['Centre-ville', 'Bergevin', 'Lauricisque', 'Massabielle', 'Carénage'], 11],
  ['Baie-Mahault', 8, ['Jarry', 'Destrellan', 'Convenance', 'La Jaille', 'Bourg'], 11],
  ['Le Gosier', 7, ['Bas-du-Fort', 'Mare-Gaillard', 'Montauban', 'Pliane', 'Bourg'], 10],
  ['Petit-Bourg', 13, ['Bourg', 'Colin', 'Vernou', 'Arnouville'], 7],
  ['Sainte-Anne', 20, ['Bourg', 'Durivage', 'Châteaubrun', 'Douville'], 7],
  ['Le Moule', 25, ['Bourg', 'Sergent', "L'Autre Bord", 'Damencourt'], 7],
  ['Sainte-Rose', 28, ['Bourg', 'La Boucan', 'Sofaïa', 'Viard'], 6],
  ['Capesterre-Belle-Eau', 32, ['Bourg', 'Sainte-Marie', 'Bananier', 'Saint-Sauveur'], 6],
  ['Basse-Terre', 60, ['Centre', 'Carmel', 'Petit-Paris', 'Rivière-des-Pères'], 6],
  ['Morne-à-l\'Eau', 12, ['Bourg', 'Vieux-Bourg', 'Perrin', 'Richeval'], 5],
  ['Lamentin', 16, ['Bourg', 'Blachon', 'Caillou', 'Ravine-Chaude'], 5],
  ['Saint-François', 35, ['Bourg', 'Marina', 'Bragelogne', 'Sainte-Marthe'], 5],
  ['Saint-Claude', 62, ['Bourg', 'Matouba', 'Morin'], 3],
  ['Goyave', 20, ['Bourg', 'Sainte-Claire', 'Morne-Rouge'], 3],
  ['Petit-Canal', 22, ['Bourg', 'Les Mangles', 'Gros-Cap'], 3],
  ['Port-Louis', 27, ['Bourg', 'Beauport', 'Pelletan'], 3],
  ['Gourbeyre', 55, ['Bourg', 'Rivière-Sens', 'Dolé'], 3],
  ['Trois-Rivières', 48, ['Bourg', 'Grande-Anse', 'Schoelcher'], 3],
  ['Bouillante', 50, ['Bourg', 'Pigeon', 'Malendure'], 3],
  ['Deshaies', 42, ['Bourg', 'Ferry', 'Grande-Anse'], 2],
  ['Pointe-Noire', 45, ['Bourg', 'Mahaut', 'Acomat'], 2],
  ['Vieux-Habitants', 60, ['Bourg', 'Marigot', 'Géry'], 2],
  ['Anse-Bertrand', 34, ['Bourg', 'Massioux', 'Campêche'], 2],
  ['Baillif', 63, ['Bourg', 'Saint-Robert'], 2],
  ['Grand-Bourg', 45, ['Bourg', 'Grande-Savane'], 2],
  ['Capesterre-de-Marie-Galante', 52, ['Bourg', 'Bézard'], 1],
  ['Saint-Louis', 50, ['Bourg', 'Vieux-Fort'], 1],
  ['Vieux-Fort', 62, ['Bourg'], 1],
  ['Terre-de-Haut', 60, ['Bourg', 'Marigot'], 1],
  ['Terre-de-Bas', 62, ['Petites-Anses'], 1],
  ['La Désirade', 55, ['Beauséjour'], 1],
]

const PRENOMS_F = ['Anaïs', 'Léa', 'Jessica', 'Kelly', 'Cynthia', 'Vanessa', 'Ingrid', 'Nadège', 'Murielle', 'Sabrina', 'Laëtitia', 'Audrey', 'Priscilla', 'Tatiana', 'Yaëlle', 'Shaïna', 'Kassandra', 'Lorna', 'Mylène', 'Rachelle', 'Ketsia', 'Naïka', 'Solène', 'Marjorie', 'Gwladys', 'Fabiola', 'Christelle', 'Daphné', 'Élodie', 'Stéphanie', 'Johanna', 'Marine', 'Leslie', 'Noémie', 'Axelle', 'Chloé', 'Wendy', 'Tracy', 'Lindsay', 'Malika', 'Samantha', 'Rébecca', 'Esther', 'Flora', 'Clarisse', 'Doriane', 'Émeline', 'Karine', 'Ludmila', 'Tessa', 'Yoline', 'Maïlys', 'Érika', 'Sandy', 'Joanie', 'Thaïs']
const PRENOMS_M = ['Kévin', 'Jordan', 'Steeve', 'Loïc', 'Dimitri', 'Wesley', 'Ruddy', 'Yannis', 'Teddy', 'Jonathan', 'Brice', 'Grégory', 'Manuel', 'Davy', 'Ludovic', 'Rodrigue', 'Marvin', 'Jimmy']
const MOTS = ['Alamanda', 'Flamboyant', 'Balisier', 'Bougainvillée', 'Frangipane', 'Corossol', 'Vanille', 'Cannelle', 'Maracudja', 'Karambole', 'Zandoli', 'Soufrière', 'Caravelle', 'Lagon', 'Corail', 'Sable Blanc', 'Ti Kaz', 'Solèy', 'Lalin', 'Zétwal', 'Lanmè', 'Kréyol', 'Gwada', 'Péyi', 'Coco', 'Goyave', 'Mango', 'Tamarin', 'Orchidée', 'Colibri Bleu', 'Alizés', 'Grand Large', 'Ti Paradis', 'Anoli', 'Kannèl', 'Jasmin', 'Ylang', 'Monbin', 'Pomme Cannelle', 'Trois Îlets']
const INITIALES = 'ABCDFGJKLMNPRSTV'

interface Trade {
  cat: Category
  share: number
  /** probabilité d'être un indépendant plutôt qu'un établissement */
  indep: number
  shop: 'Salon' | 'Institut'
  male?: boolean
  shopNames: string[]
  soloNames: string[]
  tags: string[]
  about: string[]
  soloAbout: string[]
  menu: [string, number, number][]
  extra?: Category
}

const TRADES: Trade[] = [
  {
    cat: 'ongles', share: 20, indep: 0.6, shop: 'Salon',
    shopNames: ['Nail Bar {m}', 'Onglerie {m}', '{m} Nails', "L'Atelier des Ongles {m}"],
    soloNames: ['{p} Nails', 'Ti Zong a {p}', 'Les Ongles de {p}', 'Nails by {p}', '{p} Onglerie'],
    tags: ['Pose gel', 'Nail art', 'Semi-permanent', 'Capsules', 'Baby boomer', 'Beauté des pieds', 'French'],
    about: ['Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.'],
    soloAbout: ['Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 'Reçoit dans un espace dédié, au calme, une cliente à la fois.'],
    menu: [['Pose gel + couleur', 90, 55], ['Remplissage gel', 60, 40], ['Semi-permanent mains', 45, 28], ['Semi-permanent pieds', 45, 30], ['Pose capsules + gel', 120, 58], ['Baby boomer', 120, 62], ['Nail art 10 doigts', 30, 15], ['Beauté des pieds complète', 60, 38], ['Dépose', 30, 15], ['Manucure express', 30, 18]],
    extra: 'cils',
  },
  {
    cat: 'coiffure', share: 22, indep: 0.3, shop: 'Salon',
    shopNames: ['Salon {m}', '{m} Coiffure', 'Hair {m}', "L'Atelier {m}", 'Coiffure {m}'],
    soloNames: ['{p} Coiffure', 'Coiffure by {p}', '{p} Hair', 'Les Boucles de {p}'],
    tags: ['Brushing', 'Lissage', 'Coloration', 'Cheveux texturés', 'Boucles', 'Défrisage', 'Balayage', 'Mixte'],
    about: ['Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.'],
    soloAbout: ['Coiffeuse diplômée, elle se déplace avec tout son matériel.', 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', "Coiffe à la maison pour les familles, enfants compris."],
    menu: [['Shampoing + brushing', 60, 30], ['Coupe + brushing', 60, 45], ['Coloration', 90, 65], ['Mèches et balayage', 150, 95], ['Lissage brésilien', 180, 160], ['Soin profond + coiffage boucles', 60, 40], ['Défrisage + soin', 120, 70], ['Coiffure événement', 60, 55], ['Coupe enfant', 30, 15], ['Wash and go', 60, 35]],
    extra: 'tresses',
  },
  {
    cat: 'tresses', share: 14, indep: 0.75, shop: 'Salon',
    shopNames: ['{m} Braids', 'Tresses {m}', 'Locks {m}', 'Natural {m}'],
    soloNames: ['Tresses by {p}', '{p} Braids', 'Les Nattes de {p}', '{p} Locks', 'Ti Très a {p}'],
    tags: ['Box braids', 'Knotless', 'Vanilles', 'Nattes collées', 'Locks', 'Crochet braids', 'Enfants'],
    about: ['Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 'Deux tresseuses pour aller plus vite sur les longues coiffures.'],
    soloAbout: ['Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 'Spécialiste des locks, du départ à l\'entretien.', 'Se déplace à domicile, mèches fournies sur demande en supplément.'],
    menu: [['Box braids mi-longues', 240, 110], ['Knotless braids', 300, 140], ['Vanilles', 120, 60], ['Nattes collées', 90, 45], ['Fulani braids', 180, 85], ['Retwist locks', 90, 50], ['Départ de locks', 180, 90], ['Crochet braids', 150, 75], ['Pose de perruque', 60, 45], ['Tresses enfant', 90, 35]],
  },
  {
    cat: 'cils', share: 12, indep: 0.6, shop: 'Institut',
    shopNames: ['Regard {m}', '{m} Lash', 'Institut {m} Regard', 'Studio Cils {m}'],
    soloNames: ['Cils by {p}', '{p} Lash', 'Le Regard de {p}', '{p} Brows'],
    tags: ['Cil à cil', 'Volume russe', 'Rehaussement', 'Sourcils au fil', 'Brow lift', 'Volume mixte'],
    about: ['Institut dédié au regard : extensions, rehaussement et sourcils.', 'Cabines individuelles, produits hypoallergéniques.'],
    soloAbout: ['Technicienne cils certifiée, pose naturelle ou sophistiquée selon l\'envie.', 'Reçoit dans une pièce dédiée, climatisée et au calme.', 'Spécialiste du regard, conseils d\'entretien à chaque pose.'],
    menu: [['Extensions cil à cil', 120, 70], ['Volume russe', 150, 92], ['Volume mixte', 150, 80], ['Remplissage cils', 60, 42], ['Rehaussement + teinture', 60, 48], ['Sourcils au fil', 30, 12], ['Brow lift', 60, 45], ['Teinture sourcils', 30, 15], ['Restructuration sourcils', 30, 18]],
    extra: 'ongles',
  },
  {
    cat: 'soins', share: 12, indep: 0.3, shop: 'Institut',
    shopNames: ['Institut {m}', 'Spa {m}', '{m} Beauté', 'Escale {m}'],
    soloNames: ['{p} Bien-être', 'Les Soins de {p}', '{p} Esthétique'],
    tags: ['Soin visage', 'Épilation', 'Massage', 'Gommage', 'Cire tiède', 'Soin éclat'],
    about: ['Institut de beauté : soins du visage, du corps et épilation.', 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 'Un moment pour soi, à deux pas du bourg.'],
    soloAbout: ['Esthéticienne diplômée, soins et épilation à domicile.', 'Massages et soins du visage, table et matériel apportés chez toi.'],
    menu: [['Soin visage hydratant', 60, 50], ['Soin visage éclat', 60, 55], ['Gommage corps', 60, 45], ['Épilation demi-jambes', 30, 18], ['Épilation jambes complètes', 60, 30], ['Épilation aisselles', 30, 10], ['Épilation maillot', 30, 18], ['Massage relaxant', 60, 60], ['Massage dos', 30, 35], ['Épilation sourcils', 30, 10]],
    extra: 'maquillage',
  },
  {
    cat: 'maquillage', share: 8, indep: 0.85, shop: 'Salon',
    shopNames: ['Studio {m} Make-up', '{m} Beauty Studio'],
    soloNames: ['{p} Make-up', 'Glam by {p}', 'Make-up by {p}', '{p} Beauty'],
    tags: ['Mariée', 'Soirée', 'Shooting', 'Carnaval', 'Cours', 'Invitée'],
    about: ['Studio maquillage et mise en beauté pour tous les événements.'],
    soloAbout: ['Maquilleuse professionnelle, mariages et événements dans toute l\'île.', 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.'],
    menu: [['Maquillage jour', 60, 40], ['Maquillage soirée', 60, 60], ['Maquillage mariée + essai', 120, 150], ["Cours d'auto-maquillage", 90, 70], ['Maquillage shooting', 60, 65], ['Maquillage carnaval', 60, 45], ['Maquillage invitée', 60, 50]],
  },
  {
    cat: 'barbier', share: 12, indep: 0.3, shop: 'Salon', male: true,
    shopNames: ['Barber {m}', '{m} Barber Shop', 'Barbershop {m}', 'Le Fauteuil {m}'],
    soloNames: ['{p} Barber', 'Barber by {p}', '{p} le Barbier'],
    tags: ['Dégradé', 'Barbe', 'Contours', 'Enfants', 'Rasage', 'Sans rendez-vous'],
    about: ['Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.'],
    soloAbout: ['Barbier à domicile, précis sur les dégradés et les contours.', 'Coupe à la maison pour toute la famille, matériel désinfecté.'],
    menu: [['Coupe homme', 30, 18], ['Coupe + barbe', 60, 25], ['Dégradé + contours', 30, 20], ['Coupe enfant', 30, 12], ['Taille de barbe', 30, 12], ['Rasage traditionnel', 30, 20], ['Coupe + soin', 60, 30]],
  },
]

export function generatePros(takenNames: string[]): Pro[] {
  const r = rng(20261010)
  const pick = <T>(list: T[]): T => list[Math.floor(r() * list.length)]
  const sample = <T>(list: T[], n: number): T[] => {
    const pool = [...list]
    const out: T[] = []
    while (out.length < n && pool.length) out.push(pool.splice(Math.floor(r() * pool.length), 1)[0])
    return out
  }
  const totalShare = TRADES.reduce((a, t) => a + t.share, 0)
  const pickTrade = (): Trade => {
    let x = r() * totalShare
    for (const t of TRADES) {
      x -= t.share
      if (x < 0) return t
    }
    return TRADES[0]
  }
  const names = new Set(takenNames)
  const out: Pro[] = []
  let n = 0

  for (const [commune, , quartiers, count] of COMMUNES) {
    const [cLat, cLng] = COMMUNE_COORDS[commune]
    for (let i = 0; i < count; i++) {
      const t = pickTrade()
      const solo = r() < t.indep
      const prenom = pick(t.male ? PRENOMS_M : PRENOMS_F)
      const mot = pick(MOTS)
      let name = pick(solo ? t.soloNames : t.shopNames).replace('{p}', prenom).replace('{m}', mot)
      if (names.has(name)) name = `${name} ${commune}`
      if (names.has(name)) continue
      names.add(name)

      // Prix propres à chaque prestataire : de -10 % à +15 % autour du prix habituel.
      const level = 0.9 + r() * 0.25
      const price = (p: number) => Math.max(8, Math.round((p * level) / (p >= 40 ? 5 : 1)) * (p >= 40 ? 5 : 1))
      const lines = sample(t.menu, 4 + Math.floor(r() * 3))
      const cats: Category[] = [t.cat]
      const second = t.extra && r() < 0.25 ? TRADES.find(x => x.cat === t.extra) : undefined
      if (second) {
        cats.push(second.cat)
        lines.push(...sample(second.menu, 2))
      }
      const services: Service[] = lines.map(([label, d, p], k) => ({ id: String.fromCharCode(97 + k), n: label, d, p: price(p) }))

      const open = 480 + 30 * Math.floor(r() * 4)
      const close = 1050 + 30 * Math.floor(r() * 5)
      const kind: Pro['kind'] = solo ? (t.male ? 'Indépendant' : 'Indépendante') : t.shop
      const home = t.male ? 'Chez lui' : 'Chez elle'
      // Un tiers des établissements se déplace aussi ; la moitié des indépendants propose les deux lieux.
      const where = !solo
        ? [t.shop === 'Institut' ? "À l'institut" : 'Au salon', ...(r() < 0.33 ? ['À domicile'] : [])]
        : pick([['À domicile'], [home], [home, 'À domicile'], [home, 'À domicile']])
      const travel = where.includes('À domicile') ? pick([0, 5, 5, 8, 10, 15]) : undefined

      out.push({
        id: `g${String(++n).padStart(3, '0')}`,
        name,
        owner: solo ? `${prenom} ${pick([...INITIALES])}.` : undefined,
        kind,
        where,
        travel,
        commune,
        quartier: pick(quartiers),
        lat: cLat + (r() - 0.5) * 0.02,
        lng: cLng + (r() - 0.5) * 0.02,
        cats,
        tags: sample(t.tags, 3),
        rating: Math.round((4.2 + r() * 0.8) * 10) / 10,
        nrev: 6 + Math.floor(r() * r() * 240),
        open,
        close,
        closed: solo ? pick([[0], [0], [], [0, 1]]) : pick([[0], [0, 1], [0, 1], [0]]),
        fill: 0.3 + r() * 0.35,
        h: Math.floor(r() * 360),
        about: pick(solo ? t.soloAbout : t.about),
        services,
      })
    }
  }
  return out
}
