<script setup lang="ts">
import { ChevronLeft, Heart, House, MapPin, Navigation, Star, Store } from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()
const { pro, state, toggleFav, openSlots, reviewsOf, ratingOf, km, openStatus, today } = useVladi()
const p = computed(() => pro(String(route.params.id)))
const slots = computed(() => (p.value ? openSlots(p.value.id) : []))
const tab = ref<'prestations' | 'avis' | 'infos'>('prestations')
const tabsEl = ref<HTMLElement | null>(null)
// "Voir la carte" ouvre l'onglet Infos et l'amène à l'écran.
async function showMap() {
  tab.value = 'infos'
  await nextTick()
  tabsEl.value?.scrollIntoView({ block: 'start', behavior: 'smooth' })
}
const d = computed(() => (p.value ? km(p.value) : 0))
const status = computed(() => (p.value ? openStatus(p.value) : { open: false, text: '' }))
const todayIndex = computed(() => weekday(today.value))

// Répartition des notes, déduite de la note moyenne (les avis de démonstration sont fictifs).
const bars = computed(() => {
  const r = p.value ? ratingOf(p.value).rating : 5
  const five = Math.max(35, Math.min(94, Math.round((r - 4) * 62 + 36)))
  const rest = 100 - five
  return [[5, five], [4, Math.round(rest * 0.6)], [3, Math.round(rest * 0.25)], [2, Math.round(rest * 0.1)], [1, Math.round(rest * 0.05)]]
})
const days = [1, 2, 3, 4, 5, 6, 0]
</script>

<template>
  <template v-if="p">
    <ProCover :pro="p" variant="hero" class="bleed">
      <div class="covertop">
        <button class="iconbtn glass" aria-label="Retour" @click="router.back()"><ChevronLeft :size="22" /></button>
        <button class="iconbtn glass" aria-label="Favori" :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)">
          <Heart :size="20" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />
        </button>
      </div>
    </ProCover>

    <div class="stack" style="gap:6px">
      <h1 class="h1">{{ p.name }}</h1>
      <div class="meta">
        <span class="rate" style="color:var(--ink)"><Star :size="15" />{{ String(ratingOf(p).rating).replace('.', ',') }}</span>
        <span>({{ ratingOf(p).count }} avis)</span>
        <span class="sep">{{ p.kind }}{{ p.owner ? `, ${p.owner}` : '' }}</span>
      </div>
      <div class="meta"><span class="status" :class="{ open: status.open }">{{ status.text }}</span></div>
      <div class="metaline"><MapPin :size="15" /><span>{{ p.quartier }}, {{ p.commune }} · à {{ formatKm(d) }}, environ {{ driveMinutes(d) }} min en voiture</span></div>
    </div>

    <div class="quick">
      <a :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="20" />Itinéraire</a>
      <button @click="showMap"><MapPin :size="20" />Voir la carte</button>
      <button :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)"><Heart :size="20" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />{{ state.fav[p.id] ? 'En favori' : 'Favori' }}</button>
    </div>

    <section v-if="slots.length" class="sec">
      <h2 class="h2">Libre aujourd'hui, à prix réduit</h2>
      <SlotCard v-for="s in slots" :key="s.id" :item="s" wide hide-pro />
    </section>

    <div ref="tabsEl" class="tabs">
      <button :aria-pressed="tab === 'prestations'" @click="tab = 'prestations'">Prestations</button>
      <button :aria-pressed="tab === 'avis'" @click="tab = 'avis'">Avis</button>
      <button :aria-pressed="tab === 'infos'" @click="tab = 'infos'">Infos</button>
    </div>

    <div v-if="tab === 'prestations'">
      <div v-for="s in p.services" :key="s.id" class="svc">
        <div class="grow">
          <div class="h3">{{ s.n }}</div>
          <div class="sub">{{ s.d }} min</div>
        </div>
        <span class="price">{{ euro(s.p) }}</span>
        <NuxtLink class="btn small soft" :to="`/reserver/${p.id}/${s.id}`">Choisir</NuxtLink>
      </div>
    </div>

    <div v-else-if="tab === 'avis'" class="stack">
      <div class="row" style="gap:18px">
        <div style="text-align:center">
          <div class="bigrate">{{ String(ratingOf(p).rating).replace('.', ',') }}</div>
          <div class="tiny">{{ ratingOf(p).count }} avis</div>
        </div>
        <div class="bars">
          <template v-for="b in bars" :key="b[0]"><span>{{ b[0] }}</span><i><b :style="{ width: b[1] + '%' }" /></i></template>
        </div>
      </div>
      <div>
        <div v-for="(r, i) in reviewsOf(p)" :key="i" class="rev">
          <div class="row between"><b>{{ r.a }}</b><span class="stars5"><Star v-for="n in r.s" :key="n" :size="13" /></span></div>
          <span>{{ r.t }}</span>
        </div>
      </div>
    </div>

    <div v-else class="stack" style="gap:16px">
      <p>{{ p.about }}</p>
      <div class="tags"><span v-for="t in p.tags" :key="t" class="badge">{{ t }}</span></div>
      <div class="panel">
        <div class="h3">Où ça se passe</div>
        <div v-if="proPlace(p)" class="row"><Store :size="18" /><span class="grow">{{ proPlace(p) }}, {{ p.quartier }}</span></div>
        <div v-if="goesToClient(p)" class="row"><House :size="18" /><span class="grow">Chez toi, {{ travelFee(p) ? `+ ${euro(travelFee(p))} de déplacement` : 'déplacement offert' }}</span></div>
      </div>
      <ProMap :items="[{ id: p.id, lat: p.lat, lng: p.lng }]" :user="state.pos" mini />
      <div class="row between">
        <span class="sub">{{ formatKm(d) }} depuis {{ state.pos.gps ? 'ta position' : state.pos.label }}, environ {{ driveMinutes(d) }} min en voiture</span>
        <a class="btn small line" :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="15" />Y aller</a>
      </div>
      <div class="panel">
        <div class="h3">Horaires</div>
        <div class="hours">
          <template v-for="n in days" :key="n">
            <span :class="{ today: n === todayIndex }">{{ WEEK[n] }}</span>
            <span :class="{ today: n === todayIndex }">{{ p.closed.includes(n) ? 'Fermé' : `${hm(p.open)} à ${hm(p.close)}` }}</span>
          </template>
        </div>
      </div>
      <p class="tiny">Prestataire fictif, créé pour la démonstration. Position et distance approximatives.</p>
    </div>
  </template>
  <div v-else class="empty" style="padding-top:80px">
    <p><b>Ce prestataire n'existe pas.</b></p>
    <NuxtLink class="btn small soft" to="/">Retour à l'accueil</NuxtLink>
  </div>
</template>
