# VLADI

Appli Nuxt 3 (SPA, `ssr: false`) de réservation beauté en Guadeloupe. Voir README.md pour le périmètre.

- Langue : tout le texte visible et les commentaires sont en français. Jamais de tiret long, uniquement le trait d'union.
- `composables/useVladi.ts` est le seul endroit qui lit ou écrit l'état. Les pages n'accèdent ni au stockage ni à Supabase directement.
- Tous les appels Supabase passent par `composables/useBackend.ts`. Fiches réelles : `real: true`. Fiches d'exemple : `data/pros.ts`, réservations dans le navigateur.
- Le prix, l'acompte et les frais d'une réservation réelle sont recalculés par la base (trigger `bookings_fill`). Ne jamais faire confiance au prix envoyé.
- Toute modification de schéma : l'ajouter à `supabase/schema.sql` et un contrôle à `supabase/tests/smoke.sql`, tester sur PostgreSQL 16 local avant de la lancer sur Supabase.
- La logique reste pure dans `utils/` (agenda, recherche, lieux) et couverte par `tests/`. Ajouter un test à chaque règle nouvelle.
- La recherche doit toujours trouver un prestataire par ce qu'il fait, même si son nom n'en dit rien (cas test : "Zombi" et les cils).
- Heures en minutes depuis minuit, dates en clé `AAAA-MM-JJ`, toujours à l'heure de la Guadeloupe (`utils/time.ts`), jamais celle du téléphone.
- Les données de `data/pros.ts` sont fictives. Après modification, relancer `npm run seed:sql`.
- Couleurs uniquement via les jetons CSS de `assets/main.css`. Les cinq chartes (`assets/chartes.css`) ne changent que les couleurs, jamais la police ni les formes. Elles se choisissent dans les réglages de l'accueil (`components/SettingsSheet.vue`).
- Style : police du système, pas de majuscules décoratives, sections aérées (36 px), une seule action principale par écran.
- Les distances partent toujours de `state.pos` (position du téléphone ou commune choisie) via `km()`. Ne jamais remettre de distance fixe dans les données.
- Icônes : `lucide-vue-next`. Carte : Leaflet, chargé uniquement dans `components/ProMap.vue`.
- Avant de pousser : `npm test`, `npm run typecheck` et `npm run build`, puis un parcours complet dans un navigateur.
