// Les chartes graphiques proposées au choix (temporaire, le temps de décider).
export interface Charte { id: string, name: string, mood: string, colors: [string, string, string] }

export const CHARTES: Charte[] = [
  { id: 'lagon', name: 'Lagon', mood: 'Turquoise et corail, net et lumineux', colors: ['#0b8282', '#ff7a59', '#edf4f4'] },
  { id: 'onyx', name: 'Onyx', mood: 'Noir, blanc et champagne, haut de gamme', colors: ['#141414', '#c9a46a', '#f0eee9'] },
  { id: 'sauge', name: 'Sauge', mood: 'Vert doux et miel, esprit spa', colors: ['#3d6a50', '#e2ae48', '#edf1e7'] },
  { id: 'indigo', name: 'Indigo', mood: 'Violet bleuté et menthe, appli tech', colors: ['#4f46e5', '#12b886', '#eef0fa'] },
  { id: 'ocean', name: 'Océan', mood: 'Bleu franc et ambre, rassurant', colors: ['#0a5bd8', '#ffb020', '#ecf2f9'] },
]
