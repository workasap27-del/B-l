<script setup lang="ts">
import { CircleCheck, Clock, Hourglass, MapPinCheck, TriangleAlert } from 'lucide-vue-next'
import type { Booking } from '~/composables/useVladi'
import { DISPUTE_HOURS, TOLERANCE } from '~/utils/arrival'
import { RULES } from '~/data/pros'

// Le jour du rendez-vous : celui qui se déplace signale son arrivée ou son retard, l'autre confirme ou déclare une absence.
const props = defineProps<{ booking: Booking, side: 'client' | 'pro' }>()
const { arrival, traveler, signalArrival, confirmArrival, announceLate, waitMore, declareNoShow, dispute, toast } = useVladi()

const st = computed(() => arrival(props.booking))
const iTravel = computed(() => traveler(props.booking) === props.side)
const other = computed(() => (props.side === 'client' ? 'Le/la prestataire' : 'Le/la client·e'))
const limit = computed(() => hm(props.booking.waitUntil ?? props.booking.time + TOLERANCE))
const lateOpen = ref(false)

async function late(m: number) {
  lateOpen.value = false
  if (await announceLate(props.booking.id, m)) toast(`Retard de ${m} min signalé`)
}
async function act(fn: (id: string) => unknown, msg: string) {
  if ((await fn(props.booking.id)) !== false) toast(msg)
}
</script>

<template>
  <div v-if="st !== 'hors' && st !== 'avant'" class="arrival" :class="st">
    <!-- Celui qui se déplace -->
    <template v-if="iTravel">
      <template v-if="['attendu', 'retard_annonce', 'en_retard', 'depasse'].includes(st)">
        <p v-if="st === 'attendu'" ><Clock :size="15" /> Rendez-vous à {{ hm(booking.time) }}. Signale-toi en arrivant.</p>
        <p v-else-if="st === 'retard_annonce'" ><Hourglass :size="15" /> Retard de {{ booking.lateBy }} min signalé. On t'attend jusqu'à {{ limit }}.</p>
        <p v-else-if="st === 'en_retard'" class="warn"><Hourglass :size="15" /> C'est l'heure. Tu as jusqu'à {{ limit }} pour arriver.</p>
        <p v-else class="warn"><TriangleAlert :size="15" /> Le délai de {{ TOLERANCE }} min est dépassé : {{ other.toLowerCase() }} peut déclarer une absence.</p>
        <div class="row wrap gap8">
          <button class="btn sm" @click="act(signalArrival, 'Arrivée signalée')"><MapPinCheck :size="15" />Je suis arrivé{{ side === 'client' ? 'e' : '' }}</button>
          <button v-if="!booking.lateBy && st !== 'depasse'" class="btn sm line" @click="lateOpen = !lateOpen">J'aurai du retard</button>
        </div>
        <div v-if="lateOpen" class="row wrap" style="gap:8px">
          <span class="tiny">Combien ?</span>
          <button v-for="m in [5, 10, 15]" :key="m" class="chip" @click="late(m)">{{ m }} min</button>
          <span class="tiny">Au-delà de {{ TOLERANCE }} min, annule ou reporte.</span>
        </div>
      </template>
      <p v-else-if="st === 'a_confirmer'" ><Clock :size="15" /> Arrivée signalée à {{ hm(booking.arrivedAt!) }}, en attente de confirmation.</p>
    </template>

    <!-- Celui qui attend -->
    <template v-else>
      <p v-if="st === 'attendu'" ><Clock :size="15" /> {{ other }} est attendu{{ side === 'pro' ? 'e' : '' }} à {{ hm(booking.time) }}.</p>
      <p v-else-if="st === 'retard_annonce'" ><Hourglass :size="15" /> {{ other }} a signalé {{ booking.lateBy }} min de retard. Attente jusqu'à {{ limit }}.</p>
      <p v-else-if="st === 'en_retard'" class="warn"><Hourglass :size="15" /> Pas encore là. Attente prévue jusqu'à {{ limit }}.</p>
      <template v-else-if="st === 'depasse'">
        <p class="warn"><TriangleAlert :size="15" /> {{ other }} n'est pas arrivé{{ side === 'pro' ? 'e' : '' }} et le délai est dépassé.</p>
        <div class="row wrap gap8">
          <button class="btn sm line" @click="act(waitMore, `Attente prolongée de ${TOLERANCE} min`)">Attendre {{ TOLERANCE }} min de plus</button>
          <button class="btn sm soft" @click="act(declareNoShow, 'Absence déclarée')">Déclarer une absence</button>
        </div>
      </template>
      <template v-else-if="st === 'a_confirmer'">
        <p ><MapPinCheck :size="15" /> {{ other }} indique être arrivé·e à {{ hm(booking.arrivedAt!) }}.</p>
        <div class="row wrap gap8">
          <button class="btn sm" @click="act(confirmArrival, 'Arrivée confirmée')"><CircleCheck :size="15" />Confirmer</button>
          <button class="btn sm line" @click="act(dispute, 'Désaccord transmis au service client')">Pas arrivé·e</button>
        </div>
      </template>
    </template>

    <!-- Communs -->
    <p v-if="st === 'arrive'" class="ok"><CircleCheck :size="15" /> Arrivée confirmée à {{ hm(booking.confirmedAt!) }}.</p>
    <template v-if="st === 'absent'">
      <p class="warn"><TriangleAlert :size="15" />
        <template v-if="booking.noShow === 'client'">Absence du/de la client·e déclarée.{{ RULES.onlinePayment ? ' L\'acompte revient au/à la prestataire.' : '' }}</template>
        <template v-else>Absence du/de la prestataire déclarée.{{ RULES.onlinePayment ? ' L\'acompte est remboursé.' : '' }}</template>
      </p>
      <button v-if="(booking.noShow === 'client') === (side === 'client')" class="btn sm line" @click="act(dispute, 'Contestation transmise au service client')">Contester</button>
    </template>
    <p v-if="st === 'litige'" class="warn"><TriangleAlert :size="15" /> Désaccord signalé. Le service client contacte les deux parties sous {{ DISPUTE_HOURS }} h{{ RULES.onlinePayment ? ' ; l\'acompte est bloqué d\'ici là' : '' }}.</p>
  </div>
</template>
