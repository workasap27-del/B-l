// Données de démonstration. Tous les établissements, personnes, prix et avis sont fictifs.
import { generatePros } from './generate'
import { hash, rng } from './random'
import { COMMUNE_COORDS } from '../utils/geo'

export type Category = 'visage' | 'maquillage' | 'epilation' | 'cils' | 'coiffure' | 'barbier' | 'locks' | 'ongles' | 'pieds' | 'corps' | 'massage' | 'minceur' | 'bronzage' | 'dermo' | 'tatouage' | 'piercing' | 'medecine' | 'evenements' | 'formations'

export interface Service {
  id: string
  /** nom */
  n: string
  /** durée en minutes */
  d: number
  /** prix en euros */
  p: number
}

export interface Review {
  a: string
  s: number
  t: string
}

export interface Pro {
  id: string
  name: string
  owner?: string
  /** 'Indépendante' et 'Indépendant' sont deux valeurs de la base ; l'appli les affiche toutes les deux « Indépendant·e ». */
  kind: 'Salon' | 'Institut' | 'Studio' | 'Spa' | 'Hôtel' | 'Indépendante' | 'Indépendant'
  /** lieux possibles : 'Au salon', "À l'institut", 'Chez le/la pro', 'Chez le/la pro' (chez le prestataire) et 'À domicile' (chez la cliente) */
  where: string[]
  /** frais de déplacement en euros quand la prestation a lieu chez la cliente */
  travel?: number
  commune: string
  quartier: string
  /** position (fictive, autour du centre de la commune) */
  lat: number
  lng: number
  cats: Category[]
  tags: string[]
  rating: number
  nrev: number
  /** ouverture et fermeture, en minutes depuis minuit */
  open: number
  close: number
  /** jours de fermeture, 0 = dimanche */
  closed: number[]
  /** taux de remplissage simulé de l'agenda, entre 0 et 1 */
  fill: number
  /** teinte du visuel madras */
  h: number
  about: string
  services: Service[]
  /** fiche d'un vrai prestataire inscrit (sinon : fiche de démonstration) */
  real?: boolean
  /** compte propriétaire de la fiche */
  ownerId?: string
  /** photo choisie par le prestataire */
  photo?: string
  phone?: string
  siren?: string
}

export const CATEGORIES: [Category | 'all', string][] = [
  ['all', 'Tout'],
  ['visage', 'Soins du visage et corps'],
  ['maquillage', 'Maquillage et mise en beauté'],
  ['epilation', 'Épilations'],
  ['cils', 'Cils et sourcils'],
  ['coiffure', 'Cheveux femmes'],
  ['barbier', 'Cheveux hommes et barber'],
  ['locks', 'Locks'],
  ['ongles', 'Onglerie et manucure'],
  ['pieds', 'Pédicure et beauté des pieds'],
  ['corps', 'Soins du corps et esthétique corporelle'],
  ['massage', 'Massage et relaxation'],
  ['minceur', 'Minceur esthétique et modelage de la silhouette'],
  ['bronzage', 'Bronzage et beauté solaire'],
  ['dermo', 'Maquillage permanent et dermopigmentation'],
  ['tatouage', 'Tatouage esthétique et artistique'],
  ['piercing', 'Piercings'],
  ['medecine', 'Médecine esthétique et actes spécialisés'],
  ['evenements', 'Prestations beauté, mariages et autres évènements'],
  ['formations', 'Formations, ateliers et consultations beauté'],
]

const s = (id: string, n: string, d: number, p: number): Service => ({ id, n, d, p })

/** Prestataires écrits à la main. */
const HAND_MADE: Omit<Pro, 'lat' | 'lng'>[] = [
  {
    id: 'kaz', name: 'Kaz a Zong', owner: 'Maëva L.', kind: 'Indépendante', where: ['Chez le/la pro', 'À domicile'], travel: 5,
    commune: 'Les Abymes', quartier: 'Raizet', cats: ['ongles'], tags: ['Pose gel', 'Nail art', 'Semi-permanent'],
    rating: 4.9, nrev: 87, open: 540, close: 1140, closed: [0], fill: 0.55, h: 330,
    about: "Prothésiste ongulaire depuis 6 ans. Reçoit dans son atelier au Raizet ou se déplace dans l'agglomération pointoise.",
    services: [s('a', 'Pose gel + couleur', 90, 55), s('b', 'Remplissage gel', 60, 40), s('c', 'Semi-permanent mains', 45, 28), s('d', 'Semi-permanent pieds', 45, 30), s('e', 'Nail art 10 doigts', 30, 15), s('f', 'Dépose', 30, 15)],
  },
  {
    id: 'bar', name: 'Barber Lakou', kind: 'Salon', where: ['Au salon'],
    commune: 'Les Abymes', quartier: 'Grand-Camp', cats: ['barbier'], tags: ['Dégradé', 'Barbe', 'Sans rendez-vous'],
    rating: 4.6, nrev: 154, open: 540, close: 1140, closed: [0], fill: 0.6, h: 210,
    about: 'Trois fauteuils, coupe homme et enfant. Les contours sont offerts dans les 10 jours.',
    services: [s('a', 'Coupe homme', 30, 18), s('b', 'Coupe + barbe', 60, 25), s('c', 'Dégradé + contours', 30, 20), s('d', 'Coupe enfant', 30, 12)],
  },
  {
    id: 'hib', name: 'Salon Hibiscus', kind: 'Salon', where: ['Au salon', 'À domicile'], travel: 10,
    commune: 'Pointe-à-Pitre', quartier: 'Centre-ville', cats: ['coiffure'], tags: ['Brushing', 'Lissage', 'Cheveux texturés'],
    rating: 4.7, nrev: 212, open: 540, close: 1080, closed: [0, 1], fill: 0.6, h: 350,
    about: 'Salon mixte du centre-ville. Spécialiste du soin et du coiffage des boucles, coloration végétale sur demande.',
    services: [s('a', 'Shampoing + brushing', 60, 30), s('b', 'Coupe + brushing', 60, 45), s('c', 'Coloration', 90, 65), s('d', 'Lissage brésilien', 180, 160), s('e', 'Soin profond + coiffage boucles', 60, 40)],
  },
  {
    id: 'nai', name: 'Nail Bar Bas-du-Fort', kind: 'Salon', where: ['Au salon'],
    commune: 'Le Gosier', quartier: 'Bas-du-Fort', cats: ['ongles', 'pieds'], tags: ['Pose gel', 'Beauté des pieds'],
    rating: 4.5, nrev: 98, open: 570, close: 1110, closed: [0], fill: 0.5, h: 300,
    about: 'Bar à ongles près de la marina, quatre postes. Idéal entre midi et deux.',
    services: [s('a', 'Pose gel', 90, 60), s('b', 'Remplissage', 60, 42), s('c', 'Semi-permanent', 60, 30), s('d', 'Beauté des pieds + vernis', 60, 38)],
  },
  {
    id: 'tre', name: 'Tresses Lokal', owner: 'Sandrine D.', kind: 'Indépendante', where: ['À domicile'], travel: 8,
    commune: 'Le Gosier', quartier: 'Mare-Gaillard', cats: ['coiffure', 'locks'], tags: ['Box braids', 'Vanilles', 'Locks'],
    rating: 4.8, nrev: 63, open: 480, close: 1080, closed: [0], fill: 0.45, h: 25,
    about: 'Tresseuse à domicile sur toute la Riviera du Levant. Mèches fournies sur demande, comptées en supplément.',
    services: [s('a', 'Box braids mi-longues', 240, 110), s('b', 'Vanilles', 120, 60), s('c', 'Nattes collées', 90, 45), s('d', 'Retwist locks', 90, 50), s('e', 'Départ de locks', 180, 90)],
  },
  {
    id: 'reg', name: 'Regard Karukera', kind: 'Institut', where: ["À l'institut"],
    commune: 'Baie-Mahault', quartier: 'Jarry', cats: ['cils'], tags: ['Extensions', 'Rehaussement', 'Sourcils au fil'],
    rating: 4.8, nrev: 176, open: 540, close: 1110, closed: [0], fill: 0.6, h: 265,
    about: 'Institut dédié au regard, en zone de Jarry. Parking gratuit devant la porte.',
    services: [s('a', 'Extensions cil à cil', 120, 75), s('b', 'Volume russe', 150, 95), s('c', 'Remplissage cils', 60, 45), s('d', 'Rehaussement + teinture', 60, 50), s('e', 'Sourcils au fil', 30, 12), s('f', 'Brow lift', 60, 45)],
  },
  {
    id: 'col', name: 'Studio Colibri', kind: 'Salon', where: ['Au salon', 'À domicile'], travel: 12,
    commune: 'Baie-Mahault', quartier: 'Destrellan', cats: ['coiffure', 'maquillage'], tags: ['Chignon', 'Événement', 'Maquillage'],
    rating: 4.6, nrev: 71, open: 540, close: 1110, closed: [0, 1], fill: 0.5, h: 160,
    about: 'Coiffure et maquillage au même endroit pour les baptêmes, mariages et soirées.',
    services: [s('a', 'Coupe + coiffage', 60, 48), s('b', 'Coiffure événement', 60, 55), s('c', 'Maquillage + coiffure', 120, 110), s('d', 'Brushing', 30, 28)],
  },
  {
    id: 'fle', name: 'Institut Fleur de Canne', kind: 'Institut', where: ["À l'institut"],
    commune: 'Petit-Bourg', quartier: 'Bourg', cats: ['visage', 'epilation'], tags: ['Soin visage', 'Épilation', 'Massage'],
    rating: 4.7, nrev: 120, open: 540, close: 1080, closed: [0], fill: 0.5, h: 120,
    about: 'Soins du visage et du corps, cire tiède. Cabine climatisée.',
    services: [s('a', 'Soin visage hydratant', 60, 50), s('b', 'Gommage corps', 60, 45), s('c', 'Épilation demi-jambes', 30, 18), s('d', 'Épilation aisselles', 30, 10), s('e', 'Massage dos', 30, 35)],
  },
  {
    id: 'tib', name: 'Onglerie Ti Bijou', owner: 'Naomie C.', kind: 'Indépendante', where: ['À domicile'], travel: 8,
    commune: 'Lamentin', quartier: 'Bourg', cats: ['ongles'], tags: ['Capsules', 'Baby boomer'],
    rating: 4.7, nrev: 41, open: 540, close: 1080, closed: [0, 1], fill: 0.4, h: 315,
    about: 'Se déplace avec tout son matériel sur le nord Basse-Terre : Lamentin, Sainte-Rose, Baie-Mahault.',
    services: [s('a', 'Pose capsules + gel', 120, 55), s('b', 'Remplissage', 60, 38), s('c', 'Semi-permanent', 60, 25), s('d', 'Baby boomer', 120, 60)],
  },
  {
    id: 'mad', name: 'Atelier Madras Beauté', kind: 'Institut', where: ["À l'institut", 'À domicile'], travel: 10,
    commune: 'Sainte-Anne', quartier: 'Bourg', cats: ['visage', 'epilation', 'maquillage'], tags: ['Soin éclat', 'Maquillage', 'Épilation'],
    rating: 4.5, nrev: 89, open: 540, close: 1080, closed: [0], fill: 0.45, h: 5,
    about: 'À deux rues de la plage du bourg. Soins, épilation et maquillage sur rendez-vous.',
    services: [s('a', 'Soin visage éclat', 60, 55), s('b', 'Épilation jambes complètes', 60, 30), s('c', 'Épilation maillot', 30, 18), s('d', 'Maquillage jour', 60, 40), s('e', 'Massage relaxant', 60, 60)],
  },
  {
    id: 'oce', name: 'Cils by Océane', owner: 'Océane V.', kind: 'Indépendante', where: ['Chez le/la pro'],
    commune: 'Le Moule', quartier: 'Sergent', cats: ['cils'], tags: ['Cil à cil', 'Volume mixte'],
    rating: 4.9, nrev: 52, open: 540, close: 1080, closed: [0, 1], fill: 0.5, h: 245,
    about: 'Technicienne cils certifiée, reçoit dans une pièce dédiée de sa maison.',
    services: [s('a', 'Cil à cil', 120, 65), s('b', 'Volume mixte', 150, 80), s('c', 'Remplissage', 60, 40), s('d', 'Rehaussement', 60, 45)],
  },
  {
    id: 'ali', name: 'Coiffure Alizé', kind: 'Salon', where: ['Au salon'],
    commune: 'Sainte-Rose', quartier: 'Bourg', cats: ['coiffure', 'barbier'], tags: ['Mixte', 'Défrisage', 'Couleur'],
    rating: 4.4, nrev: 67, open: 510, close: 1080, closed: [0], fill: 0.5, h: 190,
    about: 'Le salon de quartier du bourg, hommes, femmes et enfants.',
    services: [s('a', 'Coupe femme', 60, 30), s('b', 'Brushing', 30, 22), s('c', 'Coupe homme', 30, 15), s('d', 'Défrisage + soin', 120, 70), s('e', 'Couleur', 90, 55)],
  },
  {
    id: 'glo', name: 'Glow Gwada', owner: 'Kéliane P.', kind: 'Indépendante', where: ['À domicile'], travel: 15,
    commune: 'Saint-François', quartier: 'Bourg', cats: ['maquillage'], tags: ['Mariée', 'Soirée', 'Cours'],
    rating: 4.9, nrev: 38, open: 480, close: 1200, closed: [], fill: 0.35, h: 40,
    about: 'Maquilleuse mariages et événements, se déplace dans toute la Grande-Terre.',
    services: [s('a', 'Maquillage jour', 60, 40), s('b', 'Maquillage soirée', 60, 60), s('c', 'Maquillage mariée + essai', 120, 150), s('d', "Cours d'auto-maquillage", 90, 70)],
  },
  {
    id: 'loc', name: 'Locks & Nature', kind: 'Salon', where: ['Au salon'],
    commune: 'Basse-Terre', quartier: 'Centre', cats: ['locks'], tags: ['Locks', 'Soins naturels'],
    rating: 4.8, nrev: 95, open: 540, close: 1080, closed: [0, 1], fill: 0.5, h: 95,
    about: 'Entretien et création de locks, soins à base de plantes locales.',
    services: [s('a', 'Retwist', 90, 45), s('b', 'Entretien locks + soin', 120, 60), s('c', 'Départ de locks', 180, 85), s('d', 'Coiffage locks', 60, 35)],
  },
]

const ZOMBI: Omit<Pro, 'lat' | 'lng'> = {
  id: 'zom', name: 'Zombi', owner: 'Yolène R.', kind: 'Indépendante', where: ['Chez le/la pro', 'À domicile'], travel: 6,
  commune: 'Les Abymes', quartier: 'Dothémare', cats: ['cils'], tags: ['Cil à cil', 'Volume russe', 'Rehaussement'],
  rating: 4.8, nrev: 34, open: 540, close: 1110, closed: [0], fill: 0.45, h: 280,
  about: "Un nom qui ne dit rien de son métier : Yolène pose des extensions de cils et travaille les sourcils, sur place ou chez toi.",
  services: [s('a', 'Extensions cil à cil', 120, 68), s('b', 'Volume russe', 150, 90), s('c', 'Remplissage cils', 60, 40), s('d', 'Rehaussement + teinture', 60, 45), s('e', 'Sourcils au fil', 30, 12)],
}
HAND_MADE.push(ZOMBI)

/** Catalogue complet : prestataires écrits à la main, puis catalogue généré pour toute la Guadeloupe. */
/** Place un prestataire écrit à la main à quelques centaines de mètres du centre de sa commune. */
function located(p: Omit<Pro, 'lat' | 'lng'>): Pro {
  const r = rng(hash(`geo${p.id}`))
  const [lat, lng] = COMMUNE_COORDS[p.commune]
  return { ...p, lat: lat + (r() - 0.5) * 0.016, lng: lng + (r() - 0.5) * 0.016 }
}

export const PROS: Pro[] = [...HAND_MADE.map(located), ...generatePros(HAND_MADE.map(p => p.name))]

export const REVIEW_TEXTS: Record<Category, string[]> = {
  ongles: ['Pose impeccable, ça tient trois semaines sans bouger.', "Très minutieuse, et elle respecte l'heure.", "Le nail art est exactement ce que j'avais montré en photo.", 'Mes ongles naturels ne sont pas abîmés, enfin.', 'Un peu de retard mais le résultat vaut le coup.', 'Grand choix de couleurs, je reviendrai.', 'Travail propre, cuticules nickel.', 'Rapide et pas chère pour la qualité.'],
  cils: ['Regard naturel, comme demandé. Aucune gêne après la pose.', 'Douce et précise, je me suis endormie pendant la pose.', 'Le rehaussement tient encore six semaines après.', 'Sourcils parfaitement symétriques.', 'Très bonne tenue, même avec la mer et la piscine.', 'Elle prend le temps de conseiller la bonne courbure.', 'Remplissage rapide, rien à redire.', 'Un peu cher mais le travail est soigné.'],
  coiffure: ["Enfin quelqu'un qui sait coiffer mes boucles.", "Brushing qui tient malgré l'humidité, bravo.", "Accueil chaleureux et pas d'attente.", 'La couleur est exactement celle que je voulais.', 'Bons conseils pour entretenir mes cheveux à la maison.', 'Coupe fraîche, je me sens légère.', 'Salon propre et climatisé.', "J'ai attendu vingt minutes mais le résultat est top."],
  locks: ['Tresses fines et régulières, pas trop serrées.', "Rapide et soignée, elle est venue à l'heure à la maison.", "Mes locks n'ont jamais été aussi propres.", 'Ma fille a adoré, et ça a tenu un mois.', 'Aucune douleur au cuir chevelu, enfin.', 'Finitions propres, les raccords ne se voient pas.', 'Très patiente, six heures de travail sans se plaindre.', 'Prix honnête pour la longueur.'],
  maquillage: ['Teint parfait toute la soirée, même en dansant.', 'Elle a su trouver la bonne teinte du premier coup.', 'Maquillage léger et lumineux, exactement mon style.', "Tout a tenu jusqu'à la fin du mariage.", "L'essai m'a rassurée, le jour J était parfait.", 'Ponctuelle et très douce.', 'Rendu magnifique en photo.', 'Elle écoute vraiment ce qu\'on veut.'],
  visage: ['Moment de détente, peau toute douce en sortant.', 'Épilation rapide et presque sans douleur.', 'Cabine propre et fraîche, je reviendrai.', 'Massage excellent, mes épaules la remercient.', 'Le soin visage a vraiment éclairci mon teint.', 'Accueil souriant et tisane offerte.', 'Très pro, elle explique chaque étape.', 'Bon rapport qualité-prix.'],
  epilation: ['Épilation rapide et presque sans douleur.', 'Cire tiède, peau douce pendant des semaines.', 'Cabine propre, matériel à usage unique.', "Elle explique tout avant de commencer, c'est rassurant.", 'Résultat net, aucune irritation après.', 'Ponctuelle et très professionnelle.', 'Prix clair, pas de supplément surprise.', 'Je reviens tous les mois, toujours aussi bien.'],
  tatouage: ['Le dessin est exactement celui que j\'imaginais, trait très net.', 'Hygiène irréprochable, tout le matériel est ouvert devant moi.', 'Explique bien les soins après la séance, cicatrisation parfaite.', 'Très à l\'écoute pour adapter le dessin à mon bras.', 'Séance longue mais on prend des pauses quand il faut.', 'Retouche offerte, super accueil.', 'Un vrai artiste, je reviens pour mon deuxième.', 'Prix annoncé au devis, aucune surprise.'],
  piercing: ['Rapide, précis et presque indolore.', 'Matériel stérile et bijou en titane, rien à redire.', 'On m\'a bien expliqué comment nettoyer pendant la cicatrisation.', 'Placement parfait, très bons conseils sur le bijou.', 'Accueil rassurant pour une première fois.', 'Cartilage cicatrisé sans souci après deux mois.', 'Studio propre et choix de bijoux sympa.', 'Je recommande les yeux fermés.'],
  massage: ['Un vrai lâcher-prise, mon dos me dit merci.', 'Pression juste comme il faut, très bon massage.', 'Ambiance calme, huiles chaudes, je me suis endormi.', 'Parfait après une semaine de travail debout.', 'Le massage prénatal m\'a fait un bien fou.', 'Ponctuel et à l\'écoute de ce qui fait mal.', 'Cabine propre et silencieuse.', 'Le meilleur massage que j\'aie fait sur l\'île.'],
  barbier: ['Dégradé net, rien à redire.', 'Bon coup de ciseaux et bonne ambiance.', 'Mon fils ne veut plus aller ailleurs.', 'Contours au cordeau.', "Ponctuel, pas d'attente interminable.", 'Barbe bien taillée, il prend son temps.', 'Le meilleur dégradé du secteur.', 'Salon propre, matériel désinfecté.'],
  pieds: ['Pieds tout doux, vernis impeccable.', 'Soin des pieds très complet, un vrai moment de détente.', 'Elle a su traiter mes talons secs sans me faire mal.', 'Matériel bien désinfecté, rien à redire.', 'Pose de vernis semi-permanent qui tient trois semaines.', 'Accueil souriant et fauteuil confortable.', 'Parfait avant les vacances à la plage.', 'Très minutieuse sur les ongles incarnés.'],
  corps: ['Hammam et jacuzzi sans foule, vraie parenthèse.', 'Personnel discret et attentionné.', 'Le rituel visage et corps vaut le détour.', 'Très propre, serviettes et peignoirs de qualité.', 'On est venus à deux, soin duo parfait.', 'Un cadre calme, on oublie tout.', 'Bon rapport qualité-prix pour la demi-journée.', 'Réservation simple, aucune attente à l\'arrivée.'],
  minceur: ['Séances agréables, je vois la différence sur mes cuisses.', 'Programme clair et suivi sérieux à chaque rendez-vous.', 'Aucun désagrément, juste un peu de fatigue après.', 'Elle ne promet pas de miracle, et ça rassure.', 'Bons conseils pour compléter à la maison.', 'Cabine propre et ambiance calme.', 'Résultat visible après quelques séances.', 'Tarif au forfait honnête.'],
  bronzage: ['Un teint doré uniforme, sans traces.', 'Très bons conseils pour préparer la peau avant.', 'Rapide, propre, et le résultat tient plusieurs jours.', 'Couleur naturelle, exactement ce que je voulais.', 'Cabine propre, produits agréables.', 'Parfait avant un mariage.', 'Accueil chaleureux et pas d\'attente.', 'Ma peau est restée douce.'],
  dermo: ['Sourcils très naturels, je me réveille maquillée.', 'Elle prend le temps de dessiner avant de commencer.', 'Cicatrisation parfaite, retouche offerte.', 'Pigments choisis selon ma carnation, rendu magnifique.', 'Hygiène irréprochable, matériel à usage unique.', 'Explications claires sur les soins après la séance.', 'Très douce, presque aucune douleur.', 'Je recommande pour un résultat qui dure.'],
  medecine: ['Consultation sérieuse, on m\'explique tout avant de décider.', 'Cabinet très propre et équipe rassurante.', 'Résultat discret et naturel, comme convenu.', 'Prise en charge attentive, suivi après la séance.', 'Devis donné à l\'avance, aucune surprise.', 'Elle a su me dire quand ce n\'était pas utile, ça rassure.', 'Ponctuel et à l\'écoute.', 'Je recommande pour une première consultation.'],
  evenements: ['Venue à l\'heure le jour du mariage, tout était parfait.', 'Coiffure et maquillage ont tenu jusqu\'à la fin de la soirée.', 'Essai fait avant, aucune mauvaise surprise le jour J.', 'Elle s\'est occupée de toute la famille sans stress.', 'Très pro, matériel et lumière apportés.', 'Équipe discrète et efficace.', 'Devis clair et respecté.', 'Photos magnifiques, merci !'],
  formations: ['Atelier très clair, j\'ai appris plus en deux heures qu\'en vidéo.', 'Petit groupe, chacune a pu pratiquer.', 'Consultation personnalisée, des conseils vraiment adaptés à ma peau.', 'Pédagogue et patiente, je recommande.', 'Matériel fourni, rien à acheter avant.', 'Bonne ambiance, on repart avec un vrai savoir-faire.', 'Cours d\'auto-maquillage très utile.', 'Support remis à la fin, pratique pour réviser.'],
}

export const CLIENT_NAMES = ['Laurine M.', 'Cindy B.', 'Aurélie T.', 'Mélissa R.', 'Jade K.', 'Sarah-Lyne P.', 'Ludivine G.', 'Anaëlle F.', 'Yoan D.', 'Stessy V.', 'Coralie N.', 'Maïté B.']

/** Compte prestataire utilisé par l'espace pro en mode démo. */
export const DEMO_PRO_ID = 'kaz'
/** Cliente connectée en mode démo. */
export const DEMO_CLIENT = { name: 'Inès A.', firstName: 'Inès', commune: 'Les Abymes' }

/** Règles commerciales. onlinePayment reste faux tant que le paiement en ligne n'est pas branché : tout se règle sur place. */
export const RULES = { depositRate: 0.2, commissionRate: 0.12, freeCancelHours: 24, onlinePayment: false }
