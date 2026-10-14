<script setup lang="ts">
import { DEMO_PRO_ID } from '~/data/pros'
import type { AgendaItem } from '~/composables/useVladi'

const { pro, today, nowMin, agenda, earliestIn, publishSlot, removeSlot, toast, state } = useVladi()
const bookingOf = (e: AgendaItem) => state.bookings.find(b => b.id === e.bookingId)
const p = pro(DEMO_PRO_ID)!
const days = computed(() => Array.from({ length: 4 }, (_, i) => addDays(today.value, i)))
const date = ref(today.value)
const isToday = computed(() => date.value === today.value)
const closed = computed(() => isClosed(p, date.value))
const items = computed(() => agenda(date.value))

const canPublish = (e: AgendaItem) => isToday.value && e.b - earliestIn(e.a) >= 30
const isPast = (e: AgendaItem) => isToday.value && e.b <= nowMin.value

// Feuille "Proposer en Konyéla"
const gap = ref<AgendaItem | null>(null)
const sid = ref('')
const time = ref<number | null>(null)
const disc = ref(30)
const first = computed(() => (gap.value ? earliestIn(gap.value.a) : 0))
const fitting = computed(() => (gap.value ? p.services.filter(s => s.d <= gap.value!.b - first.value) : []))
const chosen = computed(() => p.services.find(s => s.id === sid.value))
const startOptions = computed(() => {
  const out: number[] = []
  if (gap.value && chosen.value) for (let t = first.value; t + chosen.value.d <= gap.value.b; t += 30) out.push(t)
  return out
})
watchEffect(() => {
  if (!gap.value) return
  if (!fitting.value.some(s => s.id === sid.value)) sid.value = fitting.value[0]?.id ?? ''
  if (time.value === null || !startOptions.value.includes(time.value)) time.value = startOptions.value[0] ?? null
})
function open(e: AgendaItem) {
  gap.value = e
  sid.value = ''
  time.value = null
  disc.value = 30
}
function publish() {
  if (time.value === null || !publishSlot(sid.value, time.value, disc.value)) {
    toast("Ce créneau n'est plus libre")
  } else {
    toast('Créneau en ligne, visible côté cliente dans Konyéla')
  }
  gap.value = null
}
</script>

<template>
  <div>
    <div class="row between"><span class="sub">{{ p.name }} · {{ p.owner }}</span><span class="pill">Espace pro</span></div>
    <h1 class="h1">Mon agenda</h1>
  </div>
  <div class="chips">
    <button v-for="d in days" :key="d" class="chip" :aria-pressed="date === d" @click="date = d">{{ dayChip(d, today) }}</button>
  </div>
  <p v-if="closed" class="empty">Jour de repos.</p>
  <div v-else class="tl">
    <template v-for="e in items" :key="`${e.kind}-${e.a}`">
      <div v-if="e.kind === 'gap'" class="ev gap" :class="{ past: isPast(e) }">
        <time>{{ hm(e.a) }} à {{ hm(e.b) }}</time>
        <div class="grow sub">Libre · {{ e.b - e.a }} min</div>
        <button v-if="canPublish(e)" class="btn small sun" @click="open(e)">Proposer en Konyéla</button>
      </div>
      <div v-else-if="e.kind === 'lm'" class="ev lm">
        <time>{{ hm(e.a) }} à {{ hm(e.b) }}</time>
        <div class="grow"><b>{{ e.what }}</b><div class="sub">En ligne sur Konyéla · -{{ e.disc }} %</div></div>
        <button class="btn small line" @click="removeSlot(e.id!)">Retirer</button>
      </div>
      <div v-else class="ev" :class="{ past: isPast(e) && e.kind !== 'app' }">
        <time>{{ hm(e.a) }} à {{ hm(e.b) }}</time>
        <div class="grow">
          <b>{{ e.who }}</b>
          <span v-if="e.kind === 'app'" class="tag new" style="margin-left:6px">via VLADI</span>
          <span v-if="e.mode === 'lm'" class="tag k" style="margin-left:6px">Konyéla</span>
          <div class="sub">{{ e.what }} · {{ euro(e.price ?? 0) }}<template v-if="e.kind === 'app'"> · acompte {{ euro(e.deposit ?? 0) }} reçu</template></div>
          <div v-if="e.kind === 'app'" class="sub">{{ e.place === 'client' ? `Chez la cliente : ${e.address}` : 'Chez toi' }}</div>
        </div>
        <ArrivalBox v-if="e.kind === 'app' && bookingOf(e)" :booking="bookingOf(e)!" side="pro" />
      </div>
    </template>
  </div>
  <p v-if="isToday && !closed" class="sub">Un trou dans la journée ? Propose-le en Konyéla : les clientes autour de toi le voient tout de suite.</p>

  <BottomSheet v-if="gap" @close="gap = null">
    <h2 class="h2">Proposer en Konyéla</h2>
    <p class="sub">Créneau libre de {{ hm(first) }} à {{ hm(gap.b) }}.</p>
    <template v-if="fitting.length && chosen">
      <b>Prestation</b>
      <div class="chips">
        <button v-for="s in fitting" :key="s.id" class="chip" :aria-pressed="sid === s.id" @click="sid = s.id; time = null">{{ s.n }}</button>
      </div>
      <b>Heure de début</b>
      <div class="chips">
        <button v-for="t in startOptions" :key="t" class="chip" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
      </div>
      <b>Remise</b>
      <div class="chips">
        <button v-for="n in [20, 30, 40]" :key="n" class="chip" :aria-pressed="disc === n" @click="disc = n">-{{ n }} %</button>
      </div>
      <div class="box"><div class="kv"><span>Prix affiché</span><span><span class="strike">{{ euro(chosen.p) }}</span>{{ euro(discounted(chosen, disc)) }}</span></div></div>
      <button class="btn block sun" @click="publish">Mettre en ligne</button>
    </template>
    <p v-else class="empty">Ce créneau est trop court pour une de tes prestations.</p>
    <button class="btn block line" @click="gap = null">Annuler</button>
  </BottomSheet>
</template>
