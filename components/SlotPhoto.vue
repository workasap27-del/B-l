<script setup lang="ts">
import { Clock, Heart, MapPin, Star } from 'lucide-vue-next'
import type { Slot } from '~/composables/useVladi'

// Carte « Libre aujourd'hui » de l'accueil en mode présentation : photo, nom, note, commune, prestation, prix et heure.
// Réserve exactement comme le créneau Konyéla correspondant (même lien, même prix).
const props = defineProps<{ item: Slot }>()
const { state, pro, service, openSlots, ratingOf, toggleFav } = useVladi()
const p = computed(() => pro(props.item.proId)!)
const sv = computed(() => service(p.value, props.item.sid)!)
const r = computed(() => ratingOf(p.value))
const same = computed(() => openSlots(props.item.proId).filter(s => s.date === props.item.date))
const times = computed(() => same.value.map(s => s.time).slice(0, 3))
const chip = computed(() => {
  const id = themeOf(state.theme).id
  if (id === 'editorial') return `${same.value.length} créneau${same.value.length > 1 ? 'x' : ''} aujourd'hui`
  if (id === 'corail') return 'Dispo aujourd\'hui'
  if (id === 'lavande') return 'Aujourd\'hui'
  return 'Disponible aujourd\'hui'
})
</script>

<template>
  <NuxtLink v-if="p && sv" class="spc" :to="`/reserver/${p.id}/${sv.id}?creneau=${item.id}`">
    <ProPhoto :pro="p" class="spc-ph" :demo-label="false">
      <span class="spc-chip"><i class="spc-dot" />{{ chip }}</span>
      <button class="icon-btn float spc-fav" :aria-pressed="!!state.fav[p.id]" aria-label="Ajouter aux favoris" @click.prevent="toggleFav(p.id)">
        <Heart :size="17" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />
      </button>
    </ProPhoto>
    <div class="spc-body">
      <div class="spc-head">
        <span class="spc-name">{{ p.name }}</span>
        <span v-if="r.count" class="rate"><Star :size="13" />{{ fr(r.rating) }} <span class="n">({{ r.count }})</span></span>
      </div>
      <span class="spc-where"><MapPin :size="13" />{{ p.commune }}<span class="spc-type"> · {{ CAT_SHORT[p.cats[0]] }}</span></span>
      <div class="spc-line">
        <span class="spc-svc">{{ sv.n }}<span class="spc-dur"> · {{ duration(sv.d) }}</span></span>
        <span class="spc-price num">{{ euro(discounted(sv, item.disc)) }}<s class="spc-old">{{ euro(sv.p) }}</s></span>
      </div>
      <span class="spc-time"><Clock :size="15" /><span class="t-long">Aujourd'hui à {{ hm(item.time) }}</span><span class="t-short">{{ hm(item.time) }}</span></span>
      <span class="spc-times" aria-hidden="true"><span v-for="t in times" :key="t" class="spc-tchip">{{ hm(t) }}</span></span>
    </div>
  </NuxtLink>
</template>
