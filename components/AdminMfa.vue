<script setup lang="ts">
import { ShieldCheck } from 'lucide-vue-next'
import * as api from '~/composables/useBackend'

// Double authentification du pilotage : première fois, on scanne un QR code ; ensuite, on tape le code de l'appli.
const { refresh, toast } = useVladi()
const factor = ref<{ id: string } | null>(null)
const enroll = ref<{ id: string, qr: string, secret: string } | null>(null)
const code = ref('')
const busy = ref(false)
const error = ref('')
const ready = ref(false)

onMounted(async () => {
  try {
    factor.value = await api.mfaFactor()
  }
  finally {
    ready.value = true
  }
})
async function start() {
  error.value = ''
  busy.value = true
  try {
    enroll.value = await api.mfaEnroll()
  }
  catch (e) {
    error.value = api.readable(e)
  }
  busy.value = false
}
async function verify() {
  const id = factor.value?.id ?? enroll.value?.id
  if (!id) return
  if (!/^\d{6}$/.test(code.value.replace(/\s/g, ''))) return (error.value = 'Le code fait 6 chiffres.')
  error.value = ''
  busy.value = true
  try {
    await api.mfaVerify(id, code.value)
    await refresh()
    toast('Double authentification validée')
  }
  catch (e) {
    error.value = api.readable(e)
  }
  busy.value = false
}
</script>

<template>
  <div class="col gap16 mt24" style="max-width:420px">
    <div class="row gap12"><ShieldCheck :size="28" /><h1 class="title" style="margin:0">Double authentification</h1></div>
    <template v-if="!ready"><p class="meta">Chargement…</p></template>
    <template v-else-if="factor">
      <p>Ouvre ton appli d'authentification (Google Authenticator, Microsoft Authenticator, 1Password…) et tape le code VLADI.</p>
    </template>
    <template v-else-if="!enroll">
      <p>Le pilotage donne accès à toutes les données de l'appli : il est protégé par un code à usage unique, en plus du mot de passe.</p>
      <p class="meta">Installe une appli d'authentification sur ton téléphone (Google Authenticator, Microsoft Authenticator, 1Password…), puis continue.</p>
      <button class="btn block" type="button" :disabled="busy" @click="start">Activer la double authentification</button>
    </template>
    <template v-else>
      <p>Scanne ce QR code avec ton appli d'authentification, puis tape le code à 6 chiffres qu'elle affiche.</p>
      <img :src="enroll.qr" alt="QR code à scanner" width="200" height="200" style="align-self:center;background:#fff;border-radius:12px;padding:8px">
      <p class="tiny">Impossible de scanner ? Saisis cette clé à la main : <code style="word-break:break-all">{{ enroll.secret }}</code></p>
    </template>
    <template v-if="factor || enroll">
      <label class="field" for="mfa-code"><span>Code à 6 chiffres</span><input id="mfa-code" v-model="code" class="input" inputmode="numeric" autocomplete="one-time-code" maxlength="7" @keydown.enter="verify"></label>
      <button class="btn block" type="button" :disabled="busy" @click="verify">{{ busy ? 'Vérification…' : 'Valider' }}</button>
    </template>
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>
