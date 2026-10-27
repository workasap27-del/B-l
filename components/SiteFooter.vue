<script setup lang="ts">
import { CATEGORIES } from '~/data/pros'
import { LEGAL } from '~/data/legal'

// Pied de page commun : catégories, informations sur VLADI et pages légales.
const cats = CATEGORIES.filter(c => c[0] !== 'all')
const { account } = useVladi()
const year = new Date().getFullYear()
</script>

<template>
  <footer class="site-foot">
    <div class="cols">
      <nav class="cats" aria-label="Catégories">
        <h2>Catégories</h2>
        <ul>
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
