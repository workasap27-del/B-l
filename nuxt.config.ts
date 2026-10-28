// VLADI : appli web mobile (SPA). Fiches d'exemple dans le navigateur, vrais comptes dans Supabase.
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  ssr: false,
  devtools: { enabled: false },
  css: ['~/assets/main.css', '~/assets/chartes.css',
    // Polices des thèmes du mode présentation (hébergées avec l'appli, aucune requête externe)
    '@fontsource/inter/latin-400.css',
    '@fontsource/inter/latin-500.css',
    '@fontsource/inter/latin-600.css',
    '@fontsource/inter/latin-700.css',
    '@fontsource/plus-jakarta-sans/latin-500.css',
    '@fontsource/plus-jakarta-sans/latin-600.css',
    '@fontsource/plus-jakarta-sans/latin-700.css',
    '@fontsource/plus-jakarta-sans/latin-800.css',
    '@fontsource/dm-sans/latin-400.css',
    '@fontsource/dm-sans/latin-500.css',
    '@fontsource/dm-sans/latin-700.css',
    '@fontsource/anton/latin-400.css',
    '@fontsource/caveat/latin-500.css',
    '@fontsource/caveat/latin-700.css',
    '@fontsource/fraunces/latin-400.css',
    '@fontsource/fraunces/latin-500.css',
    '@fontsource/fraunces/latin-600.css',
    '@fontsource/fraunces/latin-700.css',
    '@fontsource/playfair-display/latin-400.css',
    '@fontsource/playfair-display/latin-500.css',
    '@fontsource/playfair-display/latin-600.css',
    '@fontsource/playfair-display/latin-700.css',
    '@fontsource/la-belle-aurore/latin-400.css',
    '~/assets/themes.css'],
  app: {
    head: {
      title: 'VLADI',
      htmlAttrs: { lang: 'fr' },
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1, viewport-fit=cover' },
        { name: 'description', content: 'Réserve ta prestation beauté et bien-être en Guadeloupe : coiffure, ongles, cils, soins, massage, tatouage… à l\'avance ou tout de suite.' },
        // Aperçu quand un lien VLADI est partagé (WhatsApp, Facebook, SMS).
        { property: 'og:site_name', content: 'VLADI' },
        { property: 'og:type', content: 'website' },
        { property: 'og:locale', content: 'fr_FR' },
        { property: 'og:title', content: 'VLADI · Réserve ton instant beauté et bien-être' },
        { property: 'og:description', content: 'Des prestataires locaux près de chez toi, en Guadeloupe.' },
        { property: 'og:image', content: 'https://bel-manzel.vercel.app/og.png' },
        { name: 'twitter:card', content: 'summary_large_image' },
        // Installée sur l'écran d'accueil, l'appli s'ouvre en plein écran comme une appli native.
        { name: 'theme-color', content: '#ffffff' },
        { name: 'mobile-web-app-capable', content: 'yes' },
        { name: 'apple-mobile-web-app-capable', content: 'yes' },
        { name: 'apple-mobile-web-app-title', content: 'VLADI' },
        { name: 'apple-mobile-web-app-status-bar-style', content: 'default' },
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/icon.svg?v=2' },
        { rel: 'apple-touch-icon', href: '/icon-180.png?v=2' },
        { rel: 'manifest', href: '/manifest.webmanifest?v=2' },
        { rel: 'preconnect', href: 'https://images.pexels.com' },
      ],
    },
  },
  runtimeConfig: {
    // Clés secrètes, uniquement côté serveur (variables d'environnement Vercel du même nom en NUXT_…).
    // Vides : les e-mails de service sont simplement désactivés.
    supabaseServiceKey: '',
    brevoKey: '',
    mailFrom: '',
    cronSecret: '',
    public: {
      // Clé publique Supabase : prévue pour être dans le navigateur, la sécurité repose sur les règles de la base.
      // Variables d'environnement NUXT_PUBLIC_SUPABASE_URL et NUXT_PUBLIC_SUPABASE_KEY pour changer de projet ;
      // mettre une valeur vide pour faire tourner l'appli sans base.
      supabaseUrl: 'https://dkvqloksvlbniztqdywb.supabase.co',
      supabaseKey: 'sb_publishable_-pjzbL8kdTPiiiB0pq5m7Q_fHgLMLrB',
      // Clé publique Cloudflare Turnstile (anti-robots). Vide : pas de vérification. À activer en même temps
      // que la protection CAPTCHA de Supabase (Authentication > Attack Protection), avec la clé secrète correspondante.
      turnstileSiteKey: '',
      // Connexion avec Google ou Apple : liste séparée par des virgules (« google,apple »), une fois les fournisseurs
      // configurés dans Supabase (Authentication > Providers). Vide : connexion par e-mail seulement.
      oauthProviders: '',
      // Mesure d'audience Vercel Web Analytics (sans cookie). À activer aussi dans le tableau de bord Vercel.
      analytics: false,
    },
  },
})
