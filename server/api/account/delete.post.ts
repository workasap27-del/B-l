// Suppression du compte de la personne connectée, depuis l'appli.
// 1. Les rendez-vous à venir sont annulés et les autres personnes prévenues par e-mail.
// 2. La fiche du prestataire et ses photos sont supprimées.
// 3. Le compte est supprimé (profil, favoris, avis et réservations passées avec lui).
export default defineEventHandler(async (event) => {
  const c = mailConfig()
  if (!c.url || !c.service) throw createError({ statusCode: 503, statusMessage: 'Suppression automatique indisponible' })
  const token = (getHeader(event, 'authorization') ?? '').replace(/^Bearer\s+/i, '')
  if (!token) throw createError({ statusCode: 401, statusMessage: 'Connexion requise' })
  const pub = useRuntimeConfig().public.supabaseKey as string
  const user = await jsonFetch<{ id: string }>(`${c.url}/auth/v1/user`, { headers: { apikey: pub, Authorization: `Bearer ${token}` } })
    .catch(() => { throw createError({ statusCode: 401, statusMessage: 'Session expirée' }) })
  const service = { apikey: c.service, Authorization: `Bearer ${c.service}` }

  const cancelled = await jsonFetch<{ booking_id: string }[]>(`${c.url}/rest/v1/rpc/close_account_prepare`, { method: 'POST', headers: service, body: { p_user: user.id } })
  if (c.ok) {
    for (const b of cancelled) await runNotifications(b.booking_id, ['annulation_pro', 'annulation_client']).catch(() => null)
  }
  const paths = await jsonFetch<string[]>(`${c.url}/rest/v1/rpc/close_account_finish`, { method: 'POST', headers: service, body: { p_user: user.id } })
  if (paths?.length) {
    await jsonFetch(`${c.url}/storage/v1/object/pro-photos`, { method: 'DELETE', headers: service, body: { prefixes: paths } }).catch(() => null)
  }
  await jsonFetch(`${c.url}/auth/v1/admin/users/${user.id}`, { method: 'DELETE', headers: service })
  return { deleted: true, cancelled: cancelled.length }
})
