<script setup lang="ts">
import { Phone } from 'lucide-vue-next'
import type { AgendaItem } from '~/composables/useVladi'
import { RULES } from '~/data/pros'

const { today, nowMin, agenda, earliestIn, publishSlot, removeSlot, toast, findBooking, workPro, needsFiche } = useVladi()
const p = computed(() => workPro.value.pro)
const days = computed(() => Array.from({ length: 5 }, (_, i) => addDays(today.value, i)))
const date = ref(today.value)
const isToday = computed(() => date.value === today.value)
const closed = computed(() => isClosed(p.value, date.value))
const items = computed(() => agenda(date.value))
const count = computed(() => items.value.filter(e => e.kind === 'rdv' || e.kind === 'app').length)

const canPublish = (e: AgendaItem) => isToday.value && e.b - earliestIn(e.a) >= 30
const isPast = (e: AgendaItem) => isToday.value && e.b <= nowMin.value

// Feuille "Proposer en Konyéla"
const gap = ref<AgendaItem | null>(null)
const sid = ref('')
const time = ref<number | null>(null)
const disc = ref(30)
const sending = ref(false)
const first = computed(() => (gap.value ? earliestIn(gap.value.a) : 0))
const fitting = computed(() => (gap.value ? p.value.services.filter(s => s.d <= gap.value!.b - first.value) : []))
const chosen = computed(() => p.value.services.find(s => s.id === sid.value))
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
async function publish() {
  if (time.value === null) return
  sending.value = true
  const ok = await publishSlot(sid.value, time.value, disc.value)
  sending.value = false
  toast(ok ? 'Créneau en ligne, visible dans Konyéla' : 'Ce créneau n\'est plus libre')
  gap.value = null
}
</script>

<template>
  <ProGate v-if="needsFiche" />
  <template v-else>
  <ProTabs><h1 class="title">Mon agenda</h1></ProTabs>

  <div class="chips mt24">
    <button v-for="d in days" :key="d" class="chip" :aria-pressed="date === d" @click="date = d">{{ dayChip(d, today) }}</button>
  </div>

  <p class="meta mt16">{{ closed ? 'Jour de repos.' : count ? `${count} rendez-vous` : 'Aucun rendez-vous pour l\'instant.' }}</p>

  <div v-if="!closed" class="tl mt16">
    <template v-for="e in items" :key="`${e.kind}-${e.a}`">
      <div v-if="e.kind === 'gap'" class="ev gap" :class="{ past: isPast(e) }">
        <time><b>{{ hm(e.a) }}</b><span>{{ hm(e.b) }}</span></time>
        <span class="grow meta">Libre · {{ duration(e.b - e.a) }}</span>
        <button v-if="canPublish(e)" class="btn sm now" @click="open(e)">Proposer en Konyéla</button>
      </div>
      <div v-else-if="e.kind === 'lm'" class="ev lm">
        <time><b>{{ hm(e.a) }}</b><span>{{ hm(e.b) }}</span></time>
        <div class="grow col gap4"><span class="name">{{ e.what }}</span><span class="meta">En ligne sur Konyéla · -{{ e.disc }} %</span></div>
        <button class="btn sm line" @click="removeSlot(e.id!)">Retirer</button>
      </div>
      <div v-else class="ev" :class="{ past: isPast(e) && e.kind !== 'app' }">
        <time><b>{{ hm(e.a) }}</b><span>{{ hm(e.b) }}</span></time>
        <div class="grow col gap4">
          <div class="row gap8" style="flex-wrap:wrap">
            <span class="name">{{ e.who }}</span>
            <span v-if="e.kind === 'app'" class="tag accent">via VLADI</span>
            <span v-if="e.mode === 'lm'" class="tag now">Konyéla</span>
          </div>
          <span class="meta">{{ e.what }} · {{ euro(e.price ?? 0) }}<template v-if="e.kind === 'app' && RULES.onlinePayment"> · acompte {{ euro(e.deposit ?? 0) }}</template></span>
          <span v-if="e.kind === 'app'" class="meta">{{ e.place === 'client' ? `À domicile : ${e.address}` : 'Chez toi' }}</span>
          <span v-if="e.note" class="meta">« {{ e.note }} »</span>
          <a v-if="e.phone" class="link meta" :href="`tel:${e.phone.replace(/\s/g, '')}`"><Phone :size="13" style="vertical-align:-2px" /> {{ e.phone }}</a>
        </div>
        <ArrivalBox v-if="e.kind === 'app' && e.bookingId && findBooking(e.bookingId)" :booking="findBooking(e.bookingId)!" side="pro" />
      </div>
    </template>
  </div>
  <p v-if="isToday && !closed" class="tiny mt24">Un trou dans la journée ? Propose-le en Konyéla avec une remise : les personnes autour de toi le voient tout de suite.</p>

  <BottomSheet v-if="gap" @close="gap = null">
    <h2 class="h2">Proposer en Konyéla</h2>
    <p class="meta">Créneau libre de {{ hm(first) }} à {{ hm(gap.b) }}.</p>
    <template v-if="fitting.length && chosen">
      <span class="h3">Prestation</span>
      <div class="chips">
        <button v-for="s in fitting" :key="s.id" class="chip" :aria-pressed="sid === s.id" @click="sid = s.id; time = null">{{ s.n }}</button>
      </div>
      <span class="h3">Heure de début</span>
      <div class="chips">
        <button v-for="t in startOptions" :key="t" class="chip" :aria-pressed="time === t" @click="time = t">{{ hm(t) }}</button>
      </div>
      <span class="h3">Remise</span>
      <div class="chips">
        <button v-for="n in [20, 30, 40]" :key="n" class="chip" :aria-pressed="disc === n" @click="disc = n">-{{ n }} %</button>
      </div>
      <div class="box"><div class="kv"><span>Prix affiché</span><span><span class="strike">{{ euro(chosen.p) }}</span> {{ euro(discounted(chosen, disc)) }}</span></div></div>
      <button class="btn block now" :disabled="sending" @click="publish">Mettre en ligne</button>
    </template>
    <p v-else class="meta">Ce créneau est trop court pour une de tes prestations.</p>
    <button class="btn block line" @click="gap = null">Annuler</button>
  </BottomSheet>
  </template>
</template>
