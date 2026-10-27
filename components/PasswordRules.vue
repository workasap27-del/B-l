<script setup lang="ts">
import { Check, Circle } from 'lucide-vue-next'
import { STRENGTH_LABEL, passwordRules, passwordStrength } from '~/utils/password'

// Jauge et liste des règles, affichées pendant la saisie d'un nouveau mot de passe.
const props = defineProps<{ value: string, email?: string }>()
const rules = computed(() => passwordRules(props.value))
const level = computed(() => passwordStrength(props.value, props.email ?? ''))
</script>

<template>
  <div class="pw-rules" aria-live="polite">
    <div class="pw-meter" :data-level="level" aria-hidden="true"><i /><i /><i /><i /></div>
    <span v-if="level" class="pw-level">{{ t(STRENGTH_LABEL[level]) }}</span>
    <ul>
      <li v-for="r in rules" :key="r.label" :class="{ ok: r.ok }">
        <Check v-if="r.ok" :size="14" :stroke-width="2.4" /><Circle v-else :size="12" :stroke-width="2" />{{ t(r.label) }}
      </li>
    </ul>
  </div>
</template>
