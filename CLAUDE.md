# VLADI

Appli Nuxt 3 (SPA, `ssr: false`) de réservation beauté en Guadeloupe. Voir README.md pour le périmètre.

- Langue : tout le texte visible et les commentaires sont en français. Jamais de tiret long, uniquement le trait d'union.
- `composables/useVladi.ts` est le seul endroit qui lit ou écrit l'état. Les pages n'accèdent pas au stockage directement.
- La logique reste pure dans `utils/` (agenda, recherche, lieux) et couverte par `tests/`. Ajouter un test à chaque règle nouvelle.
- La recherche doit toujours trouver un prestataire par ce qu'il fait, même si son nom n'en dit rien (cas test : "Zombi" et les cils).
- Heures en minutes depuis minuit, dates en clé `AAAA-MM-JJ` (heure locale).
- Les données de `data/pros.ts` sont fictives. Après modification, relancer `npm run seed:sql`.
- Couleurs uniquement via les jetons CSS de `assets/main.css` (thèmes clair et sombre).
- Avant de pousser : `npm test` et `npm run build`.
