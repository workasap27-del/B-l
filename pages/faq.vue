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
const QA = computed(() => {
  void lang.value
  const t = translate
  return [
    { group: t('Réserver'), items: [
      { q: t('Est-ce que VLADI est payant pour moi ?'), a: t('Non. Chercher, comparer et réserver sur VLADI est gratuit.') },
      { q: t('Comment réserver ?'), a: t('Cherche une prestation ou une catégorie, choisis un prestataire, puis la prestation, le jour et l\'heure. Un compte est demandé pour confirmer, afin que le ou la prestataire sache qui vient.') },
      { q: t('Le ou la prestataire peut-il venir chez moi ?'), a: t('Oui, si sa fiche indique « À domicile ». Les éventuels frais de déplacement sont affichés avant de réserver.') },
      { q: t('Que sont les créneaux Konyéla ?'), a: t('Des créneaux libres le jour même, proposés à prix réduit. Ils sont attribués à la première personne qui réserve et ne bénéficient pas de l\'annulation sans frais.') },
    ] },
    { group: t('Payer'), items: [
      RULES.onlinePayment
        ? { q: t('Comment se passe le paiement ?'), a: t('Un acompte de {n} % est réglé en ligne à la réservation. Le solde se règle sur place, directement auprès du ou de la prestataire.', { n: deposit }) }
        : { q: t('Comment se passe le paiement ?'), a: t('Rien n\'est payé en ligne. La prestation se règle sur place, directement auprès du ou de la prestataire, selon les moyens de paiement qu\'il ou elle accepte.') },
    ] },
    { group: t('Annuler ou modifier'), items: [
      { q: t('Puis-je annuler ?'), a: t(RULES.onlinePayment ? 'Oui, sans frais depuis l\'onglet Rendez-vous jusqu\'à {h} heures avant le début. L\'acompte est alors remboursé.' : 'Oui, sans frais depuis l\'onglet Rendez-vous jusqu\'à {h} heures avant le début. Au-delà, préviens directement le ou la prestataire.', { h: RULES.freeCancelHours }) },
      { q: t('Et si je suis en retard ?'), a: t('Signale-le depuis l\'application. Un retard de {n} minutes au plus est toléré ; au-delà, la prestation peut être écourtée ou reportée.', { n: TOLERANCE }) },
      { q: t('Et si personne ne vient ?'), a: t('L\'autre partie peut déclarer l\'absence dans l\'application. La personne concernée peut la contester dans les {n} heures.', { n: DISPUTE_HOURS }) },
    ] },
    { group: t('Avis et sécurité'), items: [
      { q: t('Les avis sont-ils fiables ?'), a: t('Seules les personnes qui ont réservé et dont le rendez-vous est passé peuvent laisser un avis, une seule fois par rendez-vous. Le ou la prestataire ne peut ni les modifier ni les supprimer.') },
      { q: t('Les prestataires sont-ils déclarés ?'), a: t('Oui. Un numéro SIREN valide est demandé pour publier une fiche, et il est vérifié dans le registre officiel.') },
      { q: t('Comment supprimer mon compte ?'), a: t('Depuis l\'onglet Compte, « Supprimer mon compte ». Tes rendez-vous à venir sont annulés et les prestataires prévenus. Un souci ? Écris-nous à {email}.', { email: LEGAL.contactEmail }) },
    ] },
    { group: t('Prestataires'), items: [
      { q: t('Combien ça coûte de publier sa fiche ?'), a: t('L\'inscription et la publication d\'une fiche sont gratuites. Toute évolution tarifaire serait annoncée au moins trente jours à l\'avance.') },
      { q: t('Que faut-il pour s\'inscrire ?'), a: t('Un numéro SIREN (micro-entreprise ou société), tes prestations avec leur prix et leur durée, tes horaires et une photo.') },
    ] },
  ]
})
const { lang } = useLang()
const open = ref<string | null>(null)
</script>

<template>
  <div class="head"><button class="icon-btn" :aria-label="t('Retour')" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal faq">
    <h1 class="title">{{ t('Questions fréquentes') }}</h1>
    <section v-for="(g, gi) in QA" :key="gi">
      <h2>{{ g.group }}</h2>
      <div v-for="it in g.items" :key="it.q" class="faq-item">
        <button type="button" class="faq-q" :aria-expanded="open === it.q" @click="open = open === it.q ? null : it.q">
          <span class="grow">{{ it.q }}</span><ChevronDown :size="18" :class="{ flip: open === it.q }" />
        </button>
        <p v-if="open === it.q" class="faq-a">{{ it.a }}</p>
      </div>
    </section>
    <p class="mt24">{{ t('Une autre question ? Écris-nous à') }} <a class="link" :href="`mailto:${LEGAL.contactEmail}`">{{ LEGAL.contactEmail }}</a>.</p>
  </article>
</template>
