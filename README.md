# VLADI

Appli web mobile de réservation beauté en Guadeloupe : ongles, cils, coiffure, tresses, maquillage, soins, barbier.
Deux façons de réserver : à l'avance (classique) ou tout de suite sur un créneau qui se libère (Konyéla, avec remise).

**État actuel : version de démonstration.** Tous les salons, noms, prix et avis sont fictifs. Les réservations sont
enregistrées dans le navigateur de la personne qui teste, pas sur un serveur. Le paiement est simulé.

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

Côté cliente
- Accueil : lieu de départ (position du téléphone ou commune), recherche, catégories, créneaux Konyéla, prestataires proches, ceux qui se déplacent, les mieux notés.
- Recherche : par prestation ("cils", "pose gel", "massage"), par nom ou par commune. Chaque résultat montre la prestation, son prix et les prochains créneaux, réservables en un geste. Filtres (lieu, type, distance, disponibilité du jour), tri, vue liste ou carte.
- Distances : estimées depuis la position de l'utilisateur ou le centre de sa commune (vol d'oiseau majoré de 30 %, pas un calcul d'itinéraire). Le bouton "Itinéraire" ouvre l'application de cartes du téléphone.
- Fiche prestataire : ouvert ou fermé, distance, prestations, avis, carte, horaires, favori.
- Réservation : lieu (chez le prestataire ou chez la cliente, avec adresse et frais de déplacement), jour, heure, récapitulatif, acompte de 20 %.
- Konyéla : créneaux libres dans les prochaines heures, à prix réduit.
- Mes rendez-vous : itinéraire, annulation (gratuite plus de 24 h avant), avis, réserver à nouveau.

Côté prestataire (compte de démonstration : Kaz a Zong), depuis Profil puis "Espace prestataire"
- Agenda du jour et des trois jours suivants, avec les trous et le lieu de chaque rendez-vous.
- "Proposer en Konyéla" sur un trou : prestation, heure, remise.
- Activité : remplissage, chiffre du jour, commission.

Dans Profil, les "Réglages de démonstration" permettent de simuler une heure (utile le soir, quand tout est fermé)
et de tout remettre à zéro.

## Organisation du code

| Dossier | Rôle |
|---|---|
| `data/pros.ts` | Catalogue fictif (155 prestataires dans 32 communes), catégories, règles commerciales |
| `data/generate.ts` | Générateur du catalogue : communes, métiers, noms, cartes de prestations, positions |
| `utils/schedule.ts` | Logique d'agenda : dates, créneaux libres, trous |
| `utils/search.ts` | Recherche par prestation, métier, nom et commune (sans accents, singulier ou pluriel) |
| `utils/places.ts` | Lieux de prestation et frais de déplacement |
| `utils/geo.ts` | Coordonnées des communes, distances, lien d'itinéraire |
| `composables/useVladi.ts` | État de l'appli et toutes les actions. Seul fichier qui touche au stockage |
| `pages/` | Un fichier par écran |
| `components/` | Logo, visuel et cartes de prestataire, résultat de recherche, carte géographique, feuilles |
| `public/` | Logo (`logo.svg`, `logo.png`) et icône de l'appli (`icon.svg`) |
| `supabase/` | Schéma de base, données de démo, tests des droits d'accès |
| `tests/` | Tests de l'agenda, de la recherche, des lieux et des distances |

La carte utilise Leaflet et les tuiles publiques d'OpenStreetMap, correctes pour une démonstration.
Avant un vrai lancement, passer à un fournisseur de tuiles prévu pour la production.

## Passer à une vraie base (Supabase)

Le schéma est prêt et testé sur PostgreSQL 16, mais **l'appli ne parle pas encore à Supabase**. Étapes :

1. Créer un projet sur supabase.com (région Europe).
2. Dans l'éditeur SQL, lancer `supabase/schema.sql` puis `supabase/seed.sql`.
3. Copier `.env.example` en `.env` et renseigner l'adresse et la clé publique du projet.
4. Réécrire `composables/useVladi.ts` pour lire et écrire dans Supabase au lieu du navigateur.
   Les pages n'appellent que les fonctions de ce fichier, elles n'ont pas à changer.
5. Ajouter la connexion (téléphone ou e-mail) avec Supabase Auth.

Le schéma garantit déjà trois choses : pas de double réservation chez un même prestataire,
un créneau Konyéla ne peut être pris qu'une fois, et personne ne voit les réservations des autres.
`supabase/tests/smoke.sql` vérifie ces règles (à lancer sur une base de test, après `00_stub_auth.sql` hors Supabase).

## Reste à faire avant de vrais utilisateurs

- Brancher Supabase et la connexion (voir ci-dessus).
- Paiement réel de l'acompte (Stripe Connect, à valider pour la Guadeloupe).
- Inscription des prestataires et gestion de leurs prestations et horaires.
- Rappels par SMS ou notification.
- Vraies photos des prestataires : aujourd'hui chaque fiche a un visuel dessiné.
- Vraies adresses et calcul d'itinéraire : les positions sont fictives et les distances estimées.
- Mentions légales, CGU, RGPD.
- Faire valider "Konyéla" et les textes en créole par un créolophone.
