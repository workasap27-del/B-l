# VLADI

Appli web de réservation beauté et bien-être en Guadeloupe : ongles, cils, coiffure, tresses, maquillage, soins, barbier, tatouage, piercing, massage, spa et hôtels (chambre à la journée, piscine, brunch). Elle s'adapte au téléphone, à la tablette et à l'ordinateur.
Deux façons de réserver : à l'avance (classique) ou tout de suite sur un créneau qui se libère (Konyéla, avec remise).

**État actuel : comptes réels, catalogue mixte.** Les personnes qui réservent et les prestataires peuvent créer un compte (Supabase).
Une prestataire inscrite publie sa fiche (SIREN obligatoire), ses prestations et ses horaires ; ses réservations
et ses créneaux Konyéla sont enregistrés en base. À côté, 155 fiches d'exemple (marquées "Exemple") restent
affichées pour la démonstration : leurs réservations ne quittent pas le navigateur. Un réglage permet de les masquer.
Pas de paiement en ligne pour l'instant : la prestation se règle sur place.

## Lancer en local

```bash
npm install
npm run dev        # http://localhost:3000
npm test           # tests de la logique (agenda, recherche, lieux, distances)
npm run typecheck  # vérification des types
npm run build      # version de production
```

Node 20 ou plus récent.

## Mettre en ligne sur Vercel

1. Sur vercel.com, "Add New Project", choisir ce dépôt.
2. Vercel reconnaît Nuxt tout seul, ne rien changer, cliquer sur Deploy.
3. Chaque `git push` sur `main` redéploie.

## L'installer sur un téléphone

L'appli s'installe depuis le navigateur, sans passer par un magasin d'applications.
- iPhone : ouvrir le lien dans Safari, bouton Partager, puis "Sur l'écran d'accueil".
- Android : ouvrir le lien dans Chrome, menu à trois points, puis "Ajouter à l'écran d'accueil" ou "Installer l'application".

Elle s'ouvre ensuite en plein écran avec son icône. Une connexion reste nécessaire.

## Ce que fait l'appli

Pour réserver
- Accueil : lieu de départ (position du téléphone ou commune), recherche, catégories, créneaux Konyéla, prestataires proches, ceux qui se déplacent, les mieux notés.
- Recherche : par prestation ("cils", "pose gel", "massage"), par nom ou par commune. Chaque résultat montre la prestation, son prix et les prochains créneaux, réservables en un geste. Filtres (lieu, type, distance, disponibilité du jour), tri, vue liste ou carte.
- Distances : estimées depuis la position de l'utilisateur ou le centre de sa commune (vol d'oiseau majoré de 30 %, pas un calcul d'itinéraire). Le bouton "Itinéraire" ouvre l'application de cartes du téléphone.
- Fiche prestataire : ouvert ou fermé, distance, prestations, avis, carte, horaires, favori.
- Réservation : lieu (chez le prestataire ou chez la cliente, avec adresse et frais de déplacement), jour, heure, récapitulatif, acompte de 20 %.
- Konyéla : créneaux libres dans les prochaines heures, à prix réduit.
- Mes rendez-vous : itinéraire, annulation (gratuite plus de 24 h avant), avis, réserver à nouveau.
- Le jour J : celui qui se déplace signale son arrivée ou un retard (5 à 15 min), l'autre confirme. Passé 15 min, l'attente peut être prolongée ou une absence déclarée. Un désaccord part au service client (pas de géolocalisation).

Comptes (page Compte, puis Connexion)
- Inscription par e-mail et mot de passe : « Je réserve » ou « Je propose mes services ».
- Réserver chez une vraie prestataire demande un compte : son prénom, son téléphone et sa note sont transmis.
- Un ou une prestataire crée sa fiche dans "Créer ma fiche prestataire" : nom, SIREN, catégories, prestations
  (suggestions par métier, statut indépendant·e, salon, institut, studio, spa ou hôtel), commune ou position exacte, reçoit ou se déplace, horaires, présentation.
- Sur sa propre fiche, on voit "Votre entreprise" au lieu du bouton de réservation.

Côté prestataire, depuis Compte puis "Mon agenda" (sans fiche : l'espace d'exemple de Kaz a Zong)
- Agenda sur cinq jours, avec les trous, le lieu, le téléphone et la note de chaque client ou cliente.
- "Proposer en Konyéla" sur un trou : prestation, heure, remise.
- Activité : remplissage, chiffre du jour, réservations à venir, prestations.

Le bouton réglages de l'accueil (en haut à droite) regroupe : choix de la charte de couleurs, affichage des fiches
d'exemple, heure simulée (utile le soir) et remise à zéro des données de démonstration.

Heure : l'appli fonctionne à l'heure de la Guadeloupe (UTC-4), quel que soit le fuseau du téléphone.
Photos : photos libres de droits de Pexels (licence Pexels), une par fiche selon son métier.

Écrans : sur téléphone, menu en bas ; sur tablette, contenu centré en colonnes ; sur ordinateur (1000 px et plus), menu latéral à gauche et grilles de 3 à 4 colonnes. Les fenêtres (filtres, récapitulatif) s'ouvrent au centre sur grand écran.

Langage : l'appli évite les accords de genre (« Je réserve », « Je propose mes services », « Indépendant·e », « Chez le/la pro »).

Limites connues : un hôtel ne vend pas encore de nuitées (réservation par dates). L'appli propose des créneaux dans la journée : chambre en day use, piscine, brunch, séminaire. Pour le tatouage et le piercing, la formation à l'hygiène et à la salubrité et la déclaration à l'ARS sont obligatoires : l'appli le rappelle mais ne le vérifie pas.

## Mode présentation

Par défaut, l'appli n'affiche que les vrais prestataires. Les établissements de démonstration (`data/pros.ts`)
n'apparaissent qu'avec le lien `?demo=1` (par exemple https://bel-manzel.vercel.app/?demo=1), signalés « Démo ».
`?demo=0` ou « Quitter le mode présentation » dans les réglages les masque à nouveau.

## Paiement

`RULES.onlinePayment` (dans `data/pros.ts`) vaut `false` : aucun paiement en ligne, tout se règle sur place.
Les textes de réservation, de confirmation, d'annulation et les CGU s'adaptent à ce réglage.

## Pages légales

`/cgu`, `/confidentialite`, `/mentions-legales`. L'identité de l'éditeur, le contact et le médiateur se règlent dans
`data/legal.ts` (un champ vide n'est pas affiché). Les CGU reprennent les règles réelles de l'appli (24 h, retard
toléré, avis liés à une réservation) : les mettre à jour si une règle change.

## Pilotage

`/pilotage`, réservé aux comptes listés dans la table `admins` : indicateurs (réservations, volume d'affaires,
panier moyen, annulations, absences, fidélité, activation des prestataires, catégories, communes, jours et heures),
journal d'activité (table `app_events`, alimentée par des déclencheurs) et exports CSV pour Excel.
Ajouter un compte propriétaire : `insert into admins (user_id) select id from auth.users where email = '...';`
dans l'éditeur SQL de Supabase. Schéma : `supabase/patch-003-pilotage.sql` (déjà appliqué, inclus dans schema.sql).

## Organisation du code

| Dossier | Rôle |
|---|---|
| `data/pros.ts` | Catalogue fictif (155 prestataires dans 32 communes), catégories, règles commerciales |
| `data/generate.ts` | Générateur du catalogue : communes, métiers, noms, cartes de prestations, positions |
| `utils/schedule.ts` | Logique d'agenda : dates, créneaux libres, trous |
| `utils/search.ts` | Recherche par prestation, métier, nom et commune (sans accents, singulier ou pluriel) |
| `utils/places.ts` | Lieux de prestation et frais de déplacement |
| `utils/arrival.ts` | Suivi d'arrivée : tolérance, retard, absence, désaccord |
| `utils/geo.ts` | Coordonnées des communes, distances, lien d'itinéraire |
| `composables/useVladi.ts` | État de l'appli et toutes les actions. Mélange fiches réelles (base) et fiches d'exemple (navigateur) |
| `composables/useBackend.ts` | Tous les appels à Supabase : comptes, fiches, réservations, créneaux, avis |
| `utils/time.ts` | Heure de la Guadeloupe et conversion vers les dates de la base |
| `utils/photos.ts` | Photos Pexels par métier |
| `utils/chartes.ts`, `assets/chartes.css` | Les cinq chartes de couleurs (police et formes identiques) |
| `pages/` | Un fichier par écran |
| `components/` | Logo, visuel et cartes de prestataire, résultat de recherche, carte géographique, feuilles |
| `public/` | Logo (`logo.svg`, `logo.png`) et icône de l'appli (`icon.svg`) |
| `supabase/` | Schéma de base, données de démo, tests des droits d'accès |
| `tests/` | Tests de l'agenda, de la recherche, des lieux et des distances |

La carte utilise Leaflet et les fonds CARTO (données OpenStreetMap). L'usage gratuit de CARTO est limité :
avant un lancement à grande échelle, prendre une offre adaptée (CARTO, MapTiler ou Stadia).

## Base de données (Supabase)

Projet Supabase `dkvqloksvlbniztqdywb` (région Europe). L'adresse et la clé publique sont dans `nuxt.config.ts`
(la clé publique est faite pour être visible ; les droits sont protégés par les règles RLS du schéma).

- `supabase/schema.sql` : tables, règles d'accès, fonctions. Déjà appliqué.
- `supabase/patch-002.sql` : prix recalculé par le serveur, créneaux occupés. Déjà appliqué (inclus dans schema.sql).
- `supabase/seed.sql` : les fiches d'exemple en base (non utilisées par l'appli, qui les garde côté navigateur).
- `supabase/tests/smoke.sql` : vérifie les règles (double réservation, prix non modifiable par la cliente,
  SIREN obligatoire, une fiche par compte...). À lancer sur une base de test après `00_stub_auth.sql`.

Garanties côté serveur : pas de double réservation chez un même prestataire, un créneau Konyéla n'est pris
qu'une fois, le prix et l'acompte sont recalculés par la base, personne ne voit les réservations des autres.

Confirmation par e-mail désactivée : l'envoi d'e-mails intégré à Supabase est réservé à l'équipe du projet.
Pour l'activer, brancher un service d'envoi (Resend, Brevo) dans Authentication puis SMTP Settings.

## Reste à faire avant de vrais utilisateurs

- Envoi d'e-mails (confirmation, mot de passe oublié) avec un vrai service SMTP.
- Photo personnelle sur la fiche prestataire (aujourd'hui : photo du métier).
- Paiement réel de l'acompte (Stripe Connect, à valider pour la Guadeloupe).
- Rappels par SMS ou notification.
- Vraies adresses et calcul d'itinéraire : les positions sont fictives et les distances estimées.
- Mentions légales, CGU, RGPD.
- Faire valider "Konyéla" et les textes en créole par un créolophone.
