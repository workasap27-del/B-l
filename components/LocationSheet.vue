<script setup lang="ts">
import { Check, LocateFixed } from 'lucide-vue-next'

// Choix du point de départ des distances : position du téléphone ou commune.
const emit = defineEmits<{ close: [] }>()
const { state, setCommune, locate, toast } = useVladi()
const communes = Object.keys(COMMUNE_COORDS).sort((a, b) => a.localeCompare(b, 'fr'))
const busy = ref(false)

async function useGps() {
  busy.value = true
  const error = await locate()
  busy.value = false
  if (error) toast(error)
  else emit('close')
}
function choose(name: string) {
  setCommune(name)
  emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <h2 class="h2">Où es-tu ?</h2>
    <p class="sub">Les distances et l'ordre des résultats partent de ce point.</p>
    <button class="btn soft block" :disabled="busy" @click="useGps"><LocateFixed :size="18" />{{ busy ? 'Recherche de ta position...' : 'Utiliser ma position' }}</button>
    <div class="optlist">
      <button v-for="c in communes" :key="c" :aria-pressed="!state.pos.gps && state.pos.label === c" @click="choose(c)">
        {{ c }}<Check v-if="!state.pos.gps && state.pos.label === c" :size="18" />
      </button>
    </div>
  </BottomSheet>
</template>
