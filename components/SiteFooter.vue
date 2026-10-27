<script setup lang="ts">
import { ChevronDown, Globe } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'
import { LEGAL } from '~/data/legal'

// Pied de page commun : catégories, informations sur VLADI et pages légales.
const cats = CATEGORIES.filter(c => c[0] !== 'all')
const { account } = useVladi()
const year = new Date().getFullYear()
// Liste des catégories repliée : elle s'ouvre au clic, ou au survol sur ordinateur.
const open = ref(false)
const canHover = ref(false)
onMounted(() => { canHover.value = window.matchMedia('(hover: hover) and (min-width: 1000px)').matches })
let timer: ReturnType<typeof setTimeout> | undefined
function hover(on: boolean) {
  if (!canHover.value) return
  clearTimeout(timer)
  timer = setTimeout(() => { open.value = on }, on ? 80 : 250)
}
const { lang, setLang } = useLang()
</script>

<template>
  <footer class="site-foot">
    <div class="cols">
      <nav class="cats" :aria-label="t('Catégories')" @mouseenter="hover(true)" @mouseleave="hover(false)">
        <button type="button" class="foot-toggle" :aria-expanded="open" @click="open = !open">
          {{ t('Catégories') }} <ChevronDown :size="15" :class="{ flip: open }" />
        </button>
        <ul v-if="open">
          <li v-for="[c] in cats" :key="c"><NuxtLink :to="`/recherche?cat=${c}`">{{ t(CAT_SHORT[c as Category]) }}</NuxtLink></li>
        </ul>
      </nav>
      <nav :aria-label="'VLADI'">
        <h2>VLADI</h2>
        <ul>
          <li><NuxtLink to="/a-propos">{{ t('À propos') }}</NuxtLink></li>
          <li><NuxtLink to="/faq">{{ t('Questions fréquentes') }}</NuxtLink></li>
          <li><NuxtLink to="/devenir-prestataire">{{ t('Devenir prestataire') }}</NuxtLink></li>
          <li><a :href="`mailto:${LEGAL.contactEmail}`">{{ t('Nous contacter') }}</a></li>
          <li v-if="!account"><NuxtLink to="/connexion">{{ t('Se connecter') }}</NuxtLink></li>
        </ul>
      </nav>
      <nav :aria-label="t('Informations légales')">
        <h2>{{ t('Informations légales') }}</h2>
        <ul>
          <li><NuxtLink to="/cgu">{{ t('Conditions générales') }}</NuxtLink></li>
          <li><NuxtLink to="/confidentialite">{{ t('Confidentialité') }}</NuxtLink></li>
          <li><NuxtLink to="/mentions-legales">{{ t('Mentions légales') }}</NuxtLink></li>
        </ul>
      </nav>
    </div>
    <div class="foot-lang" role="group" :aria-label="t('Langue')">
      <Globe :size="15" />
      <button type="button" :aria-pressed="lang === 'fr'" lang="fr" @click="setLang('fr')">Français</button>
      <button type="button" :aria-pressed="lang === 'en'" lang="en" @click="setLang('en')">English</button>
    </div>
    <p class="creole" lang="gcf">Byenvini an Gwadloup</p>
    <p class="copy">© {{ year }} VLADI, {{ t('beauté et bien-être en Guadeloupe') }}.</p>
  </footer>
</template>
