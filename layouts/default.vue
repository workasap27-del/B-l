<script setup lang="ts">
import { CalendarDays, House, Search, User, Wallet, Zap } from 'lucide-vue-next'

const { state, toastMessage } = useVladi()
const route = useRoute()
const isPro = computed(() => route.path.startsWith('/espace-pro'))

const clientTabs = [
  { to: '/', label: 'Accueil', icon: House },
  { to: '/recherche', label: 'Recherche', icon: Search },
  { to: '/konyela', label: 'Konyéla', icon: Zap, k: true },
  { to: '/rdv', label: 'Rendez-vous', icon: CalendarDays },
  { to: '/profil', label: 'Profil', icon: User },
]
const proTabs = [
  { to: '/espace-pro', label: 'Agenda', icon: CalendarDays },
  { to: '/espace-pro/konyela', label: 'Konyéla', icon: Zap },
  { to: '/espace-pro/activite', label: 'Activité', icon: Wallet },
  { to: '/profil', label: 'Côté cliente', icon: User },
]
const tabs = computed(() => (isPro.value ? proTabs : clientTabs))
// Pendant une fiche ou une réservation, la navigation laisse la place au bouton d'action.
const focus = computed(() => route.path.startsWith('/pro/') || route.path.startsWith('/reserver/'))
const flush = computed(() => route.path.startsWith('/pro/'))

watch(isPro, (v) => { if (v) state.unseen = 0 }, { immediate: true })
</script>

<template>
  <div class="app">
    <main class="screen" :class="{ flush }">
      <slot />
    </main>
    <div id="sheets" />
    <div v-if="toastMessage" class="toast" role="status">{{ toastMessage }}</div>
    <nav v-if="!focus" class="navbar" aria-label="Navigation">
      <NuxtLink v-for="t in tabs" :key="t.to" :to="t.to" :class="{ on: route.path === t.to, k: 'k' in t && t.k }">
        <span v-if="'k' in t && t.k" class="bubble"><component :is="t.icon" :size="22" /></span>
        <component :is="t.icon" v-else :size="22" />
        {{ t.label }}
        <span v-if="t.to === '/profil' && !isPro && state.unseen" class="dot">{{ state.unseen }}</span>
      </NuxtLink>
    </nav>
  </div>
</template>
