// Une icône par métier, pour les catégories et les visuels des prestataires.
import type { Component } from 'vue'
import { Armchair, Brush, Eye, Flower2, Hand, Scissors, Waves } from 'lucide-vue-next'
import type { Category } from '~/data/pros'

export const CAT_ICON: Record<Category, Component> = {
  ongles: Hand,
  cils: Eye,
  coiffure: Scissors,
  tresses: Waves,
  maquillage: Brush,
  soins: Flower2,
  barbier: Armchair,
}

export const CAT_SHORT: Record<Category, string> = {
  ongles: 'Ongles',
  cils: 'Cils',
  coiffure: 'Coiffure',
  tresses: 'Tresses',
  maquillage: 'Maquillage',
  soins: 'Soins',
  barbier: 'Barbier',
}
