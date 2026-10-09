<script setup lang="ts">
import { RULES } from '~/data/pros'

const route = useRoute()
const router = useRouter()
const { pro, service, starts, today, state, nowMin, book, toast } = useBel()

const p = computed(() => pro(String(route.params.pro)))
const sv = computed(() => (p.value ? service(p.value, String(route.params.service)) : undefined))
const slot = computed(() => state.slots.find(s => s.id === route.query.creneau))
const isSlot = computed(() => !!route.query.creneau)
const slotGone = computed(() => isSlot.value && (!slot.value || slot.value.status !== 'open' || slot.value.time < nowMin.value + 10))

const days = computed(() => Array.from({ length: 7 }, (_, i) => addDays(today.value, i)))
const date = ref('')
const time = ref<number | null>(null)
const recap = ref(false)

const free = computed(() => (p.value && sv.value && date.value ? starts(p.value, date.value, sv.value.d) : []))
function hasRoom(d: string) {
  return !!(p.value && sv.value && starts(p.value, d, sv.value.d).length)
}
watchEffect(() => {
  if (!date.value && p.value && sv.value) date.value = days.value.find(hasRoom) ?? days.value[0]
})
watch(free, (f) => { if (time.value !== null && !f.includes(time.value)) time.value = null })

const price = computed(() => (sv.value ? (slot.value ? discounted(sv.value, slot.value.disc) : sv.value.p) : 0))
const deposit = computed(() => Math.round(price.value * RULES.depositRate))
const when = computed(() => (slot.value ? { date: slot.value.date, time: slot.value.time } : { date: date.value, time: time.value ?? 0 }))

function pay() {
  if (!p.value || !sv.value) return
  const b = book({ proId: p.value.id, sid: sv.value.id, date: when.value.date, time: when.value.time, slotId: slot.value?.id })
  if (!b) {
    recap.value = false
    toast('Ce créneau vient de partir. Choisis-en un autre.')
    return
  }
  router.replace(`/confirmation/${b.id}`)
}
</script>

<template>
  <template v-if="p && sv">
    <div class="topbar">
      <button class="bk" aria-label="Retour" @click="router.back()">‹</button>
      <div class="grow">
        <div class="h2">{{ sv.n }}</div>
        <div class="sub">{{ p.name }} · {{ sv.d }} min · {{ euro(price) }}</div>
      </div>
    </div>

    <template v-if="isSlot">
      <p v-if="slotGone" class="empty">Ce créneau Konyéla n'est plus disponible. <NuxtLink to="/konyela" class="ok">Voir les autres</NuxtLink></p>
      <template v-else-if="slot">
        <div class="kbox">
          <span class="tag k" style="align-self:flex-start">Konyéla · -{{ slot.disc }} %</span>
          <div class="name">Aujourd'hui à {{ hm(slot.time) }}</div>
          <div class="sub">{{ p.quartier }}, {{ p.commune }}</div>
        </div>
        <div class="box sub">Créneau de dernière minute : l'acompte n'est pas remboursable.</div>
        <button class="btn block sun" @click="recap = true">Continuer</button>
      </template>
    </template>

    <template v-else>
      <h2 class="h2">Quel jour ?</h2>
      <div class="chips">
        <button v-for="d in days" :key="d" class="chip" :aria-pressed="date === d" :disabled="!hasRoom(d)" @click="date = d; time = null">{{ dayChip(d, today) }}</button>
      </div>
      <h2 class="h2">Quelle heure ?</h2>
      <div v-if="free.length" class="slots">
        <button v-for="t in free" :key="t" class="slot" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
      </div>
      <p v-else class="empty">Plus de place ce jour-là. Essaie un autre jour.</p>
      <div class="box sub">Annulation gratuite jusqu'à {{ RULES.freeCancelHours }} h avant le rendez-vous. Passé ce délai, l'acompte reste au prestataire.</div>
      <button class="btn block" :disabled="time === null" @click="recap = true">Continuer</button>
    </template>

    <BottomSheet v-if="recap" @close="recap = false">
      <h2 class="h2">Récapitulatif</h2>
      <div class="box">
        <div class="kv"><span>Prestation</span><span>{{ sv.n }}</span></div>
        <div class="kv"><span>Chez</span><span>{{ p.name }}</span></div>
        <div class="kv"><span>Quand</span><span>{{ dayLabel(when.date, today) }} à {{ hm(when.time) }}</span></div>
        <div class="kv"><span>Prix</span><span><span v-if="slot" class="strike">{{ euro(sv.p) }}</span>{{ euro(price) }}</span></div>
        <div class="kv"><span>Acompte maintenant ({{ RULES.depositRate * 100 }} %)</span><span>{{ euro(deposit) }}</span></div>
        <div class="kv"><span>Sur place</span><span>{{ euro(price - deposit) }}</span></div>
      </div>
      <p class="sub">Paiement simulé dans cette version : aucune carte n'est débitée.</p>
      <button class="btn block" @click="pay">Payer l'acompte de {{ euro(deposit) }}</button>
      <button class="btn block line" @click="recap = false">Retour</button>
    </BottomSheet>
  </template>
  <p v-else class="empty">Cette prestation n'existe pas. <NuxtLink to="/" class="ok">Retour à l'accueil</NuxtLink></p>
</template>
