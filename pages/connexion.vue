<script setup lang="ts">
import { ChevronLeft, Eye, EyeOff, Scissors, Sparkles } from 'lucide-vue-next'

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

async function submit() {
  error.value = ''
  info.value = ''
  if (!/^\S+@\S+\.\S+$/.test(email.value.trim())) return (error.value = 'Indique une adresse e-mail valide.')
  if (password.value.length < 8) return (error.value = 'Le mot de passe doit faire au moins 8 caractères.')
  if (mode.value === 'inscription' && name.value.trim().length < 2) return (error.value = 'Indique ton prénom.')
  busy.value = true
  const e = mode.value === 'inscription'
    ? await register({ email: email.value, password: password.value, name: name.value, role: role.value, phone: phone.value })
    : await login(email.value, password.value)
  busy.value = false
  if (e) return (error.value = e)
  toast(mode.value === 'inscription' ? 'Compte créé, bienvenue !' : 'Te revoilà !')
  next()
}
async function forgot() {
  error.value = ''
  if (!/^\S+@\S+\.\S+$/.test(email.value.trim())) return (error.value = 'Indique ton e-mail ci-dessus, puis appuie à nouveau.')
  const e = await forgotPassword(email.value)
  if (e) error.value = e
  else info.value = 'Si un compte existe, un e-mail de réinitialisation vient d\'être envoyé.'
}
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
</script>

<template>
  <div class="head">
    <button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button>
  </div>

  <div v-if="!remote.online && !remote.loading" class="notice mt16">La connexion aux comptes n'est pas disponible pour le moment.</div>

  <div class="col gap8 mt16">
    <h1 class="title">{{ mode === 'inscription' ? 'Créer un compte' : 'Se connecter' }}</h1>
    <p class="meta">{{ mode === 'inscription' ? 'Gratuit, en une minute.' : 'Avec l\'e-mail utilisé à l\'inscription.' }}</p>
  </div>

  <div class="seg mt24">
    <button :aria-pressed="mode === 'connexion'" @click="mode = 'connexion'; error = ''">Connexion</button>
    <button :aria-pressed="mode === 'inscription'" @click="mode = 'inscription'; error = ''">Inscription</button>
  </div>

  <form class="col gap16 mt24" novalidate @submit.prevent="submit">
    <template v-if="mode === 'inscription'">
      <div class="col gap8">
        <span class="h3">Tu es</span>
        <div class="choice">
          <button type="button" :aria-pressed="role === 'client'" @click="role = 'client'">
            <Sparkles :size="22" /><span class="grow col gap4"><span class="name">Cliente</span><span class="meta">Je réserve des prestations</span></span><span class="radio" />
          </button>
          <button type="button" :aria-pressed="role === 'pro'" @click="role = 'pro'">
            <Scissors :size="22" /><span class="grow col gap4"><span class="name">Professionnelle</span><span class="meta">Je propose mes services (SIREN demandé)</span></span><span class="radio" />
          </button>
        </div>
      </div>
      <label class="field" for="a-name"><span>Prénom</span><input id="a-name" v-model="name" class="input" autocomplete="given-name" placeholder="Ton prénom"></label>
      <label class="field" for="a-phone"><span>Téléphone <span class="help">(facultatif)</span></span><input id="a-phone" v-model="phone" class="input" type="tel" autocomplete="tel" placeholder="0690 00 00 00"></label>
    </template>
    <label class="field" for="a-email"><span>E-mail</span><input id="a-email" v-model="email" class="input" type="email" autocomplete="email" inputmode="email" placeholder="toi@exemple.fr"></label>
    <label class="field" for="a-pass">
      <span>Mot de passe</span>
      <div style="position:relative">
        <input id="a-pass" v-model="password" class="input" :type="show ? 'text' : 'password'" :autocomplete="mode === 'inscription' ? 'new-password' : 'current-password'" placeholder="8 caractères minimum" style="padding-right:52px">
        <button type="button" class="icon-btn" style="position:absolute;right:4px;top:5px" :aria-label="show ? 'Masquer le mot de passe' : 'Afficher le mot de passe'" @click="show = !show">
          <component :is="show ? EyeOff : Eye" :size="19" />
        </button>
      </div>
    </label>
    <p v-if="error" class="error">{{ error }}</p>
    <p v-if="info" class="notice">{{ info }}</p>
    <button class="btn block" type="submit" :disabled="busy || !remote.online">{{ busy ? 'Un instant…' : mode === 'inscription' ? 'Créer mon compte' : 'Se connecter' }}</button>
    <button v-if="mode === 'connexion'" type="button" class="textbtn" style="align-self:center" @click="forgot">Mot de passe oublié ?</button>
  </form>

  <p v-if="mode === 'inscription'" class="tiny mt24">En créant un compte, tu acceptes que tes nom et téléphone soient transmis aux prestataires chez qui tu réserves. Version de test : conditions d'utilisation à venir.</p>
</template>
