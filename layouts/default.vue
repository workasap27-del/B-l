<script setup lang="ts">
const { state, toastMessage } = useBel()
const route = useRoute()
const isPro = computed(() => route.path.startsWith('/espace-pro'))

const ICONS: Record<string, string> = {
  home: '<path d="M4 11l8-7 8 7v8a1 1 0 0 1-1 1h-4v-6h-6v6H5a1 1 0 0 1-1-1z"/>',
  bolt: '<path d="M13 3L5 13h6l-1 8 8-10h-6z"/>',
  cal: '<rect x="4" y="5" width="16" height="15" rx="2"/><path d="M4 10h16M8 3v4M16 3v4"/>',
  user: '<circle cx="12" cy="8" r="4"/><path d="M4 21c1-4 4-6 8-6s7 2 8 6"/>',
  chart: '<path d="M5 20V10M12 20V4M19 20v-7"/>',
}
const clientTabs = [
  { to: '/', label: 'Accueil', icon: 'home' },
  { to: '/konyela', label: 'Konyéla', icon: 'bolt' },
  { to: '/rdv', label: 'Rendez-vous', icon: 'cal' },
  { to: '/profil', label: 'Profil', icon: 'user' },
]
const proTabs = [
  { to: '/espace-pro', label: 'Agenda', icon: 'cal' },
  { to: '/espace-pro/konyela', label: 'Konyéla', icon: 'bolt' },
  { to: '/espace-pro/activite', label: 'Activité', icon: 'chart' },
  { to: '/profil', label: 'Côté cliente', icon: 'user' },
]
const tabs = computed(() => (isPro.value ? proTabs : clientTabs))

watch(isPro, (v) => { if (v) state.unseen = 0 }, { immediate: true })
</script>

<template>
  <div class="app">
    <div class="demo">Version de démonstration · données fictives</div>
    <main class="screen">
      <slot />
    </main>
    <div id="sheets" />
    <div v-if="toastMessage" class="toast" role="status">{{ toastMessage }}</div>
    <nav class="tabbar" aria-label="Navigation">
      <NuxtLink v-for="t in tabs" :key="t.to" :to="t.to" :class="{ on: route.path === t.to }">
        <svg viewBox="0 0 24 24" aria-hidden="true" v-html="ICONS[t.icon]" />
        {{ t.label }}
        <span v-if="t.to === '/profil' && !isPro && state.unseen" class="badge">{{ state.unseen }}</span>
      </NuxtLink>
    </nav>
  </div>
</template>
