<script setup lang="ts">
import { passwordError } from '~/utils/password'
const router = useRouter()
const { newPassword, account, toast } = useVladi()
const pass = ref('')
const again = ref('')
const error = ref('')
const busy = ref(false)

async function submit() {
  error.value = ''
  const weak = passwordError(pass.value, account.value?.email ?? '')
  if (weak) return (error.value = weak)
  if (pass.value !== again.value) return (error.value = 'Les deux mots de passe ne sont pas identiques.')
  busy.value = true
  const e = await newPassword(pass.value)
  busy.value = false
  if (e) return (error.value = e)
  toast('Mot de passe modifié')
  router.replace('/profil')
}
</script>

<template>
  <div class="col gap8 mt16">
    <h1 class="title">Nouveau mot de passe</h1>
    <p class="meta">{{ account ? `Choisis un nouveau mot de passe pour ${account.email}.` : 'Ouvre d\'abord le lien reçu par e-mail pour choisir un nouveau mot de passe.' }}</p>
  </div>
  <form v-if="account" class="col gap16 mt24" novalidate @submit.prevent="submit">
    <label class="field" for="np1"><span>Nouveau mot de passe</span><input id="np1" v-model="pass" class="input" type="password" autocomplete="new-password" placeholder="12 caractères minimum"></label>
    <PasswordRules v-if="pass" :value="pass" :email="account.email" />
    <label class="field" for="np2"><span>Encore une fois</span><input id="np2" v-model="again" class="input" type="password" autocomplete="new-password"></label>
    <p v-if="error" class="error">{{ error }}</p>
    <button class="btn block" type="submit" :disabled="busy">{{ busy ? 'Un instant…' : 'Enregistrer' }}</button>
  </form>
  <NuxtLink v-else class="btn block line mt24" to="/connexion">Retour à la connexion</NuxtLink>
</template>
