<script setup lang="ts">
import { ChevronLeft } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

useHead({ title: 'Mentions légales · VLADI' })
const router = useRouter()
const e = LEGAL.editor
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
</script>

<template>
  <div class="head"><button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal">
    <h1 class="title">Mentions légales</h1>

    <h2>Éditeur</h2>
    <p>
      Le service VLADI, accessible à l'adresse {{ LEGAL.site }}, est édité par
      <template v-if="e.name">{{ e.name }}<template v-if="e.form">, {{ e.form }}</template></template><template v-else>VLADI</template>.
    </p>
    <ul>
      <li v-if="e.address">Adresse : {{ e.address }}</li>
      <li v-if="e.registration">Immatriculation : {{ e.registration }}</li>
      <li v-if="e.vat">TVA intracommunautaire : {{ e.vat }}</li>
      <li v-if="e.director">Direction de la publication : {{ e.director }}</li>
      <li>Contact : {{ LEGAL.contactEmail }}<template v-if="e.phone">, {{ e.phone }}</template></li>
    </ul>

    <h2>Hébergement</h2>
    <p>Application hébergée par {{ LEGAL.host.name }}, {{ LEGAL.host.address }} (<a class="link" :href="LEGAL.host.url" target="_blank" rel="noopener">{{ LEGAL.host.url.replace('https://', '') }}</a>).</p>
    <p>Données hébergées par {{ LEGAL.database.name }}, sur des serveurs situés à {{ LEGAL.database.place }} (<a class="link" :href="LEGAL.database.url" target="_blank" rel="noopener">{{ LEGAL.database.url.replace('https://', '') }}</a>).</p>

    <h2>Propriété intellectuelle</h2>
    <p>La marque VLADI, l'application et ses contenus propres sont protégés par le droit de la propriété intellectuelle. Les textes et photos des Fiches appartiennent aux prestataires qui les publient. Les photos d'illustration proviennent de Pexels et sont utilisées conformément à sa licence. Le fond de carte est fourni par CARTO à partir des données OpenStreetMap, © contributeurs OpenStreetMap.</p>

    <h2>Signaler un contenu</h2>
    <p>Pour signaler un contenu illicite ou une Fiche qui vous semble frauduleuse, écrivez à {{ LEGAL.contactEmail }} en précisant l'adresse de la page et la raison du signalement.</p>

    <p class="tiny mt24">Voir aussi : <NuxtLink class="link" to="/cgu">Conditions générales d'utilisation</NuxtLink> · <NuxtLink class="link" to="/confidentialite">Politique de confidentialité</NuxtLink></p>
  </article>
</template>
