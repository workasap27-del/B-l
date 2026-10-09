<script setup lang="ts">
import { DEMO_PRO_ID } from '~/data/pros'

const { state, pro, service, today, nowMin } = useVladi()
const p = pro(DEMO_PRO_ID)!
const mine = computed(() => state.slots.filter(s => s.proId === p.id && s.date === today.value).sort((a, b) => a.time - b.time))
</script>

<template>
  <h1 class="h1">Mes créneaux Konyéla</h1>
  <div class="stack">
    <div v-for="s in mine" :key="s.id" class="box">
      <div class="row between">
        <b>{{ hm(s.time) }} · {{ service(p, s.sid)!.n }}</b>
        <span v-if="s.status === 'booked'" class="ok">Réservé</span>
        <span v-else-if="s.time < nowMin + 10" class="sub">Expiré</span>
        <span v-else class="tag k">En ligne</span>
      </div>
      <div class="sub">{{ euro(service(p, s.sid)!.p) }} ramené à {{ euro(discounted(service(p, s.sid)!, s.disc)) }} (-{{ s.disc }} %)</div>
    </div>
    <p v-if="!mine.length" class="empty">Aucun créneau proposé aujourd'hui. Va dans l'agenda et touche « Proposer en Konyéla » sur un créneau libre.</p>
  </div>
</template>
