<script setup lang="ts">
import { House, Search } from 'lucide-vue-next'
import type { NuxtError } from '#app'

// Page d'erreur : adresse inconnue (404) ou erreur inattendue.
const props = defineProps<{ error: NuxtError }>()
const missing = computed(() => props.error?.statusCode === 404)
useHead({ title: missing.value ? 'Page introuvable · VLADI' : 'Erreur · VLADI' })
const home = () => clearError({ redirect: '/' })
const search = () => clearError({ redirect: '/recherche' })
</script>

<template>
  <div class="error-page">
    <AppLogo :height="28" />
    <h1 class="title">{{ missing ? 'Cette page n\'existe pas' : 'Oups, un souci est survenu' }}</h1>
    <p class="meta">{{ missing ? 'Le lien est peut-être incomplet, ou la fiche a été retirée.' : 'Réessaie dans un instant. Si le problème continue, écris-nous.' }}</p>
    <div class="col gap12" style="width:min(320px, 100%)">
      <button class="btn block" type="button" @click="search"><Search :size="18" />Chercher une prestation</button>
      <button class="btn block line" type="button" @click="home"><House :size="18" />Retour à l'accueil</button>
    </div>
  </div>
</template>

<style>
.error-page { min-height: 100dvh; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 16px; padding: 32px 20px; text-align: center; background: var(--bg); color: var(--ink); }
.error-page .btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
</style>
