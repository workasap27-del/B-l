// Contenu des e-mails de service. Fonctions pures : le serveur les remplit et les envoie.
import { fromIso } from './time'

export type MailKind = 'confirmation' | 'nouvelle_reservation' | 'annulation_pro' | 'annulation_client' | 'rappel_veille' | 'rappel_2h' | 'avis'

export interface MailData {
  kind: MailKind
  bookingId: string
  toName: string
  proId: string
  proName: string
  proPhone?: string | null
  serviceName: string
  startsAt: string
  place: 'pro' | 'client'
  clientAddress?: string | null
  price: number
  clientName?: string | null
  clientPhone?: string | null
  commune?: string | null
  quartier?: string | null
}

export interface Mail { subject: string, text: string, html: string }

const pad = (n: number) => String(n).padStart(2, '0')
const euros = (n: number) => `${Number(n).toFixed(Number.isInteger(Number(n)) ? 0 : 2).replace('.', ',')} €`
const escapeHtml = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')

/** « mardi 20 octobre à 14h00 », à l'heure de la Guadeloupe. */
export function longWhen(iso: string): string {
  const { date, min } = fromIso(iso)
  const day = new Date(`${date}T12:00:00Z`).toLocaleDateString('fr-FR', { weekday: 'long', day: 'numeric', month: 'long', timeZone: 'UTC' })
  return `${day} à ${Math.floor(min / 60)}h${pad(min % 60)}`
}

function where(d: MailData): string {
  if (d.place === 'client') return `à domicile${d.clientAddress ? ` (${d.clientAddress})` : ''}`
  return [d.quartier, d.commune].filter(Boolean).length ? `chez ${d.proName}, ${[d.quartier, d.commune].filter(Boolean).join(', ')}` : `chez ${d.proName}`
}

export function buildMail(d: MailData, site: string): Mail {
  const rdv = `${d.serviceName}, ${longWhen(d.startsAt)}`
  const myRdv = `${site}/rdv`
  const fiche = `${site}/pro/${encodeURIComponent(d.proId)}`
  const agenda = `${site}/espace-pro`
  let subject = ''
  let lines: string[] = []
  let cta: [string, string] | null = null
  switch (d.kind) {
    case 'confirmation':
      subject = `C'est réservé : ${d.serviceName} chez ${d.proName}`
      lines = [`Ton rendez-vous est confirmé : ${rdv}, ${where(d)}.`, `Prix : ${euros(d.price)}, à régler sur place.`, 'Tu peux annuler sans frais jusqu\'à 24 heures avant depuis l\'onglet Rendez-vous.']
      cta = ['Voir mon rendez-vous', myRdv]
      break
    case 'nouvelle_reservation':
      subject = `Nouvelle réservation : ${d.serviceName}, ${longWhen(d.startsAt)}`
      lines = [`${d.clientName || 'Une personne'} a réservé ${rdv}${d.place === 'client' ? `, à domicile${d.clientAddress ? ` : ${d.clientAddress}` : ''}` : ''}.`, d.clientPhone ? `Téléphone : ${d.clientPhone}.` : '', `Prix : ${euros(d.price)}.`].filter(Boolean)
      cta = ['Ouvrir mon agenda', agenda]
      break
    case 'annulation_pro':
      subject = `Rendez-vous annulé : ${d.serviceName}, ${longWhen(d.startsAt)}`
      lines = [`${d.clientName || 'La personne'} a annulé ${rdv}. Le créneau est de nouveau libre.`, 'Tu peux le proposer en Konyéla s\'il est pour aujourd\'hui.']
      cta = ['Ouvrir mon agenda', agenda]
      break
    case 'annulation_client':
      subject = `${d.proName} a annulé ton rendez-vous`
      lines = [`${d.proName} ne peut pas assurer ${rdv}. Le rendez-vous est annulé.`, 'Désolé pour ce contretemps : d\'autres prestataires sont disponibles près de chez toi.']
      cta = ['Trouver un autre créneau', `${site}/recherche`]
      break
    case 'rappel_veille':
      subject = `Demain : ${d.serviceName} chez ${d.proName}`
      lines = [`Petit rappel : ${rdv}, ${where(d)}.`, 'Un empêchement ? Annule depuis l\'appli pour libérer le créneau.']
      cta = ['Voir mon rendez-vous', myRdv]
      break
    case 'rappel_2h':
      subject = `Dans 2 heures : ${d.serviceName} chez ${d.proName}`
      lines = [`Ton rendez-vous approche : ${rdv}, ${where(d)}.`, d.proPhone ? `En cas de retard, préviens ${d.proName} au ${d.proPhone}, ou signale-le depuis l'appli.` : 'En cas de retard, signale-le depuis l\'appli.']
      cta = ['Voir mon rendez-vous', myRdv]
      break
    case 'avis':
      subject = `Comment s'est passé ton rendez-vous chez ${d.proName} ?`
      lines = [`Ton avis sur ${d.serviceName} aide les autres à choisir, et ${d.proName} à progresser. Ça prend trente secondes.`]
      cta = ['Donner mon avis', myRdv]
      break
  }
  const hello = `Bonjour ${d.toName},`
  const footer = `VLADI, beauté et bien-être en Guadeloupe · ${site}`
  const text = [hello, '', ...lines, '', cta ? `${cta[0]} : ${cta[1]}` : '', '', d.kind === 'confirmation' || d.kind.startsWith('rappel') ? `Fiche du prestataire : ${fiche}` : '', '', footer].join('\n').replace(/\n{3,}/g, '\n\n').trim()
  const html = `<!doctype html><html lang="fr"><body style="margin:0;background:#f6efe8;font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#1c1715">
<div style="max-width:520px;margin:0 auto;padding:28px 20px">
<p style="font-size:22px;font-weight:800;letter-spacing:2px;margin:0 0 24px">VLADI</p>
<div style="background:#fff;border-radius:16px;padding:24px">
<p style="margin:0 0 14px">${escapeHtml(hello)}</p>
${lines.map(l => `<p style="margin:0 0 12px;line-height:1.5">${escapeHtml(l)}</p>`).join('\n')}
${cta ? `<p style="margin:22px 0 4px"><a href="${escapeHtml(cta[1])}" style="display:inline-block;background:#1c1715;color:#fff;text-decoration:none;padding:12px 20px;border-radius:12px;font-weight:600">${escapeHtml(cta[0])}</a></p>` : ''}
</div>
<p style="font-size:12px;color:#6b5a50;margin:18px 4px 0">${escapeHtml(footer)}<br>E-mail de service lié à ton compte, envoyé pour ce rendez-vous.</p>
</div></body></html>`
  return { subject, text, html }
}
