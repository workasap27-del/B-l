// Bèl : appli web mobile (SPA). Les données vivent dans le navigateur tant que Supabase n'est pas branché.
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  ssr: false,
  devtools: { enabled: false },
  css: ['~/assets/main.css'],
  app: {
    head: {
      title: 'Bèl',
      htmlAttrs: { lang: 'fr' },
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1, viewport-fit=cover' },
        { name: 'description', content: 'Réserver une prestation beauté en Guadeloupe, à l\'avance ou tout de suite.' },
        { name: 'theme-color', content: '#c2185b' },
      ],
      link: [
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,500;12..96,700&family=Figtree:wght@400;500;600;700&display=swap' },
      ],
    },
  },
  runtimeConfig: {
    public: {
      // Vides = mode démo (données locales). Voir README pour brancher Supabase.
      supabaseUrl: '',
      supabaseAnonKey: '',
    },
  },
})
