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
        <span v-if="slot" class="label now">{{ t('-{n} % aujourd\'hui', { n: slot.disc }) }}</span>
        <span v-else />
        <button class="icon-btn float" style="width:34px;height:34px" :aria-pressed="!!state.fav[pro.id]" :aria-label="t('Ajouter aux favoris')" @click.prevent="toggleFav(pro.id)">
          <Heart :size="17" :fill="state.fav[pro.id] ? 'currentColor' : 'none'" />
        </button>
      </ProPhoto>
      <div class="info">
        <div class="row between">
          <span class="h3 ellip">{{ pro.name }}</span>
          <span v-if="r.count" class="rate"><Star :size="13" />{{ fr(r.rating) }} <span class="n">({{ r.count }})</span></span>
          <span v-else class="tag">{{ t('Nouveau') }}</span>
        </div>
        <span class="meta">{{ pro.commune }} · {{ formatKm(km(pro)) }} · {{ kindLabel(pro.kind) }}</span>
        <div v-if="sponsored || isMine(pro) || goesToClient(pro)" class="tags mt8">
          <span v-if="sponsored" class="tag" :title="t('Ce prestataire a payé pour être mis en avant. La note et les avis ne sont pas concernés.')">{{ t('Sponsorisé') }}</span>
          <span v-if="isMine(pro)" class="tag accent">{{ t('Votre entreprise') }}</span>
          <span v-if="goesToClient(pro)" class="tag">{{ t('Se déplace à domicile') }}</span>
        </div>
      </div>
    </NuxtLink>
    <div class="service-line">
      <span class="ellip">{{ main.n }} <span class="muted">· {{ duration(main.d) }}</span></span>
      <b class="num">{{ euro(main.p) }}</b>
    </div>
    <div class="times">
      <NuxtLink v-for="st in times" :key="st.date + st.time" class="time" :to="`/reserver/${pro.id}/${main.id}?date=${st.date}&time=${st.time}`">
        <small>{{ shortDay(st.date, today) }}</small>{{ hm(st.time) }}
      </NuxtLink>
      <NuxtLink class="time more" :to="`/reserver/${pro.id}/${main.id}`">{{ times.length ? t('Plus d\'horaires') : t('Voir les disponibilités') }}</NuxtLink>
    </div>
  </article>
</template>
