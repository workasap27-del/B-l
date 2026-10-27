<script setup lang="ts">
import { ChevronDown, ChevronLeft } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'
import { RULES } from '~/data/pros'
import { DISPUTE_HOURS, TOLERANCE } from '~/utils/arrival'

useHead({ title: 'Questions fréquentes · VLADI' })
const router = useRouter()
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
const deposit = Math.round(RULES.depositRate * 100)
const QA: { group: string, items: { q: string, a: string }[] }[] = [
  { group: 'Réserver', items: [
    { q: 'Est-ce que VLADI est payant pour moi ?', a: 'Non. Chercher, comparer et réserver sur VLADI est gratuit.' },
    { q: 'Comment réserver ?', a: 'Cherche une prestation ou une catégorie, choisis un prestataire, puis la prestation, le jour et l\'heure. Un compte est demandé pour confirmer, afin que le ou la prestataire sache qui vient.' },
    { q: 'Le ou la prestataire peut-il venir chez moi ?', a: 'Oui, si sa fiche indique « À domicile ». Les éventuels frais de déplacement sont affichés avant de réserver.' },
    { q: 'Que sont les créneaux Konyéla ?', a: 'Des créneaux libres le jour même, proposés à prix réduit. Ils sont attribués à la première personne qui réserve et ne bénéficient pas de l\'annulation sans frais.' },
  ] },
  { group: 'Payer', items: [
    RULES.onlinePayment
      ? { q: 'Comment se passe le paiement ?', a: `Un acompte de ${deposit} % est réglé en ligne à la réservation. Le solde se règle sur place, directement auprès du ou de la prestataire.` }
      : { q: 'Comment se passe le paiement ?', a: 'Rien n\'est payé en ligne. La prestation se règle sur place, directement auprès du ou de la prestataire, selon les moyens de paiement qu\'il ou elle accepte.' },
  ] },
  { group: 'Annuler ou modifier', items: [
    { q: 'Puis-je annuler ?', a: `Oui, sans frais depuis l'onglet Rendez-vous jusqu'à ${RULES.freeCancelHours} heures avant le début.${RULES.onlinePayment ? ' L\'acompte est alors remboursé.' : ' Au-delà, préviens directement le ou la prestataire.'}` },
    { q: 'Et si je suis en retard ?', a: `Signale-le depuis l'application. Un retard de ${TOLERANCE} minutes au plus est toléré ; au-delà, la prestation peut être écourtée ou reportée.` },
    { q: 'Et si personne ne vient ?', a: `L'autre partie peut déclarer l'absence dans l'application. La personne concernée peut la contester dans les ${DISPUTE_HOURS} heures.` },
  ] },
  { group: 'Avis et sécurité', items: [
    { q: 'Les avis sont-ils fiables ?', a: 'Seules les personnes qui ont réservé et dont le rendez-vous est passé peuvent laisser un avis, une seule fois par rendez-vous. Le ou la prestataire ne peut ni les modifier ni les supprimer.' },
    { q: 'Les prestataires sont-ils déclarés ?', a: 'Oui. Un numéro SIREN valide est demandé pour publier une fiche, et il est vérifié dans le registre officiel.' },
    { q: 'Comment supprimer mon compte ?', a: `Écris-nous à ${LEGAL.contactEmail} depuis l'adresse de ton compte. Il est supprimé dans les trente jours.` },
  ] },
  { group: 'Prestataires', items: [
    { q: 'Combien ça coûte de publier sa fiche ?', a: 'L\'inscription et la publication d\'une fiche sont gratuites. Toute évolution tarifaire serait annoncée au moins trente jours à l\'avance.' },
    { q: 'Que faut-il pour s\'inscrire ?', a: 'Un numéro SIREN (micro-entreprise ou société), tes prestations avec leur prix et leur durée, tes horaires et une photo.' },
  ] },
]
const open = ref<string | null>(null)
</script>

<template>
  <div class="head"><button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal faq">
    <h1 class="title">Questions fréquentes</h1>
    <section v-for="g in QA" :key="g.group">
      <h2>{{ g.group }}</h2>
      <div v-for="it in g.items" :key="it.q" class="faq-item">
        <button type="button" class="faq-q" :aria-expanded="open === it.q" @click="open = open === it.q ? null : it.q">
          <span class="grow">{{ it.q }}</span><ChevronDown :size="18" :class="{ flip: open === it.q }" />
        </button>
        <p v-if="open === it.q" class="faq-a">{{ it.a }}</p>
      </div>
    </section>
    <p class="mt24">Une autre question ? Écris-nous à <a class="link" :href="`mailto:${LEGAL.contactEmail}`">{{ LEGAL.contactEmail }}</a>.</p>
  </article>
</template>
