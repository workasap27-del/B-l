<script setup lang="ts">
import { RULES } from '~/data/pros'
import type { Place } from '~/utils/places'

const route = useRoute()
const router = useRouter()
const { pro, service, starts, today, state, nowMin, book, toast } = useVladi()

const p = computed(() => pro(String(route.params.pro)))
const sv = computed(() => (p.value ? service(p.value, String(route.params.service)) : undefined))
const slot = computed(() => state.slots.find(s => s.id === route.query.creneau))
const isSlot = computed(() => !!route.query.creneau)
const slotGone = computed(() => isSlot.value && (!slot.value || slot.value.status !== 'open' || slot.value.time < nowMin.value + 10))

// Lieu : chez le prestataire ou chez la cliente, selon ce qu'il propose.
const places = computed(() => (p.value ? allowedPlaces(p.value) : []))
const place = ref<Place>('pro')
const address = ref(state.address)
watchEffect(() => { if (places.value.length && !places.value.includes(place.value)) place.value = places.value[0] })
const fee = computed(() => (p.value && place.value === 'client' ? travelFee(p.value) : 0))
const addressOk = computed(() => place.value !== 'client' || address.value.trim().length >= 5)

const days = computed(() => Array.from({ length: 7 }, (_, i) => addDays(today.value, i)))
const date = ref('')
const time = ref<number | null>(null)
const recap = ref(false)

const free = computed(() => (p.value && sv.value && date.value ? starts(p.value, date.value, sv.value.d) : []))
function hasRoom(d: string) {
  return !!(p.value && sv.value && starts(p.value, d, sv.value.d).length)
}
watchEffect(() => {
  if (!date.value && p.value && sv.value) date.value = days.value.find(hasRoom) ?? days.value[0]
})
watch(free, (f) => { if (time.value !== null && !f.includes(time.value)) time.value = null })

const servicePrice = computed(() => (sv.value ? (slot.value ? discounted(sv.value, slot.value.disc) : sv.value.p) : 0))
const price = computed(() => servicePrice.value + fee.value)
const deposit = computed(() => Math.round(price.value * RULES.depositRate))
const when = computed(() => (slot.value ? { date: slot.value.date, time: slot.value.time } : { date: date.value, time: time.value ?? 0 }))
const ready = computed(() => addressOk.value && (isSlot.value ? !slotGone.value : time.value !== null))

function pay() {
  if (!p.value || !sv.value) return
  const b = book({ proId: p.value.id, sid: sv.value.id, date: when.value.date, time: when.value.time, slotId: slot.value?.id, place: place.value, address: address.value })
  if (!b) {
    recap.value = false
    toast('Ce créneau vient de partir. Choisis-en un autre.')
    return
  }
  router.replace(`/confirmation/${b.id}`)
}
</script>

<template>
  <template v-if="p && sv">
    <div class="topbar">
      <button class="bk" aria-label="Retour" @click="router.back()">‹</button>
      <div class="grow">
        <div class="h2">{{ sv.n }}</div>
        <div class="sub">{{ p.name }} · {{ sv.d }} min · {{ euro(servicePrice) }}</div>
      </div>
    </div>

    <p v-if="isSlot && slotGone" class="empty">Ce créneau Konyéla n'est plus disponible. <NuxtLink to="/konyela" class="ok">Voir les autres</NuxtLink></p>

    <template v-else>
      <h2 class="h2">Où ?</h2>
      <div class="place">
        <button v-if="places.includes('pro')" :aria-pressed="place === 'pro'" @click="place = 'pro'">
          <b>{{ proPlace(p) }}</b>
          <span class="sub">{{ p.quartier }}, {{ p.commune }} · tu te déplaces</span>
        </button>
        <button v-if="places.includes('client')" :aria-pressed="place === 'client'" @click="place = 'client'">
          <b>Chez moi</b>
          <span class="sub">{{ p.owner ?? p.name }} vient chez toi · {{ travelFee(p) ? `+ ${euro(travelFee(p))} de déplacement` : 'déplacement offert' }}</span>
        </button>
      </div>
      <template v-if="place === 'client'">
        <input id="adresse" v-model="address" class="search" type="text" autocomplete="street-address" placeholder="Ton adresse : rue, quartier, commune" aria-label="Adresse de la prestation">
        <p v-if="!addressOk" class="sub">Indique où le prestataire doit venir.</p>
      </template>

      <template v-if="isSlot && slot">
        <div class="kbox">
          <span class="tag k" style="align-self:flex-start">Konyéla · -{{ slot.disc }} %</span>
          <div class="name">Aujourd'hui à {{ hm(slot.time) }}</div>
        </div>
        <div class="box sub">Créneau de dernière minute : l'acompte n'est pas remboursable.</div>
      </template>
      <template v-else>
        <h2 class="h2">Quel jour ?</h2>
        <div class="chips">
          <button v-for="d in days" :key="d" class="chip" :aria-pressed="date === d" :disabled="!hasRoom(d)" @click="date = d; time = null">{{ dayChip(d, today) }}</button>
        </div>
        <h2 class="h2">Quelle heure ?</h2>
        <div v-if="free.length" class="slots">
          <button v-for="t in free" :key="t" class="slot" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
        </div>
        <p v-else class="empty">Plus de place ce jour-là. Essaie un autre jour.</p>
        <div class="box sub">Annulation gratuite jusqu'à {{ RULES.freeCancelHours }} h avant le rendez-vous. Passé ce délai, l'acompte reste au prestataire.</div>
      </template>
      <button class="btn block" :class="{ sun: isSlot }" :disabled="!ready" @click="recap = true">Continuer</button>
    </template>

    <BottomSheet v-if="recap" @close="recap = false">
      <h2 class="h2">Récapitulatif</h2>
      <div class="box">
        <div class="kv"><span>Prestation</span><span>{{ sv.n }}</span></div>
        <div class="kv"><span>Avec</span><span>{{ p.name }}</span></div>
        <div class="kv"><span>Où</span><span>{{ place === 'client' ? `Chez moi · ${address.trim()}` : `${proPlace(p)} · ${p.quartier}, ${p.commune}` }}</span></div>
        <div class="kv"><span>Quand</span><span>{{ dayLabel(when.date, today) }} à {{ hm(when.time) }}</span></div>
        <div class="kv"><span>Prix</span><span><span v-if="slot" class="strike">{{ euro(sv.p) }}</span>{{ euro(servicePrice) }}</span></div>
        <div v-if="place === 'client'" class="kv"><span>Déplacement</span><span>{{ fee ? euro(fee) : 'offert' }}</span></div>
        <div class="kv"><span>Total</span><span>{{ euro(price) }}</span></div>
        <div class="kv"><span>Acompte maintenant ({{ RULES.depositRate * 100 }} %)</span><span>{{ euro(deposit) }}</span></div>
        <div class="kv"><span>Reste à payer le jour même</span><span>{{ euro(price - deposit) }}</span></div>
      </div>
      <p class="sub">Paiement simulé dans cette version : aucune carte n'est débitée.</p>
      <button class="btn block" @click="pay">Payer l'acompte de {{ euro(deposit) }}</button>
      <button class="btn block line" @click="recap = false">Retour</button>
    </BottomSheet>
  </template>
  <p v-else class="empty">Cette prestation n'existe pas. <NuxtLink to="/" class="ok">Retour à l'accueil</NuxtLink></p>
</template>
