<script setup lang="ts">
import { House, LayoutGrid, Search } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'

// Entrée « Catégories » de la navigation : toutes les catégories au survol sur ordinateur (menu latéral),
// dans une fenêtre sur téléphone et tablette.
const cats = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]
const open = ref(false)
const wide = ref(false)
const route = useRoute()
let mq: MediaQueryList | undefined
const sync = () => { wide.value = !!mq?.matches }
onMounted(() => {
  mq = window.matchMedia('(min-width: 1000px) and (hover: hover)')
  sync()
  mq.addEventListener('change', sync)
})
onBeforeUnmount(() => mq?.removeEventListener('change', sync))
watch(() => route.fullPath, () => { open.value = false })

let timer: ReturnType<typeof setTimeout> | undefined
function hover(on: boolean) {
  if (!wide.value) return
  clearTimeout(timer)
  timer = setTimeout(() => { open.value = on }, on ? 60 : 180)
}
const current = computed(() => (route.path === '/recherche' ? String(route.query.cat ?? '') : ''))
</script>

<template>
  <div class="catmenu" @mouseenter="hover(true)" @mouseleave="hover(false)" @keydown.esc="open = false">
    <button type="button" class="nav-btn" :class="{ on: open }" :aria-expanded="open" aria-haspopup="true" @click="open = !open">
      <LayoutGrid :size="23" :stroke-width="1.8" />
      <span class="nav-label"><span class="nl-m">{{ t('Catégories') }}</span><span class="nl-pc">{{ t('Catégories') }}</span></span>
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
