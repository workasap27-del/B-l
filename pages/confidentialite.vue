<script setup lang="ts">
import { ChevronLeft } from 'lucide-vue-next'
import { LEGAL } from '~/data/legal'

useHead({ title: 'Politique de confidentialité · VLADI' })
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
    <h1 class="title">Politique de confidentialité</h1>
    <p class="tiny">En vigueur au {{ LEGAL.updated }}</p>

    <p>Cette politique explique quelles données nous traitons lorsque vous utilisez VLADI, pourquoi, avec qui elles sont partagées et comment exercer vos droits. Nous collectons le minimum nécessaire au fonctionnement du service et ne vendons aucune donnée.</p>

    <h2>Responsable du traitement</h2>
    <p>Le responsable du traitement est {{ editor }}<template v-if="LEGAL.editor.address">, {{ LEGAL.editor.address }}</template>. Pour toute question sur vos données : {{ LEGAL.contactEmail }}.</p>
    <p>Lorsqu'un Prestataire reçoit vos coordonnées pour assurer un rendez-vous, il devient lui-même responsable de l'usage qu'il en fait.</p>

    <h2>Les données que nous traitons</h2>
    <ul>
      <li><b>Compte</b> : adresse e-mail, mot de passe (conservé sous forme chiffrée, jamais lisible), prénom, profil client ou prestataire, téléphone.</li>
      <li><b>Réservations</b> : prestation, date et heure, lieu, adresse pour une prestation à domicile, message laissé au Prestataire, suivi du rendez-vous (arrivée, retard, absence, contestation), annulation.</li>
      <li><b>Fiche prestataire</b> : nom commercial, prénom s'il est indiqué, statut, SIREN, téléphone professionnel, commune, quartier, position, prestations, tarifs, horaires, présentation. Ces informations sont publiques, c'est leur raison d'être.</li>
      <li><b>Avis</b> : note et commentaire, rattachés à la réservation concernée. Ils sont publiés sans votre nom. Le Prestataire peut y répondre publiquement.</li>
      <li><b>Indicateur de fiabilité</b> : nombre de rendez-vous honorés, d'absences et d'annulations tardives sur les douze derniers mois, calculé à partir de vos réservations. Il n'est montré qu'aux Prestataires chez qui vous avez réservé, et à vous dans l'onglet Compte. Il ne contient aucune note ni aucun commentaire.</li>
      <li><b>Blocage</b> : un Prestataire peut empêcher une personne de réserver à nouveau chez lui. Seul ce Prestataire le sait.</li>
      <li><b>Photos des Fiches</b> : photos déposées par les Prestataires pour montrer leur travail. Elles sont réduites et leurs données de localisation retirées avant l'envoi. Elles sont publiques.</li>
      <li><b>Signalements</b> : raison du signalement d'une Fiche ou d'un avis, rattachée au compte qui l'a envoyé. Lus uniquement par l'équipe de VLADI.</li>
      <li><b>Parrainage</b> : votre code personnel et, si vous vous êtes inscrit avec le lien d'une autre personne, le lien entre vos deux comptes. La personne qui vous a invité voit seulement le nombre de personnes invitées qui ont honoré un rendez-vous, jamais leur nom.</li>
      <li><b>Visites des Fiches</b> : nombre de visites par Fiche et par jour, sans aucune information sur les visiteurs.</li>
      <li><b>Journal d'activité</b> : trace des actions effectuées sur le service (inscription, publication ou modification d'une fiche, réservation, annulation, avis), avec leur date.</li>
      <li><b>Sur votre appareil uniquement</b> : position utilisée pour calculer les distances, favoris, choix des couleurs et session de connexion. Votre position n'est pas envoyée à nos serveurs, sauf si un Prestataire choisit de l'enregistrer comme adresse de sa Fiche.</li>
    </ul>
    <p>Le message laissé au Prestataire est facultatif. Si vous choisissez d'y mentionner une information de santé (allergie, grossesse…), vous consentez à ce qu'elle soit transmise au Prestataire pour la préparation du rendez-vous, et à rien d'autre. N'y indiquez que ce qui est utile.</p>

    <h2>Pourquoi et sur quelle base</h2>
    <ul>
      <li><b>Créer votre compte, réserver, publier une Fiche, gérer les rendez-vous</b> : exécution du contrat qui nous lie (les conditions générales d'utilisation).</li>
      <li><b>Envoyer les e-mails de service</b> (confirmation d'adresse, réinitialisation du mot de passe) : exécution du contrat.</li>
      <li><b>Vérifier qu'un Prestataire est une entreprise immatriculée et active</b> : intérêt légitime à garantir des Fiches fiables. Seul le numéro SIREN est transmis au répertoire public des entreprises.</li>
      <li><b>Prévenir les abus, traiter les contestations, assurer la sécurité du service, établir des statistiques internes</b> à partir du journal d'activité : intérêt légitime à faire fonctionner un service sûr et à l'améliorer.</li>
      <li><b>Conserver certaines traces</b> lorsque la loi l'impose : obligation légale.</li>
    </ul>
    <p>Nous ne faisons pas de publicité ciblée, n'utilisons aucun outil de mesure d'audience tiers et ne prenons aucune décision automatisée produisant des effets juridiques à votre égard.</p>

    <h2>Qui y a accès</h2>
    <ul>
      <li><b>Le Prestataire chez qui vous réservez</b> : votre prénom, votre téléphone, l'adresse d'une prestation à domicile et votre message, pour ce rendez-vous uniquement. Il ne voit ni votre e-mail ni vos autres réservations.</li>
      <li><b>Les visiteurs du service</b> : les Fiches et les avis, qui sont publics.</li>
      <li><b>L'équipe de VLADI</b>, pour faire fonctionner le service, répondre à vos demandes et traiter les contestations.</li>
      <li><b>Nos sous-traitants techniques</b>, qui agissent sur nos instructions : {{ LEGAL.database.name }} (base de données et comptes, hébergés à {{ LEGAL.database.place }}), {{ LEGAL.host.name }} (hébergement de l'application), {{ LEGAL.mailer.name }} (envoi des e-mails de service).</li>
    </ul>
    <p>Pour afficher les photos d'illustration, le fond de carte et l'itinéraire, votre appareil se connecte directement à Pexels, à CARTO et, si vous ouvrez un itinéraire, à Google Maps. Ces services reçoivent alors l'adresse IP de votre appareil, selon leurs propres règles de confidentialité.</p>

    <h2>Transferts hors de l'Union européenne</h2>
    <p>La base de données est hébergée au Royaume-Uni, pays reconnu par la Commission européenne comme offrant une protection adéquate. Certains de nos prestataires techniques sont des sociétés américaines : les transferts éventuels vers les États-Unis sont encadrés par le cadre de protection des données UE-États-Unis ou, à défaut, par les clauses contractuelles types de la Commission européenne.</p>

    <h2>Combien de temps</h2>
    <ul>
      <li><b>Compte et Fiche</b> : tant que le compte est ouvert, puis supprimés dans les trente jours suivant sa fermeture. Un compte inactif depuis trois ans est supprimé après un message de prévenance.</li>
      <li><b>Réservations</b> : trois ans après la date du rendez-vous, pour répondre aux réclamations et contestations.</li>
      <li><b>Avis</b> : tant que la Fiche concernée est publiée.</li>
      <li><b>Journal d'activité</b> : vingt-quatre mois.</li>
      <li><b>Signalements</b> : un an après leur traitement.</li>
      <li><b>Blocages</b> : jusqu'à ce que le Prestataire les lève ou ferme son compte.</li>
    </ul>

    <h2>Vos droits</h2>
    <p>Vous disposez d'un droit d'accès, de rectification, d'effacement, de limitation, d'opposition et de portabilité de vos données, ainsi que du droit de définir des directives sur leur sort après votre décès. Votre prénom et votre téléphone se modifient directement depuis l'onglet Compte. Pour tout le reste, écrivez à {{ LEGAL.contactEmail }} depuis l'adresse liée à votre compte ; nous répondons dans un délai d'un mois.</p>
    <p>Si vous estimez que vos droits ne sont pas respectés, vous pouvez adresser une réclamation à la CNIL (<a class="link" href="https://www.cnil.fr" target="_blank" rel="noopener">cnil.fr</a>).</p>

    <h2>Stockage sur votre appareil</h2>
    <p>VLADI n'utilise ni cookie publicitaire ni traceur de mesure d'audience. L'application enregistre dans votre navigateur votre session de connexion et vos préférences (position, favoris, couleurs). Ces éléments sont strictement nécessaires au service et ne requièrent donc pas votre consentement. Vous pouvez les effacer à tout moment depuis les réglages de votre navigateur ; vous serez alors déconnecté.</p>

    <h2>Sécurité</h2>
    <p>Les échanges sont chiffrés. L'accès aux données est limité par des règles strictes : chaque personne ne voit que ses propres réservations, et un Prestataire uniquement celles de sa Fiche. Les mots de passe ne sont jamais conservés en clair.</p>

    <h2>Mineurs</h2>
    <p>Le service s'adresse aux personnes majeures. Un mineur ne peut l'utiliser qu'avec l'autorisation de son représentant légal.</p>

    <h2>Modification de cette politique</h2>
    <p>Cette politique peut évoluer. La version en vigueur est toujours disponible sur cette page, avec sa date. En cas de changement important, nous vous en informons par e-mail ou dans l'application.</p>

    <p class="tiny mt24">Voir aussi : <NuxtLink class="link" to="/cgu">Conditions générales d'utilisation</NuxtLink> · <NuxtLink class="link" to="/mentions-legales">Mentions légales</NuxtLink></p>
  </article>
</template>
