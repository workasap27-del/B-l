<script setup lang="ts">
import { BarChart3, CalendarDays, ChevronDown, ChevronRight, MapPin, Search, Settings2, Store } from 'lucide-vue-next'

useHead({ title: 'VLADI · Beauté et bien-être en Guadeloupe' })

const { pros, openSlots, km, ratingOf, account, myBookings, isDone, pro, service, today, placeLabel, state, remote, firstName, agenda } = useVladi()
const locOpen = ref(false)
const settingsOpen = ref(false)

const byDistance = computed(() => [...pros.value].sort((a, b) => km(a) - km(b)))
const near = computed(() => byDistance.value.slice(0, 10))
const atHome = computed(() => byDistance.value.filter(goesToClient).slice(0, 10))
const best = computed(() => byDistance.value.slice(0, 60).filter(p => ratingOf(p).count >= 15).sort((a, b) => ratingOf(b).rating - ratingOf(a).rating).slice(0, 10))
// Dernière minute : seulement ce qui est raisonnablement proche, du plus tôt au plus tard.
const slots = computed(() => openSlots().filter(s => km(pro(s.proId)!) <= 30).slice(0, 10))
const stamp = (b: { date: string, time: number }) => `${b.date}${String(b.time).padStart(4, '0')}`
const nextBooking = computed(() => myBookings.value.filter(b => b.status === 'confirmed' && !isDone(b)).sort((a, b) => stamp(a).localeCompare(stamp(b)))[0])
const nextPro = computed(() => (nextBooking.value ? pro(nextBooking.value.proId) : undefined))
// Compte prestataire : l'essentiel de sa journée, en haut de l'accueil.
const isPro = computed(() => !!remote.myPro || account.value?.role === 'pro')
const proToday = computed(() => (remote.myPro ? agenda(today.value).filter(e => e.kind === 'app').length : 0))
const initial = computed(() => (account.value?.name ?? '').trim().charAt(0).toUpperCase())

// Fiches mises en avant sur l'accueil (quand la mise en avant est ouverte), les plus proches d'abord.
const { sponsoredIds } = useVladi()
const featured = computed(() => {
  const ids = sponsoredIds('accueil')
  return pros.value.filter(p => ids.has(p.id)).sort((a, b) => km(a) - km(b)).slice(0, 6)
})
</script>

<template>
  <!-- Préversion du nouvel accueil, uniquement en mode présentation (?demo=1). -->
  <HomeDemo v-if="state.demo" />
  <template v-else>
  <div class="home-head">
  <header class="topbar">
    <AppLogo />
    <div class="row gap8">
      <button class="icon-btn filled" :aria-label="t('Réglages')" @click="settingsOpen = true"><Settings2 :size="20" /></button>
      <NuxtLink v-if="account" class="me-chip" to="/profil" :aria-label="`Mon compte, ${account.name}`">
        <span class="avatar-xs">{{ initial }}</span><span class="me-name ellip">{{ firstName }}</span>
      </NuxtLink>
      <NuxtLink v-else-if="!remote.loading" class="btn sm" to="/connexion">{{ t('Se connecter') }}</NuxtLink>
    </div>
  </header>

  <section class="section mt16 gap16">
    <div class="col gap8">
      <button class="place-picker" :aria-label="t('Changer de lieu')" @click="locOpen = true">
        <MapPin :size="15" /><span>{{ state.pos.label }}</span><ChevronDown :size="15" />
      </button>
      <p v-if="account" class="hello">{{ t('Bonjour {name}', { name: firstName }) }}</p>
      <h1 class="title">{{ t('Réserve ton instant beauté et bien-être') }}</h1>
    </div>
    <NuxtLink class="search-field" to="/recherche?saisie=1">
      <Search :size="19" /><span>{{ t('Coiffure, ongles, cils, massage…') }}</span>
    </NuxtLink>
  </section>
  </div>

  <section class="section">
    <CategoryGrid link />
  </section>

  <section v-if="account && isPro" class="section">
    <NuxtLink v-if="remote.myPro" class="banner" to="/espace-pro">
      <CalendarDays :size="22" />
      <div class="grow col gap4">
        <span class="name">{{ proToday ? `${proToday} rendez-vous aujourd'hui` : 'Aucun rendez-vous aujourd\'hui' }}</span>
        <span class="meta ellip">{{ remote.myPro.name }} · {{ t('Ouvrir mon agenda') }}</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
    <NuxtLink v-else class="banner" to="/espace-pro/fiche">
      <Store :size="22" />
      <div class="grow col gap4">
        <span class="name">{{ t('Publie ta fiche prestataire') }}</span>
        <span class="meta">{{ t('Ton compte est prêt. Ajoute tes prestations et tes horaires pour recevoir des réservations.') }}</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <section v-if="remote.admin" class="section">
    <NuxtLink class="banner" to="/pilotage">
      <BarChart3 :size="22" />
      <div class="grow col gap4"><span class="name">{{ t('Pilotage') }}</span><span class="meta">{{ t('Indicateurs, journal d\'activité et exports') }}</span></div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <section v-if="nextBooking && nextPro" class="section">
    <h2 class="h2">{{ t('Ton prochain rendez-vous') }}</h2>
    <NuxtLink class="appt" style="padding:0;border:0" to="/rdv">
      <ProPhoto class="thumb" :pro="nextPro" :w="128" :h="128" ratio="none" :demo-label="false" />
      <div class="grow col gap4">
        <span class="name">{{ capitalize(dayLabel(nextBooking.date, today)) }} à {{ hm(nextBooking.time) }}</span>
        <span class="meta ellip">{{ service(nextPro, nextBooking.sid)?.n }} · {{ nextPro.name }}</span>
        <span class="meta ellip">{{ placeLabel(nextBooking) }}</span>
      </div>
      <ChevronRight :size="18" class="muted" style="align-self:center" />
    </NuxtLink>
  </section>

  <section v-if="slots.length" class="section">
    <div class="section-head">
      <h2 class="h2">{{ t('Libre aujourd\'hui, prix réduit') }}</h2>
      <NuxtLink class="see-all" to="/konyela">{{ t('Tout voir') }}<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel wide"><SlotCard v-for="s in slots" :key="s.id" :item="s" /></div>
  </section>

  <section v-if="!near.length && !remote.loading" class="section">
    <div class="empty" style="padding:24px 0">
      <MapPin :size="28" />
      <b>{{ t('Pas encore d\'établissement près de {place}', { place: state.pos.label }) }}</b>
      <span>{{ t('De nouveaux prestataires rejoignent VLADI chaque semaine. Change de commune pour voir plus loin.') }}</span>
      <button class="btn sm soft" @click="locOpen = true">{{ t('Changer de commune') }}</button>
    </div>
  </section>

  <section v-if="featured.length" class="section">
    <div class="row between"><h2 class="h2">{{ t('À découvrir') }}</h2><span class="tag" :title="t('Fiches mises en avant contre paiement. La note et les avis ne sont pas concernés.')">{{ t('Sponsorisé') }}</span></div>
    <div class="carousel"><ProCard v-for="p in featured" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="near.length" class="section">
    <div class="section-head">
      <h2 class="h2">{{ t('Près de toi') }}</h2>
      <NuxtLink class="see-all" to="/recherche">{{ t('Tout voir') }}<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in near" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="atHome.length" class="section">
    <div class="section-head">
      <h2 class="h2">{{ t('Ils viennent chez toi') }}</h2>
      <NuxtLink class="see-all" to="/recherche?lieu=client">{{ t('Tout voir') }}<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in atHome" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="best.length" class="section">
    <div class="section-head">
      <h2 class="h2">{{ t('Les mieux notés') }}</h2>
      <NuxtLink class="see-all" to="/recherche?tri=note">{{ t('Tout voir') }}<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in best" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="!isPro" class="section">
    <NuxtLink class="banner" to="/devenir-prestataire">
      <div class="grow col gap4">
        <span class="name">{{ t('Tu es prestataire ?') }}</span>
        <span class="meta">{{ t('Crée ta fiche gratuitement et reçois tes réservations ici : beauté, coiffure, bien-être, tatouage et plus encore.') }}</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <LocationSheet v-if="locOpen" @close="locOpen = false" />
  <SettingsSheet v-if="settingsOpen" @close="settingsOpen = false" />
  </template>
</template>
