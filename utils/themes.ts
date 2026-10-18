// Les cinq thèmes complets du mode présentation. Chacun change la composition, les polices, les couleurs,
// les photographies d'en-tête, les fonds, les boutons et les cartes. Les mêmes fonctions métier servent partout.
export interface Theme { id: string, name: string, mood: string, colors: [string, string, string] }

export const THEMES: Theme[] = [
  { id: 'terracotta', name: 'Terracotta', mood: 'Photo de salon, terre cuite et crème', colors: ['#FAF6F1', '#B94B29', '#2A1B14'] },
  { id: 'lavande', name: 'Lavande', mood: 'Dégradé lavande, hibiscus au trait, bouton noir', colors: ['#EFE6FB', '#6B37C6', '#15171F'] },
  { id: 'jardin', name: 'Jardin créole', mood: 'Vert profond, citron vert et serif', colors: ['#F9F5EC', '#153B2B', '#C8E85A'] },
  { id: 'corail', name: 'Pop corail', mood: 'Corail, bleu roi et grandes lettres', colors: ['#FCF8F2', '#FD6F63', '#0147DC'] },
  { id: 'editorial', name: 'Éditorial', mood: 'Magazine : serif, crème et noir', colors: ['#FDFBF8', '#F5EEE7', '#292824'] },
]
export const THEME_IDS = THEMES.map(t => t.id)
export function themeOf(id: string): Theme { return THEMES.find(t => t.id === id) ?? THEMES[0] }
