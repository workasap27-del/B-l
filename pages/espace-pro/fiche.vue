<script setup lang="ts">
import { ChevronLeft, LocateFixed, Plus, X } from 'lucide-vue-next'
import type { Category, Pro } from '~/data/pros'
import { suggestedServices } from '~/data/generate'
import { cleanSiren, validSiren } from '~/utils/siren'

const router = useRouter()
const { account, remote, saveMyPro, checkSiren, currentPosition, toast } = useVladi()

const KINDS: Pro['kind'][] = ['Indépendante', 'Salon', 'Institut', 'Studio', 'Spa', 'Hôtel']
const AT_HOME: Record<Pro['kind'], string> = { 'Salon': 'Au salon', 'Institut': 'À l\'institut', 'Studio': 'Au studio', 'Spa': 'Au spa', 'Hôtel': 'À l\'hôtel', 'Indépendante': 'Chez le/la pro', 'Indépendant': 'Chez le/la pro' }
const CATS = Object.keys(CAT_SHORT) as Category[]
const COMMUNES = Object.keys(COMMUNE_COORDS).sort((a, b) => a.localeCompare(b, 'fr'))
const DURATIONS = [15, 30, 45, 60, 75, 90, 120, 150, 180, 210, 240, 300, 360]
const HOURS = Array.from({ length: 35 }, (_, i) => 360 + i * 30) // de 6h00 à 23h00
const DAYS = [1, 2, 3, 4, 5, 6, 0]

const f = reactive({
  id: undefined as string | undefined,
  name: '', ownerName: '', kind: 'Indépendante' as Pro['kind'], siren: '', phone: '',
  receives: true, travels: false, travel: 10,
  commune: 'Les Abymes', quartier: '', lat: 0, lng: 0, gps: false,
  cats: [] as Category[], about: '', open: 540, close: 1080, closed: [0] as number[],
  services: [] as { id?: string, n: string, d: number, p: number }[],
})
const error = ref('')
const busy = ref(false)
const locating = ref(false)

// Vérification du SIREN dans le registre officiel, dès que les 9 chiffres sont saisis.
const company = ref<{ name: string, city: string, activity: string } | null>(null)
const sirenError = ref('')
const sirenChecking = ref(false)
let sirenSeq = 0
watch(() => f.siren, async (v) => {
  company.value = null
  sirenError.value = ''
  const digits = cleanSiren(v)
  if (digits.length !== 9) return
  const seq = ++sirenSeq
  sirenChecking.value = true
  const r = await checkSiren(digits)
  if (seq !== sirenSeq) return
  sirenChecking.value = false
  if (r.error) sirenError.value = r.error
  else company.value = r.company ?? null
}, { immediate: true })

// Pré-remplissage avec la fiche existante ou le compte.
watchEffect(() => {
  const p = remote.myPro
  if (p && f.id !== p.id) {
    Object.assign(f, {
      id: p.id, name: p.name, ownerName: p.owner ?? '', kind: p.kind, siren: p.siren ?? '', phone: p.phone ?? '',
      receives: p.where.some(w => w !== 'À domicile'), travels: p.where.includes('À domicile'), travel: p.travel ?? 0,
      commune: p.commune, quartier: p.quartier, lat: p.lat, lng: p.lng, gps: true,
      cats: [...p.cats], about: p.about, open: p.open, close: p.close, closed: [...p.closed],
      services: p.services.map(s => ({ ...s })),
    })
  }
  else if (!p && account.value && !f.ownerName) {
    f.ownerName = account.value.name
    f.phone = account.value.phone ?? ''
  }
})

const suggestions = computed(() => {
  const have = new Set(f.services.map(s => s.n.toLowerCase()))
  return f.cats.flatMap(c => suggestedServices(c)).filter((s, i, all) => !have.has(s.n.toLowerCase()) && all.findIndex(x => x.n === s.n) === i).slice(0, 12)
})

function toggleCat(c: Category) {
  f.cats = f.cats.includes(c) ? f.cats.filter(x => x !== c) : [...f.cats, c]
}
function toggleDay(d: number) {
  f.closed = f.closed.includes(d) ? f.closed.filter(x => x !== d) : [...f.closed, d]
}
function addService(s = { n: '', d: 60, p: 30 }) {
  f.services.push({ ...s })
}
async function locate() {
  locating.value = true
  const pos = await currentPosition()
  locating.value = false
  if (!pos || !inGuadeloupe(pos)) return toast('Position introuvable ou hors Guadeloupe : on garde le centre de la commune.')
  f.lat = pos.lat
  f.lng = pos.lng
  f.gps = true
  toast('Position enregistrée')
}
watch(() => f.commune, () => { if (!remote.myPro || f.commune !== remote.myPro.commune) f.gps = false })

function check(): string {
  if (f.name.trim().length < 2) return 'Indique le nom de ton activité.'
  if (!validSiren(f.siren)) return 'Le SIREN doit être un vrai numéro à 9 chiffres.'
  if (sirenChecking.value) return 'Vérification du SIREN en cours, un instant.'
  if (sirenError.value) return sirenError.value
  if (!company.value) return 'Le SIREN n\'a pas pu être vérifié. Réessaie.'
  if (!f.cats.length) return 'Choisis au moins une catégorie.'
  if (!f.receives && !f.travels) return 'Indique si tu reçois, si tu te déplaces, ou les deux.'
  if (f.close <= f.open) return 'L\'heure de fermeture doit être après l\'ouverture.'
  if (f.closed.length === 7) return 'Laisse au moins un jour ouvert.'
  const list = f.services.filter(s => s.n.trim())
  if (!list.length) return 'Ajoute au moins une prestation.'
  if (list.some(s => !(s.p > 0))) return 'Chaque prestation doit avoir un prix.'
  return ''
}

async function save() {
  error.value = check()
  if (error.value) return
  const point = f.gps ? { lat: f.lat, lng: f.lng } : communePoint(f.commune)
  const places = [...(f.receives ? [AT_HOME[f.kind]] : []), ...(f.travels ? ['À domicile'] : [])]
  busy.value = true
  const e = await saveMyPro({
    id: f.id, name: f.name, ownerName: f.ownerName, kind: f.kind, siren: f.siren, phone: f.phone,
    places, travel: f.travels ? Math.max(0, Number(f.travel) || 0) : 0, commune: f.commune, quartier: f.quartier,
    lat: point.lat, lng: point.lng, cats: f.cats, about: f.about, open: f.open, close: f.close, closed: f.closed,
    services: f.services.filter(s => s.n.trim()).map(s => ({ ...s, p: Number(s.p) })),
  })
  busy.value = false
  if (e) return (error.value = e)
  toast(f.id ? 'Fiche mise à jour' : 'Ta fiche est en ligne !')
  router.push(remote.myPro ? `/pro/${remote.myPro.id}` : '/espace-pro')
}
</script>

<template>
  <div class="head"><button class="icon-btn" aria-label="Retour" @click="router.back()"><ChevronLeft :size="24" /></button></div>

  <template v-if="!account">
    <div class="col gap8 mt16">
      <h1 class="title">Crée ta fiche prestataire</h1>
      <p class="meta">Connecte-toi ou crée un compte pour publier ta fiche. C'est gratuit.</p>
    </div>
    <div class="col gap12 mt24">
      <NuxtLink class="btn block" to="/connexion?mode=inscription&role=pro&retour=/espace-pro/fiche">Créer un compte</NuxtLink>
      <NuxtLink class="btn block line" to="/connexion?retour=/espace-pro/fiche">J'ai déjà un compte</NuxtLink>
    </div>
  </template>

  <form v-else class="col" novalidate @submit.prevent="save">
    <div class="col gap8 mt16">
      <h1 class="title">{{ f.id ? 'Ma fiche' : 'Crée ta fiche' }}</h1>
      <p class="meta">On te trouve par ce que tu fais et par l'endroit où tu es. Tu peux tout modifier ensuite.</p>
    </div>

    <div class="fieldset mt24">
      <span class="h3">Ton activité</span>
      <label class="field" for="f-name"><span>Nom affiché</span><input id="f-name" v-model="f.name" class="input" placeholder="Ex. Ongles by Kelly"></label>
      <label class="field" for="f-owner"><span>Ton prénom <span class="help">(facultatif)</span></span><input id="f-owner" v-model="f.ownerName" class="input" autocomplete="given-name"></label>
      <div class="field"><span>Ton statut</span>
        <div class="chips" style="flex-wrap:wrap;margin:0;padding:0"><button v-for="k in KINDS" :key="k" type="button" class="chip" :aria-pressed="f.kind === k" @click="f.kind = k">{{ k === 'Indépendante' ? 'Indépendant·e' : k }}</button></div>
      </div>
      <label class="field" for="f-siren">
        <span>SIREN <span class="help">(9 chiffres, sur ton certificat d'inscription ou sur <a class="link" href="https://annuaire-entreprises.data.gouv.fr" target="_blank" rel="noopener">annuaire-entreprises.data.gouv.fr</a>)</span></span>
        <input id="f-siren" v-model="f.siren" class="input" inputmode="numeric" maxlength="11" placeholder="9 chiffres">
        <span v-if="sirenChecking" class="meta">Vérification dans le registre officiel…</span>
        <span v-else-if="company" class="meta" style="color:var(--ok)">Entreprise trouvée : {{ company.name }}{{ company.city ? `, ${company.city}` : '' }}</span>
        <span v-else-if="sirenError" class="meta" style="color:var(--warn)">{{ sirenError }}</span>
      </label>
      <label class="field" for="f-phone"><span>Téléphone pro <span class="help">(affiché sur ta fiche)</span></span><input id="f-phone" v-model="f.phone" class="input" type="tel" placeholder="0690 00 00 00"></label>
    </div>

    <div class="fieldset">
      <span class="h3">Ce que tu proposes</span>
      <div class="chips" style="flex-wrap:wrap;margin:0;padding:0">
        <button v-for="c in CATS" :key="c" type="button" class="chip" :aria-pressed="f.cats.includes(c)" @click="toggleCat(c)">{{ CAT_SHORT[c] }}</button>
      </div>
      <p v-if="f.cats.includes('tatouage') || f.cats.includes('piercing')" class="notice">Tatouage et piercing : la formation à l'hygiène et à la salubrité est obligatoire, et l'activité doit être déclarée auprès de l'ARS (préfecture). Pour les mineurs, l'autorisation d'un parent est exigée. VLADI ne vérifie pas ces points : tu en restes responsable.</p>
      <p v-if="f.cats.includes('hotel')" class="notice">Pour les hôtels, VLADI réserve pour l'instant des créneaux dans la journée (chambre en day use, piscine, brunch, soins). Les nuitées ne sont pas encore gérées.</p>
      <div v-for="(s, i) in f.services" :key="i" class="svc-edit">
        <input v-model="s.n" class="input" :aria-label="`Prestation ${i + 1}`" placeholder="Nom de la prestation">
        <select v-model.number="s.d" class="select" :aria-label="`Durée ${i + 1}`"><option v-for="d in DURATIONS" :key="d" :value="d">{{ duration(d) }}</option></select>
        <input v-model.number="s.p" class="input" type="number" min="0" step="1" inputmode="decimal" :aria-label="`Prix ${i + 1} en euros`" placeholder="€">
        <button type="button" class="icon-btn" :aria-label="`Retirer ${s.n || 'la prestation'}`" @click="f.services.splice(i, 1)"><X :size="18" /></button>
      </div>
      <button type="button" class="btn sm soft" style="align-self:flex-start" @click="addService()"><Plus :size="16" />Ajouter une prestation</button>
      <div v-if="suggestions.length" class="col gap8">
        <span class="meta">Suggestions, touche pour ajouter puis ajuste le prix :</span>
        <div class="chips" style="flex-wrap:wrap;margin:0;padding:0">
          <button v-for="s in suggestions" :key="s.n" type="button" class="chip" @click="addService(s)"><Plus :size="14" />{{ s.n }}</button>
        </div>
      </div>
    </div>

    <div class="fieldset">
      <span class="h3">Où</span>
      <label class="field" for="f-commune"><span>Commune</span><select id="f-commune" v-model="f.commune" class="select"><option v-for="c in COMMUNES" :key="c">{{ c }}</option></select></label>
      <label class="field" for="f-quartier"><span>Quartier <span class="help">(facultatif)</span></span><input id="f-quartier" v-model="f.quartier" class="input" placeholder="Ex. Raizet"></label>
      <button type="button" class="btn sm line" style="align-self:flex-start" :disabled="locating" @click="locate"><LocateFixed :size="16" />{{ f.gps ? 'Position précise enregistrée' : 'Utiliser ma position exacte' }}</button>
      <label class="switch"><span>Je reçois ({{ AT_HOME[f.kind].toLowerCase() }})</span><input v-model="f.receives" type="checkbox"></label>
      <label class="switch"><span>Je me déplace à domicile</span><input v-model="f.travels" type="checkbox"></label>
      <label v-if="f.travels" class="field" for="f-travel"><span>Frais de déplacement (€)</span><input id="f-travel" v-model.number="f.travel" class="input" type="number" min="0" step="1" inputmode="decimal"></label>
    </div>

    <div class="fieldset">
      <span class="h3">Horaires</span>
      <div class="row gap12">
        <label class="field grow" for="f-open"><span>Ouverture</span><select id="f-open" v-model.number="f.open" class="select"><option v-for="h in HOURS" :key="h" :value="h">{{ hm(h) }}</option></select></label>
        <label class="field grow" for="f-close"><span>Fermeture</span><select id="f-close" v-model.number="f.close" class="select"><option v-for="h in HOURS" :key="h" :value="h">{{ hm(h) }}</option></select></label>
      </div>
      <div class="field"><span>Jours de fermeture</span>
        <div class="chips" style="flex-wrap:wrap;margin:0;padding:0">
          <button v-for="d in DAYS" :key="d" type="button" class="chip" :aria-pressed="f.closed.includes(d)" @click="toggleDay(d)">{{ WEEK[d].slice(0, 3) }}</button>
        </div>
      </div>
    </div>

    <div class="fieldset">
      <label class="field" for="f-about"><span class="h3">Présentation <span class="help">(facultatif)</span></span><textarea id="f-about" v-model="f.about" class="textarea" rows="4" maxlength="600" placeholder="Ton style, ton expérience, ce qui te rend unique." /></label>
    </div>

    <p v-if="error" class="error">{{ error }}</p>
    <div class="cta">
      <button class="btn block" type="submit" :disabled="busy">{{ busy ? 'Enregistrement…' : f.id ? 'Enregistrer les modifications' : 'Publier ma fiche' }}</button>
    </div>
  </form>
</template>
