<script setup lang="ts">
import { ChevronDown, List, Map as MapIcon, MapPin, Search, SearchX, SlidersHorizontal, X } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Pro } from '~/data/pros'

const route = useRoute()
const { pros, km, ratingOf, starts, today, state } = useVladi()

const q = ref(String(route.query.q ?? ''))
const cat = ref(String(route.query.cat ?? 'all'))
const place = ref<'all' | 'client' | 'pro'>(route.query.lieu === 'client' ? 'client' : route.query.lieu === 'pro' ? 'pro' : 'all')
const kind = ref<'all' | 'salon' | 'indep'>('all')
const maxKm = ref(0)
const todayOnly = ref(false)
const sort = ref<'auto' | 'dist' | 'note' | 'prix'>(route.query.tri === 'note' ? 'note' : 'auto')
const view = ref<'list' | 'map'>('list')
const shown = ref(20)
const filtersOpen = ref(false)
const locOpen = ref(false)
const selected = ref('')
const input = ref<HTMLInputElement | null>(null)

onMounted(() => { if (route.query.saisie) input.value?.focus() })
watch([q, cat, place, kind, maxKm, todayOnly, sort], () => { shown.value = 20; selected.value = '' })

const SUGGESTIONS = ['Pose gel', 'Box braids', 'Extensions de cils', 'Dégradé', 'Massage', 'Brushing', 'Maquillage mariée', 'Épilation']
const minPrice = (p: Pro) => Math.min(...p.services.map(s => s.p))
const freeToday = (p: Pro) => p.services.some(s => starts(p, today.value, s.d).length > 0)

const list = computed(() => {
  const hits = searchPros(pros, q.value, km).filter(({ pro: p }) => {
    if (cat.value !== 'all' && !p.cats.includes(cat.value as never)) return false
    if (place.value === 'client' && !goesToClient(p)) return false
    if (place.value === 'pro' && !proPlace(p)) return false
    if (kind.value === 'salon' && p.kind.startsWith('Indépendant')) return false
    if (kind.value === 'indep' && !p.kind.startsWith('Indépendant')) return false
    if (maxKm.value && km(p) > maxKm.value) return false
    if (todayOnly.value && !freeToday(p)) return false
    return true
  })
  if (sort.value === 'dist') hits.sort((a, b) => km(a.pro) - km(b.pro))
  if (sort.value === 'note') hits.sort((a, b) => ratingOf(b.pro).rating - ratingOf(a.pro).rating || km(a.pro) - km(b.pro))
  if (sort.value === 'prix') hits.sort((a, b) => minPrice(a.pro) - minPrice(b.pro))
  return hits
})
const activeFilters = computed(() => [place.value !== 'all', kind.value !== 'all', maxKm.value > 0, todayOnly.value, sort.value !== 'auto'].filter(Boolean).length)
const mapItems = computed(() => list.value.slice(0, 80).map(h => ({ id: h.pro.id, lat: h.pro.lat, lng: h.pro.lng, label: `${minPrice(h.pro)} €` })))
const selectedHit = computed(() => list.value.find(h => h.pro.id === selected.value))

function resetFilters() {
  place.value = 'all'
  kind.value = 'all'
  maxKm.value = 0
  todayOnly.value = false
  sort.value = 'auto'
}
</script>

<template>
  <div class="searchbar">
    <Search :size="18" />
    <input id="q" ref="input" v-model="q" type="search" enterkeyhint="search" placeholder="Prestation, prestataire, commune" aria-label="Rechercher une prestation, un prestataire ou une commune">
    <button v-if="q" class="iconbtn" aria-label="Effacer la recherche" @click="q = ''; input?.focus()"><X :size="18" /></button>
  </div>

  <div class="chips">
    <button class="chip" :class="{ on: activeFilters }" @click="filtersOpen = true"><SlidersHorizontal :size="15" />Filtres{{ activeFilters ? ` · ${activeFilters}` : '' }}</button>
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>

  <div v-if="!q" class="chips" aria-label="Recherches fréquentes">
    <button v-for="s in SUGGESTIONS" :key="s" class="chip" style="background:var(--surface2);border-color:transparent" @click="q = s">{{ s }}</button>
  </div>

  <div class="row between">
    <div style="min-width:0">
      <div class="h3">{{ list.length }} prestataire{{ list.length > 1 ? 's' : '' }}</div>
      <button class="loc sub" style="font-weight:600" @click="locOpen = true"><MapPin :size="13" /><span class="where">autour de {{ state.pos.label }}</span><ChevronDown :size="13" /></button>
    </div>
    <button class="btn small line" @click="view = view === 'list' ? 'map' : 'list'">
      <component :is="view === 'list' ? MapIcon : List" :size="16" />{{ view === 'list' ? 'Carte' : 'Liste' }}
    </button>
  </div>

  <div v-if="!list.length" class="empty">
    <SearchX :size="34" />
    <p><b>Personne ne propose ça ici.</b><br>Essaie un autre mot, élargis la distance ou enlève un filtre.</p>
    <button v-if="activeFilters" class="btn small soft" @click="resetFilters">Enlever les filtres</button>
  </div>

  <div v-else-if="view === 'list'" class="stack" style="gap:16px">
    <ProResult v-for="h in list.slice(0, shown)" :key="h.pro.id" :pro="h.pro" :services="h.services" />
    <button v-if="list.length > shown" class="btn block line" @click="shown += 20">Afficher plus ({{ list.length - shown }} autres)</button>
  </div>

  <div v-else class="mapwrap">
    <ProMap :items="mapItems" :selected="selected" :user="state.pos" @select="selected = $event" />
    <div v-if="selectedHit" class="mapcard">
      <ProResult :pro="selectedHit.pro" :services="selectedHit.services" />
    </div>
    <p v-else-if="list.length > 80" class="mapcard tiny" style="text-align:center">Les 80 plus pertinents sont affichés. Affine la recherche pour voir les autres.</p>
  </div>

  <BottomSheet v-if="filtersOpen" @close="filtersOpen = false">
    <div class="row between"><h2 class="h2">Filtres</h2><button class="link" @click="resetFilters">Tout effacer</button></div>
    <div class="sec">
      <div class="h3">Où ?</div>
      <div class="seg">
        <button :aria-pressed="place === 'all'" @click="place = 'all'">Peu importe</button>
        <button :aria-pressed="place === 'client'" @click="place = 'client'">Chez moi</button>
        <button :aria-pressed="place === 'pro'" @click="place = 'pro'">Je me déplace</button>
      </div>
    </div>
    <div class="sec">
      <div class="h3">Type de prestataire</div>
      <div class="seg">
        <button :aria-pressed="kind === 'all'" @click="kind = 'all'">Tous</button>
        <button :aria-pressed="kind === 'salon'" @click="kind = 'salon'">Salons, instituts</button>
        <button :aria-pressed="kind === 'indep'" @click="kind = 'indep'">Indépendants</button>
      </div>
    </div>
    <div class="sec">
      <div class="h3">Distance maximale</div>
      <div class="seg">
        <button v-for="n in [0, 5, 10, 20, 40]" :key="n" :aria-pressed="maxKm === n" @click="maxKm = n">{{ n ? `${n} km` : 'Toutes' }}</button>
      </div>
    </div>
    <div class="sec">
      <div class="h3">Trier par</div>
      <div class="seg">
        <button :aria-pressed="sort === 'auto'" @click="sort = 'auto'">Pertinence</button>
        <button :aria-pressed="sort === 'dist'" @click="sort = 'dist'">Distance</button>
        <button :aria-pressed="sort === 'note'" @click="sort = 'note'">Note</button>
        <button :aria-pressed="sort === 'prix'" @click="sort = 'prix'">Prix</button>
      </div>
    </div>
    <button class="chip" style="align-self:flex-start" :aria-pressed="todayOnly" @click="todayOnly = !todayOnly">Disponible aujourd'hui</button>
    <button class="btn block" @click="filtersOpen = false">Voir {{ list.length }} résultat{{ list.length > 1 ? 's' : '' }}</button>
  </BottomSheet>
  <LocationSheet v-if="locOpen" @close="locOpen = false" />
</template>
