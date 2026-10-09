<script setup lang="ts">
import type { Pro } from '~/data/pros'

const props = defineProps<{ pro: Pro }>()
const { openSlots, ratingOf } = useBel()
const from = computed(() => Math.min(...props.pro.services.map(s => s.p)))
const hasSlot = computed(() => openSlots(props.pro.id).length > 0)
const km = (n: number) => String(n).replace('.', ',')
</script>

<template>
  <NuxtLink class="card" :to="`/pro/${pro.id}`">
    <div class="madras thumb" :style="{ '--h': pro.h }">{{ pro.name.charAt(0) }}</div>
    <div class="grow body">
      <div class="row between">
        <span class="name">{{ pro.name }}</span>
        <span class="star">★ {{ km(ratingOf(pro).rating) }}</span>
      </div>
      <div class="sub">{{ pro.kind }} · {{ pro.commune }} · {{ km(pro.dist) }} km</div>
      <div class="tags">
        <span v-if="hasSlot" class="tag k">Konyéla</span>
        <span v-for="t in pro.tags.slice(0, 2)" :key="t" class="tag">{{ t }}</span>
        <span class="tag">dès {{ euro(from) }}</span>
      </div>
    </div>
  </NuxtLink>
</template>
