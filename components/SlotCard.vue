<script setup lang="ts">
import type { Slot } from '~/composables/useVladi'

// Créneau Konyéla : l'heure, la prestation, où, et le prix réduit.
const props = defineProps<{ item: Slot, hidePro?: boolean }>()
const { pro, service, nowMin, km } = useVladi()
const p = computed(() => pro(props.item.proId)!)
const sv = computed(() => service(p.value, props.item.sid)!)
const wait = computed(() => {
  const m = props.item.time - nowMin.value
  return m >= 60 ? `dans ${Math.floor(m / 60)} h ${m % 60 ? String(m % 60).padStart(2, '0') : ''}`.trim() : `dans ${m} min`
})
</script>

<template>
  <NuxtLink v-if="p && sv" class="kcard" :to="`/reserver/${p.id}/${sv.id}?creneau=${item.id}`">
    <div class="when"><b>{{ hm(item.time) }}</b><span class="tiny">{{ wait }}</span></div>
    <span class="vr" />
    <div class="grow col gap4">
      <span class="name ellip">{{ sv.n }}</span>
      <span v-if="!hidePro" class="meta ellip">{{ p.name }}</span>
      <span class="meta ellip">{{ p.commune }} · {{ formatKm(km(p)) }}</span>
    </div>
    <div class="price">
      <span class="tag now">-{{ item.disc }} %</span>
      <span class="num">{{ euro(discounted(sv, item.disc)) }}</span>
      <span class="strike">{{ euro(sv.p) }}</span>
    </div>
  </NuxtLink>
</template>
