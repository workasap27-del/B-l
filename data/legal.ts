// Identité de l'éditeur et des prestataires techniques, reprise par les pages légales.
// Un champ vide n'est pas affiché. Les champs de l'éditeur sont obligatoires avant l'ouverture au public
// (article 6 de la loi pour la confiance dans l'économie numérique).

export const LEGAL = {
  brand: 'VLADI',
  site: 'https://bel-manzel.vercel.app',
  contactEmail: 'work.asap27@gmail.com',
  updated: '16 octobre 2026',
  editor: {
    /** dénomination sociale, ou nom et prénom pour un entrepreneur individuel */
    name: '',
    /** forme juridique et capital, par exemple « SAS au capital de 1 000 € » ou « Entrepreneur individuel » */
    form: '',
    address: '',
    /** SIREN ou numéro RCS */
    registration: '',
    vat: '',
    /** directeur ou directrice de la publication */
    director: '',
    phone: '',
  },
  /** médiateur de la consommation choisi par l'éditeur */
  mediator: { name: '', url: '' },
  host: { name: 'Vercel Inc.', address: '440 N Barranca Ave #4133, Covina, CA 91723, États-Unis', url: 'https://vercel.com' },
  database: { name: 'Supabase, Inc.', place: 'Londres (Royaume-Uni)', url: 'https://supabase.com' },
  mailer: { name: 'Brevo', place: 'Union européenne', url: 'https://www.brevo.com' },
}
