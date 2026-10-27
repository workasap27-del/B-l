<script setup lang="ts">
import { ChevronLeft, House, Store, Zap } from 'lucide-vue-next'
import { RULES } from '~/data/pros'
import type { Place } from '~/utils/places'

const route = useRoute()
const router = useRouter()
const { pro, service, starts, today, state, remote, nowMin, book, clashWith, km, account, firstName, saveProfile } = useVladi()

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
// Deux rendez-vous à la même heure sont impossibles : on prévient, et on propose de remplacer l'ancien.
const clash = computed(() => (hasTime.value && sv.value && account.value ? clashWith({ date: when.value.date, time: when.value.time, dur: sv.value.d }) : undefined))
const replace = ref(false)
const clashBox = ref<HTMLElement | null>(null)
watch(() => clash.value?.id, async (id) => { if (id) { await nextTick(); clashBox.value?.scrollIntoView({ block: 'center', behavior: 'smooth' }) } })
watch(() => clash.value?.id, () => { replace.value = false })
const clashPro = computed(() => (clash.value ? pro(clash.value.proId) : undefined))
const clashService = computed(() => (clash.value && clashPro.value ? service(clashPro.value, clash.value.sid) : undefined))
const clashFree = computed(() => !clash.value || replace.value)
const ready = computed(() => addressOk.value && hasTime.value && phoneOk.value && clashFree.value)
const hint = computed(() => (!hasTime.value ? translate('Choisis une heure') : !clashFree.value ? translate('Heure déjà prise') : !addressOk.value ? translate('Indique ton adresse') : !phoneOk.value ? translate('Indique ton téléphone') : translate('{day} à {time}', { day: capitalize(dayLabel(when.value.date, today.value)), time: hm(when.value.time) })))
const loginLink = computed(() => `/connexion?retour=${encodeURIComponent(route.fullPath)}`)

async function pay() {
  if (!p.value || !sv.value || busy.value) return
  busy.value = true
  error.value = translate('')
  if (needsPhone.value) {
    const e = await saveProfile({ phone: phone.value })
    if (e) {
      busy.value = false
      error.value = e
      return
    }
  }
  const res = await book({ proId: p.value.id, sid: sv.value.id, date: when.value.date, time: when.value.time, slotId: slot.value?.id, place: place.value, address: address.value, note: note.value, replaceId: replace.value ? clash.value?.id : undefined })
  busy.value = false
  if (res.error === 'connexion') return router.push(loginLink.value)
  if (res.error === 'chevauchement') {
    recap.value = false
    error.value = translate('')
    return
  }
  if (!res.booking) {
    error.value = res.error ?? translate('La réservation n\'a pas abouti.')
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
      <button class="icon-btn" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="24" /></button>
      <div class="grow col">
        <span class="h3 ellip">{{ sv.n }}</span>
        <span class="meta ellip">{{ p.name }} · {{ duration(sv.d) }}</span>
      </div>
    </div>

    <div v-if="isSlot && slotGone" class="empty">
      <Zap :size="32" />
      <b>{{ t('Ce créneau vient de partir') }}</b>
      <NuxtLink class="btn sm soft" to="/konyela">{{ t('Voir les autres') }}</NuxtLink>
    </div>

    <template v-else>
      <section class="section mt24">
        <h2 class="h3">{{ t('Où ?') }}</h2>
        <div class="choice">
          <button v-if="places.includes('pro')" :aria-pressed="place === 'pro'" @click="place = 'pro'">
            <Store :size="22" />
            <span class="grow col gap4"><span class="name">{{ t(proPlace(p) ?? '') }}</span><span class="meta">{{ p.quartier ? `${p.quartier}, ` : '' }}{{ p.commune }} · {{ formatKm(km(p)) }}</span></span>
            <span class="radio" />
          </button>
          <button v-if="places.includes('client')" :aria-pressed="place === 'client'" @click="place = 'client'">
            <House :size="22" />
            <span class="grow col gap4"><span class="name">{{ t('Chez moi') }}</span><span class="meta">{{ travelFee(p) ? t('+ {fee} de déplacement', { fee: euro(travelFee(p)) }) : t('Déplacement offert') }}</span></span>
            <span class="radio" />
          </button>
        </div>
        <input v-if="place === 'client'" id="adresse" v-model="address" class="input" type="text" autocomplete="street-address" :placeholder="t('Ton adresse : rue, quartier, commune')" :aria-label="t('Adresse de la prestation')">
      </section>

      <section v-if="isSlot && slot" class="section">
        <h2 class="h3">{{ t('Quand ?') }}</h2>
        <div class="kcard">
          <div class="when"><b>{{ hm(slot.time) }}</b><span class="tiny">{{ t('aujourd\'hui') }}</span></div>
          <span class="vr" />
          <span class="grow meta">{{ t('Créneau de dernière minute à -{n} %.', { n: slot.disc }) }} {{ RULES.onlinePayment ? t('L\'acompte n\'est pas remboursable.') : t('Réserve seulement si tu es sûr·e de pouvoir venir.') }}</span>
        </div>
      </section>
      <template v-else>
        <section class="section">
          <h2 class="h3">{{ t('Quel jour ?') }}</h2>
          <div class="days">
            <button v-for="d in days" :key="d" class="day" :aria-pressed="date === d" :disabled="!hasRoom(d)" :aria-label="dayLabel(d, today)" @click="date = d; time = null">
              <small>{{ d === today ? t('auj.') : dateParts(d).dow }}</small><b>{{ dateParts(d).day }}</b>
            </button>
          </div>
        </section>
        <section class="section">
          <h2 class="h3">{{ t('Quelle heure ?') }}</h2>
          <div v-for="part in parts" :key="part.label" class="col gap8">
            <span class="meta">{{ t(part.label) }}</span>
            <div class="slots">
              <button v-for="tm in part.list" :key="tm" class="slot" :aria-pressed="time === tm" @click="time = tm">{{ hm(tm) }}</button>
            </div>
          </div>
          <p v-if="!free.length" class="meta">{{ t('Plus de place ce jour-là. Essaie un autre jour.') }}</p>
        </section>
      </template>

      <div v-if="clash" ref="clashBox" class="notice clash" role="alert">
        <b>{{ t('Tu as déjà un rendez-vous à cette heure') }}</b>
        <span>{{ t('{what} chez {who}, {day} de {from} à {to}. Choisis une autre heure, ou remplace-le par celui-ci.', { what: clashService?.n ?? t('Rendez-vous'), who: clashPro?.name ?? t('un autre prestataire'), day: dayLabel(clash.date, today), from: hm(clash.time), to: hm(clash.time + clash.dur) }) }}</span>
        <button class="btn sm line" type="button" :aria-pressed="replace" @click="replace = !replace">{{ replace ? t('Je garde plutôt l\'ancien rendez-vous') : t('Remplacer l\'ancien rendez-vous') }}</button>
      </div>

      <section class="section">
        <label class="field" for="note">
          <span>{{ t('Une info pour {name} ?', { name: p.owner?.split(' ')[0] ?? p.name }) }} <span class="help">{{ t('(facultatif)') }}</span></span>
          <textarea id="note" v-model="note" class="textarea" maxlength="300" :placeholder="t('Grossesse, allergie, cheveux fragiles, accès difficile…')" />
          <span class="help">{{ t('Ce message est lu par le/la prestataire avant le rendez-vous. VLADI ne vérifie pas les informations de santé.') }}</span>
        </label>
      </section>

      <section v-if="needsPhone" class="section">
        <label class="field" for="tel">
          <span class="h3">{{ t('Ton téléphone') }}</span>
          <input id="tel" v-model="phone" class="input" type="tel" autocomplete="tel" inputmode="tel" placeholder="0690 00 00 00">
          <span class="help">{{ t('Transmis au/à la prestataire pour te joindre si besoin. Enregistré dans ton compte.') }}</span>
        </label>
      </section>

      <p v-if="!isSlot" class="tiny mt16">{{ t('Annulation gratuite jusqu\'à {h} h avant le rendez-vous.', { h: RULES.freeCancelHours }) }} {{ RULES.onlinePayment ? t('Passé ce délai, l\'acompte reste au/à la prestataire.') : t('Passé ce délai, préviens directement le/la prestataire.') }} <NuxtLink class="link" to="/cgu#annulation">{{ t('Conditions') }}</NuxtLink></p>

      <div class="cta mt24">
        <div class="sum grow"><b>{{ euro(price) }}</b><span class="tiny ellip">{{ hint }}</span></div>
        <NuxtLink v-if="needsAccount" class="btn" :to="loginLink">{{ t('Se connecter') }}</NuxtLink>
        <button v-else class="btn" :class="{ now: isSlot }" :disabled="!ready" @click="recap = true">{{ t('Continuer') }}</button>
      </div>
    </template>

    <BottomSheet v-if="recap" @close="recap = false">
      <h2 class="h2">{{ t('Récapitulatif') }}</h2>
      <div class="recap">
        <div class="kv"><span>{{ t('Prestation') }}</span><span>{{ sv.n }}</span></div>
        <div class="kv"><span>{{ t('Avec') }}</span><span>{{ p.name }}</span></div>
        <div class="kv"><span>{{ t('Où') }}</span><span>{{ place === 'client' ? `${t('Chez moi')}, ${address.trim()}` : `${t(proPlace(p) ?? '')}, ${p.commune}` }}</span></div>
        <div class="kv"><span>{{ t('Quand') }}</span><span>{{ capitalize(dayLabel(when.date, today)) }} à {{ hm(when.time) }}</span></div>
        <div class="kv"><span>{{ t('Prix') }}</span><span><span v-if="slot" class="strike">{{ euro(sv.p) }}</span> {{ euro(servicePrice) }}</span></div>
        <div v-if="place === 'client'" class="kv"><span>{{ t('Déplacement') }}</span><span>{{ fee ? euro(fee) : t('offert') }}</span></div>
        <div class="kv total"><span>{{ t('Total') }}</span><span>{{ euro(price) }}</span></div>
        <template v-if="RULES.onlinePayment">
          <div class="kv"><span>{{ t('Acompte à payer maintenant') }}</span><span>{{ euro(deposit) }}</span></div>
          <div class="kv"><span>{{ t('Reste à payer sur place') }}</span><span>{{ euro(price - deposit) }}</span></div>
        </template>
        <div v-else class="kv"><span>{{ t('Paiement') }}</span><span>{{ t('Sur place') }}</span></div>
      </div>
      <p v-if="replace && clash" class="notice">{{ t('Ton rendez-vous du {day} à {time} sera annulé et remplacé par celui-ci.', { day: dayLabel(clash.date, today), time: hm(clash.time) }) }}</p>
      <p class="notice">{{ p.real ? `Réservation au nom de ${firstName}. Le règlement se fait directement auprès de ${p.name}.` : 'Établissement de démonstration : aucune réservation n\'est transmise.' }}</p>
      <p v-if="error" class="error">{{ error }}</p>
      <button class="btn block" :disabled="busy" @click="pay">{{ busy ? 'Réservation…' : RULES.onlinePayment ? `Confirmer et payer ${euro(deposit)}` : 'Confirmer la réservation' }}</button>
      <button class="btn block line" @click="recap = false">{{ t('Modifier') }}</button>
    </BottomSheet>
  </template>
  <div v-else-if="remote.loading" class="empty" style="padding-top:96px">{{ t('Chargement…') }}</div>
  <div v-else class="empty" style="padding-top:96px">
    <b>{{ t('Cette prestation n\'existe pas') }}</b>
    <NuxtLink class="btn sm soft" to="/">{{ t('Retour à l\'accueil') }}</NuxtLink>
  </div>
</template>
