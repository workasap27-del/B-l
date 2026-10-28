<script setup lang="ts">
import * as api from '~/composables/useBackend'
import { passwordError } from '~/utils/password'
import { ChevronLeft, Eye, EyeOff, Scissors, Sparkles } from 'lucide-vue-next'

useHead({ title: 'Connexion · VLADI' })

const route = useRoute()
const router = useRouter()
const { register, login, forgotPassword, account, remote, toast } = useVladi()

const mode = ref<'connexion' | 'inscription'>(route.query.mode === 'inscription' ? 'inscription' : 'connexion')
const role = ref<'client' | 'pro'>(route.query.role === 'pro' ? 'pro' : 'client')
const name = ref('')
const phone = ref('')
const email = ref('')
const password = ref('')
const show = ref(false)
const busy = ref(false)
const error = ref('')
const info = ref('')
const retour = computed(() => (typeof route.query.retour === 'string' && route.query.retour.startsWith('/') ? route.query.retour : ''))

function next() {
  if (retour.value) router.replace(retour.value)
  else if (role.value === 'pro' && mode.value === 'inscription') router.replace('/espace-pro/fiche')
  else router.replace('/profil')
}
// Déjà connecté : pas besoin de rester ici.
watch(account, (a) => { if (a && !busy.value) next() }, { immediate: true })

// Vérification anti-robots (si elle est configurée).
const captcha = ref('')
const captchaBox = ref<{ reset: () => void } | null>(null)

async function submit() {
  error.value = translate('')
  info.value = translate('')
  if (!/^\S+@\S+\.\S+$/.test(email.value.trim())) return (error.value = translate('Indique une adresse e-mail valide.'))
  if (mode.value === 'inscription') {
    const weak = passwordError(password.value, email.value)
    if (weak) return (error.value = weak)
  }
  else if (!password.value) return (error.value = translate('Indique ton mot de passe.'))
  if (mode.value === 'inscription' && name.value.trim().length < 2) return (error.value = translate('Indique ton prénom.'))
  busy.value = true
  const e = mode.value === 'inscription'
    ? await register({ email: email.value, password: password.value, name: name.value, role: role.value, phone: phone.value, captcha: captcha.value })
    : await login(email.value, password.value, captcha.value)
  busy.value = false
  // Un jeton anti-robots ne sert qu'une fois.
  captchaBox.value?.reset()
  if (e) return (error.value = e)
  toast(mode.value === 'inscription' ? translate('Compte créé, bienvenue !') : translate('Te revoilà !'))
  next()
}
async function forgot() {
  error.value = translate('')
  if (!/^\S+@\S+\.\S+$/.test(email.value.trim())) return (error.value = translate('Indique ton e-mail ci-dessus, puis appuie à nouveau.'))
  const e = await forgotPassword(email.value, captcha.value)
  captchaBox.value?.reset()
  if (e) error.value = e
  else info.value = translate('Si un compte existe, un e-mail de réinitialisation vient d\'être envoyé.')
}
// Connexion avec Google ou Apple, si elle est configurée.
const providers = String(useRuntimeConfig().public.oauthProviders ?? '').split(',').map(x => x.trim()).filter((x): x is 'google' | 'apple' => x === 'google' || x === 'apple')
async function oauth(p: 'google' | 'apple') {
  error.value = translate('')
  try {
    await api.signInWith(p, String(route.query.retour ?? '/'))
  }
  catch (e) {
    error.value = api.readable(e)
  }
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
</script>

<template>
  <div class="head">
    <button class="icon-btn" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="24" /></button>
  </div>

  <div v-if="!remote.online && !remote.loading" class="notice mt16">{{ t('La connexion aux comptes n\'est pas disponible pour le moment.') }}</div>

  <div class="col gap8 mt16">
    <h1 class="title">{{ mode === 'inscription' ? t('Créer un compte') : t('Se connecter') }}</h1>
    <p class="meta">{{ mode === 'inscription' ? t('Gratuit, en une minute.') : t('Avec l\'e-mail utilisé à l\'inscription.') }}</p>
  </div>

  <div v-if="providers.length && role !== 'pro'" class="col gap8 mt24">
    <button v-for="p in providers" :key="p" type="button" class="btn block line" @click="oauth(p)">{{ t('Continuer avec {name}', { name: p === 'google' ? 'Google' : 'Apple' }) }}</button>
    <p class="tiny" style="text-align:center">{{ t('ou avec ton e-mail') }}</p>
  </div>

  <div class="seg mt24">
    <button :aria-pressed="mode === 'connexion'" @click="mode = 'connexion'; error = ''">{{ t('Connexion') }}</button>
    <button :aria-pressed="mode === 'inscription'" @click="mode = 'inscription'; error = ''">{{ t('Inscription') }}</button>
  </div>

  <form class="col gap16 mt24" novalidate @submit.prevent="submit">
    <template v-if="mode === 'inscription'">
      <div class="col gap8">
        <span class="h3">{{ t('Ton profil') }}</span>
        <div class="choice">
          <button type="button" :aria-pressed="role === 'client'" @click="role = 'client'">
            <Sparkles :size="22" /><span class="grow col gap4"><span class="name">{{ t('Je réserve') }}</span><span class="meta">{{ t('Je cherche des prestations') }}</span></span><span class="radio" />
          </button>
          <button type="button" :aria-pressed="role === 'pro'" @click="role = 'pro'">
            <Scissors :size="22" /><span class="grow col gap4"><span class="name">{{ t('Je propose mes services') }}</span><span class="meta">{{ t('Je suis prestataire (SIREN demandé)') }}</span></span><span class="radio" />
          </button>
        </div>
      </div>
      <label class="field" for="a-name"><span>{{ t('Prénom') }}</span><input id="a-name" v-model="name" class="input" autocomplete="given-name" :placeholder="t('Ton prénom')"></label>
      <label class="field" for="a-phone"><span>{{ t('Téléphone') }} <span class="help">{{ t('(facultatif)') }}</span></span><input id="a-phone" v-model="phone" class="input" type="tel" autocomplete="tel" placeholder="0690 00 00 00"></label>
    </template>
    <label class="field" for="a-email"><span>{{ t('E-mail') }}</span><input id="a-email" v-model="email" class="input" type="email" autocomplete="email" inputmode="email" :placeholder="t('prenom@mail.com')"></label>
    <label class="field" for="a-pass">
      <span>{{ t('Mot de passe') }}</span>
      <div style="position:relative">
        <input id="a-pass" v-model="password" class="input" :type="show ? 'text' : 'password'" :autocomplete="mode === 'inscription' ? 'new-password' : 'current-password'" :placeholder="mode === 'inscription' ? '12 caractères minimum' : ''" style="padding-right:52px">
        <button type="button" class="icon-btn" style="position:absolute;right:4px;top:5px" :aria-label="show ? t('Masquer le mot de passe') : t('Afficher le mot de passe')" @click="show = !show">
          <component :is="show ? EyeOff : Eye" :size="19" />
        </button>
      </div>
    </label>
    <PasswordRules v-if="mode === 'inscription' && password" :value="password" :email="email" />
    <TurnstileBox ref="captchaBox" @token="tok => (captcha = tok)" />
    <p v-if="error" class="error">{{ error }}</p>
    <p v-if="info" class="notice">{{ info }}</p>
    <button class="btn block" type="submit" :disabled="busy || !remote.online">{{ busy ? t('Un instant…') : mode === 'inscription' ? t('Créer mon compte') : t('Se connecter') }}</button>
    <button v-if="mode === 'connexion'" type="button" class="textbtn" style="align-self:center" @click="forgot">{{ t('Mot de passe oublié ?') }}</button>
  </form>

  <p v-if="mode === 'inscription' && role === 'client'" class="tiny mt24">
    {{ t('En créant ton compte, tu acceptes les') }} <NuxtLink class="link" to="/cgu">{{ t('conditions générales d\'utilisation') }}</NuxtLink> {{ t('et la') }} <NuxtLink class="link" to="/confidentialite">{{ t('politique de confidentialité') }}</NuxtLink>{{ t('. Ton prénom et ton téléphone sont transmis uniquement aux prestataires chez qui tu réserves.') }}
  </p>
  <p v-else-if="mode === 'inscription'" class="tiny mt24">
    {{ t('En créant ton compte, tu acceptes les') }} <NuxtLink class="link" to="/cgu">{{ t('conditions générales d\'utilisation') }}</NuxtLink>{{ t(', dont les') }} <NuxtLink class="link" to="/cgu#prestataires">{{ t('engagements des prestataires') }}</NuxtLink>{{ t(', et la') }} <NuxtLink class="link" to="/confidentialite">{{ t('politique de confidentialité') }}</NuxtLink>{{ t('. Les informations de ta fiche (nom commercial, commune, prestations, tarifs, horaires) seront publiques.') }}
  </p>
</template>
