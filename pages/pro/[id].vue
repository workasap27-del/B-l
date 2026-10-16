<script setup lang="ts">
import { ChevronLeft, Clock, Heart, House, MapPin, Navigation, Pencil, Phone, Star, Store } from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()
const { pro, state, remote, toggleFav, openSlots, reviewsOf, ratingOf, km, openStatus, today, isMine, loadReviewsFor } = useVladi()
const p = computed(() => pro(String(route.params.id)))
const slots = computed(() => (p.value ? openSlots(p.value.id) : []))
const tab = ref<'prestations' | 'avis' | 'infos'>('prestations')
const tabsEl = ref<HTMLElement | null>(null)
const d = computed(() => (p.value ? km(p.value) : 0))
const status = computed(() => (p.value ? openStatus(p.value) : { open: false, text: '' }))
const r = computed(() => (p.value ? ratingOf(p.value) : { rating: 0, count: 0 }))
const hero = computed(() => (p.value ? photoSrc(p.value, 800, 600) : { src: '', srcset: '' }))
const todayIndex = computed(() => weekday(today.value))
const days = [1, 2, 3, 4, 5, 6, 0]
watch(p, (v) => { if (v) void loadReviewsFor(v) }, { immediate: true })

async function show(t: 'prestations' | 'avis' | 'infos') {
  tab.value = t
  await nextTick()
  tabsEl.value?.scrollIntoView({ block: 'start', behavior: 'smooth' })
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
// Répartition des notes des fiches d'exemple, déduite de la moyenne.
const bars = computed(() => {
  const five = Math.max(35, Math.min(94, Math.round((r.value.rating - 4) * 62 + 36)))
  const rest = 100 - five
  return [[5, five], [4, Math.round(rest * 0.6)], [3, Math.round(rest * 0.25)], [2, Math.round(rest * 0.1)], [1, Math.round(rest * 0.05)]]
})
</script>

<template>
  <template v-if="p">
    <div class="hero bleed">
      <img :src="hero.src" :srcset="hero.srcset || undefined" :alt="`Photo illustrant ${p.name}`" onerror="this.style.visibility='hidden'">
      <div class="bar">
        <button class="icon-btn float" aria-label="Retour" @click="back"><ChevronLeft :size="22" /></button>
        <button class="icon-btn float" aria-label="Ajouter aux favoris" :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)">
          <Heart :size="19" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />
        </button>
      </div>
    </div>

    <div class="sheet-top">
      <div class="tags">
        <span v-if="isMine(p)" class="tag accent">Votre entreprise</span>
        <span v-if="!p.real" class="tag">Fiche d'exemple</span>
      </div>
      <h1 class="title">{{ p.name }}</h1>
      <div class="row wrap" style="gap:6px">
        <span v-if="r.count" class="rate"><Star :size="14" />{{ fr(r.rating) }} <span class="n">({{ r.count }} avis)</span></span>
        <span v-else class="tag">Nouveau sur VLADI</span>
        <span class="meta">· {{ p.kind }}{{ p.owner ? `, ${p.owner}` : '' }}</span>
      </div>
      <span class="status" :class="{ open: status.open }"><Clock :size="14" />{{ status.text }}</span>
      <span class="meta">{{ p.quartier ? `${p.quartier}, ` : '' }}{{ p.commune }} · {{ formatKm(d) }}, environ {{ driveMinutes(d) }} min en voiture</span>
    </div>

    <div class="actions mt16">
      <a :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="20" />Itinéraire</a>
      <a v-if="p.phone" :href="`tel:${p.phone.replace(/\s/g, '')}`"><Phone :size="20" />Appeler</a>
      <button v-else @click="show('infos')"><MapPin :size="20" />Carte</button>
      <NuxtLink v-if="isMine(p)" to="/espace-pro/fiche"><Pencil :size="20" />Modifier</NuxtLink>
      <button v-else :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)"><Heart :size="20" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />{{ state.fav[p.id] ? 'Enregistré' : 'Enregistrer' }}</button>
    </div>

    <section v-if="slots.length" class="section">
      <h2 class="h2">Libre aujourd'hui, prix réduit</h2>
      <div class="col gap8"><SlotCard v-for="s in slots" :key="s.id" :item="s" hide-pro /></div>
    </section>

    <div ref="tabsEl" class="tabs mt24">
      <button :aria-pressed="tab === 'prestations'" @click="tab = 'prestations'">Prestations</button>
      <button :aria-pressed="tab === 'avis'" @click="tab = 'avis'">Avis</button>
      <button :aria-pressed="tab === 'infos'" @click="tab = 'infos'">Infos</button>
    </div>

    <div v-if="tab === 'prestations'">
      <div v-for="s in p.services" :key="s.id" class="svc">
        <div class="grow col gap4">
          <span class="name">{{ s.n }}</span>
          <span class="meta">{{ duration(s.d) }} · {{ euro(s.p) }}</span>
        </div>
        <NuxtLink v-if="!isMine(p)" class="btn sm" :to="`/reserver/${p.id}/${s.id}`">Réserver</NuxtLink>
      </div>
    </div>

    <div v-else-if="tab === 'avis'" class="col">
      <div v-if="r.count" class="row gap24 mt16">
        <div class="col" style="align-items:center;gap:6px">
          <span class="bigrate">{{ fr(r.rating) }}</span>
          <span class="tiny">{{ r.count }} avis</span>
        </div>
        <div v-if="!p.real" class="bars">
          <template v-for="b in bars" :key="b[0]"><span>{{ b[0] }}</span><i><b :style="{ width: b[1] + '%' }" /></i></template>
        </div>
      </div>
      <div v-for="(rv, i) in reviewsOf(p)" :key="i" class="review">
        <div class="row between"><span class="name">{{ rv.a }}</span><span class="stars5"><Star v-for="n in rv.s" :key="n" :size="12" /></span></div>
        <span>{{ rv.t }}</span>
      </div>
      <p v-if="!reviewsOf(p).length" class="empty">Pas encore d'avis. Les clientes peuvent en laisser un après leur rendez-vous.</p>
    </div>

    <div v-else class="col gap24 mt16">
      <p v-if="p.about">{{ p.about }}</p>
      <div class="infobox">
        <span class="h3">Où ça se passe</span>
        <div v-if="proPlace(p)" class="row"><Store :size="18" /><span class="grow">{{ proPlace(p) }}{{ p.quartier ? `, ${p.quartier}` : '' }}, {{ p.commune }}</span></div>
        <div v-if="goesToClient(p)" class="row"><House :size="18" /><span class="grow">À domicile, {{ travelFee(p) ? `+ ${euro(travelFee(p))} de déplacement` : 'déplacement offert' }}</span></div>
      </div>
      <ProMap :items="[{ id: p.id, lat: p.lat, lng: p.lng }]" :user="state.pos" mini />
      <div class="col gap12">
        <span class="h3">Horaires</span>
        <div class="hours">
          <template v-for="n in days" :key="n">
            <span :class="{ today: n === todayIndex }">{{ WEEK[n] }}</span>
            <span :class="{ today: n === todayIndex }">{{ p.closed.includes(n) ? 'Fermé' : `${hm(p.open)} à ${hm(p.close)}` }}</span>
          </template>
        </div>
      </div>
      <p v-if="!p.real" class="tiny">Prestataire fictif, créé pour tester l'appli. Photo d'illustration (Pexels), position approximative.</p>
      <p v-else-if="p.siren" class="tiny">Professionnel déclaré, SIREN {{ p.siren.replace(/(\d{3})(\d{3})(\d{3})/, '$1 $2 $3') }}.</p>
    </div>
  </template>
  <div v-else-if="remote.loading" class="empty" style="padding-top:96px">Chargement…</div>
  <div v-else class="empty" style="padding-top:96px">
    <b>Ce prestataire n'existe pas</b>
    <NuxtLink class="btn sm soft" to="/">Retour à l'accueil</NuxtLink>
  </div>
</template>
