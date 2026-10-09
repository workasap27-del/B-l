<script setup lang="ts">
const route = useRoute()
const router = useRouter()
const { pro, state, toggleFav, openSlots, reviewsOf, ratingOf } = useBel()
const p = computed(() => pro(String(route.params.id)))
const slots = computed(() => (p.value ? openSlots(p.value.id) : []))
const km = (n: number) => String(n).replace('.', ',')
</script>

<template>
  <template v-if="p">
    <div class="madras cover" :style="{ '--h': p.h }">
      <button class="round left" aria-label="Retour" @click="router.back()">‹</button>
      <button class="round right" aria-label="Favori" :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)">{{ state.fav[p.id] ? '♥' : '♡' }}</button>
      <h1 class="h1">{{ p.name }}</h1>
    </div>
    <div>
      <div class="row between">
        <span class="sub">{{ p.kind }}{{ p.owner ? ` · ${p.owner}` : '' }}</span>
        <span class="star">★ {{ km(ratingOf(p).rating) }} <span class="sub">({{ ratingOf(p).count }} avis)</span></span>
      </div>
      <div class="sub">{{ p.quartier }}, {{ p.commune }} · {{ km(p.dist) }} km</div>
    </div>
    <div class="tags">
      <span v-for="w in p.where" :key="w" class="tag new">{{ w }}</span>
      <span v-for="t in p.tags" :key="t" class="tag">{{ t }}</span>
    </div>
    <p>{{ p.about }}</p>
    <template v-if="slots.length">
      <h2 class="h2">Libre aujourd'hui</h2>
      <SlotCard v-for="s in slots" :key="s.id" :item="s" />
    </template>
    <h2 class="h2">Prestations</h2>
    <div>
      <div v-for="s in p.services" :key="s.id" class="svc">
        <div class="grow">
          <div style="font-weight:600">{{ s.n }}</div>
          <div class="sub">{{ s.d }} min</div>
        </div>
        <span class="price">{{ euro(s.p) }}</span>
        <NuxtLink class="btn small" :to="`/reserver/${p.id}/${s.id}`">Réserver</NuxtLink>
      </div>
    </div>
    <h2 class="h2">Avis</h2>
    <div>
      <div v-for="(r, i) in reviewsOf(p)" :key="i" class="rev">
        <div class="row between"><b>{{ r.a }}</b><span class="star">{{ '★'.repeat(r.s) }}</span></div>
        <span>{{ r.t }}</span>
      </div>
    </div>
  </template>
  <p v-else class="empty">Ce prestataire n'existe pas. <NuxtLink to="/" class="ok">Retour à l'accueil</NuxtLink></p>
</template>
