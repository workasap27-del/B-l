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
const other = computed(() => translate(props.side === 'client' ? 'Le/la prestataire' : 'Le/la client·e'))
const limit = computed(() => hm(props.booking.waitUntil ?? props.booking.time + TOLERANCE))
const lateOpen = ref(false)

async function late(m: number) {
  lateOpen.value = false
  if (await announceLate(props.booking.id, m)) toast(translate('Retard de {n} min signalé', { n: m }))
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
        <p v-if="st === 'attendu'" ><Clock :size="15" /> {{ t('Rendez-vous à {time}. Signale-toi en arrivant.', { time: hm(booking.time) }) }}</p>
        <p v-else-if="st === 'retard_annonce'" ><Hourglass :size="15" /> {{ t('Retard de {n} min signalé. On t\'attend jusqu\'à {time}.', { n: booking.lateBy, time: limit }) }}</p>
        <p v-else-if="st === 'en_retard'" class="warn"><Hourglass :size="15" /> {{ t('C\'est l\'heure. Tu as jusqu\'à {time} pour arriver.', { time: limit }) }}</p>
        <p v-else class="warn"><TriangleAlert :size="15" /> {{ t('Le délai de {n} min est dépassé : {who} peut déclarer une absence.', { n: TOLERANCE, who: other.toLowerCase() }) }}</p>
        <div class="row wrap gap8">
          <button class="btn sm" @click="act(signalArrival, 'Arrivée signalée')"><MapPinCheck :size="15" />{{ t('Je suis arrivé·e') }}</button>
          <button v-if="!booking.lateBy && st !== 'depasse'" class="btn sm line" @click="lateOpen = !lateOpen">{{ t('J\'aurai du retard') }}</button>
        </div>
        <div v-if="lateOpen" class="row wrap" style="gap:8px">
          <span class="tiny">{{ t('Combien ?') }}</span>
          <button v-for="m in [5, 10, 15]" :key="m" class="chip" @click="late(m)">{{ m }} min</button>
          <span class="tiny">{{ t('Au-delà de {n} min, annule ou reporte.', { n: TOLERANCE }) }}</span>
        </div>
      </template>
      <p v-else-if="st === 'a_confirmer'" ><Clock :size="15" /> {{ t('Arrivée signalée à {time}, en attente de confirmation.', { time: hm(booking.arrivedAt!) }) }}</p>
    </template>

    <!-- Celui qui attend -->
    <template v-else>
      <p v-if="st === 'attendu'" ><Clock :size="15" /> {{ t('{who} est attendu·e à {time}.', { who: other, time: hm(booking.time) }) }}</p>
      <p v-else-if="st === 'retard_annonce'" ><Hourglass :size="15" /> {{ t('{who} a signalé {n} min de retard. Attente jusqu\'à {time}.', { who: other, n: booking.lateBy, time: limit }) }}</p>
      <p v-else-if="st === 'en_retard'" class="warn"><Hourglass :size="15" /> {{ t('Pas encore là. Attente prévue jusqu\'à {time}.', { time: limit }) }}</p>
      <template v-else-if="st === 'depasse'">
        <p class="warn"><TriangleAlert :size="15" /> {{ t('{who} n\'est pas arrivé·e et le délai est dépassé.', { who: other }) }}</p>
        <div class="row wrap gap8">
          <button class="btn sm line" @click="act(waitMore, translate('Attente prolongée de {n} min', { n: TOLERANCE }))">{{ t('Attendre {n} min de plus', { n: TOLERANCE }) }}</button>
          <button class="btn sm soft" @click="act(declareNoShow, 'Absence déclarée')">{{ t('Déclarer une absence') }}</button>
        </div>
      </template>
      <template v-else-if="st === 'a_confirmer'">
        <p ><MapPinCheck :size="15" /> {{ t('{who} indique être arrivé·e à {time}.', { who: other, time: hm(booking.arrivedAt!) }) }}</p>
        <div class="row wrap gap8">
          <button class="btn sm" @click="act(confirmArrival, 'Arrivée confirmée')"><CircleCheck :size="15" />{{ t('Confirmer') }}</button>
          <button class="btn sm line" @click="act(dispute, 'Désaccord transmis au service client')">{{ t('Pas arrivé·e') }}</button>
        </div>
      </template>
    </template>

    <!-- Communs -->
    <p v-if="st === 'arrive'" class="ok"><CircleCheck :size="15" /> {{ t('Arrivée confirmée à {time}.', { time: hm(booking.confirmedAt!) }) }}</p>
    <template v-if="st === 'absent'">
      <p class="warn"><TriangleAlert :size="15" />
        <template v-if="booking.noShow === 'client'">{{ t('Absence du/de la client·e déclarée.') }}{{ RULES.onlinePayment ? t(' L\'acompte revient au/à la prestataire.') : '' }}</template>
        <template v-else>{{ t('Absence du/de la prestataire déclarée.') }}{{ RULES.onlinePayment ? t(' L\'acompte est remboursé.') : '' }}</template>
      </p>
      <button v-if="(booking.noShow === 'client') === (side === 'client')" class="btn sm line" @click="act(dispute, 'Contestation transmise au service client')">{{ t('Contester') }}</button>
    </template>
    <p v-if="st === 'litige'" class="warn"><TriangleAlert :size="15" /> {{ t('Désaccord signalé. Le service client contacte les deux parties sous {n} h', { n: DISPUTE_HOURS }) }}{{ RULES.onlinePayment ? t(' ; l\'acompte est bloqué d\'ici là') : '' }}.</p>
  </div>
</template>
