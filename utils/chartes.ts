// Les chartes graphiques proposées au choix (temporaire, le temps de décider). Seules les couleurs changent.
export interface Charte { id: string, name: string, mood: string, colors: [string, string, string] }

export const CHARTES: Charte[] = [
  { id: 'noir', name: 'Noir', mood: 'Noir et blanc, jaune pour la dernière minute', colors: ['#ffffff', '#111111', '#ffd43b'] },
  { id: 'lagon', name: 'Lagon', mood: 'Bleu-vert profond et corail', colors: ['#0b5f5c', '#dcefed', '#ff7a45'] },
  { id: 'mangue', name: 'Mangue', mood: 'Orange vif et crème, vert pour le disponible', colors: ['#ff7a1a', '#fffaf3', '#0f9d6e'] },
  { id: 'indigo', name: 'Indigo', mood: 'Bleu électrique vers violet, ambre', colors: ['#3b4ef5', '#6a4cf5', '#ffb020'] },
  { id: 'nuit', name: 'Nuit', mood: 'Fond noir et or, toujours sombre', colors: ['#0c0c0e', '#232326', '#f2c14e'] },
]
