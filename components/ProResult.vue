<script setup lang="ts">
import { House, MapPin, Star } from 'lucide-vue-next'
import type { Pro, Service } from '~/data/pros'

// Résultat de recherche : le prestataire, la prestation concernée et ses prochains créneaux, réservables en un geste.
const props = defineProps<{ pro: Pro, services?: Service[] }>()
const { openSlots, ratingOf, km, nextSlots, today } = useVladi()
const hasSlot = computed(() => openSlots(props.pro.id).length > 0)
const main = computed(() => props.services?.[0] ?? props.pro.services[0])
const others = computed(() => (props.services ?? []).slice(1, 3))
const times = computed(() => nextSlots(props.pro, main.value, 3))
const d = computed(() => km(props.pro))
</script>

<template>
  <article class="result">
    <NuxtLink class="top" :to="`/pro/${pro.id}`">
      <ProCover :pro="pro" variant="thumb" />
      <div class="grow info">
        <div class="row between">
          <span class="name ellip">{{ pro.name }}</span>
          <span class="rate"><Star :size="14" />{{ String(ratingOf(pro).rating).replace('.', ',') }} <span class="tiny">({{ ratingOf(pro).count }})</span></span>
        </div>
        <div class="meta"><span>{{ pro.kind }}</span><span class="sep">{{ pro.commune }}</span></div>
        <div class="meta"><MapPin :size="13" /><span>{{ formatKm(d) }} · {{ driveMinutes(d) }} min</span></div>
        <div class="tags">
          <span v-if="hasSlot" class="badge k">Konyéla</span>
          <span v-if="goesToClient(pro)" class="badge acc"><House :size="11" />Chez toi</span>
          <span v-if="proPlace(pro)" class="badge">{{ proPlace(pro) }}</span>
        </div>
      </div>
    </NuxtLink>
    <div class="svcline">
      <span class="ellip">{{ main.n }} · {{ main.d }} min</span><b>{{ euro(main.p) }}</b>
    </div>
    <div class="times">
      <NuxtLink v-for="t in times" :key="t.date + t.time" class="time" :to="`/reserver/${pro.id}/${main.id}?date=${t.date}&time=${t.time}`">{{ shortDay(t.date, today) }} {{ hm(t.time) }}</NuxtLink>
      <NuxtLink class="time more" :to="`/reserver/${pro.id}/${main.id}`">{{ times.length ? 'Autres horaires' : 'Voir les disponibilités' }}</NuxtLink>
    </div>
    <NuxtLink v-for="s in others" :key="s.id" class="svcline" :to="`/reserver/${pro.id}/${s.id}`">
      <span class="ellip">{{ s.n }} · {{ s.d }} min</span><b>{{ euro(s.p) }} ›</b>
    </NuxtLink>
  </article>
</template>
