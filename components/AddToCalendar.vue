<script setup lang="ts">
import { CalendarPlus } from 'lucide-vue-next'
import type { Booking } from '~/composables/useVladi'

// Bouton « Ajouter à mon agenda » : fichier pour l'agenda du téléphone, ou Google Agenda.
const props = defineProps<{ booking: Booking }>()
const { pro, service, placeLabel } = useVladi()
const open = ref(false)
const event = computed(() => {
  const p = pro(props.booking.proId)!
  const s = service(p, props.booking.sid)
  return {
    id: props.booking.id,
    title: `${s?.n ?? 'Rendez-vous'}, ${p.name}`,
    date: props.booking.date,
    time: props.booking.time,
    dur: props.booking.dur,
    place: props.booking.place === 'client' ? props.booking.address ?? 'À domicile' : `${p.quartier ? `${p.quartier}, ` : ''}${p.commune}`,
    details: `${placeLabel(props.booking)}. Réservé sur VLADI : ${window.location.origin}/rdv`,
  }
})
function ics() {
  downloadIcs(event.value)
  open.value = false
}
</script>

<template>
  <button type="button" class="btn sm soft" @click="open = true"><CalendarPlus :size="15" />{{ t('Ajouter à mon agenda') }}</button>
  <BottomSheet v-if="open" @close="open = false">
    <div class="share-sheet">
      <p class="h3">{{ t('Ajouter à mon agenda') }}</p>
      <button type="button" class="share-row" @click="ics"><span class="srch-ico sm"><CalendarPlus :size="18" /></span>{{ t('Agenda du téléphone (Apple, Outlook…)') }}</button>
      <a class="share-row" :href="googleCalendarUrl(event)" target="_blank" rel="noopener" @click="open = false"><span class="srch-ico sm"><CalendarPlus :size="18" /></span>{{ t('Google Agenda') }}</a>
    </div>
  </BottomSheet>
</template>
