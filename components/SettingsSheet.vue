<script setup lang="ts">
// Réglages : couleurs de l'appli pour tout le monde. En mode présentation (lien ?demo=1), outils pour faire une démonstration.
import { Check } from 'lucide-vue-next'
const emit = defineEmits<{ close: [] }>()
const { state, nowMin, setSim, reset, toast } = useVladi()
const { lang, setLang } = useLang()
const current = computed(() => CHARTES.find(c => c.id === state.charte) ?? CHARTES[0])
const theme = computed(() => themeOf(state.theme))
function pickTheme(id: string) {
  state.theme = id
}
function doReset() {
  reset()
  toast(translate('Démonstration remise à zéro'))
}
function stopDemo() {
  state.demo = false
  setSim(null)
  toast(translate('Mode présentation désactivé'))
  emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <h2 class="h2">{{ t('Réglages') }}</h2>
    <section class="col gap12">
      <span class="h3">{{ t('Langue') }}</span>
      <div class="seg">
        <button :aria-pressed="lang === 'fr'" lang="fr" @click="setLang('fr')">Français</button>
        <button :aria-pressed="lang === 'en'" lang="en" @click="setLang('en')">English</button>
      </div>
    </section>
    <section v-if="state.demo" class="col gap12">
      <div class="col gap4">
        <span class="h3">{{ t('Thème de l\'appli') }}</span>
        <span class="meta">{{ theme.name }} : {{ theme.mood }}.</span>
      </div>
      <div class="themes" role="radiogroup" :aria-label="t('Thème de l\'appli')">
        <button v-for="th in THEMES" :key="th.id" class="theme-opt" role="radio" :aria-checked="state.theme === th.id" :aria-pressed="state.theme === th.id" @click="pickTheme(th.id)">
          <span class="disc"><i :style="{ background: th.colors[0] }" /><i :style="{ background: th.colors[1] }" /><i :style="{ background: th.colors[2] }" /></span>
          <span class="grow name">{{ th.name }}</span>
          <span v-if="state.theme === th.id" class="tag accent"><Check :size="14" />{{ t('Actif') }}</span>
        </button>
      </div>
    </section>
    <section v-else class="col gap12">
      <div class="col gap4">
        <span class="h3">{{ t('Couleurs de l\'appli') }}</span>
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
          <span class="h3">{{ t('Mode présentation') }}</span>
          <span class="meta">Des établissements de démonstration s'affichent à côté des vrais. Il est {{ hm(nowMin) }} en Guadeloupe{{ state.sim === null ? '' : ' (heure de présentation)' }}.</span>
        </div>
        <div class="row wrap gap8">
          <button class="btn sm soft" @click="setSim(null)">{{ t('Heure réelle') }}</button>
          <button class="btn sm soft" @click="setSim(10 * 60 + 20)">10h20</button>
          <button class="btn sm soft" @click="setSim(nowMin + 30)">{{ t('+30 min') }}</button>
        </div>
        <label class="switch"><span>{{ t('Afficher un prochain rendez-vous') }}</span><input id="demo-rdv" :checked="!state.demoNoRdv" type="checkbox" @change="state.demoNoRdv = !($event.target as HTMLInputElement).checked"></label>
        <div class="row wrap gap8">
          <button class="btn sm line" @click="doReset">{{ t('Remettre à zéro') }}</button>
          <button class="btn sm line" @click="stopDemo">{{ t('Quitter le mode présentation') }}</button>
        </div>
      </section>
    </template>
    <button class="btn block" @click="emit('close')">{{ t('Fermer') }}</button>
  </BottomSheet>
</template>
