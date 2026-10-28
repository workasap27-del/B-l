<script setup lang="ts">
import { ChevronDown, House, LayoutGrid, Search } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'

// Entrée « Catégories » de la navigation : toutes les catégories dans un panneau qui s'ouvre au clic sur ordinateur
// (pas au survol : il ne s'ouvre plus en passant la souris vers une autre rubrique), dans une fenêtre sur téléphone et tablette.
const cats = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]
const open = ref(false)
const wide = ref(false)
const route = useRoute()
let mq: MediaQueryList | undefined
const sync = () => { wide.value = !!mq?.matches }
const root = ref<HTMLElement | null>(null)
// Un clic ailleurs sur la page referme le panneau.
function outside(e: Event) {
  if (open.value && wide.value && root.value && !root.value.contains(e.target as Node)) open.value = false
}
onMounted(() => {
  mq = window.matchMedia('(min-width: 1000px) and (hover: hover)')
  sync()
  mq.addEventListener('change', sync)
  document.addEventListener('pointerdown', outside)
})
onBeforeUnmount(() => {
  mq?.removeEventListener('change', sync)
  document.removeEventListener('pointerdown', outside)
})
watch(() => route.fullPath, () => { open.value = false })
const current = computed(() => (route.path === '/recherche' ? String(route.query.cat ?? '') : ''))
</script>

<template>
  <div ref="root" class="catmenu" @keydown.esc="open = false">
    <button type="button" class="nav-btn" :class="{ on: open }" :aria-expanded="open" aria-haspopup="true" @click="open = !open">
      <LayoutGrid :size="23" :stroke-width="1.8" />
      <span class="nav-label"><span class="nl-m">{{ t('Catégories') }}</span><span class="nl-pc">{{ t('Catégories') }}</span></span>
      <ChevronDown class="nav-caret" :size="16" :class="{ flip: open }" />
    </button>
    <div v-if="open && wide" class="catmenu-fly" role="menu">
      <p class="catmenu-title">{{ t('Toutes les catégories') }}</p>
      <div class="catmenu-list">
        <NuxtLink v-for="[c, label] in cats" :key="c" :to="`/recherche?cat=${c}`" role="menuitem" :class="{ on: current === c }">
          <component :is="CAT_ICON[c]" :size="18" :stroke-width="1.7" />{{ t(label) }}
        </NuxtLink>
      </div>
      <div class="catmenu-foot">
        <NuxtLink to="/recherche?lieu=client" role="menuitem"><House :size="18" :stroke-width="1.7" />{{ t('À domicile') }}</NuxtLink>
        <NuxtLink to="/recherche" role="menuitem"><Search :size="18" :stroke-width="1.7" />{{ t('Tout voir') }}</NuxtLink>
      </div>
    </div>
    <BottomSheet v-if="open && !wide" @close="open = false">
      <div class="catmenu-sheet">
        <p class="h3">{{ t('Toutes les catégories') }}</p>
        <NuxtLink v-for="[c, label] in cats" :key="c" :to="`/recherche?cat=${c}`" :class="{ on: current === c }">
          <span class="srch-ico sm"><component :is="CAT_ICON[c]" :size="18" :stroke-width="1.7" /></span>{{ t(label) }}
        </NuxtLink>
        <NuxtLink to="/recherche?lieu=client"><span class="srch-ico sm"><House :size="18" :stroke-width="1.7" /></span>{{ t('À domicile') }}</NuxtLink>
        <NuxtLink to="/recherche"><span class="srch-ico sm"><Search :size="18" :stroke-width="1.7" /></span>{{ t('Tout voir') }}</NuxtLink>
      </div>
    </BottomSheet>
  </div>
</template>
