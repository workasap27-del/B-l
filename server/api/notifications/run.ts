// Tâche planifiée : envoie les rappels, demandes d'avis et e-mails en retard. Appelée toutes les dix minutes
// par Supabase (supabase/cron.sql) ou par Vercel, avec l'en-tête Authorization: Bearer <NUXT_CRON_SECRET>.
export default defineEventHandler(async (event) => {
  const secret = useRuntimeConfig().cronSecret as string
  const auth = getHeader(event, 'authorization') ?? ''
  if (!secret || auth !== `Bearer ${secret}`) throw createError({ statusCode: 401, statusMessage: 'Non autorisé' })
  return await runNotifications()
})
