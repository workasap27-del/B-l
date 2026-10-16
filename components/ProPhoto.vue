<script setup lang="ts">
import type { Pro } from '~/data/pros'

// Photo d'un prestataire : la sienne s'il en a une, sinon une photo de son métier.
const props = withDefaults(defineProps<{ pro: Pro, w?: number, h?: number, ratio?: '43' | '169' | 'none', demoLabel?: boolean }>(), { w: 480, h: 360, ratio: '43', demoLabel: true })
const img = computed(() => photoSrc(props.pro, props.w, props.h))
// Si la photo ne charge pas (hors ligne), on garde un fond neutre plutôt qu'une image cassée.
const failed = ref(false)
watch(img, () => { failed.value = false })
</script>

<template>
  <div class="photo" :class="ratio !== 'none' ? `ratio-${ratio}` : ''">
    <img :src="img.src" :srcset="img.srcset || undefined" :alt="`Photo illustrant ${pro.name}`" loading="lazy" decoding="async" :style="failed ? 'visibility:hidden' : undefined" @error="failed = true">
    <div class="over"><slot /></div>
    <span v-if="demoLabel && !pro.real" class="demo">Démo</span>
  </div>
</template>
