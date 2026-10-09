<script setup lang="ts">
import { Star } from 'lucide-vue-next'
import type { Pro } from '~/data/pros'

const props = defineProps<{ pro: Pro }>()
const { openSlots, ratingOf, km, nextSlots, today } = useVladi()
const hasSlot = computed(() => openSlots(props.pro.id).length > 0)
const next = computed(() => nextSlots(props.pro, props.pro.services[0], 1)[0])
const from = computed(() => Math.min(...props.pro.services.map(s => s.p)))
</script>

<template>
  <NuxtLink class="bigcard" :to="`/pro/${pro.id}`">
    <ProCover :pro="pro" variant="card">
      <span v-if="hasSlot" class="badge float k">Konyéla</span>
      <span v-else-if="goesToClient(pro)" class="badge float">Se déplace</span>
    </ProCover>
    <div class="body">
      <div class="row between">
        <span class="name ellip">{{ pro.name }}</span>
        <span class="rate"><Star :size="14" />{{ String(ratingOf(pro).rating).replace('.', ',') }}</span>
      </div>
      <div class="meta"><span class="ellip">{{ CAT_SHORT[pro.cats[0]] }} · {{ pro.commune }}</span></div>
      <div class="meta"><span>{{ formatKm(km(pro)) }}</span><span class="sep">dès {{ euro(from) }}</span></div>
      <div v-if="next" class="tiny ok">Libre {{ shortDay(next.date, today).toLowerCase() }} {{ hm(next.time) }}</div>
      <div v-else class="tiny">Complet cette semaine</div>
    </div>
  </NuxtLink>
</template>
