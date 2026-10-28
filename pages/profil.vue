<script setup lang="ts">
import { LOYALTY, RULES } from '~/data/pros'
import type { Reliability } from '~/utils/reliability'
import { BarChart3, ChevronRight, FileText, Heart, LogOut, Mail, MapPin, Settings2, Shield, Store, Trash2, UserRound } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

useHead({ title: 'Mon compte · VLADI' })

const { lang } = useLang()
const { state, pros, km, account, remote, logout, saveProfile, toast } = useVladi()
const favs = computed(() => pros.value.filter(p => state.fav[p.id]).sort((a, b) => km(a) - km(b)))
const locOpen = ref(false)
const settingsOpen = ref(false)
const editOpen = ref(false)
const name = ref('')
const phone = ref('')
const error = ref('')

function openEdit() {
  name.value = account.value?.name ?? ''
  phone.value = account.value?.phone ?? ''
  error.value = translate('')
  editOpen.value = true
}
async function save() {
  if (name.value.trim().length < 2) {
    error.value = translate('Indique ton prénom.')
    return
  }
  const e = await saveProfile({ name: name.value, phone: phone.value })
  if (e) error.value = e
  else {
    editOpen.value = false
    toast('Informations enregistrées')
  }
}
async function out(everywhere = false) {
  await logout(everywhere)
  toast(everywhere ? translate('Déconnecté·e de tous tes appareils') : translate('Déconnexion effectuée'))
}

// Suppression du compte.
const { deleteAccount } = useVladi()
const delOpen = ref(false)
const delWord = ref('')
const delBusy = ref(false)
const delError = ref('')
async function confirmDelete() {
  delError.value = translate('')
  if (!['SUPPRIMER', 'DELETE'].includes(delWord.value.trim().toUpperCase())) return (delError.value = translate('Écris SUPPRIMER pour confirmer.'))
  delBusy.value = true
  const e = await deleteAccount()
  delBusy.value = false
  if (e === 'indisponible') return (delError.value = translate('La suppression automatique n\'est pas encore ouverte. Écris-nous à {email} depuis l\'adresse de ton compte : il sera supprimé sous trente jours.', { email: LEGAL.contactEmail }))
  if (e) return (delError.value = e)
  delOpen.value = false
  toast('Ton compte a été supprimé')
}

// Indicateur de fiabilité de la personne connectée.
const { myReliability } = useVladi()
const trust = ref<Reliability | null>(null)
watch(() => account.value?.id, async (id) => { trust.value = id ? await myReliability() : null }, { immediate: true })

// Fidélité et parrainage : visibles quand le programme est ouvert, ou en mode présentation avec des chiffres d'illustration.
const { myLoyalty } = useVladi()
const loyalty = ref<{ visits: number, referrals: number, code: string } | null>(null)
watch(() => account.value?.id, async (id) => {
  if (state.demo && !LOYALTY.enabled) loyalty.value = { visits: 3, referrals: 1, code: 'KREYOL' }
  else loyalty.value = id && LOYALTY.enabled ? await myLoyalty() : null
}, { immediate: true })
const loyal = computed(() => (loyalty.value ? loyaltyState(loyalty.value.visits, loyalty.value.referrals) : null))
const code = computed(() => loyalty.value?.code ?? '')
const inviteOpen = ref(false)
const inviteUrl = computed(() => `${window.location.origin}/?parrain=${code.value}`)
</script>

<template>
  <template v-if="account">
    <div class="row gap16">
      <div class="avatar">{{ account.name.charAt(0).toUpperCase() }}</div>
      <div class="col gap4" style="min-width:0">
        <h1 class="title ellip">{{ account.name }}</h1>
        <span class="meta ellip">{{ account.email }}</span>
      </div>
    </div>

    <section class="section">
      <h2 class="h2">{{ remote.myPro ? t('Mon activité') : account.role === 'pro' ? t('Ma fiche prestataire') : t('Tu proposes des services ?') }}</h2>
      <div class="list">
        <template v-if="remote.myPro">
          <NuxtLink to="/espace-pro"><Store :size="20" />{{ t('Mon agenda') }}<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
          <NuxtLink :to="`/pro/${remote.myPro.id}`"><UserRound :size="20" />{{ t('Voir ma fiche') }}<span class="sub ellip" style="max-width:50%">{{ remote.myPro.name }}<ChevronRight :size="18" /></span></NuxtLink>
          <NuxtLink to="/espace-pro/fiche"><Settings2 :size="20" />{{ t('Modifier ma fiche') }}<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
        </template>
        <NuxtLink v-else to="/espace-pro/fiche"><Store :size="20" />{{ t('Créer ma fiche prestataire') }}<span class="sub">{{ t('Gratuit') }}<ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>

    <section v-if="remote.admin || remote.adminMfa" class="section">
      <h2 class="h2">{{ t('Administration') }}</h2>
      <div class="list">
        <NuxtLink to="/pilotage"><BarChart3 :size="20" />{{ t('Pilotage') }}<span class="sub">{{ t('Indicateurs et journal') }}<ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>

    <section class="section">
      <h2 class="h2">{{ t('Mon compte') }}</h2>
      <div class="list">
        <button @click="openEdit"><UserRound :size="20" />{{ t('Mes informations') }}<span class="sub">{{ account.phone || t('Ajouter un téléphone') }}<ChevronRight :size="18" /></span></button>
        <button @click="locOpen = true"><MapPin :size="20" />{{ t('Ma position') }}<span class="sub">{{ state.pos.label }}<ChevronRight :size="18" /></span></button>
        <button @click="settingsOpen = true"><Settings2 :size="20" />{{ t('Réglages') }}<span class="sub"><ChevronRight :size="18" /></span></button>
        <button @click="out()"><LogOut :size="20" />{{ t('Se déconnecter') }}</button>
        <button @click="out(true)"><LogOut :size="20" />{{ t('Se déconnecter de tous les appareils') }}</button>
        <button class="danger-row" @click="delOpen = true; delWord = ''; delError = ''"><Trash2 :size="20" />{{ t('Supprimer mon compte') }}</button>
      </div>
    </section>
  </template>

  <template v-else>
    <div class="col gap8">
      <h1 class="title">{{ t('Ton compte VLADI') }}</h1>
      <p class="meta">{{ t('Réserve en quelques secondes et retrouve tes rendez-vous sur tous tes appareils.') }}</p>
    </div>
    <div class="col gap12 mt24">
      <NuxtLink class="btn block" to="/connexion?mode=inscription">{{ t('Créer un compte') }}</NuxtLink>
      <NuxtLink class="btn block line" to="/connexion">{{ t('J\'ai déjà un compte') }}</NuxtLink>
    </div>
    <section class="section">
      <NuxtLink class="banner" to="/connexion?mode=inscription&role=pro">
        <Store :size="22" />
        <div class="grow col gap4">
          <span class="name">{{ t('Tu es prestataire ?') }}</span>
          <span class="meta">{{ t('Crée ta fiche gratuitement, gère ton agenda et remplis tes créneaux vides.') }}</span>
        </div>
        <ChevronRight :size="18" style="align-self:center" />
      </NuxtLink>
    </section>
    <section class="section">
      <div class="list">
        <button @click="locOpen = true"><MapPin :size="20" />{{ t('Ma position') }}<span class="sub">{{ state.pos.label }}<ChevronRight :size="18" /></span></button>
        <button @click="settingsOpen = true"><Settings2 :size="20" />{{ t('Réglages') }}<span class="sub"><ChevronRight :size="18" /></span></button>
        <NuxtLink v-if="state.demo" to="/espace-pro"><Store :size="20" />{{ t('Espace prestataire de démonstration') }}<span class="sub"><span v-if="state.unseen" class="tag warn">{{ state.unseen }}</span><ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>
  </template>

  <section v-if="loyal" class="section">
    <h2 class="h2">{{ t('Fidélité et parrainage') }}</h2>
    <div class="loyal mt12">
      <div class="loyal-bar" role="progressbar" :aria-valuenow="loyal.inCycle" aria-valuemin="0" :aria-valuemax="loyal.cycle"><i :style="{ width: `${(loyal.inCycle / loyal.cycle) * 100}%` }" /></div>
      <p class="mt8"><b>{{ t(loyal.visits > 1 ? '{n} rendez-vous honorés' : '{n} rendez-vous honoré', { n: loyal.visits }) }}</b> · {{ t('encore {n} avant {amount} de crédit', { n: loyal.next.left, amount: euro(loyal.next.credit) }) }}</p>
      <p class="meta">{{ t('Crédit cumulé : {amount}', { amount: euro(loyal.earned) }) }}<template v-if="!RULES.onlinePayment">{{ t(', utilisable dès l\'ouverture du paiement en ligne') }}</template>.</p>
    </div>
    <div v-if="code" class="infobox mt16">
      <span class="h3">{{ t('Invite tes proches') }}</span>
      <p class="mt8">{{ t('{amount} pour toi et {amount} pour la personne invitée après son premier rendez-vous. Ton code :', { amount: euro(LOYALTY.referralCredit) }) }} <b>{{ code }}</b></p>
      <button type="button" class="btn sm soft mt8" @click="inviteOpen = true">{{ t('Partager mon lien') }}</button>
    </div>
    <ShareSheet v-if="inviteOpen" :title="t('Invitation VLADI')" :text="`Je réserve mes rendez-vous beauté sur VLADI. Inscris-toi avec mon lien :`" :url="inviteUrl" @close="inviteOpen = false" />
  </section>

  <section v-if="trust" class="section">
    <h2 class="h2">{{ t('Ma fiabilité') }}</h2>
    <p class="mt8"><b>{{ reliabilityText(trust, lang) }}</b></p>
    <p class="tiny mt8">{{ t('Calculée sur douze mois : rendez-vous honorés, absences et annulations à moins de {h} h. Seuls les prestataires chez qui tu réserves la voient, jamais le public. Prévenir quand tu ne peux pas venir la garde au vert.', { h: RULES.freeCancelHours }) }}</p>
  </section>

  <section class="section">
    <h2 class="h2"><Heart :size="18" style="vertical-align:-2px" /> {{ t('Mes favoris') }}</h2>
    <div v-if="favs.length" class="carousel"><ProCard v-for="p in favs" :key="p.id" :pro="p" /></div>
    <p v-else class="meta">{{ t('Touche le cœur sur une fiche pour la retrouver ici.') }}</p>
  </section>

  <section class="section">
    <h2 class="h2">{{ t('Informations') }}</h2>
    <div class="list">
      <NuxtLink to="/cgu"><FileText :size="20" />{{ t('Conditions générales d\'utilisation') }}<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <NuxtLink to="/confidentialite"><Shield :size="20" />{{ t('Politique de confidentialité') }}<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <NuxtLink to="/mentions-legales"><FileText :size="20" />{{ t('Mentions légales') }}<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <a :href="`mailto:${LEGAL.contactEmail}`"><Mail :size="20" />{{ t('Nous contacter') }}<span class="sub ellip" style="max-width:55%">{{ LEGAL.contactEmail }}</span></a>
    </div>
  </section>

  <BottomSheet v-if="editOpen" @close="editOpen = false">
    <h2 class="h2">{{ t('Mes informations') }}</h2>
    <label class="field" for="p-name"><span>{{ t('Prénom') }}</span><input id="p-name" v-model="name" class="input" autocomplete="given-name"></label>
    <label class="field" for="p-phone"><span>{{ t('Téléphone') }} <span class="help">{{ t('(transmis aux prestataires chez qui tu réserves)') }}</span></span><input id="p-phone" v-model="phone" class="input" type="tel" autocomplete="tel" placeholder="0690 00 00 00"></label>
    <p v-if="error" class="error">{{ error }}</p>
    <button class="btn block" @click="save">{{ t('Enregistrer') }}</button>
  </BottomSheet>
  <BottomSheet v-if="delOpen" @close="delOpen = false">
    <h2 class="h2">{{ t('Supprimer ton compte ?') }}</h2>
    <p>{{ t('C\'est définitif. Tes rendez-vous à venir seront annulés et les prestataires prévenus. Ton historique, tes favoris et tes avis seront supprimés.') }}<template v-if="remote.myPro"> {{ t('Ta fiche « {name} », ses photos et ses rendez-vous à venir seront aussi supprimés, et les client·e·s prévenu·e·s.', { name: remote.myPro.name }) }}</template></p>
    <label class="field" for="del-w"><span>{{ t('Écris SUPPRIMER pour confirmer') }}</span><input id="del-w" v-model="delWord" class="input" autocomplete="off" autocapitalize="characters"></label>
    <p v-if="delError" class="error">{{ delError }}</p>
    <button class="btn block danger" :disabled="delBusy" @click="confirmDelete">{{ delBusy ? t('Suppression…') : t('Supprimer définitivement') }}</button>
    <button class="btn block" @click="delOpen = false">{{ t('Garder mon compte') }}</button>
  </BottomSheet>
  <LocationSheet v-if="locOpen" @close="locOpen = false" />
  <SettingsSheet v-if="settingsOpen" @close="settingsOpen = false" />
</template>
