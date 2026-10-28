// Langue de l'interface : français par défaut, anglais au choix (ou d'office pour un navigateur anglophone).
// Les textes sont écrits en français dans le code ; t() renvoie la traduction anglaise de locales/en.ts quand elle existe.
import { ref } from 'vue'
import { EN } from '../locales/en'

export type Lang = 'fr' | 'en'
const KEY = 'vladi-lang'

function initial(): Lang {
  if (typeof window === 'undefined') return 'fr'
  try {
    const saved = localStorage.getItem(KEY)
    if (saved === 'fr' || saved === 'en') return saved
  }
  catch { /* navigation privée */ }
  return /^en\b/i.test(navigator.language ?? '') ? 'en' : 'fr'
}

const lang = ref<Lang>(initial())

export type Params = Record<string, string | number | undefined | null>

/** Traduit un texte écrit en français et remplace les {variables}. */
export function translate(fr: string, params?: Params, l: Lang = lang.value): string {
  const out = l === 'en' ? EN[fr] ?? fr : fr
  return params ? out.replace(/\{(\w+)\}/g, (m, k: string) => (params[k] ?? '') + '') : out
}

/** Marque un texte à traduire plus tard, à l'affichage (listes, libellés stockés). Le renvoie tel quel. */
export function tr(fr: string): string {
  return fr
}

/** Langue actuelle, pour les fonctions qui fabriquent du texte hors des gabarits. */
export function currentLang(): Lang {
  return lang.value
}

export function setLang(l: Lang) {
  lang.value = l
  try {
    localStorage.setItem(KEY, l)
  }
  catch { /* navigation privée */ }
  if (typeof document !== 'undefined') document.documentElement.lang = l
}

export function useLang() {
  return { lang, setLang, t: (fr: string, params?: Params) => translate(fr, params, lang.value) }
}
