<script setup lang="ts">
import { BarChart3, CalendarDays, ChevronDown, ChevronRight, MapPin, Search, Settings2, Store } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

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
</script>

<template>
  <div class="home-head">
  <header class="topbar">
    <AppLogo />
    <div class="row gap8">
      <button class="icon-btn filled" aria-label="Réglages" @click="settingsOpen = true"><Settings2 :size="20" /></button>
      <NuxtLink v-if="account" class="me-chip" to="/profil" :aria-label="`Mon compte, ${account.name}`">
        <span class="avatar-xs">{{ initial }}</span><span class="me-name ellip">{{ firstName }}</span>
      </NuxtLink>
      <NuxtLink v-else-if="!remote.loading" class="btn sm" to="/connexion">Se connecter</NuxtLink>
    </div>
  </header>

  <section class="section mt16 gap16">
    <div class="col gap8">
      <button class="place-picker" aria-label="Changer de lieu" @click="locOpen = true">
        <MapPin :size="15" /><span>{{ state.pos.label }}</span><ChevronDown :size="15" />
      </button>
      <p v-if="account" class="hello">Bonjour {{ firstName }}</p>
      <h1 class="title">Réserve ton moment beauté et bien-être</h1>
    </div>
    <NuxtLink class="search-field" to="/recherche?saisie=1">
      <Search :size="19" /><span>Ongles, tatouage, massage, spa…</span>
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
        <span class="meta ellip">{{ remote.myPro.name }} · Ouvrir mon agenda</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
    <NuxtLink v-else class="banner" to="/espace-pro/fiche">
      <Store :size="22" />
      <div class="grow col gap4">
        <span class="name">Publie ta fiche prestataire</span>
        <span class="meta">Ton compte est prêt. Ajoute tes prestations et tes horaires pour recevoir des réservations.</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <section v-if="remote.admin" class="section">
    <NuxtLink class="banner" to="/pilotage">
      <BarChart3 :size="22" />
      <div class="grow col gap4"><span class="name">Pilotage</span><span class="meta">Indicateurs, journal d'activité et exports</span></div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <section v-if="nextBooking && nextPro" class="section">
    <h2 class="h2">Ton prochain rendez-vous</h2>
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
      <h2 class="h2">Libre aujourd'hui, prix réduit</h2>
      <NuxtLink class="see-all" to="/konyela">Tout voir<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel wide"><SlotCard v-for="s in slots" :key="s.id" :item="s" /></div>
  </section>

  <section v-if="!near.length && !remote.loading" class="section">
    <div class="empty" style="padding:24px 0">
      <MapPin :size="28" />
      <b>Pas encore d'établissement près de {{ state.pos.label }}</b>
      <span>De nouveaux prestataires rejoignent VLADI chaque semaine. Change de commune pour voir plus loin.</span>
      <button class="btn sm soft" @click="locOpen = true">Changer de commune</button>
    </div>
  </section>

  <section v-if="near.length" class="section">
    <div class="section-head">
      <h2 class="h2">Près de toi</h2>
      <NuxtLink class="see-all" to="/recherche">Tout voir<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in near" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="atHome.length" class="section">
    <div class="section-head">
      <h2 class="h2">Ils viennent chez toi</h2>
      <NuxtLink class="see-all" to="/recherche?lieu=client">Tout voir<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in atHome" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="best.length" class="section">
    <div class="section-head">
      <h2 class="h2">Les mieux notés</h2>
      <NuxtLink class="see-all" to="/recherche?tri=note">Tout voir<ChevronRight :size="16" /></NuxtLink>
    </div>
    <div class="carousel"><ProCard v-for="p in best" :key="p.id" :pro="p" /></div>
  </section>

  <section v-if="!isPro" class="section">
    <NuxtLink class="banner" :to="account ? '/espace-pro/fiche' : '/connexion?mode=inscription&role=pro'">
      <div class="grow col gap4">
        <span class="name">Tu es prestataire ?</span>
        <span class="meta">Crée ta fiche gratuitement et reçois tes réservations ici : beauté, bien-être, tatouage, spa, hôtel.</span>
      </div>
      <ChevronRight :size="18" style="align-self:center" />
    </NuxtLink>
  </section>

  <footer class="legal-links mt24">
    <NuxtLink to="/cgu">Conditions générales</NuxtLink>
    <NuxtLink to="/confidentialite">Confidentialité</NuxtLink>
    <NuxtLink to="/mentions-legales">Mentions légales</NuxtLink>
    <a :href="`mailto:${LEGAL.contactEmail}`">Contact</a>
  </footer>

  <LocationSheet v-if="locOpen" @close="locOpen = false" />
  <SettingsSheet v-if="settingsOpen" @close="settingsOpen = false" />
</template>
