// Mise en avant payante dans les résultats : au plus deux fiches sponsorisées, parmi celles qui correspondent déjà à la recherche.

/** Place les fiches sponsorisées en 1re et 4e position, sans en ajouter qui ne correspondent pas aux filtres. */
export function withSponsored<T extends { pro: { id: string } }>(hits: T[], sponsored: Set<string>, max = 2): (T & { sponsored?: boolean })[] {
  if (!sponsored.size) return hits
  const picked = hits.filter(h => sponsored.has(h.pro.id)).slice(0, max).map(h => ({ ...h, sponsored: true }))
  if (!picked.length) return hits
  const ids = new Set(picked.map(h => h.pro.id))
  const rest: (T & { sponsored?: boolean })[] = hits.filter(h => !ids.has(h.pro.id))
  const slots = [0, 3]
  picked.forEach((h, i) => rest.splice(Math.min(slots[i], rest.length), 0, h))
  return rest
}
