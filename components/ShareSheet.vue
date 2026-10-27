<script setup lang="ts">
import { Copy, MessageCircle, Send } from 'lucide-vue-next'

// Partage d'un lien : WhatsApp, SMS ou copie. Sur téléphone, la feuille de partage du système passe en premier.
const props = defineProps<{ title: string, text: string, url: string }>()
const emit = defineEmits<{ close: [] }>()
const { toast } = useVladi()
const message = computed(() => `${props.text} ${props.url}`)
async function copy() {
  try {
    await navigator.clipboard.writeText(props.url)
    toast('Lien copié')
  }
  catch {
    toast('Copie impossible, sélectionne le lien à la main')
  }
  emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <div class="share-sheet">
      <p class="h3">Partager</p>
      <p class="meta ellip">{{ title }}</p>
      <a class="share-row" :href="`https://wa.me/?text=${encodeURIComponent(message)}`" target="_blank" rel="noopener" @click="emit('close')">
        <span class="srch-ico sm"><MessageCircle :size="18" /></span>WhatsApp
      </a>
      <a class="share-row" :href="`sms:?&body=${encodeURIComponent(message)}`" @click="emit('close')">
        <span class="srch-ico sm"><Send :size="18" /></span>SMS
      </a>
      <button type="button" class="share-row" @click="copy"><span class="srch-ico sm"><Copy :size="18" /></span>Copier le lien</button>
    </div>
  </BottomSheet>
</template>
