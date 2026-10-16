<script setup lang="ts">
// Réglages : couleurs de l'appli pour tout le monde. En mode présentation (lien ?demo=1), outils pour faire une démonstration.
const emit = defineEmits<{ close: [] }>()
const { state, nowMin, setSim, reset, toast } = useVladi()
const current = computed(() => CHARTES.find(c => c.id === state.charte) ?? CHARTES[0])
function doReset() {
  reset()
  toast('Démonstration remise à zéro')
}
function stopDemo() {
  state.demo = false
  setSim(null)
  toast('Mode présentation désactivé')
  emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <h2 class="h2">Réglages</h2>
    <section class="col gap12">
      <div class="col gap4">
        <span class="h3">Couleurs de l'appli</span>
        <span class="meta">{{ current.mood }}.</span>
      </div>
      <div class="swatches">
        <button v-for="c in CHARTES" :key="c.id" class="swatch" :aria-pressed="state.charte === c.id" @click="state.charte = c.id">
          <span class="disc"><i :style="{ background: c.colors[0] }" /><i :style="{ background: c.colors[1] }" /><i :style="{ background: c.colors[2] }" /></span>
          {{ c.name }}
        </button>
      </div>
    </section>
    <template v-if="state.demo">
      <hr class="hr">
      <section class="col gap12">
        <div class="col gap4">
          <span class="h3">Mode présentation</span>
          <span class="meta">Des établissements de démonstration s'affichent à côté des vrais. Il est {{ hm(nowMin) }} en Guadeloupe{{ state.sim === null ? '' : ' (heure de présentation)' }}.</span>
        </div>
        <div class="row wrap gap8">
          <button class="btn sm soft" @click="setSim(null)">Heure réelle</button>
          <button class="btn sm soft" @click="setSim(10 * 60 + 20)">10h20</button>
          <button class="btn sm soft" @click="setSim(nowMin + 30)">+30 min</button>
        </div>
        <label class="switch"><span>Afficher un prochain rendez-vous</span><input id="demo-rdv" :checked="!state.demoNoRdv" type="checkbox" @change="state.demoNoRdv = !($event.target as HTMLInputElement).checked"></label>
        <div class="row wrap gap8">
          <button class="btn sm line" @click="doReset">Remettre à zéro</button>
          <button class="btn sm line" @click="stopDemo">Quitter le mode présentation</button>
        </div>
      </section>
    </template>
    <button class="btn block" @click="emit('close')">Fermer</button>
  </BottomSheet>
</template>
