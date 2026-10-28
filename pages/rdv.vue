<script setup lang="ts">
import { CalendarDays, Navigation, Star } from 'lucide-vue-next'
import type { Booking } from '~/composables/useVladi'
import { RULES } from '~/data/pros'

useHead({ title: 'Mes rendez-vous · VLADI' })

const { myBookings, pro, service, today, isDone, refundable, cancel, addReview, toast, placeLabel, account, remote } = useVladi()
const stamp = (b: Booking) => `${b.date} ${String(b.time).padStart(4, '0')}`
const upcoming = computed(() => myBookings.value.filter(b => b.status === 'confirmed' && !isDone(b) && pro(b.proId)).sort((a, b) => stamp(a).localeCompare(stamp(b))))
const past = computed(() => myBookings.value.filter(b => (b.status === 'cancelled' || isDone(b)) && pro(b.proId)).sort((a, b) => stamp(b).localeCompare(stamp(a))))
const tab = ref<'next' | 'past'>('next')
const list = computed(() => (tab.value === 'next' ? upcoming.value : past.value))

const toCancel = ref<Booking | null>(null)
const toReview = ref<Booking | null>(null)
const stars = ref(5)
const text = ref('')

const label = (b: Booking) => service(pro(b.proId)!, b.sid)?.n
async function confirmCancel() {
  const b = toCancel.value
  toCancel.value = null
  if (b && await cancel(b.id)) toast('Rendez-vous annulé')
}
function openReview(b: Booking) {
  toReview.value = b
  stars.value = 5
  text.value = ''
}
async function sendReview() {
  const b = toReview.value
  toReview.value = null
  if (b) {
    await addReview(b.id, stars.value, text.value)
    toast('Merci, ton avis est publié')
  }
}
</script>

<template>
  <h1 class="title">{{ t('Rendez-vous') }}</h1>
  <div v-if="!account" class="empty mt24">
    <CalendarDays :size="32" />
    <template v-if="remote.loading">{{ t('Chargement…') }}</template>
    <template v-else>
      <b>{{ t('Connecte-toi pour voir tes rendez-vous') }}</b>
      <span>{{ t('Tes réservations sont liées à ton compte et te suivent sur tous tes appareils.') }}</span>
      <NuxtLink class="btn sm" to="/connexion?retour=/rdv">{{ t('Se connecter') }}</NuxtLink>
      <NuxtLink class="textbtn" to="/connexion?mode=inscription&retour=/rdv">{{ t('Créer un compte') }}</NuxtLink>
    </template>
  </div>
  <template v-else>
  <div class="seg mt16">
    <button :aria-pressed="tab === 'next'" @click="tab = 'next'">{{ t('À venir') }}{{ upcoming.length ? ` (${upcoming.length})` : '' }}</button>
    <button :aria-pressed="tab === 'past'" @click="tab = 'past'">{{ t('Passés') }}{{ past.length ? ` (${past.length})` : '' }}</button>
  </div>

  <div class="col mt8">
    <article v-for="b in list" :key="b.id" class="appt">
      <NuxtLink :to="`/pro/${b.proId}`"><ProPhoto class="thumb" :pro="pro(b.proId)!" :w="128" :h="128" ratio="none" :demo-label="false" /></NuxtLink>
      <div class="grow col gap8">
        <div class="col gap4">
          <div class="row between">
            <span class="name">{{ capitalize(dayLabel(b.date, today)) }} à {{ hm(b.time) }}</span>
            <span v-if="b.mode === 'lm'" class="tag now">{{ t('Konyéla') }}</span>
          </div>
          <span class="meta">{{ label(b) }} · {{ euro(b.price) }}</span>
          <NuxtLink class="meta ellip" :to="`/pro/${b.proId}`">{{ pro(b.proId)!.name }}</NuxtLink>
          <span class="tiny ellip">{{ placeLabel(b) }}</span>
        </div>
        <ArrivalBox v-if="tab === 'next' || b.noShow || b.disputed" :booking="b" side="client" />
        <div class="row wrap gap8">
          <template v-if="tab === 'next'">
            <a v-if="b.place === 'pro'" class="btn sm soft" :href="directionsUrl(pro(b.proId)!)" target="_blank" rel="noopener"><Navigation :size="15" />{{ t('Itinéraire') }}</a>
            <AddToCalendar :booking="b" />
            <button v-if="b.arrivedAt === undefined" class="btn sm line" @click="toCancel = b">{{ t('Annuler') }}</button>
          </template>
          <template v-else>
            <span v-if="b.status === 'cancelled'" class="tag">{{ t('Annulé') }}</span>
            <span v-else-if="b.noShow || b.disputed" class="tag warn">{{ b.disputed ? t('Litige en cours') : t('Absence') }}</span>
            <span v-else-if="b.reviewed" class="tag ok">{{ t('Avis envoyé') }}</span>
            <button v-else class="btn sm soft" @click="openReview(b)"><Star :size="15" />{{ t('Donner mon avis') }}</button>
            <NuxtLink class="btn sm line" :to="`/reserver/${b.proId}/${b.sid}`">{{ t('Reprendre rendez-vous') }}</NuxtLink>
          </template>
        </div>
      </div>
    </article>
    <div v-if="!list.length" class="empty">
      <CalendarDays :size="32" />
      <template v-if="tab === 'next'">
        <b>{{ t('Aucun rendez-vous prévu') }}</b>
        <span>{{ t('Trouve une prestation ou tente un créneau de dernière minute.') }}</span>
        <NuxtLink class="btn sm soft" to="/recherche">{{ t('Chercher une prestation') }}</NuxtLink>
      </template>
      <b v-else>{{ t('Aucun rendez-vous passé') }}</b>
    </div>
  </div>
  </template>

  <BottomSheet v-if="toCancel" @close="toCancel = null">
    <h2 class="h2">{{ t('Annuler ce rendez-vous ?') }}</h2>
    <p>{{ t('{what} avec {who}, {day} à {time}.', { what: label(toCancel) ?? '', who: pro(toCancel.proId)!.name, day: dayLabel(toCancel.date, today), time: hm(toCancel.time) }) }}</p>
    <template v-if="RULES.onlinePayment">
      <p v-if="refundable(toCancel)" class="notice">{{ t('Ton acompte de {amount} sera remboursé.', { amount: euro(toCancel.deposit) }) }}</p>
      <p v-else class="error">{{ toCancel.mode === 'lm' ? t('Créneau de dernière minute') : t('Moins de 24 h avant') }} : {{ t('l\'acompte de {amount} reste au/à la prestataire.', { amount: euro(toCancel.deposit) }) }}</p>
    </template>
    <template v-else>
      <p v-if="refundable(toCancel)" class="notice">{{ t('Annulation sans frais.') }}</p>
      <p v-else class="error">{{ toCancel.mode === 'lm' ? t('Créneau de dernière minute') : t('Moins de {h} h avant le rendez-vous', { h: RULES.freeCancelHours }) }} : {{ t('préviens {name} si possible. Les annulations tardives répétées peuvent entraîner la suspension du compte.', { name: pro(toCancel.proId)!.name }) }}</p>
    </template>
    <button class="btn block danger" @click="confirmCancel">{{ t('Annuler le rendez-vous') }}</button>
    <button class="btn block" @click="toCancel = null">{{ t('Garder le rendez-vous') }}</button>
  </BottomSheet>

  <BottomSheet v-if="toReview" @close="toReview = null">
    <h2 class="h2">{{ t('Ton avis sur {name}', { name: pro(toReview.proId)!.name }) }}</h2>
    <div class="stars" role="group" :aria-label="t('Note')">
      <button v-for="n in 5" :key="n" :aria-pressed="n <= stars" :aria-label="t('{n} sur 5', { n })" @click="stars = n"><Star :size="34" /></button>
    </div>
    <textarea id="avis" v-model="text" class="textarea" :placeholder="t('Raconte en une phrase')" :aria-label="t('Commentaire')" />
    <button class="btn block" @click="sendReview">{{ t('Publier l\'avis') }}</button>
  </BottomSheet>
</template>
