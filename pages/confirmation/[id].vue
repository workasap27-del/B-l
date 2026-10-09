<script setup lang="ts">
import { Check, Navigation } from 'lucide-vue-next'
import { DEMO_PRO_ID } from '~/data/pros'

const route = useRoute()
const { state, pro, service, today, placeLabel } = useVladi()
const b = computed(() => state.bookings.find(x => x.id === Number(route.params.id)))
const p = computed(() => (b.value ? pro(b.value.proId) : undefined))
const sv = computed(() => (p.value && b.value ? service(p.value, b.value.sid) : undefined))
</script>

<template>
  <div v-if="b && p && sv" class="done">
    <div class="tick"><Check :size="38" :stroke-width="3" /></div>
    <div>
      <h1 class="h1">C'est réservé</h1>
      <p class="sub">Un rappel t'attend la veille et 2 h avant.</p>
    </div>
    <div class="panel" style="text-align:left">
      <div class="row">
        <div class="datebox"><small>{{ dateParts(b.date).month }}</small><b>{{ dateParts(b.date).day }}</b></div>
        <div class="grow">
          <div class="name">{{ sv.n }}</div>
          <div class="meta"><span>{{ dayLabel(b.date, today) }} à {{ hm(b.time) }} · {{ p.name }}</span></div>
        </div>
      </div>
      <div class="kv"><span>Lieu</span><span>{{ placeLabel(b) }}</span></div>
      <div v-if="b.fee" class="kv"><span>Dont déplacement</span><span>{{ euro(b.fee) }}</span></div>
      <div class="kv"><span>Acompte payé</span><span>{{ euro(b.deposit) }}</span></div>
      <div class="kv"><span>Reste à payer le jour même</span><span>{{ euro(b.price - b.deposit) }}</span></div>
    </div>
    <a v-if="b.place === 'pro'" class="btn block line" :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="18" />Itinéraire</a>
    <NuxtLink class="btn block" to="/rdv">Voir mes rendez-vous</NuxtLink>
    <NuxtLink class="link" to="/">Retour à l'accueil</NuxtLink>
    <p v-if="p.id === DEMO_PRO_ID" class="tiny">Ce rendez-vous apparaît aussi dans l'espace prestataire de {{ p.owner }} (Profil, puis Espace prestataire).</p>
  </div>
  <div v-else class="empty" style="padding-top:80px">
    <p><b>Réservation introuvable.</b></p>
    <NuxtLink class="btn small soft" to="/rdv">Mes rendez-vous</NuxtLink>
  </div>
</template>
