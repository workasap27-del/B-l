<script setup lang="ts">
const emit = defineEmits<{ close: [] }>()
</script>

<template>
  <Teleport to="#sheets">
    <div class="scrim" @click.self="emit('close')">
      <div class="sheet" role="dialog" aria-modal="true">
        <slot />
      </div>
    </div>
  </Teleport>
</template>
