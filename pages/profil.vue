<script setup lang="ts">
import { BarChart3, ChevronRight, FileText, Heart, LogOut, Mail, MapPin, Settings2, Shield, Store, UserRound } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

useHead({ title: 'Mon compte · VLADI' })

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
  error.value = ''
  editOpen.value = true
}
async function save() {
  if (name.value.trim().length < 2) {
    error.value = 'Indique ton prénom.'
    return
  }
  const e = await saveProfile({ name: name.value, phone: phone.value })
  if (e) error.value = e
  else {
    editOpen.value = false
    toast('Informations enregistrées')
  }
}
async function out() {
  await logout()
  toast('Déconnexion effectuée')
}
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
      <h2 class="h2">{{ remote.myPro ? 'Mon activité' : account.role === 'pro' ? 'Ma fiche prestataire' : 'Tu proposes des services ?' }}</h2>
      <div class="list">
        <template v-if="remote.myPro">
          <NuxtLink to="/espace-pro"><Store :size="20" />Mon agenda<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
          <NuxtLink :to="`/pro/${remote.myPro.id}`"><UserRound :size="20" />Voir ma fiche<span class="sub ellip" style="max-width:50%">{{ remote.myPro.name }}<ChevronRight :size="18" /></span></NuxtLink>
          <NuxtLink to="/espace-pro/fiche"><Settings2 :size="20" />Modifier ma fiche<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
        </template>
        <NuxtLink v-else to="/espace-pro/fiche"><Store :size="20" />Créer ma fiche prestataire<span class="sub">Gratuit<ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>

    <section v-if="remote.admin" class="section">
      <h2 class="h2">Administration</h2>
      <div class="list">
        <NuxtLink to="/pilotage"><BarChart3 :size="20" />Pilotage<span class="sub">Indicateurs et journal<ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>

    <section class="section">
      <h2 class="h2">Mon compte</h2>
      <div class="list">
        <button @click="openEdit"><UserRound :size="20" />Mes informations<span class="sub">{{ account.phone || 'Ajouter un téléphone' }}<ChevronRight :size="18" /></span></button>
        <button @click="locOpen = true"><MapPin :size="20" />Ma position<span class="sub">{{ state.pos.label }}<ChevronRight :size="18" /></span></button>
        <button @click="settingsOpen = true"><Settings2 :size="20" />Réglages<span class="sub"><ChevronRight :size="18" /></span></button>
        <button @click="out"><LogOut :size="20" />Se déconnecter</button>
      </div>
    </section>
  </template>

  <template v-else>
    <div class="col gap8">
      <h1 class="title">Ton compte VLADI</h1>
      <p class="meta">Réserve en quelques secondes et retrouve tes rendez-vous sur tous tes appareils.</p>
    </div>
    <div class="col gap12 mt24">
      <NuxtLink class="btn block" to="/connexion?mode=inscription">Créer un compte</NuxtLink>
      <NuxtLink class="btn block line" to="/connexion">J'ai déjà un compte</NuxtLink>
    </div>
    <section class="section">
      <NuxtLink class="banner" to="/connexion?mode=inscription&role=pro">
        <Store :size="22" />
        <div class="grow col gap4">
          <span class="name">Tu es prestataire ?</span>
          <span class="meta">Crée ta fiche gratuitement, gère ton agenda et remplis tes créneaux vides.</span>
        </div>
        <ChevronRight :size="18" style="align-self:center" />
      </NuxtLink>
    </section>
    <section class="section">
      <div class="list">
        <button @click="locOpen = true"><MapPin :size="20" />Ma position<span class="sub">{{ state.pos.label }}<ChevronRight :size="18" /></span></button>
        <button @click="settingsOpen = true"><Settings2 :size="20" />Réglages<span class="sub"><ChevronRight :size="18" /></span></button>
        <NuxtLink v-if="state.demo" to="/espace-pro"><Store :size="20" />Espace prestataire de démonstration<span class="sub"><span v-if="state.unseen" class="tag warn">{{ state.unseen }}</span><ChevronRight :size="18" /></span></NuxtLink>
      </div>
    </section>
  </template>

  <section class="section">
    <h2 class="h2"><Heart :size="18" style="vertical-align:-2px" /> Mes favoris</h2>
    <div v-if="favs.length" class="carousel"><ProCard v-for="p in favs" :key="p.id" :pro="p" /></div>
    <p v-else class="meta">Touche le cœur sur une fiche pour la retrouver ici.</p>
  </section>

  <section class="section">
    <h2 class="h2">Informations</h2>
    <div class="list">
      <NuxtLink to="/cgu"><FileText :size="20" />Conditions générales d'utilisation<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <NuxtLink to="/confidentialite"><Shield :size="20" />Politique de confidentialité<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <NuxtLink to="/mentions-legales"><FileText :size="20" />Mentions légales<span class="sub"><ChevronRight :size="18" /></span></NuxtLink>
      <a :href="`mailto:${LEGAL.contactEmail}`"><Mail :size="20" />Nous contacter<span class="sub ellip" style="max-width:55%">{{ LEGAL.contactEmail }}</span></a>
    </div>
  </section>

  <BottomSheet v-if="editOpen" @close="editOpen = false">
    <h2 class="h2">Mes informations</h2>
    <label class="field" for="p-name"><span>Prénom</span><input id="p-name" v-model="name" class="input" autocomplete="given-name"></label>
    <label class="field" for="p-phone"><span>Téléphone <span class="help">(transmis aux prestataires chez qui tu réserves)</span></span><input id="p-phone" v-model="phone" class="input" type="tel" autocomplete="tel" placeholder="0690 00 00 00"></label>
    <p v-if="error" class="error">{{ error }}</p>
    <button class="btn block" @click="save">Enregistrer</button>
  </BottomSheet>
  <LocationSheet v-if="locOpen" @close="locOpen = false" />
  <SettingsSheet v-if="settingsOpen" @close="settingsOpen = false" />
</template>
