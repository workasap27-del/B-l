// VLADI : appli web mobile (SPA). Fiches d'exemple dans le navigateur, vrais comptes dans Supabase.
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  ssr: false,
  devtools: { enabled: false },
  css: ['~/assets/main.css', '~/assets/chartes.css'],
  app: {
    head: {
      title: 'VLADI',
      htmlAttrs: { lang: 'fr' },
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1, viewport-fit=cover' },
        { name: 'description', content: 'Réserver une prestation beauté en Guadeloupe, à l\'avance ou tout de suite.' },
        // Installée sur l'écran d'accueil, l'appli s'ouvre en plein écran comme une appli native.
        { name: 'theme-color', content: '#ffffff' },
        { name: 'mobile-web-app-capable', content: 'yes' },
        { name: 'apple-mobile-web-app-capable', content: 'yes' },
        { name: 'apple-mobile-web-app-title', content: 'VLADI' },
        { name: 'apple-mobile-web-app-status-bar-style', content: 'default' },
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/icon.svg' },
        { rel: 'apple-touch-icon', href: '/icon-180.png' },
        { rel: 'manifest', href: '/manifest.webmanifest' },
        { rel: 'preconnect', href: 'https://images.pexels.com' },
      ],
    },
  },
  runtimeConfig: {
    public: {
      // Clé publique Supabase : prévue pour être dans le navigateur, la sécurité repose sur les règles de la base.
      // Variables d'environnement NUXT_PUBLIC_SUPABASE_URL et NUXT_PUBLIC_SUPABASE_KEY pour changer de projet ;
      // mettre une valeur vide pour faire tourner l'appli sans base.
      supabaseUrl: 'https://dkvqloksvlbniztqdywb.supabase.co',
      supabaseKey: 'sb_publishable_-pjzbL8kdTPiiiB0pq5m7Q_fHgLMLrB',
    },
  },
})
