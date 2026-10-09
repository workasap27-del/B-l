<script setup lang="ts">
import type { Pro } from '~/data/pros'

// Visuel d'un prestataire en attendant de vraies photos : teinte propre, icône du métier, initiale.
defineProps<{ pro: Pro, variant: 'thumb' | 'card' | 'hero' }>()
</script>

<template>
  <div class="cover" :class="variant" :style="{ '--h': pro.h }">
    <component :is="CAT_ICON[pro.cats[0]]" class="art" aria-hidden="true" />
    <span class="mono" aria-hidden="true">{{ pro.name.charAt(0) }}</span>
    <slot />
  </div>
</template>
