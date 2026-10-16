<script setup lang="ts">
const { workPro, today, agenda, proBookings, state, needsFiche } = useVladi()
const p = computed(() => workPro.value.pro)
const appts = computed(() => agenda(today.value).filter(e => e.kind === 'rdv' || e.kind === 'app'))
const minutes = computed(() => appts.value.reduce((a, e) => a + e.b - e.a, 0))
const revenue = computed(() => appts.value.reduce((a, e) => a + (e.price ?? 0), 0))
const fillRate = computed(() => Math.round((minutes.value / Math.max(30, p.value.close - p.value.open)) * 100))
const viaApp = computed(() => (workPro.value.demo ? state.bookings.filter(b => b.proId === p.value.id) : proBookings.value).filter(b => b.status === 'confirmed'))
const upcoming = computed(() => viaApp.value.filter(b => b.date >= today.value).length)
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
