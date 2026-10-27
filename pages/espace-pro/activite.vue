<script setup lang="ts">
import * as api from '~/composables/useBackend'
const { workPro, today, agenda, proBookings, state, needsFiche } = useVladi()
const p = computed(() => workPro.value.pro)
const appts = computed(() => agenda(today.value).filter(e => e.kind === 'rdv' || e.kind === 'app'))
const minutes = computed(() => appts.value.reduce((a, e) => a + e.b - e.a, 0))
const revenue = computed(() => appts.value.reduce((a, e) => a + (e.price ?? 0), 0))
const fillRate = computed(() => Math.round((minutes.value / Math.max(30, p.value.close - p.value.open)) * 100))
const viaApp = computed(() => (workPro.value.demo ? state.bookings.filter(b => b.proId === p.value.id) : proBookings.value).filter(b => b.status === 'confirmed'))
const upcoming = computed(() => viaApp.value.filter(b => b.date >= today.value).length)

// Statistiques des 30 derniers jours (réservations reçues via VLADI).
const { remote, blocked, loadBlocked, setBlocked } = useVladi()
const since = computed(() => addDays(today.value, -30))
const all = computed(() => (workPro.value.demo ? state.bookings.filter(b => b.proId === p.value.id) : proBookings.value))
const month = computed(() => all.value.filter(b => b.date >= since.value && b.date <= today.value))
const done = computed(() => month.value.filter(b => b.status === 'confirmed' && b.noShow !== 'client'))
const monthRevenue = computed(() => done.value.reduce((a, b) => a + b.price, 0))
const noShows = computed(() => month.value.filter(b => b.noShow === 'client').length)
const cancels = computed(() => month.value.filter(b => b.status === 'cancelled').length)
const top = computed(() => {
  const n: Record<string, number> = {}
  for (const b of done.value) n[b.sid] = (n[b.sid] ?? 0) + 1
  return Object.entries(n).sort((a, b) => b[1] - a[1]).slice(0, 3)
    .map(([sid, c]) => ({ name: p.value.services.find(s => s.id === sid)?.n ?? 'Prestation', count: c }))
})
const views = ref<{ day: string, views: number }[]>([])
const totalViews = computed(() => views.value.reduce((a, v) => a + v.views, 0))
const conversion = computed(() => (totalViews.value ? Math.round((month.value.length / totalViews.value) * 100) : 0))
onMounted(async () => {
  if (workPro.value.demo || !remote.myPro) return
  views.value = await api.loadViews(remote.myPro.id, 30)
  await loadBlocked()
})
/** Personnes bloquées, avec le nom laissé lors d'une réservation. */
const blockedPeople = computed(() => blocked.value.map(id => ({ id, name: all.value.find(b => b.clientId === id)?.clientName || 'Client·e' })))
</script>

<template>
  <ProGate v-if="needsFiche" />
  <template v-else>
  <ProTabs><h1 class="title">Mon activité</h1></ProTabs>
  <div class="stats mt24">
    <div class="stat"><b>{{ appts.length }}</b><span>rendez-vous aujourd'hui</span></div>
    <div class="stat"><b>{{ fillRate }} %</b><span>de la journée remplie</span></div>
    <div class="stat"><b>{{ euro(revenue) }}</b><span>prévu aujourd'hui</span></div>
    <div class="stat"><b>{{ upcoming }}</b><span>réservation{{ upcoming > 1 ? 's' : '' }} à venir via VLADI</span></div>
  </div>

  <section class="section">
    <h2 class="h2">Les 30 derniers jours</h2>
    <div class="stats mt16">
      <div v-if="!workPro.demo" class="stat"><b>{{ totalViews }}</b><span>visite{{ totalViews > 1 ? 's' : '' }} de ta fiche</span></div>
      <div class="stat"><b>{{ month.length }}</b><span>réservation{{ month.length > 1 ? 's' : '' }} reçue{{ month.length > 1 ? 's' : '' }}</span></div>
      <div class="stat"><b>{{ euro(monthRevenue) }}</b><span>de prestations réalisées</span></div>
      <div v-if="!workPro.demo && totalViews" class="stat"><b>{{ conversion }} %</b><span>des visites deviennent une réservation</span></div>
      <div class="stat"><b>{{ noShows }}</b><span>absence{{ noShows > 1 ? 's' : '' }} · {{ cancels }} annulation{{ cancels > 1 ? 's' : '' }}</span></div>
    </div>
    <div v-if="top.length" class="mt16">
      <span class="h3">Prestations les plus réservées</span>
      <div v-for="t in top" :key="t.name" class="svc"><span class="grow name">{{ t.name }}</span><span class="meta">{{ t.count }} fois</span></div>
    </div>
  </section>

  <section v-if="blockedPeople.length" class="section">
    <h2 class="h2">Personnes bloquées</h2>
    <div v-for="b in blockedPeople" :key="b.id" class="svc">
      <span class="grow name">{{ b.name }}</span>
      <button type="button" class="btn sm line" @click="setBlocked(b.id, false)">Débloquer</button>
    </div>
  </section>

  <section class="section">
    <div class="row between">
      <h2 class="h2">Mes prestations</h2>
      <NuxtLink v-if="!workPro.demo" class="textbtn" to="/espace-pro/fiche">Modifier</NuxtLink>
    </div>
    <div class="mt8">
      <div v-for="s in p.services" :key="s.id" class="svc">
        <div class="grow col gap4"><span class="name">{{ s.n }}</span><span class="meta">{{ duration(s.d) }}</span></div>
        <span class="price">{{ euro(s.p) }}</span>
      </div>
    </div>
  </section>
  </template>
</template>
