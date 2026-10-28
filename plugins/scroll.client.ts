// Remonte en haut de la page à chaque changement de page. Le contenu défile dans <main class="screen">,
// pas dans la fenêtre : le retour en haut automatique du routeur ne le touche pas.
// Retour arrière ou avant du navigateur : on retrouve la position où l'on était. Lien vers une ancre (#…) : on y va.
export default defineNuxtPlugin((nuxtApp) => {
  const router = useRouter()
  const saved = new Map<string, number>()
  const box = () => document.querySelector<HTMLElement>('main.screen')
  let fromHistory = false
  let target: { top: number } | { hash: string } | null = null

  window.addEventListener('popstate', () => { fromHistory = true })

  router.beforeEach((_to, from) => {
    const b = box()
    if (b) saved.set(from.fullPath, b.scrollTop)
  })

  router.afterEach((to, from) => {
    const history = fromHistory
    fromHistory = false
    // Même page, seuls les filtres changent (?cat=…) : on ne bouge pas.
    if (to.path === from.path && !to.hash) return
    target = to.hash ? { hash: to.hash } : { top: history ? saved.get(to.fullPath) ?? 0 : 0 }
  })

  function apply() {
    if (!target) return
    const t = target
    target = null
    const b = box()
    if ('hash' in t) {
      document.getElementById(decodeURIComponent(t.hash.slice(1)))?.scrollIntoView()
      return
    }
    if (b) b.scrollTop = t.top
    window.scrollTo(0, t.top)
  }

  nuxtApp.hook('page:finish', () => requestAnimationFrame(apply))
})
