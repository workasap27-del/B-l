<script setup lang="ts">
import { Heart, Star } from 'lucide-vue-next'
import type { Pro, Service } from '~/data/pros'

// Résultat de recherche : la photo, l'essentiel du prestataire, la prestation trouvée et ses prochains créneaux.
const props = defineProps<{ pro: Pro, services?: Service[], sponsored?: boolean }>()
const { state, openSlots, ratingOf, km, nextSlots, today, toggleFav, isMine } = useVladi()
const slot = computed(() => openSlots(props.pro.id)[0])
const main = computed(() => props.services?.[0] ?? props.pro.services[0])
const times = computed(() => nextSlots(props.pro, main.value, 4))
const r = computed(() => ratingOf(props.pro))
</script>

<template>
  <article class="result">
    <NuxtLink :to="`/pro/${pro.id}`" class="col gap12">
      <ProPhoto :pro="pro" ratio="169" :w="640" :h="360">
        <span v-if="slot" class="label now">-{{ slot.disc }} % aujourd'hui</span>
        <span v-else />
        <button class="icon-btn float" style="width:34px;height:34px" :aria-pressed="!!state.fav[pro.id]" aria-label="Ajouter aux favoris" @click.prevent="toggleFav(pro.id)">
          <Heart :size="17" :fill="state.fav[pro.id] ? 'currentColor' : 'none'" />
        </button>
      </ProPhoto>
      <div class="info">
        <div class="row between">
          <span class="h3 ellip">{{ pro.name }}</span>
          <span v-if="r.count" class="rate"><Star :size="13" />{{ fr(r.rating) }} <span class="n">({{ r.count }})</span></span>
          <span v-else class="tag">Nouveau</span>
        </div>
        <span class="meta">{{ pro.commune }} · {{ formatKm(km(pro)) }} · {{ kindLabel(pro.kind) }}</span>
        <div v-if="sponsored || isMine(pro) || goesToClient(pro)" class="tags mt8">
          <span v-if="sponsored" class="tag" title="Ce prestataire a payé pour être mis en avant. La note et les avis ne sont pas concernés.">Sponsorisé</span>
          <span v-if="isMine(pro)" class="tag accent">Votre entreprise</span>
          <span v-if="goesToClient(pro)" class="tag">Se déplace à domicile</span>
        </div>
      </div>
    </NuxtLink>
    <div class="service-line">
      <span class="ellip">{{ main.n }} <span class="muted">· {{ duration(main.d) }}</span></span>
      <b class="num">{{ euro(main.p) }}</b>
    </div>
    <div class="times">
      <NuxtLink v-for="t in times" :key="t.date + t.time" class="time" :to="`/reserver/${pro.id}/${main.id}?date=${t.date}&time=${t.time}`">
        <small>{{ shortDay(t.date, today) }}</small>{{ hm(t.time) }}
      </NuxtLink>
      <NuxtLink class="time more" :to="`/reserver/${pro.id}/${main.id}`">{{ times.length ? 'Plus d\'horaires' : 'Voir les disponibilités' }}</NuxtLink>
    </div>
  </article>
</template>
