<script setup lang="ts">
import { ChevronLeft, ChevronRight, X } from 'lucide-vue-next'

// Galerie de réalisations : vignettes qui défilent, et une photo en grand au toucher.
const props = defineProps<{ photos: { id: string, url: string, thumb: string }[], name: string }>()
const open = ref<number | null>(null)
const move = (d: number) => { if (open.value !== null) open.value = (open.value + d + props.photos.length) % props.photos.length }
function key(e: KeyboardEvent) {
  if (open.value === null) return
  if (e.key === 'Escape') open.value = null
  if (e.key === 'ArrowRight') move(1)
  if (e.key === 'ArrowLeft') move(-1)
}
onMounted(() => window.addEventListener('keydown', key))
onBeforeUnmount(() => window.removeEventListener('keydown', key))
</script>

<template>
  <div class="gallery" role="list" :aria-label="`Réalisations de ${name}`">
    <button v-for="(ph, i) in photos" :key="ph.id" type="button" role="listitem" class="gal-thumb" :aria-label="`Voir la photo ${i + 1} sur ${photos.length}`" @click="open = i">
      <img :src="ph.thumb" alt="" loading="lazy" onerror="this.parentElement.style.display='none'">
    </button>
  </div>
  <Teleport to="#sheets">
    <div v-if="open !== null" class="lightbox" role="dialog" aria-modal="true" :aria-label="`Photo ${open + 1} sur ${photos.length}`" @click.self="open = null">
      <button class="icon-btn lb-close" type="button" :aria-label="t('Fermer')" @click="open = null"><X :size="22" /></button>
      <button v-if="photos.length > 1" class="icon-btn lb-prev" type="button" :aria-label="t('Photo précédente')" @click="move(-1)"><ChevronLeft :size="24" /></button>
      <img :src="photos[open].url" :alt="`Réalisation de ${name}`">
      <button v-if="photos.length > 1" class="icon-btn lb-next" type="button" :aria-label="t('Photo suivante')" @click="move(1)"><ChevronRight :size="24" /></button>
      <span class="lb-count">{{ open + 1 }} / {{ photos.length }}</span>
    </div>
  </Teleport>
</template>
