<script setup lang="ts">
import { ChevronLeft, House, Store, Zap } from 'lucide-vue-next'
import { RULES } from '~/data/pros'
import type { Place } from '~/utils/places'

const route = useRoute()
const router = useRouter()
const { pro, service, starts, today, state, nowMin, book, toast, km } = useVladi()

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

// Jour et heure, éventuellement déjà choisis depuis la liste de résultats.
const days = computed(() => Array.from({ length: 14 }, (_, i) => addDays(today.value, i)))
const date = ref(typeof route.query.date === 'string' ? route.query.date : '')
const time = ref<number | null>(route.query.time ? Number(route.query.time) : null)
const recap = ref(false)

const free = computed(() => (p.value && sv.value && date.value ? starts(p.value, date.value, sv.value.d) : []))
function hasRoom(d: string) {
  return !!(p.value && sv.value && starts(p.value, d, sv.value.d).length)
}
watchEffect(() => {
  if (p.value && sv.value && (!date.value || !days.value.includes(date.value))) date.value = days.value.find(hasRoom) ?? days.value[0]
})
watch(free, (f) => { if (time.value !== null && !f.includes(time.value)) time.value = null }, { immediate: true })
const parts = computed(() => [
  { label: 'Matin', list: free.value.filter(t => t < 720) },
  { label: 'Après-midi', list: free.value.filter(t => t >= 720 && t < 1020) },
  { label: 'Soir', list: free.value.filter(t => t >= 1020) },
].filter(x => x.list.length))

const servicePrice = computed(() => (sv.value ? (slot.value ? discounted(sv.value, slot.value.disc) : sv.value.p) : 0))
const price = computed(() => servicePrice.value + fee.value)
const deposit = computed(() => Math.round(price.value * RULES.depositRate))
const when = computed(() => (slot.value ? { date: slot.value.date, time: slot.value.time } : { date: date.value, time: time.value ?? 0 }))
const hasTime = computed(() => (isSlot.value ? !slotGone.value : time.value !== null))
const ready = computed(() => addressOk.value && hasTime.value)
const hint = computed(() => (!hasTime.value ? 'Choisis une heure' : !addressOk.value ? 'Indique ton adresse' : `${dayLabel(when.value.date, today.value)} à ${hm(when.value.time)}`))

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
      <button class="iconbtn soft" aria-label="Retour" @click="router.back()"><ChevronLeft :size="22" /></button>
      <div class="grow">
        <div class="h2 ellip">{{ sv.n }}</div>
        <div class="sub ellip">{{ p.name }} · {{ sv.d }} min</div>
      </div>
    </div>

    <div v-if="isSlot && slotGone" class="empty">
      <Zap :size="34" />
      <p><b>Ce créneau Konyéla vient de partir.</b></p>
      <NuxtLink class="btn small soft" to="/konyela">Voir les autres</NuxtLink>
    </div>

    <template v-else>
      <section class="sec">
        <h2 class="h3">Où ?</h2>
        <div class="choice">
          <button v-if="places.includes('pro')" :aria-pressed="place === 'pro'" @click="place = 'pro'">
            <span class="ico"><Store :size="20" /></span>
            <span class="grow"><b>{{ proPlace(p) }}</b><br><span class="sub">{{ p.quartier }}, {{ p.commune }} · à {{ formatKm(km(p)) }}</span></span>
            <span class="radio" />
          </button>
          <button v-if="places.includes('client')" :aria-pressed="place === 'client'" @click="place = 'client'">
            <span class="ico"><House :size="20" /></span>
            <span class="grow"><b>Chez moi</b><br><span class="sub">{{ travelFee(p) ? `+ ${euro(travelFee(p))} de déplacement` : 'Déplacement offert' }}</span></span>
            <span class="radio" />
          </button>
        </div>
        <template v-if="place === 'client'">
          <input id="adresse" v-model="address" class="field" type="text" autocomplete="street-address" placeholder="Ton adresse : rue, quartier, commune" aria-label="Adresse de la prestation">
        </template>
      </section>

      <section v-if="isSlot && slot" class="sec">
        <h2 class="h3">Quand ?</h2>
        <div class="kcard wide">
          <div class="row between"><span class="when">Aujourd'hui à {{ hm(slot.time) }}</span><span class="badge k">-{{ slot.disc }} %</span></div>
          <div class="tiny">Créneau de dernière minute : l'acompte n'est pas remboursable.</div>
        </div>
      </section>
      <template v-else>
        <section class="sec">
          <h2 class="h3">Quel jour ?</h2>
          <div class="days">
            <button v-for="d in days" :key="d" class="day" :aria-pressed="date === d" :disabled="!hasRoom(d)" :aria-label="dayLabel(d, today)" @click="date = d; time = null">
              <small>{{ d === today ? 'auj' : dateParts(d).dow }}</small><b>{{ dateParts(d).day }}</b>
            </button>
          </div>
        </section>
        <section class="sec">
          <h2 class="h3">Quelle heure ?</h2>
          <template v-for="part in parts" :key="part.label">
            <div class="part">{{ part.label }}</div>
            <div class="slots">
              <button v-for="t in part.list" :key="t" class="slot" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
            </div>
          </template>
          <p v-if="!free.length" class="sub">Plus de place ce jour-là. Essaie un autre jour.</p>
        </section>
        <p class="tiny">Annulation gratuite jusqu'à {{ RULES.freeCancelHours }} h avant. Passé ce délai, l'acompte reste au prestataire.</p>
      </template>

      <div class="cta">
        <div class="sum grow"><b>{{ euro(price) }}</b><span class="tiny ellip">{{ hint }}</span></div>
        <button class="btn" :class="{ sun: isSlot }" :disabled="!ready" @click="recap = true">Continuer</button>
      </div>
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
        <div class="kv total"><span>Total</span><span>{{ euro(price) }}</span></div>
        <div class="kv"><span>Acompte maintenant ({{ RULES.depositRate * 100 }} %)</span><span>{{ euro(deposit) }}</span></div>
        <div class="kv"><span>Reste à payer le jour même</span><span>{{ euro(price - deposit) }}</span></div>
      </div>
      <p class="tiny">Paiement simulé dans cette version : aucune carte n'est débitée.</p>
      <button class="btn block" @click="pay">Payer l'acompte de {{ euro(deposit) }}</button>
      <button class="btn block line" @click="recap = false">Modifier</button>
    </BottomSheet>
  </template>
  <div v-else class="empty" style="padding-top:80px">
    <p><b>Cette prestation n'existe pas.</b></p>
    <NuxtLink class="btn small soft" to="/">Retour à l'accueil</NuxtLink>
  </div>
</template>
