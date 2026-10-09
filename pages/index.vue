<script setup lang="ts">
import { ChevronDown, MapPin, Search } from 'lucide-vue-next'
import { CATEGORIES, DEMO_CLIENT } from '~/data/pros'
import type { Category } from '~/data/pros'

const { state, pros, openSlots, km, ratingOf, pro, service, today, isDone, placeLabel } = useVladi()
const locOpen = ref(false)
const cats = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]

const byDistance = computed(() => [...pros].sort((a, b) => km(a) - km(b)))
const near = computed(() => byDistance.value.slice(0, 10))
const atHome = computed(() => byDistance.value.filter(goesToClient).slice(0, 10))
const best = computed(() => byDistance.value.slice(0, 60).filter(p => ratingOf(p).count >= 15).sort((a, b) => ratingOf(b).rating - ratingOf(a).rating).slice(0, 10))
const slots = computed(() => openSlots().slice(0, 10))
const nextBooking = computed(() => state.bookings
  .filter(b => b.status === 'confirmed' && !isDone(b))
  .sort((a, b) => `${a.date}${String(a.time).padStart(4, '0')}`.localeCompare(`${b.date}${String(b.time).padStart(4, '0')}`))[0])
</script>

<template>
  <header class="homehead">
    <AppLogo :height="24" />
    <span class="pill">Démo</span>
  </header>

  <div class="stack" style="gap:6px">
    <button class="loc" aria-label="Changer de lieu" @click="locOpen = true">
      <MapPin :size="16" /><span class="where">{{ state.pos.label }}</span><ChevronDown :size="16" />
    </button>
    <h1 class="h1">De quoi as-tu envie, {{ DEMO_CLIENT.firstName }} ?</h1>
  </div>

  <NuxtLink class="searchpill" to="/recherche?saisie=1">
    <Search :size="20" /><span>Cils, tresses, pose gel, massage...</span>
  </NuxtLink>

  <div class="rail" aria-label="Catégories">
    <NuxtLink v-for="c in cats" :key="c[0]" class="cat" :to="`/recherche?cat=${c[0]}`">
      <span class="ico"><component :is="CAT_ICON[c[0]]" :size="26" /></span>{{ CAT_SHORT[c[0]] }}
    </NuxtLink>
  </div>

  <NuxtLink v-if="nextBooking" class="appt" to="/rdv">
    <div class="datebox"><small>{{ dateParts(nextBooking.date).month }}</small><b>{{ dateParts(nextBooking.date).day }}</b></div>
    <div class="grow">
      <div class="tiny">Ton prochain rendez-vous</div>
      <div class="name ellip">{{ service(pro(nextBooking.proId)!, nextBooking.sid)?.n }}</div>
      <div class="meta"><span class="ellip">{{ dayLabel(nextBooking.date, today) }} à {{ hm(nextBooking.time) }} · {{ pro(nextBooking.proId)!.name }}</span></div>
      <div class="tiny ellip">{{ placeLabel(nextBooking) }}</div>
    </div>
  </NuxtLink>

  <section v-if="slots.length" class="sec">
    <div class="sechead">
      <div><h2 class="h2">Konyéla, tout de suite</h2><p class="sub">Des créneaux qui se libèrent aujourd'hui, à prix réduit</p></div>
      <NuxtLink class="link" to="/konyela">Tout voir</NuxtLink>
    </div>
    <div class="rail"><SlotCard v-for="s in slots" :key="s.id" :item="s" /></div>
  </section>

  <section class="sec">
    <div class="sechead"><h2 class="h2">Près de toi</h2><NuxtLink class="link" to="/recherche">Tout voir</NuxtLink></div>
    <div class="rail"><ProCardBig v-for="p in near" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="atHome.length" class="sec">
    <div class="sechead">
      <div><h2 class="h2">Ils viennent chez toi</h2><p class="sub">Sans bouger de la maison</p></div>
      <NuxtLink class="link" to="/recherche?lieu=client">Tout voir</NuxtLink>
    </div>
    <div class="rail"><ProCardBig v-for="p in atHome" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="best.length" class="sec">
    <div class="sechead"><h2 class="h2">Les mieux notés autour de toi</h2><NuxtLink class="link" to="/recherche?tri=note">Tout voir</NuxtLink></div>
    <div class="rail"><ProCardBig v-for="p in best" :key="p.id" :pro="p" /></div>
  </section>

  <p class="tiny" style="text-align:center">Version de démonstration : prestataires, prix, avis et positions sont fictifs.</p>

  <LocationSheet v-if="locOpen" @close="locOpen = false" />
</template>
