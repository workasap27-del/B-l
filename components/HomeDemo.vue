<script setup lang="ts">
import { BarChart3, CalendarDays, ChevronRight, MapPin, Search, Settings2, Store, X } from 'lucide-vue-next'
import { DEMO_CLIENT } from '~/data/pros'
import type { Category } from '~/data/pros'
import { LEGAL } from '~/data/legal'
import type { SearchPick } from '~/utils/suggest'

// Accueil en préversion, visible seulement en mode présentation (?demo=1) :
// un premier ensemble (logo, profil, titre, formulaire de recherche, prochain rendez-vous), puis les offres et la découverte.
const router = useRouter()
const { pros, openSlots, km, ratingOf, account, myBookings, isDone, pro, service, today, state, remote, agenda } = useVladi()

const locOpen = ref(false)
const settingsOpen = ref(false)
const searchOpen = ref(false)
const whenOpen = ref(false)

// Formulaire : prestation (texte ou catégorie), lieu (la position choisie), jour facultatif.
const what = ref<SearchPick | null>(null)
const when = ref('')
const days = computed(() => Array.from({ length: 14 }, (_, i) => addDays(today.value, i)))
const whenLabel = computed(() => (when.value ? capitalize(dayLabel(when.value, today.value)) : 'Peu importe'))

function onPick(p: SearchPick) {
  what.value = p
  searchOpen.value = false
}
function resultsUrl(q?: string) {
  const params = new URLSearchParams()
  const pick = q ? { label: q, q } : what.value
  if (pick?.cat === 'domicile') params.set('lieu', 'client')
  else if (pick?.cat) params.set('cat', pick.cat)
  else if (pick?.q) params.set('q', pick.q)
  if (when.value) params.set('date', when.value)
  const s = params.toString()
  return `/recherche${s ? `?${s}` : ''}`
}
function onAll(q: string) {
  searchOpen.value = false
  router.push(resultsUrl(q))
}

// Personne affichée : le compte connecté, sinon la cliente de présentation.
const who = computed(() => (account.value?.name ?? DEMO_CLIENT.name).split(' ')[0])
const initial = computed(() => who.value.charAt(0).toUpperCase())

// Prochain rendez-vous : ceux du compte, sinon ceux de la présentation (masquables dans les réglages).
const stamp = (b: { date: string, time: number }) => `${b.date}${String(b.time).padStart(4, '0')}`
const nextBooking = computed(() => {
  if (state.demoNoRdv) return undefined
  const list = account.value ? myBookings.value : state.bookings
  return list.filter(b => b.status === 'confirmed' && !isDone(b) && pro(b.proId)).sort((a, b) => stamp(a).localeCompare(stamp(b)))[0]
})
const nextPro = computed(() => (nextBooking.value ? pro(nextBooking.value.proId) : undefined))

const isPro = computed(() => !!remote.myPro || account.value?.role === 'pro')
const proToday = computed(() => (remote.myPro ? agenda(today.value).filter(e => e.kind === 'app').length : 0))

const byDistance = computed(() => [...pros.value].sort((a, b) => km(a) - km(b)))
const near = computed(() => byDistance.value.slice(0, 10))
const atHome = computed(() => byDistance.value.filter(goesToClient).slice(0, 10))
const best = computed(() => byDistance.value.slice(0, 60).filter(p => ratingOf(p).count >= 15).sort((a, b) => ratingOf(b).rating - ratingOf(a).rating).slice(0, 10))
const slots = computed(() => openSlots().filter(s => km(pro(s.proId)!) <= 30).slice(0, 10))
// Palette chaude de la maquette, posée seulement le temps que cet accueil est affiché.
onMounted(() => { document.documentElement.dataset.home = 'chaud' })
onBeforeUnmount(() => { delete document.documentElement.dataset.home })
const catOf = (c?: Category | 'domicile') => (c && c !== 'domicile' ? CAT_ICON[c] : Search)
</script>

<template>
  <div class="hd">
    <section class="hd-hero">
      <header class="topbar">
        <AppLogo />
        <div class="row gap8">
          <button class="icon-btn filled" aria-label="Réglages" @click="settingsOpen = true"><Settings2 :size="20" /></button>
          <NuxtLink class="me-chip" to="/profil" :aria-label="`Mon compte, ${who}`">
            <span class="avatar-xs">{{ initial }}</span><span class="me-name ellip">{{ who }}</span>
          </NuxtLink>
        </div>
      </header>
      <div class="hd-hello">
        <span class="hd-bonjour">Bonjour {{ who }}</span>
        <h1 class="hd-title">Réserve ton moment beauté et bien-être</h1>
      </div>
    </section>

    <form class="hd-panel" role="search" aria-label="Rechercher" @submit.prevent="router.push(resultsUrl())">
      <div class="hd-card">
        <div class="hd-field">
          <button type="button" class="hd-row" @click="searchOpen = true">
            <component :is="catOf(what?.cat)" :size="20" class="hd-ico" />
            <span class="hd-txt">
              <span class="hd-k">Prestation</span>
              <span class="hd-v" :class="{ ph: !what }">{{ what?.label ?? 'Soin ou établissement' }}</span>
            </span>
          </button>
          <button v-if="what" type="button" class="icon-btn hd-clear" aria-label="Retirer la prestation" @click="what = null"><X :size="17" /></button>
        </div>
        <button type="button" class="hd-row" @click="locOpen = true">
          <MapPin :size="20" class="hd-ico" />
          <span class="hd-txt"><span class="hd-k">Où ?</span><span class="hd-v">{{ state.pos.label }}</span></span>
          <span class="hd-change">Changer</span>
        </button>
        <button type="button" class="hd-row" @click="whenOpen = true">
          <CalendarDays :size="20" class="hd-ico" />
          <span class="hd-txt"><span class="hd-k">Quand ?</span><span class="hd-v" :class="{ ph: !when }">{{ whenLabel }}</span></span>
        </button>
      </div>
      <button type="submit" class="btn block hd-go">Rechercher</button>
    </form>

    <NuxtLink v-if="nextBooking && nextPro" class="hd-rdv" :to="account ? '/rdv' : `/pro/${nextPro.id}`">
      <ProPhoto class="thumb" :pro="nextPro" :w="128" :h="128" ratio="none" :demo-label="false" />
      <div class="grow col gap4" style="min-width:0">
        <span class="hd-k">Ton prochain rendez-vous</span>
        <span class="name">{{ capitalize(dayLabel(nextBooking.date, today)) }} à {{ hm(nextBooking.time) }}</span>
        <span class="meta ellip">{{ service(nextPro, nextBooking.sid)?.n }} · {{ nextPro.name }}</span>
      </div>
      <ChevronRight :size="18" class="muted" style="align-self:center" />
    </NuxtLink>
  </div>

  <div class="hd-more">
    <section v-if="account && isPro" class="hd-sec">
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
        <div class="grow col gap4"><span class="name">Publie ta fiche prestataire</span><span class="meta">Ajoute tes prestations et tes horaires pour recevoir des réservations.</span></div>
        <ChevronRight :size="18" style="align-self:center" />
      </NuxtLink>
    </section>
    <section v-if="remote.admin" class="hd-sec">
      <NuxtLink class="banner" to="/pilotage">
        <BarChart3 :size="22" />
        <div class="grow col gap4"><span class="name">Pilotage</span><span class="meta">Indicateurs, journal d'activité et exports</span></div>
        <ChevronRight :size="18" style="align-self:center" />
      </NuxtLink>
    </section>

    <section v-if="slots.length" class="hd-sec band">
      <div class="section-head">
        <h2 class="h2">Libre aujourd'hui, prix réduit</h2>
        <NuxtLink class="see-all" to="/konyela">Tout voir<ChevronRight :size="16" /></NuxtLink>
      </div>
      <div class="carousel wide"><SlotCard v-for="s in slots" :key="s.id" :item="s" /></div>
    </section>

    <section v-if="near.length" class="hd-sec">
      <div class="section-head">
        <h2 class="h2">Près de toi</h2>
        <NuxtLink class="see-all" to="/recherche">Tout voir<ChevronRight :size="16" /></NuxtLink>
      </div>
      <div class="carousel"><ProCard v-for="p in near" :key="p.id" :pro="p" /></div>
    </section>

    <section v-if="atHome.length" class="hd-sec band">
      <div class="section-head">
        <h2 class="h2">Ils viennent chez toi</h2>
        <NuxtLink class="see-all" to="/recherche?lieu=client">Tout voir<ChevronRight :size="16" /></NuxtLink>
      </div>
      <div class="carousel"><ProCard v-for="p in atHome" :key="p.id" :pro="p" /></div>
    </section>

    <section v-if="best.length" class="hd-sec">
      <div class="section-head">
        <h2 class="h2">Les mieux notés</h2>
        <NuxtLink class="see-all" to="/recherche?tri=note">Tout voir<ChevronRight :size="16" /></NuxtLink>
      </div>
      <div class="carousel"><ProCard v-for="p in best" :key="p.id" :pro="p" /></div>
    </section>

    <section v-if="!isPro" class="hd-sec">
      <NuxtLink class="banner" :to="account ? '/espace-pro/fiche' : '/connexion?mode=inscription&role=pro'">
        <div class="grow col gap4">
          <span class="name">Tu es prestataire ?</span>
          <span class="meta">Crée ta fiche gratuitement et reçois tes réservations ici : beauté, bien-être, tatouage, spa, hôtel.</span>
        </div>
        <ChevronRight :size="18" style="align-self:center" />
      </NuxtLink>
    </section>

    <footer class="legal-links hd-sec">
      <NuxtLink to="/cgu">Conditions générales</NuxtLink>
      <NuxtLink to="/confidentialite">Confidentialité</NuxtLink>
      <NuxtLink to="/mentions-legales">Mentions légales</NuxtLink>
      <a :href="`mailto:${LEGAL.contactEmail}`">Contact</a>
    </footer>
  </div>

  <BottomSheet v-if="whenOpen" @close="whenOpen = false">
    <h2 class="h2">Quand ?</h2>
    <div class="chips" style="flex-wrap:wrap">
      <button class="chip" :aria-pressed="!when" @click="when = ''; whenOpen = false">Peu importe</button>
      <button v-for="d in days" :key="d" class="chip" :aria-pressed="when === d" @click="when = d; whenOpen = false">{{ dayChip(d, today) }}</button>
    </div>
    <p class="meta">Seuls les établissements qui ont encore de la place ce jour-là seront affichés.</p>
  </BottomSheet>
  <SearchSheet v-if="searchOpen" :initial="what?.q ?? ''" @close="searchOpen = false" @pick="onPick" @all="onAll" />
  <LocationSheet v-if="locOpen" @close="locOpen = false" />
  <SettingsSheet v-if="settingsOpen" @close="settingsOpen = false" />
</template>
