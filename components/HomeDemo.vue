<script setup lang="ts">
import { ArrowRight, BarChart3, CalendarDays, ChevronDown, ChevronRight, MapPin, Search, Settings2, Store, X } from 'lucide-vue-next'
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
// Le thème est posé sur la page par le gabarit ; ici on signale seulement que l'accueil est affiché
// (en-tête transparent sur la photo, pour les thèmes qui le demandent).
onMounted(() => { document.documentElement.classList.add('hd-home') })
onBeforeUnmount(() => { document.documentElement.classList.remove('hd-home') })

// Composition propre à chaque thème : textes d'accompagnement, photos d'en-tête, mention de signature.
const themeId = computed(() => themeOf(state.theme).id)
const COPY: Record<string, { eyebrow: string, sub: string, subM: string, script?: boolean }> = {
  terracotta: { eyebrow: '', sub: 'Des salons et praticien·nes de confiance en Guadeloupe, pour prendre soin de toi, tout simplement.', subM: '' },
  lavande: { eyebrow: 'Guadeloupe · Beauté · Bien-être · Proche de toi', sub: 'Instituts, salons et experts près de chez toi, en toute simplicité.', subM: 'Des établissements de confiance, près de chez toi.' },
  jardin: { eyebrow: 'Beauté & bien-être en Guadeloupe', sub: 'Instituts, coiffeurs, nail bars, spas… Les meilleur·e·s prestataires près de chez toi, pour prendre soin de toi en toute simplicité.', subM: 'En Guadeloupe, des prestataires de confiance pour prendre soin de toi.' },
  corail: { eyebrow: '', sub: 'Les meilleurs instituts et prestataires de Guadeloupe, près de chez toi.', subM: '', script: true },
  editorial: { eyebrow: 'Guadeloupe · Beauté & bien-être', sub: 'Coiffeurs, instituts, ongleries, soins bien-être… Les meilleur·e·s prestataires près de chez toi, en toute simplicité.', subM: '', script: true },
}
const copy = computed(() => COPY[themeId.value])
const ART = {
  terracotta: { m: '/themes/terra-m.jpg', pc: '/themes/terra-pc.jpg' },
  lavande: { m: '/themes/lavande-m-hibiscus.png', pc: '/themes/lavande-pc-feuilles.png' },
  jardin: { m: '/themes/jardin-m-tall.webp', pc: '/themes/jardin-pc.webp' },
  corail: { m: '/themes/corail-m.jpg', pc: '/themes/corail-pc-right.jpg' },
  editorial: { m: '/themes/edito-m.jpg', pc: '/themes/edito-pc.jpg' },
} as Record<string, { m: string, pc: string }>
const art = computed(() => ART[themeId.value])
// Date du prochain rendez-vous, en lettres (pour les thèmes qui l'affichent en vignette).
const nextDate = computed(() => {
  if (!nextBooking.value) return { wd: '', day: '', mon: '' }
  const [y, m, d] = nextBooking.value.date.split('-').map(Number)
  const dt = new Date(y, m - 1, d, 12)
  return {
    wd: dt.toLocaleDateString('fr-FR', { weekday: 'short' }).replace('.', ''),
    day: String(d),
    mon: dt.toLocaleDateString('fr-FR', { month: 'short' }).replace('.', ''),
  }
})
const catOf = (c?: Category | 'domicile') => (c && c !== 'domicile' ? CAT_ICON[c] : Search)
</script>

<template>
  <div class="hd" :class="[`hd-${themeId}`, { 'with-rdv': nextBooking && nextPro }]">
    <header class="hd-bar">
      <AppLogo class="hd-logo" :height="26" tagline />
      <div class="hd-tools">
        <button class="icon-btn hd-gear" aria-label="Réglages et thème" @click="settingsOpen = true"><Settings2 :size="19" /></button>
        <NuxtLink class="me-chip hd-me" to="/profil" :aria-label="`Mon compte, ${who}`">
          <span class="avatar-xs">{{ initial }}</span><span class="me-name ellip">{{ who }}</span><ChevronDown :size="15" class="hd-me-chev" />
        </NuxtLink>
      </div>
    </header>

    <section class="hd-hero">
      <picture class="hd-art" aria-hidden="true">
        <source media="(min-width: 700px)" :srcset="art.pc">
        <img :src="art.m" alt="" width="800" height="600" fetchpriority="high">
      </picture>
      <img v-if="themeId === 'corail'" class="hd-art-l" src="/themes/corail-pc-left.jpg" alt="" aria-hidden="true">
      <span v-if="copy.script" class="hd-script" aria-hidden="true">Plus qu'un rendez-vous, un moment pour toi</span>
      <div class="hd-copy">
        <span v-if="copy.eyebrow" class="hd-eyebrow">{{ copy.eyebrow }}</span>
        <h1 class="hd-title"><span class="sr-only">Bonjour {{ who }}. </span>{{ themeId === 'terracotta' ? 'Des prestataires locaux près de chez toi' : 'Réserve ton moment beauté et bien-être' }}</h1>
        <p v-if="copy.sub" class="hd-sub hd-sub-pc">{{ copy.sub }}</p>
        <p v-if="copy.subM" class="hd-sub hd-sub-m">{{ copy.subM }}</p>
      </div>

      <form class="hd-panel" role="search" aria-label="Rechercher" @submit.prevent="router.push(resultsUrl())">
        <div class="hd-field">
          <button type="button" class="hd-row" @click="searchOpen = true">
            <component :is="catOf(what?.cat)" :size="22" class="hd-ico" />
            <span class="hd-txt">
              <span class="hd-a" :class="{ ph: !what }">{{ what?.label ?? 'Soin ou établissement' }}</span>
              <span class="hd-b">{{ what ? 'Soin ou établissement' : 'Ex. : Coiffure, onglerie, massage…' }}</span>
            </span>
            <ChevronRight :size="18" class="hd-chev" />
          </button>
          <button v-if="what" type="button" class="icon-btn hd-clear" aria-label="Retirer la prestation" @click="what = null"><X :size="17" /></button>
        </div>
        <button type="button" class="hd-row" aria-label="Changer de lieu" @click="locOpen = true">
          <MapPin :size="22" class="hd-ico" />
          <span class="hd-txt"><span class="hd-a">{{ state.pos.label }}</span><span class="hd-b">Guadeloupe</span></span>
          <ChevronRight :size="18" class="hd-chev" />
        </button>
        <button type="button" class="hd-row" @click="whenOpen = true">
          <CalendarDays :size="22" class="hd-ico" />
          <span class="hd-txt"><span class="hd-a">Quand ? <span class="hd-dot">·</span> <span class="hd-when" :class="{ ph: !when }">{{ whenLabel }}</span></span><span class="hd-b">Choisis une date</span></span>
          <ChevronRight :size="18" class="hd-chev" />
        </button>
        <button type="submit" class="btn block hd-go">Rechercher<ArrowRight :size="19" /></button>
      </form>
    </section>

    <NuxtLink v-if="nextBooking && nextPro" class="hd-rdv" :to="account ? '/rdv' : `/pro/${nextPro.id}`">
      <span class="rdv-ic" aria-hidden="true"><CalendarDays :size="22" /></span>
      <span class="rdv-date" aria-hidden="true"><i>{{ nextDate.wd }}.</i><b>{{ nextDate.day }}</b><i>{{ nextDate.mon }}.</i></span>
      <span class="rdv-when">
        <span class="rdv-k">Ton prochain rendez-vous</span>
        <span class="rdv-v">{{ capitalize(dayLabel(nextBooking.date, today)) }} à {{ hm(nextBooking.time) }}</span>
      </span>
      <ProPhoto class="rdv-thumb thumb" :pro="nextPro" :w="128" :h="128" ratio="none" :demo-label="false" />
      <span class="rdv-what">
        <span class="rdv-svc"><span class="rdv-s">{{ service(nextPro, nextBooking.sid)?.n }}</span><span class="rdv-dot"> · </span><span class="rdv-p">{{ nextPro.name }}</span></span>
        <span class="rdv-where"><MapPin :size="13" />{{ nextPro.commune }}</span>
      </span>
      <span class="rdv-go"><span class="rdv-go-t">Voir mon rendez-vous</span><ArrowRight :size="17" class="rdv-go-a" /><ChevronRight :size="18" class="rdv-go-c" /></span>
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

    <section v-if="slots.length" class="hd-sec hd-slots">
      <div class="section-head">
        <div class="col gap4">
          <h2 class="h2">Libre aujourd'hui</h2>
          <p class="hd-sec-sub">Des créneaux disponibles près de chez toi, pour te faire du bien sans attendre.</p>
        </div>
        <NuxtLink class="see-all" to="/konyela">Voir tout<ChevronRight :size="16" /></NuxtLink>
      </div>
      <div class="carousel wide hd-car"><SlotPhoto v-for="s in slots" :key="s.id" :item="s" /></div>
    </section>

    <section v-if="near.length" class="hd-sec">
      <div class="section-head">
        <h2 class="h2">Près de toi</h2>
        <NuxtLink class="see-all" to="/recherche">Voir tout<ChevronRight :size="16" /></NuxtLink>
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
