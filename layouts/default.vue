<script setup lang="ts">
import { CalendarDays, House, Search, User, Zap } from 'lucide-vue-next'

const { state, toastMessage, account, remote, firstName } = useVladi()
const route = useRoute()
const router = useRouter()
// Lien « mot de passe oublié » ouvert : on propose de choisir un nouveau mot de passe.
watch(() => remote.recovery, (v) => { if (v && route.path !== '/nouveau-mot-de-passe') router.push('/nouveau-mot-de-passe') })

const tabsLive = computed(() => [
  { to: '/', label: 'Accueil', pc: 'Explorer', icon: House },
  { to: '/recherche', label: 'Rechercher', icon: Search },
  { to: '/konyela', label: 'Konyéla', icon: Zap },
  { to: '/rdv', label: 'Rendez-vous', pc: 'Mes rendez-vous', icon: CalendarDays },
  { to: '/profil', label: account.value ? firstName.value : 'Connexion', icon: User },
])
const active = (to: string) => (to === '/' ? route.path === '/' : route.path.startsWith(to) || (to === '/profil' && ['/espace-pro', '/connexion', '/pilotage', '/cgu', '/confidentialite', '/mentions-legales'].some(x => route.path.startsWith(x))))
// Pastille sur Compte : réservations reçues par la fiche de démonstration et pas encore vues.
const badge = computed(() => (state.demo ? state.unseen : 0))
const initial = computed(() => (account.value?.name ?? '').trim().charAt(0).toUpperCase())
const flush = computed(() => route.path.startsWith('/pro/'))
const homeDemo = computed(() => state.demo && route.path === '/')
// Largeur du contenu sur tablette et ordinateur : large (listes), moyenne (fiche) ou étroite (formulaires).
const width = computed(() => {
  const p = route.path
  if (p === '/' || p.startsWith('/recherche') || p.startsWith('/konyela') || p.startsWith('/pilotage')) return 'wide'
  if (p.startsWith('/pro/')) return 'mid'
  return 'narrow'
})

// Applique la charte choisie à toute l'appli, y compris la couleur de la barre du téléphone.
watchEffect(() => {
  const el = document.documentElement
  el.dataset.charte = state.charte || 'noir'
  // Mode présentation : le thème choisi s'applique à toute l'appli (accueil, recherche, fiches, réservation).
  if (state.demo) el.dataset.theme = themeOf(state.theme).id
  else delete el.dataset.theme
  requestAnimationFrame(() => {
    const bg = getComputedStyle(el).getPropertyValue('--bg').trim()
    if (bg) document.querySelectorAll('meta[name="theme-color"]').forEach(m => m.setAttribute('content', bg))
  })
})
</script>

<template>
  <div class="app">
    <main class="screen" :class="[{ flush, 'hd-screen': homeDemo }, `w-${width}`]">
      <slot />
    </main>
    <div id="sheets" />
    <div v-if="toastMessage" class="toast" role="status">{{ toastMessage }}</div>
    <nav class="nav" aria-label="Navigation principale">
      <NuxtLink to="/" class="nav-logo" aria-label="VLADI, accueil"><AppLogo :height="26" /></NuxtLink>
      <NuxtLink v-for="t in tabsLive" :key="t.to" :to="t.to" :class="{ on: active(t.to) }">
        <span v-if="t.to === '/profil' && account" class="avatar-xs" aria-hidden="true">{{ initial }}</span>
        <component :is="t.icon" v-else :size="23" :stroke-width="1.8" />
        <span class="nav-label"><span class="nl-m">{{ t.label }}</span><span class="nl-pc">{{ t.pc ?? t.label }}</span></span>
        <span v-if="t.to === '/profil' && badge" class="count">{{ badge }}</span>
      </NuxtLink>
    </nav>
  </div>
</template>
