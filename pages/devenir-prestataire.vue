<script setup lang="ts">
import { CalendarCheck, ChevronLeft, Eye, ShieldCheck, Zap } from 'lucide-vue-next'

useHead({ title: 'Devenir prestataire · VLADI' })
const router = useRouter()
const { account } = useVladi()
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
const start = computed(() => (account.value ? '/espace-pro/fiche' : '/connexion?mode=inscription&role=pro'))
const WHY = [
  { icon: Eye, t: 'Être visible', d: 'Ta fiche apparaît quand quelqu\'un cherche ton métier près de chez toi, même sans connaître ton nom.' },
  { icon: CalendarCheck, t: 'Recevoir des réservations', d: 'Les clients et clientes réservent à toute heure selon tes disponibilités, sans échange de messages.' },
  { icon: Zap, t: 'Remplir les trous', d: 'Un créneau libre aujourd\'hui ? Propose-le en Konyéla avec la remise de ton choix.' },
  { icon: ShieldCheck, t: 'Moins de lapins', d: 'Annulation en ligne, signalement de retard et déclaration d\'absence : chacun sait à quoi s\'en tenir.' },
]
</script>

<template>
  <div class="head"><button class="icon-btn" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal">
    <h1 class="title">{{ t('Devenir prestataire') }}</h1>
    <p>{{ t('Coiffure, ongles, cils, soins, massage, tatouage… Publie ta fiche gratuitement et reçois tes réservations sur VLADI.') }}</p>
    <div class="why">
      <div v-for="w in WHY" :key="w.t" class="why-item">
        <span class="srch-ico sm"><component :is="w.icon" :size="18" :stroke-width="1.7" /></span>
        <div><b>{{ w.t }}</b><p>{{ w.d }}</p></div>
      </div>
    </div>
    <h2>{{ t('Comment ça marche') }}</h2>
    <ol>
      <li>{{ t('Crée ton compte prestataire.') }}</li>
      <li>{{ t('Renseigne ton SIREN, tes prestations (prix et durée), tes horaires et où tu travailles.') }}</li>
      <li>{{ t('Publie ta fiche : les réservations arrivent dans ton espace pro.') }}</li>
    </ol>
    <h2>{{ t('Ce qu\'il faut') }}</h2>
    <ul>
      <li>{{ t('Un numéro SIREN : micro-entreprise ou société. Tu n\'en as pas encore ? La création d\'une micro-entreprise se fait en ligne sur le guichet unique de l\'INPI.') }}</li>
      <li>{{ t('Les diplômes ou déclarations exigés par ton métier, quand il y en a (coiffure, esthétique, tatouage, piercing, maquillage permanent, médecine esthétique).') }}</li>
    </ul>
    <h2>{{ t('Combien ça coûte') }}</h2>
    <p>{{ t('L\'inscription et la publication d\'une fiche sont gratuites. Toute évolution tarifaire serait annoncée au moins trente jours à l\'avance.') }}</p>
    <NuxtLink class="btn block mt24" :to="start">{{ t('Créer ma fiche') }}</NuxtLink>
    <p class="tiny mt16">{{ t('Des questions ? Consulte les') }} <NuxtLink class="link" to="/faq">{{ t('questions fréquentes') }}</NuxtLink>.</p>
  </article>
</template>
