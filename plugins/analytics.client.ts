// Mesure d'audience sans cookie (Vercel Web Analytics), seulement si elle est activée dans la configuration.
export default defineNuxtPlugin(async () => {
  if (!useRuntimeConfig().public.analytics) return
  const { inject } = await import('@vercel/analytics')
  inject({ mode: 'production' })
})
