<script setup lang="ts">
import type { Booking } from '~/composables/useVladi'

const { state, pro, service, today, isDone, refundable, cancel, addReview, toast, placeLabel } = useVladi()
const stamp = (b: Booking) => `${b.date} ${String(b.time).padStart(4, '0')}`
const upcoming = computed(() => state.bookings.filter(b => b.status === 'confirmed' && !isDone(b)).sort((a, b) => stamp(a).localeCompare(stamp(b))))
const past = computed(() => state.bookings.filter(b => b.status === 'cancelled' || isDone(b)).sort((a, b) => stamp(b).localeCompare(stamp(a))))

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
  <h2 class="h2">À venir</h2>
  <div class="stack">
    <div v-for="b in upcoming" :key="b.id" class="box">
      <div class="row between"><b>{{ label(b) }}</b><span v-if="b.mode === 'lm'" class="tag k">Konyéla</span></div>
      <div class="sub">{{ pro(b.proId)!.name }} · {{ placeLabel(b) }}</div>
      <div class="row between">
        <span><b>{{ dayLabel(b.date, today) }} à {{ hm(b.time) }}</b> · {{ euro(b.price) }}</span>
        <button class="btn small line" @click="toCancel = b">Annuler</button>
      </div>
    </div>
    <p v-if="!upcoming.length" class="empty">Rien de prévu. Un créneau Konyéla te tente ?</p>
  </div>
  <h2 class="h2">Passés</h2>
  <div class="stack">
    <div v-for="b in past" :key="b.id" class="box">
      <div class="row between"><b>{{ label(b) }}</b><span v-if="b.mode === 'lm'" class="tag k">Konyéla</span></div>
      <div class="sub">{{ pro(b.proId)!.name }} · {{ placeLabel(b) }}</div>
      <div class="row between">
        <span><b>{{ dayLabel(b.date, today) }} à {{ hm(b.time) }}</b> · {{ euro(b.price) }}</span>
        <span v-if="b.status === 'cancelled'" class="warn">Annulé</span>
        <span v-else-if="b.reviewed" class="ok">Avis envoyé</span>
        <button v-else class="btn small" @click="openReview(b)">Laisser un avis</button>
      </div>
    </div>
    <p v-if="!past.length" class="empty">Aucun rendez-vous passé.</p>
  </div>

  <BottomSheet v-if="toCancel" @close="toCancel = null">
    <h2 class="h2">Annuler ce rendez-vous ?</h2>
    <p>{{ label(toCancel) }} chez {{ pro(toCancel.proId)!.name }}, {{ dayLabel(toCancel.date, today) }} à {{ hm(toCancel.time) }}.</p>
    <p v-if="refundable(toCancel)" class="ok">Acompte de {{ euro(toCancel.deposit) }} remboursé.</p>
    <p v-else class="warn">{{ toCancel.mode === 'lm' ? 'Créneau Konyéla' : 'Moins de 24 h avant' }} : l'acompte de {{ euro(toCancel.deposit) }} reste au prestataire.</p>
    <button class="btn block" @click="confirmCancel">Confirmer l'annulation</button>
    <button class="btn block line" @click="toCancel = null">Garder le rendez-vous</button>
  </BottomSheet>

  <BottomSheet v-if="toReview" @close="toReview = null">
    <h2 class="h2">Ton avis</h2>
    <div class="stars" role="group" aria-label="Note">
      <button v-for="n in 5" :key="n" :aria-pressed="n <= stars" :aria-label="`${n} sur 5`" @click="stars = n">★</button>
    </div>
    <textarea id="avis" v-model="text" placeholder="Raconte en une phrase" aria-label="Commentaire" />
    <button class="btn block" @click="sendReview">Publier l'avis</button>
    <button class="btn block line" @click="toReview = null">Plus tard</button>
  </BottomSheet>
</template>
