<script setup lang="ts">
import { ChevronRight, MapPin, Search, X } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'
import { suggestedServices } from '~/data/generate'
import type { SoinSuggestion } from '~/utils/suggest'
import { suggestCats, suggestSoins } from '~/utils/suggest'

// Recherche plein écran : types de soin et recherches courantes d'abord, puis suggestions au fil de la saisie.
const emit = defineEmits<{ close: [], place: [] }>()
const router = useRouter()
const { pros, km, state } = useVladi()

const q = ref('')
const input = ref<HTMLInputElement | null>(null)
onMounted(() => nextTick(() => input.value?.focus()))

const LABELS = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]
const POPULAR: SoinSuggestion[] = [
  { name: 'Pose gel', cat: 'ongles' }, { name: 'Extension de cils', cat: 'cils' }, { name: 'Box braids', cat: 'tresses' },
  { name: 'Dégradé', cat: 'barbier' }, { name: 'Massage relaxant', cat: 'massage' }, { name: 'Soin du visage', cat: 'soins' },
  { name: 'Tatouage', cat: 'tatouage' }, { name: 'Day use', cat: 'hotel' },
]
// Tous les soins connus : ceux des fiches publiées et les prestations courantes de chaque métier.
const soins = computed<SoinSuggestion[]>(() => [
  ...pros.value.flatMap(p => p.services.map(s => ({ name: s.n, cat: p.cats[0] }))),
  ...LABELS.flatMap(([c]) => suggestedServices(c).map(s => ({ name: s.n, cat: c }))),
])
const typed = computed(() => q.value.trim())
const cats = computed(() => suggestCats(typed.value, LABELS))
const soinHits = computed(() => suggestSoins(typed.value, soins.value, 7))
const proHits = computed(() => (typed.value ? searchPros(pros.value, typed.value, km).filter(h => h.score > 0).slice(0, 4) : []))

function go(path: string) {
  emit('close')
  router.push(path)
}
const searchFor = (text: string) => go(`/recherche?q=${encodeURIComponent(text)}`)
function submit() {
  if (typed.value) searchFor(typed.value)
}
function onKey(e: KeyboardEvent) {
  if (e.key === 'Escape') emit('close')
}
onMounted(() => window.addEventListener('keydown', onKey))
onBeforeUnmount(() => window.removeEventListener('keydown', onKey))
</script>

<template>
  <Teleport to="body">
    <div class="srch-backdrop" @click.self="emit('close')">
      <div class="srch" role="dialog" aria-modal="true" aria-label="Rechercher">
        <form class="srch-top" @submit.prevent="submit">
          <label class="search-field srch-field" for="srch-input">
            <Search :size="19" />
            <input id="srch-input" ref="input" v-model="q" type="search" enterkeyhint="search" autocomplete="off" placeholder="Soin, établissement ou catégorie">
            <button v-if="q" type="button" class="icon-btn" aria-label="Effacer" @click="q = ''; input?.focus()"><X :size="17" /></button>
          </label>
          <button type="button" class="textbtn" @click="emit('close')">Annuler</button>
        </form>

        <div class="srch-body">
          <button type="button" class="srch-place" @click="emit('place')">
            <MapPin :size="16" /><span class="grow ellip">Autour de {{ state.pos.label }}</span><span class="link">Changer</span>
          </button>

          <template v-if="!typed">
            <section class="col gap12">
              <span class="srch-label">Type de soin</span>
              <div class="srch-chips">
                <button v-for="[c] in LABELS" :key="c" type="button" class="chip" @click="go(`/recherche?cat=${c}`)">{{ CAT_SHORT[c] }}</button>
                <button type="button" class="chip" @click="go('/recherche?lieu=client')">À domicile</button>
              </div>
            </section>
            <section class="col">
              <span class="srch-label">Recherches fréquentes</span>
              <button v-for="s in POPULAR" :key="s.name" type="button" class="srch-row" @click="searchFor(s.name)">
                <span class="srch-ico"><component :is="CAT_ICON[s.cat]" :size="18" :stroke-width="1.7" /></span>
                <span class="grow">{{ s.name }}</span>
              </button>
            </section>
          </template>

          <template v-else>
            <section v-if="cats.length" class="col gap12">
              <span class="srch-label">Catégories</span>
              <div class="srch-chips">
                <button v-for="c in cats" :key="c" type="button" class="chip" @click="go(`/recherche?cat=${c}`)">{{ CAT_SHORT[c] }}</button>
              </div>
            </section>
            <section v-if="soinHits.length" class="col">
              <span class="srch-label">Soins</span>
              <button v-for="s in soinHits" :key="s.name" type="button" class="srch-row" @click="searchFor(s.name)">
                <span class="srch-ico"><component :is="CAT_ICON[s.cat]" :size="18" :stroke-width="1.7" /></span>
                <span class="grow">{{ s.name }}</span>
              </button>
            </section>
            <section v-if="proHits.length" class="col">
              <span class="srch-label">Établissements</span>
              <button v-for="h in proHits" :key="h.pro.id" type="button" class="srch-row" @click="go(`/pro/${h.pro.id}`)">
                <ProPhoto class="srch-thumb" :pro="h.pro" :w="80" :h="80" ratio="none" :demo-label="false" />
                <span class="grow col" style="min-width:0"><span class="ellip">{{ h.pro.name }}</span><span class="meta ellip">{{ kindLabel(h.pro.kind) }} · {{ h.pro.commune }}</span></span>
              </button>
            </section>
            <button type="button" class="srch-row srch-all" @click="submit">
              <span class="srch-ico"><Search :size="18" /></span>
              <span class="grow">Voir tous les résultats pour « {{ typed }} »</span>
              <ChevronRight :size="18" class="muted" />
            </button>
          </template>
        </div>
      </div>
    </div>
  </Teleport>
</template>
