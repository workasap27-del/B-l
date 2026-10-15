<script setup lang="ts">
// En-tête commun de l'espace prestataire : nom de la fiche, bandeau d'exemple et onglets.
const route = useRoute()
const { workPro, account } = useVladi()
const tabs = [
  { to: '/espace-pro', label: 'Agenda' },
  { to: '/espace-pro/konyela', label: 'Konyéla' },
  { to: '/espace-pro/activite', label: 'Activité' },
]
</script>

<template>
  <div class="col gap4">
    <span class="meta ellip">{{ workPro.pro.name }}{{ workPro.pro.owner ? ` · ${workPro.pro.owner}` : '' }}</span>
    <slot />
  </div>
  <div v-if="workPro.demo" class="banner mt16">
    <div class="grow col gap4">
      <span class="name">Espace d'exemple</span>
      <span class="meta">Tu vois l'agenda fictif de {{ workPro.pro.name }}. Crée ta fiche pour gérer tes vrais rendez-vous.</span>
      <NuxtLink class="link mt8" :to="account ? '/espace-pro/fiche' : '/connexion?mode=inscription&role=pro'">Créer ma fiche</NuxtLink>
    </div>
  </div>
  <div class="seg mt16">
    <NuxtLink v-for="t in tabs" :key="t.to" :to="t.to" custom>
      <template #default="{ navigate }">
        <button :aria-pressed="route.path === t.to" @click="navigate">{{ t.label }}</button>
      </template>
    </NuxtLink>
  </div>
</template>
