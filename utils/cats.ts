// Une icône par métier, pour les catégories et les visuels des prestataires.
import type { Component } from 'vue'
import { Armchair, Brush, Eye, Feather, Flower2, Footprints, GraduationCap, Gem, Hand, HandHeart, PartyPopper, PenLine, Pipette, Ruler, Scissors, Sparkles, Stethoscope, Sun, Waves } from 'lucide-vue-next'
import type { Category } from '~/data/pros'

export const CAT_ICON: Record<Category, Component> = {
  visage: Sparkles,
  maquillage: Brush,
  epilation: Feather,
  cils: Eye,
  coiffure: Scissors,
  barbier: Armchair,
  locks: Waves,
  ongles: Hand,
  pieds: Footprints,
  corps: Flower2,
  massage: HandHeart,
  minceur: Ruler,
  bronzage: Sun,
  dermo: Pipette,
  tatouage: PenLine,
  piercing: Gem,
  medecine: Stethoscope,
  evenements: PartyPopper,
  formations: GraduationCap,
}

export const CAT_SHORT: Record<Category, string> = {
  visage: 'Soins visage',
  maquillage: 'Maquillage',
  epilation: 'Épilations',
  cils: 'Cils et sourcils',
  coiffure: 'Cheveux femmes',
  barbier: 'Hommes et barber',
  locks: 'Locks',
  ongles: 'Ongles',
  pieds: 'Pieds',
  corps: 'Soins du corps',
  massage: 'Massage',
  minceur: 'Minceur',
  bronzage: 'Bronzage',
  dermo: 'Maquillage permanent',
  tatouage: 'Tatouage',
  piercing: 'Piercings',
  medecine: 'Médecine esthétique',
  evenements: 'Évènements',
  formations: 'Formations',
}

/** Anciens identifiants de catégorie, encore présents sur les fiches réelles tant que supabase/patch-005-categories.sql n'a pas été lancé. */
const OLD_CATEGORIES: Record<string, Category[]> = {
  tresses: ['coiffure', 'locks'],
  soins: ['visage', 'epilation'],
  spa: ['massage', 'corps'],
  hotel: ['massage'],
}

/** Convertit une liste de catégories de la base : anciens identifiants remplacés, inconnus écartés, sans doublon. */
export function readCategories(raw: string[]): Category[] {
  const out: Category[] = []
  for (const c of raw) {
    for (const n of OLD_CATEGORIES[c] ?? [c as Category]) {
      if (n in CAT_SHORT && !out.includes(n)) out.push(n)
    }
  }
  return out.length ? out : ['visage']
}
