<script setup lang="ts">
import { ChevronLeft, Clock, Flag, Heart, House, MapPin, Navigation, Pencil, Phone, Share2, Star, Store } from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()
const { pro, state, remote, toggleFav, openSlots, reviewsOf, ratingOf, km, openStatus, today, isMine, loadReviewsFor, photosOf, loadPhotosFor, replyToReview, countView } = useVladi()
const p = computed(() => pro(String(route.params.id)))
const slots = computed(() => (p.value ? openSlots(p.value.id) : []))
const tab = ref<'prestations' | 'avis' | 'infos'>('prestations')
const tabsEl = ref<HTMLElement | null>(null)
const d = computed(() => (p.value ? km(p.value) : 0))
const status = computed(() => (p.value ? openStatus(p.value) : { open: false, text: '' }))
const r = computed(() => (p.value ? ratingOf(p.value) : { rating: 0, count: 0 }))
const hero = computed(() => (p.value ? photoSrc(p.value, 800, 600) : { src: '', srcset: '' }))
const todayIndex = computed(() => weekday(today.value))
const days = [1, 2, 3, 4, 5, 6, 0]
watch(p, (v) => {
  if (!v) return
  void loadReviewsFor(v)
  void loadPhotosFor(v)
  countView(v)
}, { immediate: true })
const photos = computed(() => (p.value ? photosOf(p.value) : []))

// Titre et description de la page, pour l'onglet du navigateur et les moteurs de recherche.
useHead(() => {
  const v = p.value
  if (!v) return { title: 'VLADI' }
  const what = translate(CAT_SHORT[v.cats[0]] ?? 'Beauté')
  const desc = `${v.name}, ${what.toLowerCase()} ${inCommune(v.commune)}. ${v.services.slice(0, 3).map(x => x.n).join(', ')}. Réserve en ligne sur VLADI.`
  return {
    title: `${v.name} · ${what} ${inCommune(v.commune)} · VLADI`,
    meta: [{ name: 'description', content: desc }, { property: 'og:title', content: `${v.name} · ${what} ${inCommune(v.commune)}` }, { property: 'og:description', content: desc }],
  }
})

// Partage de la fiche : feuille de partage du téléphone, sinon WhatsApp, SMS ou copie du lien.
const shareOpen = ref(false)
const shareUrl = computed(() => (p.value ? `${window.location.origin}/pro/${p.value.id}` : ''))
async function share() {
  const v = p.value
  if (!v) return
  const data = { title: v.name, text: `${v.name} sur VLADI`, url: shareUrl.value }
  if (navigator.share) {
    try {
      await navigator.share(data)
      return
    }
    catch (e) {
      if ((e as Error).name === 'AbortError') return
    }
  }
  shareOpen.value = true
}

// Signalement d'une fiche ou d'un avis.
const reportOf = ref<{ proId?: string, reviewId?: string } | null>(null)

// Réponse du prestataire à un avis.
const editing = ref('')
const draft = ref('')
function startReply(id: string, current = '') {
  editing.value = id
  draft.value = current
}
async function saveReply(id: string) {
  if (!p.value) return
  if (await replyToReview(p.value, id, draft.value)) editing.value = ''
}

async function show(t: 'prestations' | 'avis' | 'infos') {
  tab.value = t
  await nextTick()
  tabsEl.value?.scrollIntoView({ block: 'start', behavior: 'smooth' })
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
// Répartition des notes des fiches de démonstration, déduite de la moyenne.
const bars = computed(() => {
  const five = Math.max(35, Math.min(94, Math.round((r.value.rating - 4) * 62 + 36)))
  const rest = 100 - five
  return [[5, five], [4, Math.round(rest * 0.6)], [3, Math.round(rest * 0.25)], [2, Math.round(rest * 0.1)], [1, Math.round(rest * 0.05)]]
})
</script>

<template>
  <template v-if="p">
    <div class="hero bleed">
      <img :src="hero.src" :srcset="hero.srcset || undefined" :alt="t('Photo illustrant {name}', { name: p.name })" onerror="this.style.visibility='hidden'">
      <div class="bar">
        <button class="icon-btn float" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="22" /></button>
        <button class="icon-btn float" :aria-label="t('Ajouter aux favoris')" :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)">
          <Heart :size="19" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />
        </button>
      </div>
    </div>

    <div class="sheet-top">
      <div class="tags">
        <span v-if="isMine(p)" class="tag accent">{{ t('Votre entreprise') }}</span>
        <span v-if="!p.real" class="tag">{{ t('Démonstration') }}</span>
      </div>
      <h1 class="title">{{ p.name }}</h1>
      <div class="row wrap" style="gap:6px">
        <span v-if="r.count" class="rate"><Star :size="14" />{{ fr(r.rating) }} <span class="n">({{ t('{n} avis', { n: r.count }) }})</span></span>
        <span v-else class="tag">{{ t('Nouveau sur VLADI') }}</span>
        <span class="meta">· {{ kindLabel(p.kind) }}{{ p.owner ? `, ${p.owner}` : '' }}</span>
      </div>
      <span class="status" :class="{ open: status.open }"><Clock :size="14" />{{ status.text }}</span>
      <span class="meta">{{ p.quartier ? `${p.quartier}, ` : '' }}{{ p.commune }} · {{ t('{km}, environ {min} min en voiture', { km: formatKm(d), min: driveMinutes(d) }) }}</span>
    </div>

    <div class="actions mt16">
      <a :href="directionsUrl(p)" target="_blank" rel="noopener"><Navigation :size="20" />{{ t('Itinéraire') }}</a>
      <a v-if="p.phone" :href="`tel:${p.phone.replace(/\s/g, '')}`"><Phone :size="20" />{{ t('Appeler') }}</a>
      <button v-else @click="show('infos')"><MapPin :size="20" />{{ t('Carte') }}</button>
      <NuxtLink v-if="isMine(p)" to="/espace-pro/fiche"><Pencil :size="20" />{{ t('Modifier') }}</NuxtLink>
      <button v-else :aria-pressed="!!state.fav[p.id]" @click="toggleFav(p.id)"><Heart :size="20" :fill="state.fav[p.id] ? 'currentColor' : 'none'" />{{ state.fav[p.id] ? t('Enregistré') : t('Enregistrer') }}</button>
      <button @click="share"><Share2 :size="20" />{{ t('Partager') }}</button>
    </div>

    <ProGallery v-if="photos.length" :photos="photos" :name="p.name" />

    <section v-if="slots.length" class="section">
      <h2 class="h2">{{ t('Libre aujourd\'hui, prix réduit') }}</h2>
      <div class="col gap8"><SlotCard v-for="s in slots" :key="s.id" :item="s" hide-pro /></div>
    </section>

    <div ref="tabsEl" class="tabs mt24">
      <button :aria-pressed="tab === 'prestations'" @click="tab = 'prestations'">{{ t('Prestations') }}</button>
      <button :aria-pressed="tab === 'avis'" @click="tab = 'avis'">{{ t('Avis') }}</button>
      <button :aria-pressed="tab === 'infos'" @click="tab = 'infos'">{{ t('Infos') }}</button>
    </div>

    <div v-if="tab === 'prestations'">
      <div v-for="s in p.services" :key="s.id" class="svc">
        <div class="grow col gap4">
          <span class="name">{{ s.n }}</span>
          <span class="meta">{{ duration(s.d) }} · {{ euro(s.p) }}</span>
        </div>
        <NuxtLink v-if="!isMine(p)" class="btn sm" :to="`/reserver/${p.id}/${s.id}`">{{ t('Réserver') }}</NuxtLink>
      </div>
    </div>

    <div v-else-if="tab === 'avis'" class="col">
      <div v-if="r.count" class="row gap24 mt16">
        <div class="col" style="align-items:center;gap:6px">
          <span class="bigrate">{{ fr(r.rating) }}</span>
          <span class="tiny">{{ t('{n} avis', { n: r.count }) }}</span>
        </div>
        <div v-if="!p.real" class="bars">
          <template v-for="b in bars" :key="b[0]"><span>{{ b[0] }}</span><i><b :style="{ width: b[1] + '%' }" /></i></template>
        </div>
      </div>
      <div v-for="(rv, i) in reviewsOf(p)" :key="rv.id ?? i" class="review">
        <div class="row between"><span class="name">{{ rv.a }}</span><span class="stars5"><Star v-for="n in rv.s" :key="n" :size="12" /></span></div>
        <span>{{ rv.t }}</span>
        <div v-if="rv.reply && editing !== rv.id" class="reply"><b>{{ t('Réponse de {name}', { name: p.name }) }}</b>{{ rv.reply }}</div>
        <div v-if="rv.id && editing === rv.id" class="col gap8 mt8">
          <textarea v-model="draft" class="input" rows="3" maxlength="1000" :aria-label="t('Réponse à l\'avis {n}', { n: i + 1 })" :placeholder="t('Merci pour ton avis…')" />
          <div class="row gap8">
            <button type="button" class="btn sm" @click="saveReply(rv.id)">{{ t('Publier') }}</button>
            <button type="button" class="btn sm soft" @click="editing = ''">{{ t('Annuler') }}</button>
          </div>
        </div>
        <div v-else-if="rv.id" class="rv-tools">
          <button v-if="isMine(p)" type="button" @click="startReply(rv.id, rv.reply)">{{ rv.reply ? t('Modifier la réponse') : t('Répondre') }}</button>
          <button v-else type="button" @click="reportOf = { reviewId: rv.id }">{{ t('Signaler') }}</button>
        </div>
      </div>
      <p v-if="!reviewsOf(p).length" class="empty">{{ t('Pas encore d\'avis. Les avis sont publiés après un rendez-vous effectué.') }}</p>
    </div>

    <div v-else class="col gap24 mt16">
      <p v-if="p.about">{{ p.about }}</p>
      <div class="infobox">
        <span class="h3">{{ t('Où ça se passe') }}</span>
        <div v-if="proPlace(p)" class="row"><Store :size="18" /><span class="grow">{{ t(proPlace(p) ?? '') }}{{ p.quartier ? `, ${p.quartier}` : '' }}, {{ p.commune }}</span></div>
        <div v-if="goesToClient(p)" class="row"><House :size="18" /><span class="grow col gap4"><span>{{ t('À domicile') }}, {{ travelFee(p) ? t('+ {fee} de déplacement', { fee: euro(travelFee(p)) }) : t('déplacement offert') }}</span><span class="meta">{{ travelZone(p).length ? t('Se déplace à : {list}', { list: travelZone(p).join(', ') }) : t('Se déplace partout en Guadeloupe') }}</span></span></div>
      </div>
      <ProMap :items="[{ id: p.id, lat: p.lat, lng: p.lng }]" :user="state.pos" mini />
      <div class="col gap12">
        <span class="h3">{{ t('Horaires') }}</span>
        <div class="hours">
          <template v-for="n in days" :key="n">
            <span :class="{ today: n === todayIndex }">{{ t(WEEK[n]) }}</span>
            <span :class="{ today: n === todayIndex }">{{ p.closed.includes(n) ? t('Fermé') : t('{a} à {b}', { a: hm(p.open), b: hm(p.close) }) }}</span>
          </template>
        </div>
      </div>
      <button v-if="p.real && !isMine(p)" type="button" class="textbtn row gap8" style="align-self:flex-start" @click="reportOf = { proId: p.id }"><Flag :size="15" />{{ t('Signaler cette fiche') }}</button>
      <p v-if="!p.real" class="tiny">{{ t('Établissement de démonstration, présenté à titre d\'illustration.') }}</p>
      <p v-else class="tiny">
        <template v-if="p.siren">{{ t('Entreprise immatriculée, SIREN {n}.', { n: p.siren.replace(/(\d{3})(\d{3})(\d{3})/, '$1 $2 $3') }) }}</template>
        <template v-if="!p.photo"> {{ t('Photo d\'illustration.') }}</template>
      </p>
    </div>
    <ShareSheet v-if="shareOpen" :title="p.name" :text="`${p.name} sur VLADI`" :url="shareUrl" @close="shareOpen = false" />
    <ReportSheet v-if="reportOf" v-bind="reportOf" @close="reportOf = null" />
  </template>
  <div v-else-if="remote.loading" class="empty" style="padding-top:96px">{{ t('Chargement…') }}</div>
  <div v-else class="empty" style="padding-top:96px">
    <b>{{ t('Cette fiche n\'existe pas') }}</b>
    <NuxtLink class="btn sm soft" to="/">{{ t('Retour à l\'accueil') }}</NuxtLink>
  </div>
</template>
