// Rend t() disponible dans tous les gabarits, et règle la langue de la page.
export default defineNuxtPlugin((nuxtApp) => {
  const { t, lang } = useLang()
  nuxtApp.vueApp.config.globalProperties.t = t
  if (typeof document !== 'undefined') document.documentElement.lang = lang.value
})

declare module 'vue' {
  interface ComponentCustomProperties {
    t: (fr: string, params?: Record<string, string | number | undefined | null>) => string
  }
}
