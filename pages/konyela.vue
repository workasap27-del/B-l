<script setup lang="ts">
import { Zap } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'

const { openSlots, pro, km } = useVladi()
const cat = ref('all')
const near = ref(false)
const list = computed(() => {
  const out = openSlots().filter(s => cat.value === 'all' || pro(s.proId)!.cats.includes(cat.value as never))
  return near.value ? [...out].sort((a, b) => km(pro(a.proId)!) - km(pro(b.proId)!)) : out
})
</script>

<template>
  <div>
    <h1 class="h1">Konyéla</h1>
    <p class="sub">« Maintenant » en créole. Des créneaux qui se libèrent aujourd'hui, à prix réduit. Premier arrivé, premier servi.</p>
  </div>
  <div class="chips">
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>
  <div class="seg">
    <button :aria-pressed="!near" @click="near = false">Les plus tôt</button>
    <button :aria-pressed="near" @click="near = true">Les plus proches</button>
  </div>
  <div class="stack">
    <SlotCard v-for="s in list" :key="s.id" :item="s" wide />
    <div v-if="!list.length" class="empty">
      <Zap :size="34" />
      <p><b>Rien pour l'instant{{ cat !== 'all' ? ' dans cette catégorie' : '' }}.</b><br>Les prestataires ajoutent des créneaux au fil de la journée.</p>
    </div>
  </div>
</template>
