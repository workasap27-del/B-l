<script setup lang="ts">
// Signalement d'une fiche ou d'un avis : la raison est transmise aux propriétaires de l'appli.
const props = defineProps<{ proId?: string, reviewId?: string }>()
const emit = defineEmits<{ close: [] }>()
const { reportContent, account } = useVladi()
const REASONS = props.reviewId
  ? [tr('Avis faux ou mensonger'), tr('Propos injurieux ou discriminants'), tr('Informations personnelles'), tr('Autre')]
  : [tr('Prestataire introuvable ou fermé'), tr('Informations fausses'), tr('Contenu choquant'), tr('Activité non déclarée ou illégale'), tr('Autre')]
const choice = ref('')
const details = ref('')
const busy = ref(false)
const error = ref('')
async function send() {
  error.value = translate('')
  const reason = [choice.value, details.value.trim()].filter(Boolean).join(' : ')
  if (!choice.value) return (error.value = translate('Choisis une raison.'))
  if (reason.length < 5) return (error.value = translate('Précise un peu la raison.'))
  busy.value = true
  const ok = await reportContent({ proId: props.proId, reviewId: props.reviewId, reason })
  busy.value = false
  if (ok) emit('close')
}
</script>

<template>
  <BottomSheet @close="emit('close')">
    <div class="col gap16" style="padding:0 var(--gutter, 20px) 20px">
      <p class="h3" style="margin:0">{{ reviewId ? t('Signaler cet avis') : t('Signaler cette fiche') }}</p>
      <template v-if="account">
        <div class="col gap8">
          <label v-for="r in REASONS" :key="r" class="radio-row"><input v-model="choice" type="radio" name="reason" :value="r">{{ t(r) }}</label>
        </div>
        <label class="field" for="rep-d"><span>{{ t('Précisions') }} <span class="help">{{ t('(facultatif)') }}</span></span>
          <textarea id="rep-d" v-model="details" class="input" rows="3" maxlength="800" /></label>
        <p v-if="error" class="error">{{ error }}</p>
        <button class="btn block" type="button" :disabled="busy" @click="send">{{ busy ? t('Envoi…') : t('Envoyer le signalement') }}</button>
        <p class="tiny">{{ t('Les signalements sont lus par l\'équipe VLADI. Ils restent confidentiels.') }}</p>
      </template>
      <template v-else>
        <p>{{ t('Connecte-toi pour signaler un contenu. Cela évite les signalements abusifs.') }}</p>
        <NuxtLink class="btn block" to="/connexion">{{ t('Se connecter') }}</NuxtLink>
      </template>
    </div>
  </BottomSheet>
</template>
