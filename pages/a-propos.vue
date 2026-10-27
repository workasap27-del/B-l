<script setup lang="ts">
import { ChevronLeft } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

useHead({ title: 'À propos · VLADI' })
const router = useRouter()
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
</script>

<template>
  <div class="head"><button class="icon-btn" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal">
    <h1 class="title">{{ t('À propos de VLADI') }}</h1>
    <p>{{ t('VLADI, c\'est un prénom avant d\'être une appli : celui de la personne qui porte le projet. L\'idée est simple : trouver et réserver en quelques secondes un ou une prestataire de beauté et de bien-être près de chez soi, sans passer sa journée à envoyer des messages.') }}</p>
    <h2>{{ t('Ce que fait VLADI') }}</h2>
    <ul>
      <li>{{ t('Rassembler les prestataires de toute la Guadeloupe : salons, instituts, studios et indépendant·es, sur place ou à domicile.') }}</li>
      <li>{{ t('Montrer les vrais prix, les vraies disponibilités et des avis laissés uniquement après un rendez-vous.') }}</li>
      <li>{{ t('Aider les prestataires à remplir leur agenda et à réduire les rendez-vous manqués.') }}</li>
    </ul>
    <h2>{{ t('Local avant tout') }}</h2>
    <p>{{ t('VLADI commence en Guadeloupe, avec des prestataires d\'ici et pour les gens d\'ici, comme pour celles et ceux qui viennent nous rendre visite.') }}</p>
    <h2>{{ t('Nous écrire') }}</h2>
    <p>{{ t('Une idée, une remarque, un partenariat ?') }} <a class="link" :href="`mailto:${LEGAL.contactEmail}`">{{ LEGAL.contactEmail }}</a></p>
  </article>
</template>
