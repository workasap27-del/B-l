<script setup lang="ts">
import { Heart, Star } from 'lucide-vue-next'
import type { Pro } from '~/data/pros'

// Carte d'un prestataire dans les carrousels : photo, nom, note, métier, commune et distance, prochaine disponibilité.
const props = defineProps<{ pro: Pro }>()
const { state, openSlots, ratingOf, km, nextSlots, today, toggleFav, isMine } = useVladi()
const slot = computed(() => openSlots(props.pro.id)[0])
const next = computed(() => nextSlots(props.pro, props.pro.services[0], 1)[0])
const from = computed(() => Math.min(...props.pro.services.map(s => s.p)))
const r = computed(() => ratingOf(props.pro))
</script>

<template>
  <NuxtLink class="pcard" :to="`/pro/${pro.id}`">
    <ProPhoto :pro="pro">
      <span v-if="slot" class="label now">-{{ slot.disc }} % aujourd'hui</span>
      <span v-else-if="isMine(pro)" class="label">Votre entreprise</span>
      <span v-else />
      <button class="icon-btn float" style="width:34px;height:34px" :aria-pressed="!!state.fav[pro.id]" aria-label="Ajouter aux favoris" @click.prevent="toggleFav(pro.id)">
        <Heart :size="17" :fill="state.fav[pro.id] ? 'currentColor' : 'none'" />
      </button>
    </ProPhoto>
    <div class="lines">
      <div class="row between">
        <span class="name ellip">{{ pro.name }}</span>
        <span v-if="r.count" class="rate"><Star :size="13" />{{ fr(r.rating) }} <span class="n">({{ r.count }})</span></span>
        <span v-else class="tag">Nouveau</span>
      </div>
      <span class="meta ellip">{{ CAT_SHORT[pro.cats[0]] }} · {{ pro.commune }} · {{ formatKm(km(pro)) }}</span>
      <span class="meta">
        Dès {{ euro(from) }}
        <template v-if="next"> · <span class="ok">Libre {{ shortDay(next.date, today).toLowerCase() }} {{ hm(next.time) }}</span></template>
      </span>
    </div>
  </NuxtLink>
</template>
