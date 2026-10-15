<script setup lang="ts">
// Réglages : charte graphique en test, fiches d'exemple, heure simulée. Le choix de la charte disparaîtra une fois décidé.
const emit = defineEmits<{ close: [] }>()
const { state, nowMin, setSim, reset, toast } = useVladi()
const current = computed(() => CHARTES.find(c => c.id === state.charte) ?? CHARTES[0])
function doReset() {
  reset()
  toast('Données d\'exemple remises à zéro')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <h2 class="h2">Réglages</h2>
    <section class="col gap12">
      <div class="col gap4">
        <span class="h3">Charte graphique</span>
        <span class="meta">En test : seules les couleurs changent. {{ current.mood }}.</span>
      </div>
      <div class="swatches">
        <button v-for="c in CHARTES" :key="c.id" class="swatch" :aria-pressed="state.charte === c.id" @click="state.charte = c.id">
          <span class="disc"><i :style="{ background: c.colors[0] }" /><i :style="{ background: c.colors[1] }" /><i :style="{ background: c.colors[2] }" /></span>
          {{ c.name }}
        </button>
      </div>
    </section>
    <hr class="hr">
    <label class="switch">
      <span class="col gap4"><span>Afficher les fiches d'exemple</span><span class="tiny">Prestataires fictifs, pour tester l'appli.</span></span>
      <input id="show-demo" v-model="state.showDemo" type="checkbox">
    </label>
    <hr class="hr">
    <section class="col gap12">
      <div class="col gap4">
        <span class="h3">Heure utilisée</span>
        <span class="meta">{{ hm(nowMin) }} en Guadeloupe{{ state.sim === null ? '' : ' (simulée)' }}. Utile pour tester la dernière minute quand tout est fermé.</span>
      </div>
      <div class="row wrap gap8">
        <button class="btn sm soft" @click="setSim(null)">Heure réelle</button>
        <button class="btn sm soft" @click="setSim(10 * 60 + 20)">Simuler 10h20</button>
        <button class="btn sm soft" @click="setSim(nowMin + 30)">+30 min</button>
      </div>
      <button class="textbtn" style="align-self:flex-start" @click="doReset">Remettre les données d'exemple à zéro</button>
    </section>
    <button class="btn block" @click="emit('close')">Fermer</button>
  </BottomSheet>
</template>
