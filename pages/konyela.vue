<script setup lang="ts">
import { Zap } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'

const { openSlots, pro, km, state } = useVladi()
const cat = ref('all')
const order = ref<'near' | 'soon'>('near')
const list = computed(() => {
  const out = openSlots().filter(s => cat.value === 'all' || pro(s.proId)!.cats.includes(cat.value as Category))
  return order.value === 'near' ? [...out].sort((a, b) => km(pro(a.proId)!) - km(pro(b.proId)!)) : out
})
</script>

<template>
  <div class="col gap8">
    <h1 class="title">Konyéla</h1>
    <p class="meta">« Maintenant » en créole : des créneaux libérés aujourd'hui, à prix réduit. Premier arrivé, premier servi.</p>
  </div>
  <div class="chips mt16">
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>
  <div class="seg mt16">
    <button :aria-pressed="order === 'near'" @click="order = 'near'">Les plus proches de {{ state.pos.gps ? 'moi' : state.pos.label }}</button>
    <button :aria-pressed="order === 'soon'" @click="order = 'soon'">Les plus tôt</button>
  </div>
  <div class="col gap12 mt16">
    <SlotCard v-for="s in list" :key="s.id" :item="s" />
    <div v-if="!list.length" class="empty">
      <Zap :size="32" />
      <b>Rien pour l'instant{{ cat !== 'all' ? ' dans cette catégorie' : '' }}</b>
      <span>Les prestataires ajoutent des créneaux au fil de la journée.</span>
    </div>
  </div>
</template>
