<script setup lang="ts">
import { Check, Navigation } from 'lucide-vue-next'
import { DEMO_PRO_ID, RULES } from '~/data/pros'

const route = useRoute()
const { findBooking, pro, service, today, placeLabel, remote } = useVladi()
const b = computed(() => findBooking(String(route.params.id)))
const p = computed(() => (b.value ? pro(b.value.proId) : undefined))
const sv = computed(() => (p.value && b.value ? service(p.value, b.value.sid) : undefined))
</script>

<template>
  <div v-if="b && p && sv" class="done">
    <div class="col gap16" style="align-items:center;text-align:center">
      <div class="tick"><Check :size="34" :stroke-width="3" /></div>
      <div class="col gap4">
        <h1 class="title">C'est réservé</h1>
        <p class="meta">{{ p.real ? `${p.name} a reçu ta réservation.` : 'Réservation de démonstration.' }}</p>
      </div>
    </div>
    <div class="appt" style="border:0">
      <ProPhoto class="thumb" :pro="p" :w="128" :h="128" ratio="none" :demo-label="false" />
      <div class="grow col gap4">
        <span class="name">{{ capitalize(dayLabel(b.date, today)) }} à {{ hm(b.time) }}</span>
        <span class="meta">{{ sv.n }} · {{ p.name }}</span>
      </div>
    </div>
    <div class="recap">
      <div class="kv"><span>Lieu</span><span>{{ placeLabel(b) }}</span></div>
      <div v-if="b.fee" class="kv"><span>Dont déplacement</span><span>{{ euro(b.fee) }}</span></div>
      <template v-if="RULES.onlinePayment">
        <div class="kv"><span>Acompte payé</span><span>{{ euro(b.deposit) }}</span></div>
        <div class="kv"><span>Reste à payer sur place</span><span>{{ euro(b.price - b.deposit) }}</span></div>
      </template>
      <div v-else class="kv"><span>À régler sur place</span><span>{{ euro(b.price) }}</span></div>
    </div>
    <div class="col gap12">
      <NuxtLink class="btn block" to="/rdv">Voir mes rendez-vous</NuxtLink>
      <AddToCalendar :booking="b" class="block" />
      <a v-if="b.place === 'pro'" class="btn block line" :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="18" />Itinéraire</a>
    </div>
    <p v-if="p.id === DEMO_PRO_ID" class="tiny" style="text-align:center">Ce rendez-vous apparaît aussi dans l'espace prestataire de démonstration.</p>
  </div>
  <div v-else-if="remote.loading" class="empty" style="padding-top:96px">Chargement…</div>
  <div v-else class="empty" style="padding-top:96px">
    <b>Réservation introuvable</b>
    <NuxtLink class="btn sm soft" to="/rdv">Mes rendez-vous</NuxtLink>
  </div>
</template>
