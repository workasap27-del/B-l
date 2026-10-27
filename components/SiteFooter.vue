<script setup lang="ts">
import { ChevronDown } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
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
</script>

<template>
  <footer class="site-foot">
    <div class="cols">
      <nav class="cats" aria-label="Catégories" @mouseenter="hover(true)" @mouseleave="hover(false)">
        <button type="button" class="foot-toggle" :aria-expanded="open" @click="open = !open">
          Catégories <ChevronDown :size="15" :class="{ flip: open }" />
        </button>
        <ul v-if="open">
          <li v-for="[c, label] in cats" :key="c"><NuxtLink :to="`/recherche?cat=${c}`">{{ label }}</NuxtLink></li>
        </ul>
      </nav>
      <nav aria-label="VLADI">
        <h2>VLADI</h2>
        <ul>
          <li><NuxtLink to="/a-propos">À propos</NuxtLink></li>
          <li><NuxtLink to="/faq">Questions fréquentes</NuxtLink></li>
          <li><NuxtLink to="/devenir-prestataire">Devenir prestataire</NuxtLink></li>
          <li><a :href="`mailto:${LEGAL.contactEmail}`">Nous contacter</a></li>
          <li v-if="!account"><NuxtLink to="/connexion">Se connecter</NuxtLink></li>
        </ul>
      </nav>
      <nav aria-label="Informations légales">
        <h2>Informations légales</h2>
        <ul>
          <li><NuxtLink to="/cgu">Conditions générales</NuxtLink></li>
          <li><NuxtLink to="/confidentialite">Confidentialité</NuxtLink></li>
          <li><NuxtLink to="/mentions-legales">Mentions légales</NuxtLink></li>
        </ul>
      </nav>
    </div>
    <p class="copy">© {{ year }} VLADI, beauté et bien-être en Guadeloupe.</p>
  </footer>
</template>
