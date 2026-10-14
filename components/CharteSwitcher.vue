<script setup lang="ts">
import { Palette } from 'lucide-vue-next'

// Choix de la charte graphique, en test. À retirer une fois la charte choisie.
const { state } = useVladi()
const current = computed(() => CHARTES.find(c => c.id === state.charte))
</script>

<template>
  <section class="charte" aria-label="Choisir une charte graphique">
    <div class="row between">
      <span class="inline h3"><Palette :size="17" />Charte graphique (test)</span>
      <button v-if="state.charte" class="link" @click="state.charte = ''">Voir l'origine</button>
    </div>
    <div class="swatches">
      <button v-for="c in CHARTES" :key="c.id" class="sw" :aria-pressed="state.charte === c.id" :aria-label="`Charte ${c.name}`" @click="state.charte = c.id">
        <span class="dots"><i :style="{ background: c.colors[2] }" /><i :style="{ background: c.colors[0] }" /><i :style="{ background: c.colors[1] }" /></span>
        {{ c.name }}
      </button>
    </div>
    <p class="tiny">{{ current ? current.mood : 'Charte d\'origine : rose et jaune' }}</p>
  </section>
</template>
