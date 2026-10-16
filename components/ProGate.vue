<script setup lang="ts">
// Espace prestataire sans fiche : on envoie vers la création de fiche (ou l'inscription), sans rien afficher d'autre.
const router = useRouter()
const { account, remote } = useVladi()
watchEffect(() => {
  if (remote.loading) return
  router.replace(account.value ? '/espace-pro/fiche' : '/connexion?mode=inscription&role=pro&retour=/espace-pro/fiche')
})
</script>

<template>
  <div class="empty">Chargement…</div>
</template>
