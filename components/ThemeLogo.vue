<script setup lang="ts">
// Logo VLADI des thèmes du mode présentation : le mot en lettres du thème, un motif propre au thème
// (hibiscus, feuille ou palme) et, sur demande, la mention « beauté et bien-être en Guadeloupe ».
const props = withDefaults(defineProps<{ height?: number, tagline?: boolean }>(), { height: 22, tagline: false })
const { state } = useVladi()
const id = computed(() => themeOf(state.theme).id)
const deco = computed(() => ({ terracotta: 'hibiscus', lavande: 'hibiscus', corail: 'hibiscus', jardin: 'feuille', editorial: 'palme' } as Record<string, string>)[id.value])
const size = computed(() => `${props.height}px`)
</script>

<template>
  <span class="tlogo" :class="`tl-${id}`" :style="{ '--tl': size }" role="img" aria-label="VLADI">
    <span class="tl-top" aria-hidden="true">
      <span class="tl-word">VLADI</span>
      <svg v-if="deco === 'hibiscus'" class="tl-deco" viewBox="-24 -24 48 48">
        <g fill="currentColor">
          <ellipse v-for="a in [0, 72, 144, 216, 288]" :key="a" cx="0" cy="-11" rx="8.5" ry="12.5" :transform="`rotate(${a})`" />
        </g>
        <circle r="4" fill="var(--tl-eye, #fff)" opacity=".85" />
        <path d="M0 0 L9 -15" stroke="var(--tl-eye, #fff)" stroke-width="2" stroke-linecap="round" opacity=".9" />
        <circle cx="9" cy="-15" r="2.2" fill="var(--tl-eye, #fff)" />
      </svg>
      <svg v-else-if="deco === 'feuille'" class="tl-deco" viewBox="0 0 40 40">
        <path d="M6 34 C6 14 18 5 36 5 C36 24 26 34 6 34 Z" fill="currentColor" />
        <path d="M8 32 C16 24 24 16 32 9" stroke="var(--tl-eye, #fff)" stroke-width="2" fill="none" stroke-linecap="round" />
      </svg>
      <svg v-else class="tl-deco" viewBox="0 0 60 40" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round">
        <path d="M30 36 C30 24 30 14 30 6" /><path d="M30 30 C20 28 12 22 8 12" /><path d="M30 30 C40 28 48 22 52 12" /><path d="M30 22 C22 20 16 14 14 6" /><path d="M30 22 C38 20 44 14 46 6" />
      </svg>
    </span>
    <span v-if="tagline" class="tl-tag" aria-hidden="true">{{ id === 'corail' ? 'Beauté  Bien-être  Guadeloupe' : 'Beauté & bien-être en Guadeloupe' }}</span>
  </span>
</template>
