<script setup lang="ts">
import { CATEGORIES } from '~/data/pros'

const { openSlots, pro } = useBel()
const cat = ref('all')
const list = computed(() => openSlots().filter(s => cat.value === 'all' || pro(s.proId)!.cats.includes(cat.value as never)))
</script>

<template>
  <div>
    <h1 class="h1">Konyéla</h1>
    <p class="sub">« Maintenant » en créole. Des créneaux qui se libèrent aujourd'hui, à prix réduit. Premier arrivé, premier servi.</p>
  </div>
  <div class="chips">
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>
  <div class="stack">
    <SlotCard v-for="s in list" :key="s.id" :item="s" with-pro />
    <p v-if="!list.length" class="empty">Aucun créneau de dernière minute pour l'instant{{ cat !== 'all' ? ' dans cette catégorie' : '' }}. Les prestataires en ajoutent au fil de la journée.</p>
  </div>
</template>
