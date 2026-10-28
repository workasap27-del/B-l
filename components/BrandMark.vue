<script setup lang="ts">
// Logo VLADI : le V est une fleur qui s'ouvre (deux pétales et un bouton), suivi de LADI en lettres fines.
// Les lettres prennent la couleur du texte ; les pétales et le bouton suivent la charte (--bm-petal, --bm-dot).
withDefaults(defineProps<{ height?: number }>(), { height: 22 })
</script>

<template>
  <svg class="brandmark" :height="height" viewBox="0 0 278 84" role="img" aria-label="VLADI" fill="none" stroke="currentColor" stroke-width="9" stroke-linecap="round" stroke-linejoin="round">
    <path d="M33.5 77 C18.5 66 2.5 41.5 4 9 C23 18.5 35 43 33.5 77 Z" fill="var(--bm-petal, var(--accent))" stroke="none" />
    <path d="M33.5 77 C48.5 66 64.5 41.5 63 9 C44 18.5 32 43 33.5 77 Z" fill="var(--bm-petal, var(--accent))" fill-opacity=".72" stroke="none" />
    <circle cx="33.5" cy="13.5" r="6.5" fill="var(--bm-dot, var(--now))" stroke="none" />
    <path d="M92 17 V71 H118" />
    <path d="M136 71 L157 17 L178 71 M144 52 H170" />
    <path d="M202 17 V71 H210 A27 27 0 0 0 210 17 Z" />
    <path d="M262 17 V71" />
  </svg>
</template>
