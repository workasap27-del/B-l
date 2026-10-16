<script setup lang="ts">
// Histogramme simple, une seule série : barres fines arrondies en haut, valeur au survol, étiquettes espacées.
const props = withDefaults(defineProps<{ items: { label: string, value: number, tip: string }[], height?: number, every?: number }>(), { height: 140, every: 1 })
const max = computed(() => Math.max(1, ...props.items.map(i => i.value)))
const hover = ref(-1)
</script>

<template>
  <div class="mbars" :style="{ '--h': `${height}px` }" role="img" :aria-label="items.map(i => i.tip).join(', ')">
    <div class="plot">
      <div v-for="(it, i) in items" :key="i" class="col-hit" @mouseenter="hover = i" @mouseleave="hover = -1" @focus="hover = i" @blur="hover = -1">
        <span class="bar" :class="{ zero: !it.value, on: hover === i }" :style="{ height: it.value ? `${Math.max(3, (it.value / max) * 100)}%` : '2px' }" />
        <span v-if="hover === i" class="tip">{{ it.tip }}</span>
      </div>
    </div>
    <div class="labels">
      <span v-for="(it, i) in items" :key="i">{{ i % every === 0 ? it.label : '' }}</span>
    </div>
  </div>
</template>

<style scoped>
.mbars { display: flex; flex-direction: column; gap: 6px; }
.plot { height: var(--h); display: flex; align-items: flex-end; gap: 2px; border-bottom: 1px solid var(--line); }
.col-hit { flex: 1; height: 100%; display: flex; align-items: flex-end; justify-content: center; position: relative; cursor: default; }
.bar { width: 100%; max-width: 22px; background: var(--accent); border-radius: 4px 4px 0 0; opacity: .85; transition: opacity .15s; }
.bar.on { opacity: 1; }
.bar.zero { background: var(--surface3); }
.tip { position: absolute; bottom: calc(100% + 6px); left: 50%; transform: translateX(-50%); white-space: nowrap; background: var(--ink); color: var(--bg); font-size: 12px; padding: 5px 8px; border-radius: 6px; pointer-events: none; z-index: 2; }
.labels { display: flex; gap: 2px; }
.labels span { flex: 1; text-align: center; font-size: 10.5px; color: var(--muted); white-space: nowrap; overflow: visible; }
</style>
