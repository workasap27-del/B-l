// Juste après une réservation ou une annulation, l'appli demande l'envoi immédiat des e-mails de cette réservation.
// La personne doit être connectée et liée à la réservation (cliente ou propriétaire de la fiche).
export default defineEventHandler(async (event) => {
  const c = mailConfig()
  if (!c.ok) return { sent: 0, failed: 0, disabled: true }
  const body = await readBody<{ bookingId?: string }>(event)
  const id = String(body?.bookingId ?? '')
  if (!/^[0-9a-f-]{36}$/.test(id)) throw createError({ statusCode: 400, statusMessage: 'Réservation inconnue' })
  const token = (getHeader(event, 'authorization') ?? '').replace(/^Bearer\s+/i, '')
  if (!token) throw createError({ statusCode: 401, statusMessage: 'Connexion requise' })
  const pub = useRuntimeConfig().public.supabaseKey as string
  const user = await jsonFetch<{ id: string }>(`${c.url}/auth/v1/user`, { headers: { apikey: pub, Authorization: `Bearer ${token}` } })
    .catch(() => { throw createError({ statusCode: 401, statusMessage: 'Session expirée' }) })
  const rows = await jsonFetch<{ client_id: string, pros: { owner_id: string | null } }[]>(
    `${c.url}/rest/v1/bookings?id=eq.${id}&select=client_id,pros(owner_id)`,
    { headers: { apikey: c.service, Authorization: `Bearer ${c.service}` } },
  )
  const b = rows[0]
  if (!b || (b.client_id !== user.id && b.pros?.owner_id !== user.id)) throw createError({ statusCode: 403, statusMessage: 'Accès refusé' })
  return await runNotifications(id, ['confirmation', 'nouvelle_reservation', 'annulation_pro', 'annulation_client'])
})
