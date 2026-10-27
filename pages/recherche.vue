<script setup lang="ts">
import { ChevronDown, List, Map as MapIcon, MapPin, Search, SearchX, SlidersHorizontal, X } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category, Pro } from '~/data/pros'

const route = useRoute()
const { pros, km, ratingOf, starts, today, state } = useVladi()

const q = ref(String(route.query.q ?? ''))
const cat = ref(String(route.query.cat ?? 'all'))
const place = ref<'all' | 'client' | 'pro'>(route.query.lieu === 'client' ? 'client' : route.query.lieu === 'pro' ? 'pro' : 'all')
const kind = ref<'all' | 'salon' | 'indep'>('all')
const maxKm = ref(0)
const todayOnly = ref(false)
// Jour souhaité, passé par le formulaire de l'accueil (?date=AAAA-MM-JJ). Vide : peu importe.
const day = ref(typeof route.query.date === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(route.query.date) ? route.query.date : '')
const sort = ref<'auto' | 'dist' | 'note' | 'prix'>(route.query.tri === 'note' ? 'note' : 'auto')
const view = ref<'list' | 'map'>('list')
const shown = ref(12)
const filtersOpen = ref(false)
const locOpen = ref(false)
const selected = ref('')
const input = ref<HTMLInputElement | null>(null)

onMounted(() => { if (route.query.saisie) input.value?.focus() })
// Le menu des catégories peut changer la catégorie alors que la page est déjà ouverte.
watch(() => [route.query.cat, route.query.lieu], ([c, l]) => {
  cat.value = String(c ?? 'all')
  place.value = l === 'client' ? 'client' : l === 'pro' ? 'pro' : 'all'
  q.value = ''
})
watch([q, cat, place, kind, maxKm, todayOnly, sort, day], () => { shown.value = 12; selected.value = '' })

useHead(() => {
  const label = CATEGORIES.find(c => c[0] === cat.value && c[0] !== 'all')?.[1]
  return { title: label ? `${label} en Guadeloupe · VLADI` : 'Rechercher une prestation · VLADI' }
})

const SUGGESTIONS = ['Pose gel', 'Box braids', 'Extensions de cils', 'Dégradé', 'Massage', 'Tatouage', 'Piercing', 'Pédicure', 'Brushing', 'Maquillage mariée', 'Épilation', 'Microblading']
const minPrice = (p: Pro) => Math.min(...p.services.map(s => s.p))
const freeToday = (p: Pro) => p.services.some(s => starts(p, today.value, s.d).length > 0)
/** Tant que rien n'est cherché ni choisi, on montre d'abord les catégories. */
const browsing = computed(() => !q.value.trim() && cat.value === 'all' && place.value === 'all')

const list = computed(() => {
  const c = cat.value === 'all' ? null : cat.value as Category
  const hits = searchPros(pros.value, q.value, km).filter(({ pro: p }) => {
    // La catégorie compte les prestations proposées, pas seulement le métier affiché (un barbier qui fait les sourcils apparaît dans Cils).
    if (c && !inCategory(p, c)) return false
    if (place.value === 'client' && !goesToClient(p)) return false
    if (place.value === 'pro' && !proPlace(p)) return false
    if (kind.value === 'salon' && p.kind.startsWith('Indépendant')) return false
    if (kind.value === 'indep' && !p.kind.startsWith('Indépendant')) return false
    if (maxKm.value && km(p) > maxKm.value) return false
    if (todayOnly.value && !freeToday(p)) return false
    if (day.value && !p.services.some(s => starts(p, day.value, s.d).length > 0)) return false
    return true
  }).map((h) => {
    // Sans texte tapé, on pointe sur la carte les prestations de la catégorie choisie.
    if (!c || h.services.length) return h
    const own = servicesInCat(h.pro, c)
    return own.length ? { ...h, services: own.slice(0, 3) } : h
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
  <div class="search-field">
    <Search :size="19" />
    <input id="q" ref="input" v-model="q" type="search" enterkeyhint="search" placeholder="Prestation, prestataire, commune" aria-label="Rechercher une prestation, un prestataire ou une commune">
    <button v-if="q" class="icon-btn" style="width:32px;height:32px" aria-label="Effacer la recherche" @click="q = ''; input?.focus()"><X :size="18" /></button>
  </div>

  <template v-if="browsing">
    <section class="section mt24">
      <h2 class="h2">Catégories</h2>
      <CategoryGrid @pick="c => (c === 'domicile' ? (place = 'client') : (cat = c))" />
    </section>
    <section class="section">
      <h2 class="h2">Recherches fréquentes</h2>
      <div class="row wrap gap8">
        <button v-for="s in SUGGESTIONS" :key="s" class="chip" @click="q = s">{{ s }}</button>
      </div>
    </section>
  </template>

  <div class="chips mt16">
    <button v-if="day" class="chip" aria-pressed="true" :aria-label="`Retirer le filtre : disponible ${dayLabel(day, today)}`" @click="day = ''">Dispo {{ dayLabel(day, today) }}<X :size="14" /></button>
    <button class="chip" :class="{ has: activeFilters }" @click="filtersOpen = true"><SlidersHorizontal :size="16" />Filtres{{ activeFilters ? ` (${activeFilters})` : '' }}</button>
    <button v-for="c in CATEGORIES" :key="c[0]" class="chip" :aria-pressed="cat === c[0]" @click="cat = c[0]">{{ c[1] }}</button>
  </div>

  <div class="row between mt24" :class="{ section: browsing }">
    <div class="col gap4" style="min-width:0">
      <span class="h2">{{ browsing ? 'Près de toi' : `${list.length} résultat${list.length > 1 ? 's' : ''}` }}</span>
      <button class="place-picker" style="font-weight:500;font-size:13px" @click="locOpen = true"><MapPin :size="13" /><span>Autour de {{ state.pos.label }}</span><ChevronDown :size="13" /></button>
    </div>
    <button class="btn sm soft" @click="view = view === 'list' ? 'map' : 'list'">
      <component :is="view === 'list' ? MapIcon : List" :size="16" />{{ view === 'list' ? 'Carte' : 'Liste' }}
    </button>
  </div>

  <div v-if="!list.length" class="empty">
    <SearchX :size="32" />
    <b>Personne ne propose ça ici</b>
    <span>Essaie un autre mot, élargis la distance ou enlève un filtre.</span>
    <button v-if="activeFilters" class="btn sm soft" @click="resetFilters">Enlever les filtres</button>
  </div>

  <div v-else-if="view === 'list'" class="col mt16 results">
    <ProResult v-for="h in list.slice(0, shown)" :key="h.pro.id" :pro="h.pro" :services="h.services" />
    <button v-if="list.length > shown" class="btn block soft" @click="shown += 12">Voir plus de résultats</button>
  </div>

  <div v-else class="mapwrap mt16">
    <ProMap :items="mapItems" :selected="selected" :user="state.pos" @select="selected = $event" />
    <div v-if="selectedHit" class="mapcard">
      <ProResult :pro="selectedHit.pro" :services="selectedHit.services" />
    </div>
  </div>

  <BottomSheet v-if="filtersOpen" @close="filtersOpen = false">
    <div class="row between"><h2 class="h2">Filtres</h2><button class="textbtn" @click="resetFilters">Tout effacer</button></div>
    <div class="col gap8">
      <span class="h3">Où ?</span>
      <div class="seg">
        <button :aria-pressed="place === 'all'" @click="place = 'all'">Peu importe</button>
        <button :aria-pressed="place === 'client'" @click="place = 'client'">Chez moi</button>
        <button :aria-pressed="place === 'pro'" @click="place = 'pro'">Je me déplace</button>
      </div>
    </div>
    <div class="col gap8">
      <span class="h3">Prestataire</span>
      <div class="seg">
        <button :aria-pressed="kind === 'all'" @click="kind = 'all'">Tous</button>
        <button :aria-pressed="kind === 'salon'" @click="kind = 'salon'">Établissements</button>
        <button :aria-pressed="kind === 'indep'" @click="kind = 'indep'">Indépendant·es</button>
      </div>
    </div>
    <div class="col gap8">
      <span class="h3">Distance maximale</span>
      <div class="seg">
        <button v-for="n in [0, 5, 10, 20, 40]" :key="n" :aria-pressed="maxKm === n" @click="maxKm = n">{{ n ? `${n} km` : 'Toutes' }}</button>
      </div>
    </div>
    <div class="col gap8">
      <span class="h3">Trier par</span>
      <div class="seg">
        <button :aria-pressed="sort === 'auto'" @click="sort = 'auto'">Pertinence</button>
        <button :aria-pressed="sort === 'dist'" @click="sort = 'dist'">Distance</button>
        <button :aria-pressed="sort === 'note'" @click="sort = 'note'">Note</button>
        <button :aria-pressed="sort === 'prix'" @click="sort = 'prix'">Prix</button>
      </div>
    </div>
    <label class="switch"><span>Disponible aujourd'hui</span><input id="today-only" v-model="todayOnly" type="checkbox"></label>
    <button class="btn block" @click="filtersOpen = false">Voir {{ list.length }} résultat{{ list.length > 1 ? 's' : '' }}</button>
  </BottomSheet>
  <LocationSheet v-if="locOpen" @close="locOpen = false" />
</template>
