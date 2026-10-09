# Bèl

Appli web mobile de réservation beauté en Guadeloupe : ongles, cils, coiffure, tresses, maquillage, soins, barbier.
Deux façons de réserver : à l'avance (classique) ou tout de suite sur un créneau qui se libère (Konyéla, avec remise).

**État actuel : version de démonstration.** Tous les salons, noms, prix et avis sont fictifs. Les réservations sont
enregistrées dans le navigateur de la personne qui teste, pas sur un serveur. Le paiement est simulé.

## Lancer en local

```bash
npm install
npm run dev        # http://localhost:3000
npm test           # tests de la logique d'agenda
npm run build      # version de production
```

Node 20 ou plus récent.

## Mettre en ligne sur Vercel

1. Sur vercel.com, "Add New Project", choisir ce dépôt.
2. Vercel reconnaît Nuxt tout seul, ne rien changer, cliquer sur Deploy.
3. Chaque `git push` sur `main` redéploie.

## Ce que fait l'appli

Côté cliente
- Accueil : recherche, catégories, filtres salon / indépendante / à domicile.
- Fiche prestataire : prestations, prix, durée, avis, favori.
- Réservation classique : jour, heure, récapitulatif, acompte de 20 %.
- Konyéla : créneaux libres dans les prochaines heures, à prix réduit.
- Mes rendez-vous : annulation (gratuite plus de 24 h avant), avis après le rendez-vous.

Côté prestataire (compte de démonstration : Kaz a Zong), depuis Profil puis "Espace prestataire"
- Agenda du jour et des trois jours suivants, avec les trous.
- "Proposer en Konyéla" sur un trou : prestation, heure, remise.
- Activité : remplissage, chiffre du jour, commission.

Dans Profil, les "Réglages de démonstration" permettent de simuler une heure (utile le soir, quand tout est fermé)
et de tout remettre à zéro.

## Organisation du code

| Dossier | Rôle |
|---|---|
| `data/pros.ts` | Prestataires fictifs, catégories, règles commerciales (acompte, commission) |
| `utils/schedule.ts` | Logique d'agenda pure : dates, créneaux libres, trous. Testée dans `tests/` |
| `composables/useBel.ts` | État de l'appli et toutes les actions. Seul fichier qui touche au stockage |
| `pages/` | Un fichier par écran |
| `components/` | Carte prestataire, carte Konyéla, feuille du bas |
| `supabase/` | Schéma de base, données de démo, tests des droits d'accès |

## Passer à une vraie base (Supabase)

Le schéma est prêt et testé sur PostgreSQL 16, mais **l'appli ne parle pas encore à Supabase**. Étapes :

1. Créer un projet sur supabase.com (région Europe).
2. Dans l'éditeur SQL, lancer `supabase/schema.sql` puis `supabase/seed.sql`.
3. Copier `.env.example` en `.env` et renseigner l'adresse et la clé publique du projet.
4. Réécrire `composables/useBel.ts` pour lire et écrire dans Supabase au lieu du navigateur.
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
- Géolocalisation : les distances sont fixes, calculées depuis Les Abymes.
- Mentions légales, CGU, RGPD.
- Faire valider "Konyéla" et les textes en créole par un créolophone.
