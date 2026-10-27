// Plan du site pour les moteurs de recherche : pages fixes, catégories et fiches réelles publiées.
import { CATEGORIES } from '~/data/pros'
import { LEGAL } from '~/data/legal'

export default defineEventHandler(async (event) => {
  const { public: cfg } = useRuntimeConfig()
  const site = LEGAL.site.replace(/\/$/, '')
  const urls = ['/', '/recherche', '/konyela', '/a-propos', '/faq', '/devenir-prestataire', '/cgu', '/confidentialite', '/mentions-legales']
  for (const [c] of CATEGORIES) if (c !== 'all') urls.push(`/recherche?cat=${c}`)
  if (cfg.supabaseUrl && cfg.supabaseKey) {
    try {
      const rows = await $fetch<{ id: string }[]>(`${cfg.supabaseUrl}/rest/v1/pros?select=id&is_demo=eq.false`, {
        headers: { apikey: cfg.supabaseKey, Authorization: `Bearer ${cfg.supabaseKey}` },
      })
      for (const r of rows) urls.push(`/pro/${encodeURIComponent(r.id)}`)
    }
    catch {
      // Base injoignable : le plan reste valable avec les pages fixes.
    }
  }
  const esc = (s: string) => s.replace(/&/g, '&amp;')
  setHeader(event, 'content-type', 'application/xml; charset=utf-8')
  setHeader(event, 'cache-control', 'public, max-age=3600')
  return `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls.map(u => `  <url><loc>${esc(site + u)}</loc></url>`).join('\n')}\n</urlset>\n`
})
