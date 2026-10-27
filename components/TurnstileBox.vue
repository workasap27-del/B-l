<script setup lang="ts">
// Vérification anti-robots Cloudflare Turnstile, le plus souvent invisible. Rien ne s'affiche sans clé configurée.
const emit = defineEmits<{ token: [value: string] }>()
const key = useRuntimeConfig().public.turnstileSiteKey as string
const el = ref<HTMLElement | null>(null)
let widget: string | undefined

interface Turnstile { render: (el: HTMLElement, o: Record<string, unknown>) => string, reset: (id?: string) => void, remove: (id?: string) => void }
const ts = () => (window as unknown as { turnstile?: Turnstile }).turnstile

function load(): Promise<void> {
  if (ts()) return Promise.resolve()
  return new Promise((resolve, reject) => {
    const s = document.createElement('script')
    s.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'
    s.async = true
    s.onload = () => resolve()
    s.onerror = () => reject(new Error('Turnstile indisponible'))
    document.head.appendChild(s)
  })
}

onMounted(async () => {
  if (!key || !el.value) return
  try {
    await load()
    widget = ts()!.render(el.value, {
      'sitekey': key,
      'language': 'fr',
      'appearance': 'interaction-only',
      'callback': (t: string) => emit('token', t),
      'expired-callback': () => emit('token', ''),
      'error-callback': () => emit('token', ''),
    })
  }
  catch {
    emit('token', '')
  }
})
onBeforeUnmount(() => { if (widget) ts()?.remove(widget) })
defineExpose({ reset: () => { if (widget) ts()?.reset(widget) } })
</script>

<template>
  <div v-if="key" ref="el" class="turnstile" />
</template>
