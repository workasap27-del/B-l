<script setup lang="ts">
import type { Slot } from '~/composables/useVladi'

// Créneau Konyéla. "wide" pour la liste, sinon format compact pour le carrousel de l'accueil.
const props = defineProps<{ item: Slot, wide?: boolean, hidePro?: boolean }>()
const { pro, service, nowMin, km } = useVladi()
const p = computed(() => pro(props.item.proId)!)
const sv = computed(() => service(p.value, props.item.sid)!)
const wait = computed(() => {
  const m = props.item.time - nowMin.value
  return m >= 60 ? `${Math.floor(m / 60)} h ${String(m % 60).padStart(2, '0')}` : `${m} min`
})
const to = computed(() => `/reserver/${p.value.id}/${sv.value.id}?creneau=${props.item.id}`)
</script>

<template>
  <NuxtLink class="kcard" :class="{ wide }" :to="to">
    <div class="row between">
      <span class="when">{{ hm(item.time) }}</span>
      <span class="badge k">-{{ item.disc }} %</span>
    </div>
    <div class="tiny">dans {{ wait }}</div>
    <div class="name ellip">{{ sv.n }}</div>
    <div v-if="!hidePro" class="meta"><span class="ellip">{{ p.name }} · {{ formatKm(km(p)) }}</span></div>
    <div class="row between">
      <span class="price"><span class="strike">{{ euro(sv.p) }}</span>{{ euro(discounted(sv, item.disc)) }}</span>
      <span v-if="wide" class="btn small sun">Réserver</span>
    </div>
  </NuxtLink>
</template>
