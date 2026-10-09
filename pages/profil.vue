<script setup lang="ts">
import { ChevronRight, MapPin, Store } from 'lucide-vue-next'
import { DEMO_CLIENT } from '~/data/pros'

const { state, pros, nowMin, setSim, reset, toast, km } = useVladi()
const favs = computed(() => pros.filter(p => state.fav[p.id]).sort((a, b) => km(a) - km(b)))
const locOpen = ref(false)
function doReset() {
  reset()
  toast('Données de démonstration remises à zéro')
}
</script>

<template>
  <div class="row">
    <div class="datebox" style="width:52px;height:52px;border-radius:26px;align-self:center"><b>{{ DEMO_CLIENT.firstName.charAt(0) }}</b></div>
    <div><h1 class="h1">{{ DEMO_CLIENT.name }}</h1><p class="sub">Compte de démonstration</p></div>
  </div>

  <div class="optlist panel" style="padding:2px 14px">
    <button @click="locOpen = true"><span class="inline"><MapPin :size="18" />Ma position : {{ state.pos.label }}</span><ChevronRight :size="18" /></button>
    <NuxtLink to="/espace-pro" style="display:flex;align-items:center;justify-content:space-between;padding:12px 2px;font-weight:600">
      <span class="inline"><Store :size="18" />Espace prestataire<span v-if="state.unseen" class="badge acc">{{ state.unseen }} nouvelle{{ state.unseen > 1 ? 's' : '' }}</span></span><ChevronRight :size="18" />
    </NuxtLink>
  </div>

  <section class="sec">
    <h2 class="h2">Mes favoris</h2>
    <div v-if="favs.length" class="rail"><ProCardBig v-for="p in favs" :key="p.id" :pro="p" /></div>
    <p v-else class="sub">Touche le cœur sur une fiche pour la retrouver ici.</p>
  </section>

  <section class="sec">
    <h2 class="h2">Réglages de démonstration</h2>
    <div class="box">
      <div class="kv"><span>Heure utilisée par l'appli</span><span>{{ hm(nowMin) }}{{ state.sim === null ? '' : ' (simulée)' }}</span></div>
      <div class="row wrap" style="gap:8px">
        <button class="btn small line" @click="setSim(null)">Heure réelle</button>
        <button class="btn small line" @click="setSim(10 * 60 + 20)">Simuler 10h20</button>
        <button class="btn small line" @click="setSim(nowMin + 30)">+30 min</button>
      </div>
      <p class="tiny">Utile pour tester Konyéla le soir ou le dimanche, quand tout est fermé.</p>
      <button class="btn small line" style="align-self:flex-start" @click="doReset">Tout remettre à zéro</button>
    </div>
    <p class="tiny">Prestataires, prix, avis et positions sont fictifs. Le paiement est simulé.</p>
  </section>

  <LocationSheet v-if="locOpen" @close="locOpen = false" />
</template>
