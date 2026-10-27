<script setup lang="ts">
import { ChevronLeft } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'
import { LOYALTY, RULES } from '~/data/pros'
import { DISPUTE_HOURS, TOLERANCE } from '~/utils/arrival'

useHead({ title: 'Conditions générales d\'utilisation · VLADI' })
const router = useRouter()
const editor = LEGAL.editor.name || 'VLADI'
function back() {
  if (window.history.length > 1) router.back()
  else router.push('/')
}
</script>

<template>
  <div class="head"><button class="icon-btn" aria-label="Retour" @click="back"><ChevronLeft :size="24" /></button></div>
  <article class="legal">
    <h1 class="title">Conditions générales d'utilisation</h1>
    <p class="tiny">En vigueur au {{ LEGAL.updated }}</p>

    <nav class="toc" aria-label="Sommaire">
      <a href="#objet">1. Objet</a>
      <a href="#definitions">2. Définitions</a>
      <a href="#role">3. Rôle de VLADI</a>
      <a href="#compte">4. Accès et compte</a>
      <a href="#reservation">5. Réservation</a>
      <a href="#prix">6. Prix et paiement</a>
      <a href="#annulation">7. Annulation, retard et absence</a>
      <a href="#konyela">8. Créneaux Konyéla</a>
      <a href="#clients">9. Engagements des clients</a>
      <a href="#prestataires">10. Engagements des prestataires</a>
      <a href="#classement">11. Référencement et classement</a>
      <a href="#avis">12. Avis</a>
      <a href="#suspension">13. Suspension et fermeture de compte</a>
      <a href="#responsabilite">14. Responsabilité</a>
      <a href="#propriete">15. Propriété intellectuelle</a>
      <a href="#donnees">16. Données personnelles</a>
      <a href="#retractation">17. Droit de rétractation</a>
      <a href="#modification">18. Modification des conditions</a>
      <a href="#litiges">19. Réclamations et litiges</a>
    </nav>

    <h2 id="objet">1. Objet</h2>
    <p>Les présentes conditions générales d'utilisation (les « Conditions ») encadrent l'accès et l'utilisation de VLADI, service de réservation en ligne de prestations de beauté et de bien-être, accessible à l'adresse {{ LEGAL.site }}, édité par {{ editor }}{{ LEGAL.editor.name ? ' (« VLADI », « nous »)' : ' (« nous »)' }}.</p>
    <p>Elles s'appliquent à toute personne qui consulte le service, crée un compte, réserve une prestation ou publie une fiche. Créer un compte vaut acceptation des Conditions dans leur version en vigueur. Si vous ne les acceptez pas, vous pouvez consulter le service mais pas y réserver ni y publier.</p>

    <h2 id="definitions">2. Définitions</h2>
    <ul>
      <li><b>Utilisateur</b> : toute personne qui utilise VLADI, avec ou sans compte.</li>
      <li><b>Client</b> : Utilisateur qui réserve une prestation.</li>
      <li><b>Prestataire</b> : professionnel immatriculé (indépendant, salon, institut, studio, spa, hôtel) qui publie une fiche pour proposer ses prestations.</li>
      <li><b>Fiche</b> : page qui présente un Prestataire, ses prestations, ses tarifs, ses horaires et son lieu d'exercice.</li>
      <li><b>Réservation</b> : rendez-vous pris par un Client auprès d'un Prestataire par l'intermédiaire de VLADI.</li>
      <li><b>Créneau Konyéla</b> : créneau disponible le jour même, proposé par un Prestataire à prix réduit.</li>
    </ul>

    <h2 id="role">3. Rôle de VLADI</h2>
    <p>VLADI est une plateforme de mise en relation. Nous mettons à disposition des outils qui permettent aux Clients de trouver un Prestataire et de réserver, et aux Prestataires de présenter leur activité et de gérer leur agenda.</p>
    <p>VLADI n'exécute aucune prestation et n'est pas partie au contrat conclu entre le Client et le Prestataire. Le Prestataire est seul responsable de la prestation qu'il réalise, de ses tarifs, de ses qualifications et du respect des règles applicables à son métier.</p>
    <p>Les informations d'une Fiche sont fournies par le Prestataire. Nous vérifions à la création de la Fiche que son numéro SIREN correspond à une entreprise active au répertoire officiel des entreprises. Nous ne contrôlons pas les diplômes, les assurances ni les conditions d'hygiène.</p>

    <h2 id="compte">4. Accès et compte</h2>
    <p>La consultation des Fiches est libre et gratuite. Réserver ou publier une Fiche nécessite un compte, créé avec une adresse e-mail valide et un mot de passe personnel, ou avec un compte Google ou Apple lorsque cette option est proposée. L'adresse e-mail est confirmée par un lien envoyé à l'inscription.</p>
    <p>Le compte est réservé aux personnes majeures. Un mineur ne peut l'utiliser qu'avec l'autorisation et sous la responsabilité de son représentant légal.</p>
    <p>Vous vous engagez à fournir des informations exactes et à les tenir à jour, en particulier votre numéro de téléphone, qui permet au Prestataire de vous joindre. Vos identifiants sont personnels : vous êtes responsable de leur confidentialité et de toute utilisation de votre compte. En cas d'usage frauduleux, prévenez-nous sans délai à {{ LEGAL.contactEmail }}.</p>
    <p>Un compte Prestataire correspond à une seule Fiche. Un Prestataire ne peut pas réserver ses propres prestations.</p>

    <h2 id="reservation">5. Réservation</h2>
    <p>Le Client choisit une prestation, un lieu (chez le Prestataire ou à domicile lorsque le Prestataire se déplace), une date et une heure parmi les disponibilités affichées. Un récapitulatif indique la prestation, le lieu, l'horaire et le prix total avant toute validation.</p>
    <p>La Réservation est ferme dès sa confirmation. Elle apparaît immédiatement dans l'agenda du Prestataire et dans l'onglet Rendez-vous du Client. Le Prestataire reçoit le prénom, le téléphone et, le cas échéant, l'adresse et le message du Client, dans le seul but d'assurer le rendez-vous.</p>
    <p>Le message facultatif laissé au Prestataire (allergie, grossesse, cheveux fragiles, accès difficile…) est transmis tel quel. VLADI ne l'analyse pas et ne donne aucun avis médical. En cas de doute sur une contre-indication, demandez conseil à un professionnel de santé avant le rendez-vous.</p>

    <h2 id="prix">6. Prix et paiement</h2>
    <p>Les prix sont fixés librement par chaque Prestataire et affichés toutes taxes comprises. Pour une prestation à domicile, les frais de déplacement éventuels sont indiqués avant la confirmation et inclus dans le total.</p>
    <p v-if="RULES.onlinePayment">Un acompte de {{ Math.round(RULES.depositRate * 100) }} % du prix total est réglé en ligne au moment de la Réservation, par l'intermédiaire d'un prestataire de services de paiement agréé. Le solde est réglé sur place, directement auprès du Prestataire.</p>
    <template v-else>
      <p>La réservation sur VLADI est gratuite pour le Client. Aucun paiement n'est demandé en ligne : la prestation est réglée sur place, directement auprès du Prestataire, selon les moyens de paiement qu'il accepte.</p>
      <p>Si un paiement en ligne est proposé à l'avenir, il sera opéré par un prestataire de services de paiement agréé et les présentes Conditions seront mises à jour avant sa mise en service.</p>
    </template>
    <p>L'inscription et la publication d'une Fiche sont gratuites pour le Prestataire à la date des présentes. Toute évolution tarifaire sera annoncée aux Prestataires au moins trente jours avant son entrée en vigueur.</p>

    <h2 id="annulation">7. Annulation, retard et absence</h2>
    <p><b>Annulation par le Client.</b> Une Réservation peut être annulée sans frais depuis l'onglet Rendez-vous jusqu'à {{ RULES.freeCancelHours }} heures avant son heure de début.
      <template v-if="RULES.onlinePayment">L'acompte est alors remboursé intégralement. Au-delà, ou pour un Créneau Konyéla, l'acompte reste acquis au Prestataire.</template>
      <template v-else>Au-delà, l'annulation reste possible, mais le Client est invité à prévenir le Prestataire directement. Les annulations tardives répétées peuvent conduire à la suspension du compte.</template>
    </p>
    <p><b>Annulation par le Prestataire.</b> Le Prestataire qui ne peut pas honorer un rendez-vous l'annule au plus tôt et prévient le Client.<template v-if="RULES.onlinePayment"> L'acompte est alors remboursé intégralement.</template> Les annulations répétées d'un Prestataire peuvent entraîner la suspension de sa Fiche.</p>
    <p><b>Retard.</b> Le jour du rendez-vous, la personne qui se déplace peut signaler son arrivée ou un retard depuis l'application. Un retard de {{ TOLERANCE }} minutes au plus est toléré. Au-delà, le Prestataire peut écourter la prestation ou la reporter.</p>
    <p><b>Absence.</b> Si l'une des parties ne se présente pas, l'autre peut déclarer son absence dans l'application. La personne concernée peut contester cette déclaration dans un délai de {{ DISPUTE_HOURS }} heures ; VLADI prend alors contact avec les deux parties pour établir les faits.<template v-if="RULES.onlinePayment"> En cas d'absence du Client, l'acompte reste acquis au Prestataire ; en cas d'absence du Prestataire, il est remboursé au Client.</template></p>

    <p><b>Fiabilité.</b> Pour chaque Client, VLADI calcule sur douze mois le nombre de rendez-vous honorés, d'absences non contestées et d'annulations à moins de {{ RULES.freeCancelHours }} heures. Cet indicateur n'est montré qu'aux Prestataires chez qui le Client a réservé, et au Client lui-même. Il ne comporte ni note ni commentaire.</p>
    <p><b>Blocage.</b> Un Prestataire peut empêcher un Client de réserver à nouveau chez lui, notamment après des absences répétées. Le blocage ne vaut que pour ce Prestataire ; les rendez-vous déjà pris restent valables tant qu'il ne les annule pas.</p>

    <h2 id="konyela">8. Créneaux Konyéla</h2>
    <p>Un Prestataire peut proposer, le jour même, un créneau resté libre avec une remise qu'il fixe lui-même. Le prix barré correspond au tarif habituel affiché sur sa Fiche. Un Créneau Konyéla est attribué à la première personne qui le réserve. Comme il est pris au dernier moment, il ne bénéficie pas de l'annulation sans frais prévue à l'article 7.</p>

    <template v-if="LOYALTY.enabled">
      <p><b>Fidélité et parrainage.</b> Chaque rendez-vous honoré, réservé et réalisé via VLADI, rapproche le Client d'un palier : {{ LOYALTY.tiers.map(t => `${t.credit} € au ${t.visits}e rendez-vous`).join(', ') }}, puis le cycle recommence. Un Client qui invite une personne reçoit {{ LOYALTY.referralCredit }} €, comme la personne invitée, après le premier rendez-vous honoré de celle-ci. Le crédit est financé par VLADI, n'est ni remboursable ni échangeable contre de l'argent, et se déduit d'un paiement en ligne. Les absences et les rendez-vous annulés ne comptent pas. VLADI peut retirer un crédit obtenu de façon frauduleuse.</p>
    </template>

    <h2 id="clients">9. Engagements des clients</h2>
    <p>Le Client s'engage à se présenter à l'heure, à prévenir en cas d'empêchement, à donner une adresse exacte pour une prestation à domicile et à garantir au Prestataire des conditions d'accueil correctes et sûres. Il s'engage à signaler au Prestataire toute information utile à la bonne réalisation de la prestation.</p>

    <h2 id="prestataires">10. Engagements des prestataires</h2>
    <p>En publiant une Fiche, le Prestataire déclare et garantit :</p>
    <ul>
      <li>exercer son activité de manière déclarée, sous un numéro SIREN actif qui est le sien ;</li>
      <li>disposer des qualifications exigées pour les prestations qu'il propose, notamment pour la coiffure et l'esthétique ;</li>
      <li>pour le tatouage, le perçage corporel et le maquillage permanent, avoir suivi la formation aux conditions d'hygiène et de salubrité et déclaré son activité auprès de l'agence régionale de santé, et ne réaliser ces actes sur un mineur qu'avec le consentement écrit d'un titulaire de l'autorité parentale ;</li>
      <li>ne proposer, sous l'appellation massage ou bien-être, aucune prestation à visée thérapeutique ou médicale ;</li>
      <li>être couvert par une assurance de responsabilité civile professionnelle adaptée à son activité ;</li>
      <li>respecter les règles d'hygiène, de sécurité et d'information du consommateur applicables à son métier ;</li>
      <li>publier des informations exactes et à jour : nom, statut, lieu, prestations, durées, prix, horaires ;</li>
      <li>utiliser des textes et des photos dont il détient les droits ;</li>
      <li>honorer les Réservations acceptées et tenir son agenda à jour.</li>
    </ul>
    <p>Le Prestataire reste seul responsable de ses obligations fiscales et sociales, ainsi que de la facturation de ses prestations. Il s'interdit d'utiliser les coordonnées des Clients à d'autres fins que la gestion de leurs rendez-vous, notamment à des fins de prospection commerciale sans leur accord.</p>

    <h2 id="classement">11. Référencement et classement</h2>
    <p>Toute entreprise qui remplit les conditions de l'article 10 peut publier une Fiche. Aucun Prestataire ne paie pour être mieux placé.</p>
    <p>Par défaut, les résultats sont classés selon leur correspondance avec la recherche (la prestation recherchée, puis le métier, puis le nom), et à pertinence égale selon la distance depuis la position choisie par l'Utilisateur. L'Utilisateur peut à tout moment trier les résultats par distance, par note ou par prix, et les filtrer par lieu, type d'établissement, distance et disponibilité du jour. Les Créneaux Konyéla sont présentés du plus proche dans le temps au plus éloigné.</p>
    <p v-if="RULES.sponsored">Certaines Fiches peuvent être mises en avant contre paiement, dans les résultats (deux au plus, parmi celles qui correspondent à la recherche, en première et quatrième position, avec le classement par pertinence) et sur l'accueil. Elles portent la mention « Sponsorisé ». La mise en avant ne change ni la note ni les avis, et elle est refusée aux Fiches mal notées ou dont le Prestataire a manqué des rendez-vous.</p>

    <h2 id="avis">12. Avis</h2>
    <p>Seul un Client qui a réservé par VLADI peut publier un avis, une seule fois par Réservation et après l'heure de fin du rendez-vous. Les avis sont donc tous liés à une Réservation réelle. Ils ne sont ni achetés ni rémunérés, et le Prestataire ne peut ni les modifier ni les supprimer. Il peut y répondre une fois, publiquement, et modifier sa réponse.</p>
    <p>Les avis sont publiés sans contrôle préalable et affichés du plus récent au plus ancien. La note d'une Fiche est la moyenne de tous ses avis. Nous retirons un avis qui contient des propos injurieux, diffamatoires, discriminatoires ou des données personnelles, ou qui ne se rapporte pas à la prestation. Pour signaler un avis ou une Fiche, utilisez le lien « Signaler » présent sur la Fiche, ou écrivez-nous à {{ LEGAL.contactEmail }}.</p>

    <h2 id="suspension">13. Suspension et fermeture de compte</h2>
    <p>Vous pouvez fermer votre compte à tout moment en nous écrivant à {{ LEGAL.contactEmail }}. Les Réservations à venir sont alors annulées et les Prestataires concernés prévenus.</p>
    <p>Nous pouvons suspendre ou fermer un compte, ou retirer une Fiche, en cas de manquement aux présentes Conditions, d'informations inexactes, de fraude, d'absences ou d'annulations tardives répétées, ou de comportement portant atteinte aux autres Utilisateurs. Sauf urgence ou manquement grave, la personne concernée est prévenue au préalable, avec les motifs de la décision, et peut présenter ses observations. Pour un Prestataire, la fermeture définitive intervient avec un préavis de trente jours, sauf manquement grave ou obligation légale.</p>

    <h2 id="responsabilite">14. Responsabilité</h2>
    <p>Nous faisons le nécessaire pour que VLADI fonctionne de façon continue et sécurisée, sans pouvoir garantir l'absence d'interruption, notamment en cas de maintenance, de panne d'un fournisseur technique ou de force majeure.</p>
    <p>En tant qu'intermédiaire, VLADI ne répond pas de l'exécution de la prestation, de sa qualité, de ses suites ni des dommages qu'elle pourrait causer, qui relèvent de la responsabilité du Prestataire. Nous ne sommes pas responsables des informations fournies par les Prestataires ou par les Clients, ni de l'usage que les Utilisateurs font du service en violation des présentes Conditions.</p>
    <p>Rien dans les présentes ne limite les droits que le Client tient de la loi en tant que consommateur.</p>

    <h2 id="propriete">15. Propriété intellectuelle</h2>
    <p>Le nom VLADI, l'application, sa présentation et ses contenus propres sont protégés. Toute reproduction ou réutilisation sans autorisation est interdite. Le Prestataire conserve ses droits sur les textes et photos qu'il publie et nous autorise à les afficher sur VLADI pendant la durée de publication de sa Fiche. Les photos d'illustration utilisées en l'absence de photo du Prestataire proviennent de banques d'images libres de droits.</p>

    <h2 id="donnees">16. Données personnelles</h2>
    <p>Le traitement de vos données est décrit dans la <NuxtLink class="link" to="/confidentialite">politique de confidentialité</NuxtLink>, qui fait partie des présentes Conditions.</p>

    <h2 id="retractation">17. Droit de rétractation</h2>
    <p>L'utilisation de VLADI par le Client est gratuite. Pour la prestation réservée, le Client qui demande qu'elle soit réalisée avant la fin du délai légal de rétractation de quatorze jours reconnaît qu'il ne pourra plus exercer ce droit une fois la prestation entièrement exécutée (article L. 221-28 du Code de la consommation). Jusqu'au rendez-vous, il conserve la possibilité d'annuler dans les conditions de l'article 7.</p>

    <h2 id="modification">18. Modification des conditions</h2>
    <p>Nous pouvons faire évoluer les présentes Conditions, notamment pour suivre l'évolution du service ou de la réglementation. La nouvelle version est publiée sur cette page avec sa date d'entrée en vigueur. Les Prestataires sont prévenus au moins quinze jours à l'avance de toute modification qui les concerne. Une Réservation reste régie par les Conditions en vigueur au moment où elle a été faite.</p>

    <h2 id="litiges">19. Réclamations et litiges</h2>
    <p>Pour toute question ou réclamation, écrivez-nous à {{ LEGAL.contactEmail }}. Nous répondons dans les meilleurs délais. Un différend portant sur la prestation elle-même se règle d'abord avec le Prestataire.</p>
    <p v-if="LEGAL.mediator.name">Si votre réclamation n'a pas abouti, vous pouvez saisir gratuitement le médiateur de la consommation dont nous relevons : {{ LEGAL.mediator.name }}<template v-if="LEGAL.mediator.url"> (<a class="link" :href="LEGAL.mediator.url" target="_blank" rel="noopener">{{ LEGAL.mediator.url.replace(/^https?:\/\//, '') }}</a>)</template>, dans le délai d'un an suivant votre réclamation écrite.</p>
    <p>Les présentes Conditions sont soumises au droit français. À défaut d'accord amiable, le litige est porté devant les tribunaux compétents ; le consommateur peut saisir, à son choix, la juridiction du lieu où il demeurait au moment de la conclusion du contrat ou de la survenance du fait dommageable.</p>

    <p class="tiny mt24">Voir aussi : <NuxtLink class="link" to="/confidentialite">Politique de confidentialité</NuxtLink> · <NuxtLink class="link" to="/mentions-legales">Mentions légales</NuxtLink></p>
  </article>
</template>
