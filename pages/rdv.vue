<script setup lang="ts">
import { CalendarDays, Navigation, Star } from 'lucide-vue-next'
import type { Booking } from '~/composables/useVladi'

const { state, pro, service, today, isDone, refundable, cancel, addReview, toast, placeLabel } = useVladi()
const stamp = (b: Booking) => `${b.date} ${String(b.time).padStart(4, '0')}`
const upcoming = computed(() => state.bookings.filter(b => b.status === 'confirmed' && !isDone(b)).sort((a, b) => stamp(a).localeCompare(stamp(b))))
const past = computed(() => state.bookings.filter(b => b.status === 'cancelled' || isDone(b)).sort((a, b) => stamp(b).localeCompare(stamp(a))))
const tab = ref<'next' | 'past'>('next')
const list = computed(() => (tab.value === 'next' ? upcoming.value : past.value))

const toCancel = ref<Booking | null>(null)
const toReview = ref<Booking | null>(null)
const stars = ref(5)
const text = ref('')

const label = (b: Booking) => service(pro(b.proId)!, b.sid)?.n
function confirmCancel() {
  if (toCancel.value) cancel(toCancel.value.id)
  toCancel.value = null
  toast('Rendez-vous annulé')
}
function openReview(b: Booking) {
  toReview.value = b
  stars.value = 5
  text.value = ''
}
function sendReview() {
  if (toReview.value) addReview(toReview.value.id, stars.value, text.value)
  toReview.value = null
  toast('Merci, ton avis est publié')
}
</script>

<template>
  <h1 class="h1">Mes rendez-vous</h1>
  <div class="seg">
    <button :aria-pressed="tab === 'next'" @click="tab = 'next'">À venir{{ upcoming.length ? ` (${upcoming.length})` : '' }}</button>
    <button :aria-pressed="tab === 'past'" @click="tab = 'past'">Passés{{ past.length ? ` (${past.length})` : '' }}</button>
  </div>

  <div class="stack">
    <article v-for="b in list" :key="b.id" class="appt">
      <div class="datebox" :class="{ past: tab === 'past' }"><small>{{ dateParts(b.date).month }}</small><b>{{ dateParts(b.date).day }}</b></div>
      <div class="grow stack" style="gap:6px">
        <div>
          <div class="row between"><span class="name ellip">{{ label(b) }}</span><span v-if="b.mode === 'lm'" class="badge k">Konyéla</span></div>
          <div class="meta"><span>{{ dayLabel(b.date, today) }} à {{ hm(b.time) }} · {{ euro(b.price) }}</span></div>
          <NuxtLink class="meta" :to="`/pro/${b.proId}`"><span class="ellip">{{ pro(b.proId)!.name }}</span></NuxtLink>
          <div class="tiny">{{ placeLabel(b) }}</div>
        </div>
        <div class="row wrap" style="gap:8px">
          <template v-if="tab === 'next'">
            <a v-if="b.place === 'pro'" class="btn small line" :href="directionsUrl(pro(b.proId)!)" target="_blank" rel="noopener"><Navigation :size="14" />Itinéraire</a>
            <button class="btn small line" @click="toCancel = b">Annuler</button>
          </template>
          <template v-else>
            <span v-if="b.status === 'cancelled'" class="badge">Annulé</span>
            <span v-else-if="b.reviewed" class="badge ok">Avis envoyé</span>
            <button v-else class="btn small soft" @click="openReview(b)"><Star :size="14" />Laisser un avis</button>
            <NuxtLink class="btn small line" :to="`/reserver/${b.proId}/${b.sid}`">Réserver à nouveau</NuxtLink>
          </template>
        </div>
      </div>
    </article>
    <div v-if="!list.length" class="empty">
      <CalendarDays :size="34" />
      <p v-if="tab === 'next'"><b>Rien de prévu.</b><br>Trouve une prestation ou tente un créneau Konyéla.</p>
      <p v-else><b>Aucun rendez-vous passé.</b></p>
      <NuxtLink v-if="tab === 'next'" class="btn small soft" to="/recherche">Chercher une prestation</NuxtLink>
    </div>
  </div>

  <BottomSheet v-if="toCancel" @close="toCancel = null">
    <h2 class="h2">Annuler ce rendez-vous ?</h2>
    <p>{{ label(toCancel) }} avec {{ pro(toCancel.proId)!.name }}, {{ dayLabel(toCancel.date, today) }} à {{ hm(toCancel.time) }}.</p>
    <p v-if="refundable(toCancel)" class="ok">Acompte de {{ euro(toCancel.deposit) }} remboursé.</p>
    <p v-else class="warn">{{ toCancel.mode === 'lm' ? 'Créneau Konyéla' : 'Moins de 24 h avant' }} : l'acompte de {{ euro(toCancel.deposit) }} reste au prestataire.</p>
    <button class="btn block" @click="confirmCancel">Confirmer l'annulation</button>
    <button class="btn block line" @click="toCancel = null">Garder le rendez-vous</button>
  </BottomSheet>

  <BottomSheet v-if="toReview" @close="toReview = null">
    <h2 class="h2">Ton avis sur {{ pro(toReview.proId)!.name }}</h2>
    <div class="stars" role="group" aria-label="Note">
      <button v-for="n in 5" :key="n" :aria-pressed="n <= stars" :aria-label="`${n} sur 5`" @click="stars = n"><Star :size="34" /></button>
    </div>
    <textarea id="avis" v-model="text" placeholder="Raconte en une phrase" aria-label="Commentaire" />
    <button class="btn block" @click="sendReview">Publier l'avis</button>
    <button class="btn block line" @click="toReview = null">Plus tard</button>
  </BottomSheet>
</template>
