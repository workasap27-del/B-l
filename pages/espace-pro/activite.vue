<script setup lang="ts">
import { DEMO_PRO_ID, RULES } from '~/data/pros'

const { state, pro, today, agenda } = useBel()
const p = pro(DEMO_PRO_ID)!
const appts = computed(() => agenda(today.value).filter(e => e.kind === 'rdv' || e.kind === 'app'))
const minutes = computed(() => appts.value.reduce((a, e) => a + e.b - e.a, 0))
const revenue = computed(() => appts.value.reduce((a, e) => a + (e.price ?? 0), 0))
const fillRate = computed(() => Math.round((minutes.value / (p.close - p.open)) * 100))
const viaApp = computed(() => state.bookings.filter(b => b.proId === p.id && b.status === 'confirmed'))
const viaRevenue = computed(() => viaApp.value.reduce((a, b) => a + b.price, 0))
</script>

<template>
  <h1 class="h1">Mon activité</h1>
  <div class="stats">
    <div class="stat"><b>{{ appts.length }}</b><span>rendez-vous aujourd'hui</span></div>
    <div class="stat"><b>{{ fillRate }} %</b><span>de la journée remplie</span></div>
    <div class="stat"><b>{{ euro(revenue) }}</b><span>chiffre du jour</span></div>
    <div class="stat"><b>{{ viaApp.length }}</b><span>réservation{{ viaApp.length > 1 ? 's' : '' }} via Bèl</span></div>
  </div>
  <div class="box">
    <b>Ce que Bèl prélève</b>
    <div class="kv"><span>Réservations via l'appli</span><span>{{ euro(viaRevenue) }}</span></div>
    <div class="kv"><span>Commission {{ RULES.commissionRate * 100 }} %</span><span>{{ euro(viaRevenue * RULES.commissionRate) }}</span></div>
    <div class="sub">Taux donné à titre d'hypothèse. Rien n'est prélevé sur tes clientes habituelles.</div>
  </div>
  <h2 class="h2">Mes prestations</h2>
  <div>
    <div v-for="s in p.services" :key="s.id" class="svc">
      <div class="grow"><div style="font-weight:600">{{ s.n }}</div><div class="sub">{{ s.d }} min</div></div>
      <span class="price">{{ euro(s.p) }}</span>
    </div>
  </div>
</template>
