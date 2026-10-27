// Envoi des e-mails de service. Désactivé tant que les clés ne sont pas configurées sur Vercel :
// NUXT_SUPABASE_SERVICE_KEY (clé secrète Supabase), NUXT_BREVO_KEY (clé API Brevo), NUXT_MAIL_FROM (adresse d'envoi validée dans Brevo).
import { buildMail } from '~/utils/emails'
import type { MailKind } from '~/utils/emails'
import { LEGAL } from '~/data/legal'

interface DueRow {
  kind: MailKind, booking_id: string, to_email: string, to_name: string, pro_id: string, pro_name: string, pro_phone: string | null,
  service_name: string, starts_at: string, place: 'pro' | 'client', client_address: string | null, price_eur: number,
  client_name: string | null, client_phone: string | null, commune: string | null, quartier: string | null
}

export function mailConfig() {
  const cfg = useRuntimeConfig()
  const ok = !!(cfg.public.supabaseUrl && cfg.supabaseServiceKey && cfg.brevoKey && cfg.mailFrom)
  return { ok, url: cfg.public.supabaseUrl as string, service: cfg.supabaseServiceKey as string, brevo: cfg.brevoKey as string, from: cfg.mailFrom as string }
}

/** Appel JSON simple (fetch du navigateur standard, pour ne pas dépendre du typage des routes de Nuxt). */
export async function jsonFetch<T>(url: string, init: { method?: string, headers?: Record<string, string>, body?: unknown } = {}): Promise<T> {
  const res = await fetch(url, {
    method: init.method ?? 'GET',
    headers: { 'content-type': 'application/json', ...init.headers },
    body: init.body === undefined ? undefined : JSON.stringify(init.body),
  })
  if (!res.ok) throw new Error(`${res.status} ${await res.text()}`)
  const text = await res.text()
  return (text ? JSON.parse(text) : null) as T
}

async function rpc<T>(name: string, body: Record<string, unknown>): Promise<T> {
  const c = mailConfig()
  return await jsonFetch<T>(`${c.url}/rest/v1/rpc/${name}`, { method: 'POST', body, headers: { apikey: c.service, Authorization: `Bearer ${c.service}` } })
}

/** Envoie les e-mails en attente (tous, ou ceux d'une réservation) et les marque comme envoyés. */
export async function runNotifications(bookingId?: string, only?: MailKind[]): Promise<{ sent: number, failed: number, disabled?: boolean }> {
  const c = mailConfig()
  if (!c.ok) return { sent: 0, failed: 0, disabled: true }
  const rows = await rpc<DueRow[]>('notifications_due', { p_booking: bookingId ?? null })
  const site = LEGAL.site.replace(/\/$/, '')
  let sent = 0
  let failed = 0
  for (const r of rows) {
    if (only && !only.includes(r.kind)) continue
    const mail = buildMail({
      kind: r.kind, bookingId: r.booking_id, toName: r.to_name, proId: r.pro_id, proName: r.pro_name, proPhone: r.pro_phone,
      serviceName: r.service_name, startsAt: r.starts_at, place: r.place, clientAddress: r.client_address, price: Number(r.price_eur),
      clientName: r.client_name, clientPhone: r.client_phone, commune: r.commune, quartier: r.quartier,
    }, site)
    try {
      await jsonFetch('https://api.brevo.com/v3/smtp/email', {
        method: 'POST',
        headers: { 'api-key': c.brevo, 'accept': 'application/json' },
        body: { sender: { name: 'VLADI', email: c.from }, to: [{ email: r.to_email, name: r.to_name }], subject: mail.subject, htmlContent: mail.html, textContent: mail.text, tags: [r.kind] },
      })
      await rpc('mark_notified', { p_booking: r.booking_id, p_kind: r.kind })
      sent++
    }
    catch (e) {
      failed++
      console.error('e-mail non envoyé', r.kind, r.booking_id, (e as Error).message)
    }
  }
  return { sent, failed }
}
