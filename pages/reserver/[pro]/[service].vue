<script setup lang="ts">
import { ChevronLeft, House, Store, Zap } from 'lucide-vue-next'
import { RULES } from '~/data/pros'
import type { Place } from '~/utils/places'

const route = useRoute()
const router = useRouter()
const { pro, service, starts, today, state, remote, nowMin, book, km, account, firstName, saveProfile } = useVladi()

const p = computed(() => pro(String(route.params.pro)))
const sv = computed(() => (p.value ? service(p.value, String(route.params.service)) : undefined))
const slot = computed(() => [...remote.slots, ...state.slots].find(s => s.id === route.query.creneau))
const isSlot = computed(() => !!route.query.creneau)
const slotGone = computed(() => isSlot.value && (!slot.value || slot.value.status !== 'open' || slot.value.time < nowMin.value + 10))
const needsAccount = computed(() => !!p.value?.real && !account.value)

// Lieu : chez le/la prestataire ou à domicile, selon ce qui est proposé.
const places = computed(() => (p.value ? allowedPlaces(p.value) : []))
const place = ref<Place>('pro')
const address = ref(state.address)
const note = ref('')
watchEffect(() => { if (places.value.length && !places.value.includes(place.value)) place.value = places.value[0] })
const fee = computed(() => (p.value && place.value === 'client' ? travelFee(p.value) : 0))
const addressOk = computed(() => place.value !== 'client' || address.value.trim().length >= 5)

// Jour et heure, éventuellement déjà choisis depuis la liste de résultats.
const days = computed(() => Array.from({ length: 14 }, (_, i) => addDays(today.value, i)))
const date = ref(typeof route.query.date === 'string' ? route.query.date : '')
const time = ref<number | null>(route.query.time ? Number(route.query.time) : null)
const recap = ref(false)
const busy = ref(false)
const error = ref('')

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
// Chez une vraie fiche, le/la prestataire doit pouvoir joindre la personne : le téléphone est demandé une fois.
const phone = ref('')
const needsPhone = computed(() => !!p.value?.real && !!account.value && !account.value.phone)
const phoneOk = computed(() => !needsPhone.value || phone.value.replace(/\D/g, '').length >= 8)
const ready = computed(() => addressOk.value && hasTime.value && phoneOk.value)
const hint = computed(() => (!hasTime.value ? 'Choisis une heure' : !addressOk.value ? 'Indique ton adresse' : !phoneOk.value ? 'Indique ton téléphone' : `${capitalize(dayLabel(when.value.date, today.value))} à ${hm(when.value.time)}`))
const loginLink = computed(() => `/connexion?retour=${encodeURIComponent(route.fullPath)}`)

async function pay() {
  if (!p.value || !sv.value || busy.value) return
  busy.value = true
  error.value = ''
  if (needsPhone.value) {
    const e = await saveProfile({ phone: phone.value })
    if (e) {
      busy.value = false
      error.value = e
      return
    }
  }
  const res = await book({ proId: p.value.id, sid: sv.value.id, date: when.value.date, time: when.value.time, slotId: slot.value?.id, place: place.value, address: address.value, note: note.value })
  busy.value = false
  if (res.error === 'connexion') return router.push(loginLink.value)
  if (!res.booking) {
    error.value = res.error ?? 'La réservation n\'a pas abouti.'
    return
  }
  router.replace(`/confirmation/${res.booking.id}`)
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push(p.value ? `/pro/${p.value.id}` : '/')
}
</script>

<template>
  <template v-if="p && sv">
    <div class="head">
      <button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button>
      <div class="grow col">
        <span class="h3 ellip">{{ sv.n }}</span>
        <span class="meta ellip">{{ p.name }} · {{ duration(sv.d) }}</span>
      </div>
    </div>

    <div v-if="isSlot && slotGone" class="empty">
      <Zap :size="32" />
      <b>Ce créneau vient de partir</b>
      <NuxtLink class="btn sm soft" to="/konyela">Voir les autres</NuxtLink>
    </div>

    <template v-else>
      <section class="section mt24">
        <h2 class="h3">Où ?</h2>
        <div class="choice">
          <button v-if="places.includes('pro')" :aria-pressed="place === 'pro'" @click="place = 'pro'">
            <Store :size="22" />
            <span class="grow col gap4"><span class="name">{{ proPlace(p) }}</span><span class="meta">{{ p.quartier ? `${p.quartier}, ` : '' }}{{ p.commune }} · {{ formatKm(km(p)) }}</span></span>
            <span class="radio" />
          </button>
          <button v-if="places.includes('client')" :aria-pressed="place === 'client'" @click="place = 'client'">
            <House :size="22" />
            <span class="grow col gap4"><span class="name">Chez moi</span><span class="meta">{{ travelFee(p) ? `+ ${euro(travelFee(p))} de déplacement` : 'Déplacement offert' }}</span></span>
            <span class="radio" />
          </button>
        </div>
        <input v-if="place === 'client'" id="adresse" v-model="address" class="input" type="text" autocomplete="street-address" placeholder="Ton adresse : rue, quartier, commune" aria-label="Adresse de la prestation">
      </section>

      <section v-if="isSlot && slot" class="section">
        <h2 class="h3">Quand ?</h2>
        <div class="kcard">
          <div class="when"><b>{{ hm(slot.time) }}</b><span class="tiny">aujourd'hui</span></div>
          <span class="vr" />
          <span class="grow meta">Créneau de dernière minute à -{{ slot.disc }} %. L'acompte n'est pas remboursable.</span>
        </div>
      </section>
      <template v-else>
        <section class="section">
          <h2 class="h3">Quel jour ?</h2>
          <div class="days">
            <button v-for="d in days" :key="d" class="day" :aria-pressed="date === d" :disabled="!hasRoom(d)" :aria-label="dayLabel(d, today)" @click="date = d; time = null">
              <small>{{ d === today ? 'auj.' : dateParts(d).dow }}</small><b>{{ dateParts(d).day }}</b>
            </button>
          </div>
        </section>
        <section class="section">
          <h2 class="h3">Quelle heure ?</h2>
          <div v-for="part in parts" :key="part.label" class="col gap8">
            <span class="meta">{{ part.label }}</span>
            <div class="slots">
              <button v-for="t in part.list" :key="t" class="slot" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
            </div>
          </div>
          <p v-if="!free.length" class="meta">Plus de place ce jour-là. Essaie un autre jour.</p>
        </section>
      </template>

      <section class="section">
        <label class="field" for="note">
          <span>Une info pour {{ p.owner?.split(' ')[0] ?? p.name }} ? <span class="help">(facultatif)</span></span>
          <textarea id="note" v-model="note" class="textarea" maxlength="300" placeholder="Grossesse, allergie, cheveux fragiles, accès difficile…" />
          <span class="help">Ce message est lu par le/la prestataire avant le rendez-vous. VLADI ne vérifie pas les informations de santé.</span>
        </label>
      </section>

      <section v-if="needsPhone" class="section">
        <label class="field" for="tel">
          <span class="h3">Ton téléphone</span>
          <input id="tel" v-model="phone" class="input" type="tel" autocomplete="tel" inputmode="tel" placeholder="0690 00 00 00">
          <span class="help">Transmis au/à la prestataire pour te joindre si besoin. Enregistré dans ton compte.</span>
        </label>
      </section>

      <p v-if="!isSlot" class="tiny mt16">Annulation gratuite jusqu'à {{ RULES.freeCancelHours }} h avant. Passé ce délai, l'acompte reste au/à la prestataire.</p>

      <div class="cta mt24">
        <div class="sum grow"><b>{{ euro(price) }}</b><span class="tiny ellip">{{ hint }}</span></div>
        <NuxtLink v-if="needsAccount" class="btn" :to="loginLink">Se connecter</NuxtLink>
        <button v-else class="btn" :class="{ now: isSlot }" :disabled="!ready" @click="recap = true">Continuer</button>
      </div>
    </template>

    <BottomSheet v-if="recap" @close="recap = false">
      <h2 class="h2">Récapitulatif</h2>
      <div class="recap">
        <div class="kv"><span>Prestation</span><span>{{ sv.n }}</span></div>
        <div class="kv"><span>Avec</span><span>{{ p.name }}</span></div>
        <div class="kv"><span>Où</span><span>{{ place === 'client' ? `Chez moi, ${address.trim()}` : `${proPlace(p)}, ${p.commune}` }}</span></div>
        <div class="kv"><span>Quand</span><span>{{ capitalize(dayLabel(when.date, today)) }} à {{ hm(when.time) }}</span></div>
        <div class="kv"><span>Prix</span><span><span v-if="slot" class="strike">{{ euro(sv.p) }}</span> {{ euro(servicePrice) }}</span></div>
        <div v-if="place === 'client'" class="kv"><span>Déplacement</span><span>{{ fee ? euro(fee) : 'offert' }}</span></div>
        <div class="kv total"><span>Total</span><span>{{ euro(price) }}</span></div>
        <div class="kv"><span>Acompte à payer maintenant</span><span>{{ euro(deposit) }}</span></div>
        <div class="kv"><span>Reste à payer sur place</span><span>{{ euro(price - deposit) }}</span></div>
      </div>
      <p class="notice">{{ p.real ? `Réservation au nom de ${firstName}.` : 'Fiche d\'exemple : rien n\'est envoyé.' }} Paiement simulé pendant les tests, aucune carte n'est débitée.</p>
      <p v-if="error" class="error">{{ error }}</p>
      <button class="btn block" :disabled="busy" @click="pay">{{ busy ? 'Réservation…' : `Confirmer et payer ${euro(deposit)}` }}</button>
      <button class="btn block line" @click="recap = false">Modifier</button>
    </BottomSheet>
  </template>
  <div v-else-if="remote.loading" class="empty" style="padding-top:96px">Chargement…</div>
  <div v-else class="empty" style="padding-top:96px">
    <b>Cette prestation n'existe pas</b>
    <NuxtLink class="btn sm soft" to="/">Retour à l'accueil</NuxtLink>
  </div>
</template>
