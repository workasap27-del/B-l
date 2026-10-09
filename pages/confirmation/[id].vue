<script setup lang="ts">
import { DEMO_PRO_ID } from '~/data/pros'

const route = useRoute()
const { state, pro, service, today, placeLabel } = useVladi()
const b = computed(() => state.bookings.find(x => x.id === Number(route.params.id)))
const p = computed(() => (b.value ? pro(b.value.proId) : undefined))
const sv = computed(() => (p.value && b.value ? service(p.value, b.value.sid) : undefined))
</script>

<template>
  <div v-if="b && p && sv" class="done">
    <div class="tick">✓</div>
    <h1 class="h1">C'est réservé</h1>
    <p>{{ sv.n }} chez {{ p.name }}<br><b>{{ dayLabel(b.date, today) }} à {{ hm(b.time) }}</b></p>
    <div class="box" style="text-align:left">
      <div class="kv"><span>Acompte payé</span><span>{{ euro(b.deposit) }}</span></div>
      <div class="kv"><span>Reste à payer le jour même</span><span>{{ euro(b.price - b.deposit) }}</span></div>
      <div v-if="b.fee" class="kv"><span>Dont déplacement</span><span>{{ euro(b.fee) }}</span></div>
      <div class="kv"><span>Lieu</span><span>{{ placeLabel(b) }}</span></div>
    </div>
    <NuxtLink class="btn block" to="/rdv">Voir mes rendez-vous</NuxtLink>
    <p v-if="p.id === DEMO_PRO_ID" class="sub">Ce rendez-vous est visible dans l'espace pro de {{ p.owner }} (Profil, puis Espace prestataire).</p>
  </div>
  <p v-else class="empty">Réservation introuvable. <NuxtLink to="/rdv" class="ok">Mes rendez-vous</NuxtLink></p>
</template>
