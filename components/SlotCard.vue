<script setup lang="ts">
import type { Slot } from '~/composables/useBel'

const props = defineProps<{ item: Slot, withPro?: boolean }>()
const { pro, service, nowMin, ratingOf } = useBel()
const p = computed(() => pro(props.item.proId)!)
const sv = computed(() => service(p.value, props.item.sid)!)
const wait = computed(() => {
  const m = props.item.time - nowMin.value
  return m >= 60 ? `${Math.floor(m / 60)} h ${String(m % 60).padStart(2, '0')}` : `${m} min`
})
const km = (n: number) => String(n).replace('.', ',')
</script>

<template>
  <div class="kbox">
    <div class="row between">
      <span class="tag k">dans {{ wait }} · {{ hm(item.time) }}</span>
      <span class="price"><span class="strike">{{ euro(sv.p) }}</span>{{ euro(discounted(sv, item.disc)) }}</span>
    </div>
    <div>
      <div class="name">{{ sv.n }} · {{ sv.d }} min</div>
      <div v-if="withPro" class="sub">{{ p.name }} · {{ p.commune }} · {{ km(p.dist) }} km · ★ {{ km(ratingOf(p).rating) }}</div>
    </div>
    <div class="row">
      <NuxtLink v-if="withPro" class="btn small line" :to="`/pro/${p.id}`">Voir la fiche</NuxtLink>
      <NuxtLink class="btn small sun grow" :to="`/reserver/${p.id}/${sv.id}?creneau=${item.id}`">Prendre ce créneau, -{{ item.disc }} %</NuxtLink>
    </div>
  </div>
</template>
