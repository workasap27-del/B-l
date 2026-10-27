<script setup lang="ts">
// Signalement d'une fiche ou d'un avis : la raison est transmise aux propriétaires de l'appli.
const props = defineProps<{ proId?: string, reviewId?: string }>()
const emit = defineEmits<{ close: [] }>()
const { reportContent, account } = useVladi()
const REASONS = props.reviewId
  ? ['Avis faux ou mensonger', 'Propos injurieux ou discriminants', 'Informations personnelles', 'Autre']
  : ['Prestataire introuvable ou fermé', 'Informations fausses', 'Contenu choquant', 'Activité non déclarée ou illégale', 'Autre']
const choice = ref('')
const details = ref('')
const busy = ref(false)
const error = ref('')
async function send() {
  error.value = ''
  const reason = [choice.value, details.value.trim()].filter(Boolean).join(' : ')
  if (!choice.value) return (error.value = 'Choisis une raison.')
  if (reason.length < 5) return (error.value = 'Précise un peu la raison.')
  busy.value = true
  const ok = await reportContent({ proId: props.proId, reviewId: props.reviewId, reason })
  busy.value = false
  if (ok) emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <div class="col gap16" style="padding:0 var(--gutter, 20px) 20px">
      <p class="h3" style="margin:0">{{ reviewId ? 'Signaler cet avis' : 'Signaler cette fiche' }}</p>
      <template v-if="account">
        <div class="col gap8">
          <label v-for="r in REASONS" :key="r" class="radio-row"><input v-model="choice" type="radio" name="reason" :value="r">{{ r }}</label>
        </div>
        <label class="field" for="rep-d"><span>Précisions <span class="help">(facultatif)</span></span>
          <textarea id="rep-d" v-model="details" class="input" rows="3" maxlength="800" /></label>
        <p v-if="error" class="error">{{ error }}</p>
        <button class="btn block" type="button" :disabled="busy" @click="send">{{ busy ? 'Envoi…' : 'Envoyer le signalement' }}</button>
        <p class="tiny">Les signalements sont lus par l'équipe VLADI. Ils restent confidentiels.</p>
      </template>
      <template v-else>
        <p>Connecte-toi pour signaler un contenu. Cela évite les signalements abusifs.</p>
        <NuxtLink class="btn block" to="/connexion">Se connecter</NuxtLink>
      </template>
    </div>
  </BottomSheet>
</template>
