<script setup lang="ts">
// Logo VLADI : le V et le A se répondent en miroir, chacun avec son point.
withDefaults(defineProps<{ height?: number }>(), { height: 22 })
</script>

<template>
  <svg class="logo" :height="height" viewBox="0 0 268 80" role="img" aria-label="VLADI" fill="none" stroke="currentColor" stroke-width="12" stroke-linecap="round" stroke-linejoin="round">
    <path d="M10 12 L32 68 L54 12" stroke="var(--logo-v, var(--accent))" />
    <circle cx="32" cy="16" r="7" fill="var(--logo-dot, var(--now))" stroke="none" />
    <path d="M82 12 V68 H110" />
    <path d="M128 68 L150 12 L172 68" />
    <circle cx="150" cy="64" r="7" fill="var(--logo-dot, var(--now))" stroke="none" />
    <path d="M198 12 V68 H206 A28 28 0 0 0 206 12 Z" />
    <path d="M258 12 V68" />
  </svg>
</template>
