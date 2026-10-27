<script setup lang="ts">
import { House } from 'lucide-vue-next'
import { CATEGORIES } from '~/data/pros'
import type { Category } from '~/data/pros'

// Grille des catégories : 7 en vedette plus « Voir plus » (2 lignes de 4), puis toutes les catégories et « À domicile ».
const props = withDefaults(defineProps<{ link?: boolean }>(), { link: false })
const emit = defineEmits<{ pick: [cat: Category | 'domicile'] }>()
const cats = CATEGORIES.filter(c => c[0] !== 'all') as [Category, string][]
const open = ref(false)
const shown = computed(() => (open.value ? cats : cats.slice(0, 7)))
</script>

<template>
  <div class="cat-grid">
    <component :is="props.link ? resolveComponent('NuxtLink') : 'button'" v-for="c in shown" :key="c[0]" class="cat" v-bind="props.link ? { to: `/recherche?cat=${c[0]}` } : { type: 'button' }" @click="!props.link && emit('pick', c[0])">
      <span class="ico"><component :is="CAT_ICON[c[0]]" :size="25" :stroke-width="1.6" /></span>{{ t(CAT_SHORT[c[0]]) }}
    </component>
    <component :is="props.link ? resolveComponent('NuxtLink') : 'button'" v-if="open" class="cat" v-bind="props.link ? { to: '/recherche?lieu=client' } : { type: 'button' }" @click="!props.link && emit('pick', 'domicile')">
      <span class="ico"><House :size="25" :stroke-width="1.6" /></span>{{ t('À domicile') }}
    </component>
    <button class="cat more" type="button" :aria-expanded="open" @click="open = !open">
      <span class="ico"><span class="dots">{{ open ? '−' : '+' }}</span></span>{{ open ? t('Moins') : t('Voir plus') }}
    </button>
  </div>
</template>
