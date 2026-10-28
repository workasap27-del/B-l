<script setup lang="ts">
// Logo VLADI : la fleur-V et LADI (components/BrandMark.vue) ; en mode présentation, le logo du thème.
withDefaults(defineProps<{ height?: number, tagline?: boolean }>(), { height: 22, tagline: false })
const { state } = useVladi()
</script>

<template>
  <ThemeLogo v-if="state.demo" :height="height" :tagline="tagline" />
  <BrandMark v-else class="logo" :height="height" />
</template>
