<script setup lang="ts">
import { CATEGORIES, DEMO_CLIENT, TYPES } from '~/data/pros'
import type { Pro } from '~/data/pros'

const { pros, openSlots } = useVladi()
const q = ref('')
const cat = ref('all')
const type = ref('all')
const commune = ref('')
const shown = ref(30)
const communes = [...new Set(pros.map(p => p.commune))].sort((a, b) => a.localeCompare(b, 'fr'))
watch([q, cat, type, commune], () => { shown.value = 30 })

function matchType(p: Pro) {
  if (type.value === 'salon') return !p.kind.startsWith('Indépendant')
  if (type.value === 'indep') return p.kind.startsWith('Indépendant')
  if (type.value === 'dom') return goesToClient(p)
  if (type.value === 'place') return !!proPlace(p)
  return true
}
// La recherche porte d'abord sur les prestations, puis sur le métier, puis sur le nom et la commune.
const list = computed(() => searchPros(pros, q.value).filter(({ pro: p }) => {
  if (cat.value !== 'all' && !p.cats.includes(cat.value as never)) return false
  if (commune.value && p.commune !== commune.value) return false
  return matchType(p)
}))
const nk = computed(() => openSlots().length)
</script>

<template>
  <div>
    <div class="sub">Autour de {{ DEMO_CLIENT.commune }}</div>
    <h1 class="h1">Bonjour {{ DEMO_CLIENT.firstName }}, de quoi as-tu envie ?</h1>
  </div>
  <input id="q" v-model="q" class="search" type="search" placeholder="Cils, tresses, pose gel, massage..." aria-label="Rechercher une prestation, un prestataire ou une commune">
  <select id="commune" v-model="commune" class="search" aria-label="Commune">
    <option value="">Toute la Guadeloupe</option>
    <option v-for="c in communes" :key="c" :value="c">{{ c }}</option>
  </select>
  <div class="chips">
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>
  <NuxtLink v-if="nk && !q" class="kbanner" to="/konyela">
    <span class="grow"><strong>Konyéla</strong>{{ nk }} créneau{{ nk > 1 ? 'x' : '' }} libre{{ nk > 1 ? 's' : '' }} dans les prochaines heures, jusqu'à -40 %</span>
    <span class="arrow">›</span>
  </NuxtLink>
  <div class="row between">
    <h2 class="h2">{{ q.trim() ? 'Qui le propose' : 'Près de toi' }}</h2>
    <span class="sub">{{ list.length }} résultat{{ list.length > 1 ? 's' : '' }}</span>
  </div>
  <div class="chips">
    <button v-for="t in TYPES" :key="t[0]" class="chip" :aria-pressed="type === t[0]" @click="type = t[0]">{{ t[1] }}</button>
  </div>
  <div class="stack">
    <ProCard v-for="h in list.slice(0, shown)" :key="h.pro.id" :pro="h.pro" :services="h.services" />
    <button v-if="list.length > shown" class="btn block line" @click="shown += 30">Afficher plus ({{ list.length - shown }} autres)</button>
    <p v-if="!list.length" class="empty">Personne ne propose ça avec ces filtres. Essaie un autre mot, une autre commune ou enlève un filtre.</p>
  </div>
</template>
