<script setup lang="ts">
import { DEMO_CLIENT } from '~/data/pros'

const { state, pros, nowMin, setSim, reset, toast } = useBel()
const favs = computed(() => pros.filter(p => state.fav[p.id]))
function doReset() {
  reset()
  toast('Données de démonstration remises à zéro')
}
</script>

<template>
  <h1 class="h1">{{ DEMO_CLIENT.name }}</h1>
  <div class="box">
    <div class="kv"><span>Secteur</span><span>{{ DEMO_CLIENT.commune }}, Guadeloupe</span></div>
    <div class="kv"><span>Rappels</span><span>Veille et 2 h avant</span></div>
  </div>

  <NuxtLink class="kbanner" to="/espace-pro">
    <span class="grow"><strong>Espace prestataire</strong>Voir l'appli côté salon ou indépendante<span v-if="state.unseen"> · {{ state.unseen }} nouvelle{{ state.unseen > 1 ? 's' : '' }} réservation{{ state.unseen > 1 ? 's' : '' }}</span></span>
    <span class="arrow">›</span>
  </NuxtLink>

  <h2 class="h2">Mes favoris</h2>
  <div class="stack">
    <ProCard v-for="p in favs" :key="p.id" :pro="p" />
    <p v-if="!favs.length" class="empty">Touche le cœur sur une fiche pour la retrouver ici.</p>
  </div>

  <h2 class="h2">Réglages de démonstration</h2>
  <div class="box">
    <div class="kv"><span>Heure utilisée par l'appli</span><span>{{ hm(nowMin) }}{{ state.sim === null ? '' : ' (simulée)' }}</span></div>
    <div class="row" style="flex-wrap:wrap">
      <button class="btn small line" :aria-pressed="state.sim === null" @click="setSim(null)">Heure réelle</button>
      <button class="btn small line" @click="setSim(10 * 60 + 20)">Simuler 10h20</button>
      <button class="btn small line" @click="setSim(nowMin + 30)">+30 min</button>
    </div>
    <p class="sub">Utile pour tester Konyéla en dehors des heures d'ouverture.</p>
    <button class="btn small line" style="align-self:flex-start" @click="doReset">Tout remettre à zéro</button>
  </div>
</template>
