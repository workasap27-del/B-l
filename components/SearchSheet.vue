<script setup lang="ts">
import { ChevronRight, History, House, Search, X } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'
import { suggestedServices } from '~/data/generate'
import type { SearchPick, SoinSuggestion } from '~/utils/suggest'
import { suggestCats, suggestSoins } from '~/utils/suggest'

// Recherche plein écran : catégories et recherches fréquentes d'abord, puis suggestions groupées pendant la saisie.
// Choisir une catégorie ou un soin remplit le formulaire de l'accueil ; un établissement ouvre sa fiche.
const props = withDefaults(defineProps<{ initial?: string }>(), { initial: '' })
const emit = defineEmits<{ close: [], pick: [value: SearchPick], all: [q: string] }>()
const router = useRouter()
const { pros, km } = useVladi()

const q = ref(props.initial)
const input = ref<HTMLInputElement | null>(null)
onMounted(() => nextTick(() => input.value?.focus()))

const LABELS = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]
const POPULAR: SoinSuggestion[] = [
  { name: 'Pose gel', cat: 'ongles' }, { name: 'Extension de cils', cat: 'cils' }, { name: 'Box braids', cat: 'coiffure' },
  { name: 'Dégradé', cat: 'barbier' }, { name: 'Massage relaxant', cat: 'massage' }, { name: 'Soin du visage', cat: 'visage' },
  { name: 'Épilation jambes', cat: 'epilation' }, { name: 'Maquillage mariée', cat: 'evenements' },
]
// Tous les soins connus : ceux des fiches visibles et les prestations courantes de chaque métier.
const soins = computed<SoinSuggestion[]>(() => [
  ...pros.value.flatMap(p => p.services.map(s => ({ name: s.n, cat: p.cats[0] }))),
  ...LABELS.flatMap(([c]) => suggestedServices(c).map(s => ({ name: s.n, cat: c }))),
])
const typed = computed(() => q.value.trim())
const cats = computed(() => suggestCats(typed.value, LABELS))
const soinHits = computed(() => suggestSoins(typed.value, soins.value, 6))
const proHits = computed(() => (typed.value ? searchPros(pros.value, typed.value, km).filter(h => h.score > 0).slice(0, 4) : []))

const pickCat = (c: Category | 'domicile') => emit('pick', { label: c === 'domicile' ? 'À domicile' : CAT_SHORT[c], cat: c })
const pickSoin = (name: string) => emit('pick', { label: name, q: name })
function openPro(id: string) {
  emit('close')
  router.push(`/pro/${id}`)
}
function submit() {
  if (typed.value) emit('all', typed.value)
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
      <div class="srch" role="dialog" aria-modal="true" aria-label="Rechercher une prestation">
        <form class="srch-top" @submit.prevent="submit">
          <label class="search-field srch-field" for="srch-input">
            <Search :size="19" />
            <input id="srch-input" ref="input" v-model="q" type="search" enterkeyhint="search" autocomplete="off" placeholder="Soin ou établissement">
            <button v-if="q" type="button" class="icon-btn" aria-label="Effacer" @click="q = ''; input?.focus()"><X :size="17" /></button>
          </label>
          <button type="button" class="textbtn" @click="emit('close')">Annuler</button>
        </form>

        <div class="srch-body">
          <template v-if="!typed">
            <section class="col">
              <span class="srch-label">Catégories</span>
              <div class="srch-cats">
                <button v-for="[c] in LABELS" :key="c" type="button" class="srch-cat" @click="pickCat(c)">
                  <span class="srch-ico"><component :is="CAT_ICON[c]" :size="20" :stroke-width="1.7" /></span>{{ CAT_SHORT[c] }}
                </button>
                <button type="button" class="srch-cat" @click="pickCat('domicile')">
                  <span class="srch-ico"><House :size="20" :stroke-width="1.7" /></span>À domicile
                </button>
              </div>
            </section>
            <section class="col">
              <span class="srch-label">Recherches fréquentes</span>
              <button v-for="s in POPULAR" :key="s.name" type="button" class="srch-row" @click="pickSoin(s.name)">
                <span class="srch-ico sm"><History :size="17" /></span>
                <span class="grow">{{ s.name }}</span>
              </button>
            </section>
          </template>

          <template v-else>
            <section v-if="cats.length" class="col">
              <span class="srch-label">Catégories</span>
              <button v-for="c in cats" :key="c" type="button" class="srch-row" @click="pickCat(c)">
                <span class="srch-ico sm"><component :is="CAT_ICON[c]" :size="18" :stroke-width="1.7" /></span>
                <span class="grow">{{ CAT_SHORT[c] }}</span>
              </button>
            </section>
            <section v-if="soinHits.length" class="col">
              <span class="srch-label">Prestations</span>
              <button v-for="s in soinHits" :key="s.name" type="button" class="srch-row" @click="pickSoin(s.name)">
                <span class="srch-ico sm"><component :is="CAT_ICON[s.cat]" :size="18" :stroke-width="1.7" /></span>
                <span class="grow">{{ s.name }}</span>
              </button>
            </section>
            <section v-if="proHits.length" class="col">
              <span class="srch-label">Établissements</span>
              <button v-for="h in proHits" :key="h.pro.id" type="button" class="srch-row" @click="openPro(h.pro.id)">
                <ProPhoto class="srch-thumb" :pro="h.pro" :w="88" :h="88" ratio="none" :demo-label="false" />
                <span class="grow col" style="min-width:0"><span class="ellip">{{ h.pro.name }}</span><span class="meta ellip">{{ kindLabel(h.pro.kind) }} · {{ h.pro.commune }}</span></span>
              </button>
            </section>
            <p v-if="!cats.length && !soinHits.length && !proHits.length" class="meta srch-none">Aucune suggestion. Lance la recherche pour voir tous les résultats.</p>
            <button type="button" class="srch-row srch-all" @click="submit">
              <span class="srch-ico sm"><Search :size="17" /></span>
              <span class="grow ellip">Voir tous les résultats pour « {{ typed }} »</span>
              <ChevronRight :size="18" class="muted" />
            </button>
          </template>
        </div>
      </div>
    </div>
  </Teleport>
</template>
