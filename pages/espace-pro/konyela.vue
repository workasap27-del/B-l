<script setup lang="ts">
const { workPro, service, nowMin, mySlots, removeSlot, needsFiche } = useVladi()
const p = computed(() => workPro.value.pro)
</script>

<template>
  <ProGate v-if="needsFiche" />
  <template v-else>
  <ProTabs><h1 class="title">Mes créneaux Konyéla</h1></ProTabs>
  <div class="col gap12 mt24">
    <template v-for="s in mySlots" :key="s.id">
      <div v-if="service(p, s.sid)" class="box">
        <div class="row between">
          <span class="name">{{ hm(s.time) }} · {{ service(p, s.sid)!.n }}</span>
          <span v-if="s.status === 'booked'" class="tag ok">Réservé</span>
          <span v-else-if="s.time < nowMin + 10" class="tag">Expiré</span>
          <span v-else class="tag now">En ligne</span>
        </div>
        <span class="meta">{{ euro(service(p, s.sid)!.p) }} ramené à {{ euro(discounted(service(p, s.sid)!, s.disc)) }} (-{{ s.disc }} %)</span>
        <button v-if="s.status === 'open' && s.time >= nowMin + 10" class="btn sm line" style="align-self:flex-start" @click="removeSlot(s.id)">Retirer</button>
      </div>
    </template>
    <p v-if="!mySlots.length" class="meta">Aucun créneau proposé aujourd'hui. Dans l'agenda, touche « Proposer en Konyéla » sur un créneau libre.</p>
  </div>
  </template>
</template>
