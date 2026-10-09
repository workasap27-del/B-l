// Génère supabase/seed.sql à partir de data/pros.ts : node scripts/gen-seed.mjs
import { writeFileSync } from 'node:fs'
import { PROS } from '../data/pros.ts'

const q = v => (v === undefined || v === null ? 'null' : `'${String(v).replace(/'/g, "''")}'`)
const arr = (list, cast) => `array[${list.map(x => (typeof x === 'number' ? x : q(x))).join(', ')}]::${cast}[]`

const lines = ['-- Données de démonstration (fictives). Fichier généré par scripts/gen-seed.mjs, ne pas modifier à la main.', '']
for (const p of PROS) {
  lines.push(
    `insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values (`
    + [q(p.id), q(p.name), q(p.owner), q(p.kind), arr(p.where, 'text'), q(p.commune), q(p.quartier), arr(p.cats, 'text'), arr(p.tags, 'text'), q(p.about), p.open, p.close, arr(p.closed, 'smallint'), p.h, 'true'].join(', ')
    + ');',
  )
  for (const s of p.services) {
    lines.push(`insert into services (pro_id, code, name, duration_min, price_eur) values (${q(p.id)}, ${q(s.id)}, ${q(s.n)}, ${s.d}, ${s.p});`)
  }
  lines.push('')
}
writeFileSync(new URL('../supabase/seed.sql', import.meta.url), lines.join('\n'))
console.log(`seed.sql : ${PROS.length} prestataires, ${PROS.reduce((a, p) => a + p.services.length, 0)} prestations`)
