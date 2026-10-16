// Une icône par métier, pour les catégories et les visuels des prestataires.
import type { Component } from 'vue'
import { Armchair, Bath, BedDouble, Brush, Eye, Flower2, Gem, Hand, HandHeart, PenLine, Scissors, Waves } from 'lucide-vue-next'
import type { Category } from '~/data/pros'

export const CAT_ICON: Record<Category, Component> = {
  ongles: Hand,
  cils: Eye,
  coiffure: Scissors,
  tresses: Waves,
  maquillage: Brush,
  soins: Flower2,
  barbier: Armchair,
  tatouage: PenLine,
  piercing: Gem,
  massage: HandHeart,
  spa: Bath,
  hotel: BedDouble,
}

export const CAT_SHORT: Record<Category, string> = {
  ongles: 'Ongles',
  cils: 'Cils',
  coiffure: 'Coiffure',
  tresses: 'Tresses',
  maquillage: 'Maquillage',
  soins: 'Soins',
  barbier: 'Barbier',
  tatouage: 'Tatouage',
  piercing: 'Piercing',
  massage: 'Massage',
  spa: 'Spa',
  hotel: 'Hôtels',
}
