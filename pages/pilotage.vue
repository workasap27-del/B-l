<script setup lang="ts">
import { ChevronLeft, Download, RefreshCw, TrendingDown, TrendingUp } from 'lucide-vue-next'
import type { Category } from '~/data/pros'
import * as api from '~/composables/useBackend'
import type { AdminEvent, AdminStats } from '~/utils/admin'
import { EVENT_KINDS, eventText, rate, toCsv, trend } from '~/utils/admin'

// Pilotage réservé aux propriétaires de l'appli : indicateurs, segments, journal d'activité et exports.
useHead({ title: 'Pilotage · VLADI' })
const router = useRouter()
const { account, remote, toast } = useVladi()

const PERIODS = [{ days: 7, label: '7 jours' }, { days: 30, label: '30 jours' }, { days: 90, label: '90 jours' }, { days: 0, label: 'Depuis le début' }]
const days = ref(30)
const stats = ref<AdminStats | null>(null)
const events = ref<AdminEvent[]>([])
const kind = ref('')
const limit = ref(60)
const loading = ref(false)
const error = ref('')
const reports = ref<api.AdminReport[]>([])
async function closeReport(id: string) {
  try {
    await api.adminCloseReport(id)
    reports.value = reports.value.filter(r => r.id !== id)
    toast('Signalement traité')
  }
  catch (e) {
    toast(api.readable(e))
  }
}

async function load() {
  if (!remote.admin) return
  loading.value = true
  error.value = ''
  try {
    const [s, e] = await Promise.all([api.adminStats(days.value), api.adminEvents(limit.value, kind.value || undefined)])
    stats.value = s
    events.value = e
    // Les signalements arrivent avec le patch 006 : sans lui, la section reste simplement vide.
    reports.value = await api.adminReports('ouvert').catch(() => [])
  }
  catch (e) {
    error.value = api.readable(e)
  }
  finally {
    loading.value = false
  }
}
watch(() => remote.admin, (v) => { if (v) void load() }, { immediate: true })
watch(days, () => void load())
watch([kind, limit], async () => {
  if (!remote.admin) return
  try { events.value = await api.adminEvents(limit.value, kind.value || undefined) }
  catch (e) { error.value = api.readable(e) }
})

const s = computed(() => stats.value)
const periodText = computed(() => (days.value ? `sur ${days.value} jours` : 'depuis le début'))
const cmp = computed(() => (days.value ? `vs ${days.value} jours précédents` : ''))

interface Tile { label: string, value: string, trend?: { pct: number, up: boolean } | null, help?: string, bad?: boolean }
const tiles = computed<Tile[]>(() => {
  const x = s.value
  if (!x) return []
  const b = x.bookings
  return [
    { label: 'Réservations', value: String(b.total), trend: days.value ? trend(b.total, x.previous.total) : null },
    { label: 'Volume d\'affaires', value: euro(b.gmv), trend: days.value ? trend(b.gmv, x.previous.gmv) : null, help: 'Total des réservations maintenues, frais de déplacement compris' },
    { label: 'Panier moyen', value: euro(b.avgBasket) },
    { label: 'Clients actifs', value: String(b.clients), trend: days.value ? trend(b.clients, x.previous.clients) : null, help: 'Personnes ayant réservé au moins une fois sur la période' },
    { label: 'Nouveaux comptes', value: String(x.accounts.new), trend: days.value ? trend(x.accounts.new, x.accounts.prevNew) : null, help: `${x.accounts.newClients} client·e·s, ${x.accounts.newPros} prestataires` },
    { label: 'Taux d\'annulation', value: `${rate(b.cancelled, b.total)} %`, help: `${b.cancelled} annulation${b.cancelled > 1 ? 's' : ''}`, bad: true },
    { label: 'Absences', value: `${rate(b.noShow, b.confirmed)} %`, help: `${b.noShow} signalée${b.noShow > 1 ? 's' : ''}, ${b.disputed} contestée${b.disputed > 1 ? 's' : ''}`, bad: true },
    { label: 'Réservé à l\'avance', value: b.avgLeadHours >= 48 ? `${fr(Math.round(b.avgLeadHours / 24))} j` : `${fr(b.avgLeadHours)} h`, help: 'Délai moyen entre la réservation et le rendez-vous' },
    { label: 'Part Konyéla', value: `${rate(b.konyela, b.total)} %`, help: 'Créneaux de dernière minute' },
    { label: 'Part à domicile', value: `${rate(b.atHome, b.total)} %` },
    { label: 'Note moyenne', value: x.reviews.total ? `${fr(x.reviews.avg)} / 5` : '-', help: `${x.reviews.total} avis au total, ${x.reviews.period} ${periodText.value}` },
    { label: 'Prestataires réservés', value: String(b.pros), help: `sur ${x.fiches.total} fiche${x.fiches.total > 1 ? 's' : ''} publiée${x.fiches.total > 1 ? 's' : ''}` },
  ]
})

// Séries journalières : au-delà de 90 points, on regroupe par semaine pour garder des barres lisibles.
function series(key: 'bookings' | 'signups' | 'gmv') {
  const d = s.value?.daily ?? []
  const fmtDay = (k: string) => new Date(`${k}T12:00:00`).toLocaleDateString('fr-FR', { day: 'numeric', month: 'short' })
  const unit = key === 'gmv' ? (v: number) => euro(v) : (v: number) => String(v)
  if (d.length <= 90) return d.map(p => ({ label: fmtDay(p.d), value: Number(p[key]), tip: `${fmtDay(p.d)} : ${unit(Number(p[key]))}` }))
  const weeks: { label: string, value: number, tip: string }[] = []
  for (let i = 0; i < d.length; i += 7) {
    const chunk = d.slice(i, i + 7)
    const v = chunk.reduce((a, p) => a + Number(p[key]), 0)
    weeks.push({ label: fmtDay(chunk[0].d), value: v, tip: `Semaine du ${fmtDay(chunk[0].d)} : ${unit(v)}` })
  }
  return weeks
}
const every = (n: number) => Math.max(1, Math.ceil(n / 7))
const DOW = ['', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']
const weekdayBars = computed(() => DOW.slice(1).map((l, i) => {
  const v = s.value?.byWeekday.find(x => x.dow === i + 1)?.bookings ?? 0
  return { label: l, value: v, tip: `${l} : ${v} rendez-vous` }
}))
const hourBars = computed(() => Array.from({ length: 16 }, (_, i) => i + 6).map((h) => {
  const v = s.value?.byHour.find(x => x.h === h)?.bookings ?? 0
  return { label: `${h}h`, value: v, tip: `${h}h : ${v} rendez-vous` }
}))
const catLabel = (c: string) => CAT_SHORT[c as Category] ?? 'Autre'
const share = (v: number, list: { bookings: number }[]) => rate(v, Math.max(1, ...list.map(x => x.bookings)))
const loyaltyRows = computed(() => {
  const l = s.value?.loyalty
  if (!l) return []
  return [
    { label: '1 réservation', n: l.once },
    { label: '2 à 3 réservations', n: l.twoToThree },
    { label: '4 réservations et plus', n: l.fourPlus },
  ].map(r => ({ ...r, pct: rate(r.n, l.clients) }))
})
const funnel = computed(() => {
  const x = s.value
  if (!x) return []
  return [
    { label: 'Comptes prestataires', n: x.accounts.pros },
    { label: 'Fiches publiées', n: x.fiches.total },
    { label: 'Avec des prestations actives', n: x.fiches.withServices },
    { label: 'Déjà réservées au moins une fois', n: x.fiches.withBooking },
  ]
})

const tz = 'America/Guadeloupe'
const when = (iso: string) => new Date(iso).toLocaleString('fr-FR', { timeZone: tz, day: 'numeric', month: 'short', hour: '2-digit', minute: '2-digit' })

function download(name: string, csv: string) {
  const url = URL.createObjectURL(new Blob([csv], { type: 'text/csv;charset=utf-8' }))
  const a = document.createElement('a')
  a.href = url
  a.download = name
  a.click()
  setTimeout(() => URL.revokeObjectURL(url), 1000)
}
const stamp = () => new Date().toISOString().slice(0, 10)
async function exportBookings() {
  try {
    const rows = (await api.adminBookings(days.value)).map(r => ({
      ...r,
      created_at: when(String(r.created_at)), starts_at: when(String(r.starts_at)),
      category: catLabel(String(r.category)),
      mode: r.mode === 'konyela' ? 'Konyéla' : 'Classique', place: r.place === 'client' ? 'À domicile' : 'Sur place',
      status: r.status === 'cancelled' ? 'Annulée' : 'Maintenue', no_show: r.no_show === 'client' ? 'Client·e absent·e' : r.no_show === 'pro' ? 'Prestataire absent·e' : '',
      price_eur: Number(r.price_eur), deposit_eur: Number(r.deposit_eur),
    }))
    download(`vladi-reservations-${stamp()}.csv`, toCsv(rows, [
      { key: 'created_at', label: 'Réservée le' }, { key: 'starts_at', label: 'Rendez-vous' }, { key: 'pro_name', label: 'Prestataire' },
      { key: 'commune', label: 'Commune' }, { key: 'category', label: 'Catégorie' }, { key: 'service_name', label: 'Prestation' },
      { key: 'client_name', label: 'Client·e' }, { key: 'price_eur', label: 'Prix (€)' }, { key: 'mode', label: 'Type' },
      { key: 'place', label: 'Lieu' }, { key: 'status', label: 'Statut' }, { key: 'no_show', label: 'Absence' },
    ]))
    toast(`${rows.length} réservation${rows.length > 1 ? 's' : ''} exportée${rows.length > 1 ? 's' : ''}`)
  }
  catch (e) { toast(api.readable(e)) }
}
function exportEvents() {
  const rows = events.value.map(e => ({ at: when(e.at), kind: EVENT_KINDS[e.kind] ?? e.kind, actor: e.actor, role: e.role === 'pro' ? 'Prestataire' : e.role ? 'Client·e' : '', pro: e.pro, text: eventText(e) }))
  download(`vladi-journal-${stamp()}.csv`, toCsv(rows, [
    { key: 'at', label: 'Date' }, { key: 'kind', label: 'Type' }, { key: 'actor', label: 'Par' }, { key: 'role', label: 'Profil' }, { key: 'pro', label: 'Fiche' }, { key: 'text', label: 'Détail' },
  ]))
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/profil')
}
</script>

<template>
  <div class="head"><button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button></div>

  <div v-if="remote.loading" class="empty">Chargement…</div>
  <div v-else-if="!account" class="empty">
    <b>Connexion requise</b>
    <NuxtLink class="btn sm" to="/connexion?retour=/pilotage">Se connecter</NuxtLink>
  </div>
  <div v-else-if="!remote.admin" class="empty">
    <b>Accès réservé</b>
    <span>Cette page est réservée aux propriétaires de VLADI.</span>
    <NuxtLink class="btn sm soft" to="/">Retour à l'accueil</NuxtLink>
  </div>

  <template v-else>
    <div class="row between wrap gap12 mt16">
      <div class="col gap4">
        <h1 class="title">Pilotage</h1>
        <span class="meta">Activité {{ periodText }}, hors établissements de démonstration</span>
      </div>
      <button class="icon-btn filled" aria-label="Actualiser" :disabled="loading" @click="load"><RefreshCw :size="18" /></button>
    </div>
    <div class="chips mt16">
      <button v-for="p in PERIODS" :key="p.days" class="chip" :aria-pressed="days === p.days" @click="days = p.days">{{ p.label }}</button>
    </div>
    <p v-if="error" class="error mt16">{{ error }}</p>

    <template v-if="s">
      <div class="kpis mt24">
        <div v-for="t in tiles" :key="t.label" class="kpi" :title="t.help">
          <span class="k-label">{{ t.label }}</span>
          <b>{{ t.value }}</b>
          <span v-if="t.trend" class="k-trend" :class="{ good: t.bad ? !t.trend.up : t.trend.up, bad: t.bad ? t.trend.up : !t.trend.up }">
            <component :is="t.trend.up ? TrendingUp : TrendingDown" :size="13" />{{ t.trend.up ? '+' : '-' }}{{ t.trend.pct }} % <span class="muted">{{ cmp }}</span>
          </span>
          <span v-else-if="t.help" class="k-help">{{ t.help }}</span>
        </div>
      </div>

      <section class="section">
        <h2 class="h2">Réservations par jour</h2>
        <p class="meta">Comptées à la date où elles ont été faites.</p>
        <MiniBars class="mt16" :items="series('bookings')" :every="every(series('bookings').length)" />
      </section>

      <section class="section">
        <h2 class="h2">Volume d'affaires par jour</h2>
        <MiniBars class="mt16" :items="series('gmv')" :every="every(series('gmv').length)" />
      </section>

      <section class="section">
        <h2 class="h2">Inscriptions par jour</h2>
        <p class="meta">{{ s.accounts.total }} comptes au total : {{ s.accounts.clients }} client·e·s et {{ s.accounts.pros }} prestataires.</p>
        <MiniBars class="mt16" :items="series('signups')" :every="every(series('signups').length)" :height="100" />
      </section>

      <div class="grid2">
        <section class="section">
          <h2 class="h2">Fidélité des client·e·s</h2>
          <p class="meta">Depuis le début. {{ s.loyalty.clients }} client·e·s ont réservé, {{ fr(s.loyalty.avgPerClient) }} réservations en moyenne.</p>
          <div class="hbars mt16">
            <div v-for="r in loyaltyRows" :key="r.label" class="hbar">
              <span class="hb-label">{{ r.label }}</span>
              <span class="hb-track"><i :style="{ width: `${r.pct}%` }" /></span>
              <span class="hb-val">{{ r.n }} · {{ r.pct }} %</span>
            </div>
          </div>
        </section>

        <section class="section">
          <h2 class="h2">Activation des prestataires</h2>
          <p class="meta">Du compte créé à la première réservation.</p>
          <div class="hbars mt16">
            <div v-for="r in funnel" :key="r.label" class="hbar">
              <span class="hb-label">{{ r.label }}</span>
              <span class="hb-track"><i :style="{ width: `${rate(r.n, Math.max(1, funnel[0].n, funnel[1].n))}%` }" /></span>
              <span class="hb-val">{{ r.n }}</span>
            </div>
          </div>
        </section>

        <section class="section">
          <h2 class="h2">Par catégorie</h2>
          <div v-if="s.byCategory.length" class="hbars mt16">
            <div v-for="c in s.byCategory" :key="c.cat" class="hbar" :title="`${c.clients} client·e·s, ${euro(c.gmv)}`">
              <span class="hb-label">{{ catLabel(c.cat) }}</span>
              <span class="hb-track"><i :style="{ width: `${share(c.bookings, s.byCategory)}%` }" /></span>
              <span class="hb-val">{{ c.bookings }} · {{ euro(c.gmv) }}</span>
            </div>
          </div>
          <p v-else class="meta mt8">Aucune réservation {{ periodText }}.</p>
        </section>

        <section class="section">
          <h2 class="h2">Par commune</h2>
          <div v-if="s.byCommune.length" class="hbars mt16">
            <div v-for="c in s.byCommune.slice(0, 10)" :key="c.commune" class="hbar">
              <span class="hb-label">{{ c.commune }}</span>
              <span class="hb-track"><i :style="{ width: `${share(c.bookings, s.byCommune)}%` }" /></span>
              <span class="hb-val">{{ c.bookings }} · {{ euro(c.gmv) }}</span>
            </div>
          </div>
          <p v-else class="meta mt8">Aucune réservation {{ periodText }}.</p>
          <p v-if="s.fichesByCommune.length" class="tiny mt16">Fiches publiées : {{ s.fichesByCommune.map(c => `${c.commune} (${c.fiches})`).join(', ') }}.</p>
        </section>

        <section class="section">
          <h2 class="h2">Jours de rendez-vous</h2>
          <MiniBars class="mt16" :items="weekdayBars" :height="100" />
        </section>

        <section class="section">
          <h2 class="h2">Heures de rendez-vous</h2>
          <MiniBars class="mt16" :items="hourBars" :height="100" :every="2" />
        </section>
      </div>

      <section class="section">
        <h2 class="h2">Prestataires les plus réservés</h2>
        <div v-if="s.topPros.length" class="table-wrap mt16">
          <table class="table">
            <thead><tr><th>Prestataire</th><th>Commune</th><th class="num">Réserv.</th><th class="num">Volume</th><th class="num">Annul.</th><th class="num">Note</th></tr></thead>
            <tbody>
              <tr v-for="p in s.topPros" :key="p.id">
                <td><NuxtLink class="link" :to="`/pro/${p.id}`">{{ p.name }}</NuxtLink></td><td>{{ p.commune }}</td>
                <td class="num">{{ p.bookings }}</td><td class="num">{{ euro(p.gmv) }}</td><td class="num">{{ p.cancelled }}</td><td class="num">{{ p.rating ? fr(p.rating) : '-' }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <p v-else class="meta mt8">Aucune réservation {{ periodText }}.</p>
      </section>

      <section class="section">
        <h2 class="h2">Prestations les plus demandées</h2>
        <div v-if="s.topServices.length" class="table-wrap mt16">
          <table class="table">
            <thead><tr><th>Prestation</th><th>Catégorie</th><th class="num">Réserv.</th><th class="num">Prix moyen</th></tr></thead>
            <tbody>
              <tr v-for="t in s.topServices" :key="`${t.name}-${t.cat}`"><td>{{ t.name }}</td><td>{{ catLabel(t.cat) }}</td><td class="num">{{ t.bookings }}</td><td class="num">{{ euro(Number(t.avg_price)) }}</td></tr>
            </tbody>
          </table>
        </div>
        <p v-else class="meta mt8">Aucune réservation {{ periodText }}.</p>
      </section>
    </template>

    <section class="section">
      <h2 class="h2">Signalements à traiter <span v-if="reports.length" class="tag accent">{{ reports.length }}</span></h2>
      <p v-if="!reports.length" class="meta mt8">Aucun signalement en attente.</p>
      <div v-for="r in reports" :key="r.id" class="infobox mt12">
        <div class="row between wrap gap8">
          <span class="name">{{ r.reviewBody || r.reviewStars ? 'Avis' : 'Fiche' }} · <NuxtLink class="link" :to="`/pro/${r.proId}`">{{ r.proName || r.proId }}</NuxtLink></span>
          <span class="tiny">{{ new Date(r.at).toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'short' }) }}{{ r.reporter ? ` · ${r.reporter}` : '' }}</span>
        </div>
        <p class="mt8">{{ r.reason }}</p>
        <p v-if="r.reviewBody || r.reviewStars" class="meta">Avis {{ r.reviewStars }}/5 : « {{ r.reviewBody || 'sans commentaire' }} »</p>
        <button type="button" class="btn sm soft mt8" @click="closeReport(r.id)">Marquer comme traité</button>
      </div>
    </section>

    <section class="section">
      <div class="row between wrap gap12">
        <h2 class="h2">Journal d'activité</h2>
        <select v-model="kind" class="select" style="width:auto;min-height:40px" aria-label="Filtrer le journal">
          <option value="">Tout</option>
          <option v-for="(l, k) in EVENT_KINDS" :key="k" :value="k">{{ l }}</option>
        </select>
      </div>
      <div v-if="events.length" class="log mt16">
        <div v-for="e in events" :key="e.id" class="log-row">
          <time class="tiny">{{ when(e.at) }}</time>
          <div class="col gap4" style="min-width:0">
            <span>{{ eventText(e) }}</span>
            <span class="meta ellip">{{ [e.actor, e.pro].filter(Boolean).join(' · ') || 'Système' }}</span>
          </div>
        </div>
        <button v-if="events.length >= limit" class="btn sm line" style="align-self:center" @click="limit += 100">Afficher plus</button>
      </div>
      <p v-else class="meta mt8">Rien pour l'instant.</p>
    </section>

    <section class="section">
      <h2 class="h2">Exports</h2>
      <p class="meta">Fichiers lisibles directement dans Excel ou Google Sheets.</p>
      <div class="row wrap gap8 mt16">
        <button class="btn sm soft" @click="exportBookings"><Download :size="16" />Réservations ({{ periodText }})</button>
        <button class="btn sm soft" :disabled="!events.length" @click="exportEvents"><Download :size="16" />Journal affiché</button>
      </div>
    </section>
  </template>
</template>
