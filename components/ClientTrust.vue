<script setup lang="ts">
import { Ban, ShieldCheck, TriangleAlert } from 'lucide-vue-next'
import type { Booking } from '~/composables/useVladi'
import type { Reliability } from '~/utils/reliability'

// Fiabilité de la personne qui a réservé, visible par le prestataire seulement, et blocage.
const props = defineProps<{ booking: Booking }>()
const { reliabilityFor, blocked, setBlocked } = useVladi()
const r = ref<Reliability | null>(null)
watch(() => props.booking.id, async () => { r.value = await reliabilityFor(props.booking) }, { immediate: true })
const isBlocked = computed(() => !!props.booking.clientId && blocked.value.includes(props.booking.clientId))
const asking = ref(false)
async function block() {
  if (!props.booking.clientId) return
  await setBlocked(props.booking.clientId, true)
  asking.value = false
}
</script>

<template>
  <div v-if="booking.real" class="trust">
    <span v-if="r" class="trust-line" :class="{ care: needsCare(r) }">
      <component :is="needsCare(r) ? TriangleAlert : ShieldCheck" :size="14" />{{ reliabilityText(r) }}
    </span>
    <button v-if="booking.clientId && !isBlocked" type="button" class="trust-btn" @click="asking = true"><Ban :size="13" />{{ t('Bloquer') }}</button>
    <span v-else-if="isBlocked" class="tiny">{{ t('Bloqué·e chez toi') }}</span>
    <BottomSheet v-if="asking" @close="asking = false">
      <div class="col gap16" style="padding:0 var(--gutter, 20px) 20px">
        <p class="h3" style="margin:0">{{ t('Bloquer {name} ?', { name: booking.clientName || t('cette personne') }) }}</p>
        <p>{{ t('Elle ne pourra plus réserver chez toi. Ses rendez-vous déjà pris restent valables : annule-les si besoin. Elle n\'est pas prévenue et rien n\'est visible ailleurs sur VLADI. Tu peux lever le blocage depuis Mon activité.') }}</p>
        <button type="button" class="btn block" @click="block">{{ t('Bloquer') }}</button>
        <button type="button" class="btn block line" @click="asking = false">{{ t('Annuler') }}</button>
      </div>
    </BottomSheet>
  </div>
</template>
