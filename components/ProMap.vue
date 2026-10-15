<script setup lang="ts">
import 'leaflet/dist/leaflet.css'
import type { LayerGroup, Map as LeafletMap } from 'leaflet'
import type { LatLng } from '~/utils/geo'

// Carte OpenStreetMap. Chaque point porte une étiquette (prix ou rien) ; "mini" donne une carte fixe, non déplaçable.
export interface MapItem { id: string, lat: number, lng: number, label?: string }
const props = defineProps<{ items: MapItem[], selected?: string, user?: LatLng, mini?: boolean }>()
const emit = defineEmits<{ select: [id: string] }>()

const el = ref<HTMLElement | null>(null)
let L: typeof import('leaflet') | null = null
let map: LeafletMap | null = null
let layer: LayerGroup | null = null
let fitted = ''
let timer: ReturnType<typeof setTimeout> | undefined

function draw() {
  if (!L || !map || !layer || !el.value?.isConnected) return
  layer.clearLayers()
  if (props.user) {
    L.marker([props.user.lat, props.user.lng], { icon: L.divIcon({ className: '', html: '<span class="me"></span>', iconSize: [0, 0] }), interactive: false, keyboard: false }).addTo(layer)
  }
  for (const it of props.items) {
    const cls = `pin${it.label ? '' : ' dot'}${it.id === props.selected ? ' sel' : ''}`
    const marker = L.marker([it.lat, it.lng], {
      icon: L.divIcon({ className: '', html: `<span class="${cls}">${it.label ?? ''}</span>`, iconSize: [0, 0] }),
      zIndexOffset: it.id === props.selected ? 1000 : 0,
      interactive: !props.mini,
      keyboard: false,
    })
    marker.on('click', () => emit('select', it.id))
    marker.addTo(layer)
  }
  // On ne recadre que si la liste des points a changé, pas à chaque sélection.
  const key = props.items.map(i => i.id).join(',')
  if (key !== fitted) {
    fitted = key
    if (props.items.length === 1) map.setView([props.items[0].lat, props.items[0].lng], 14, { animate: false })
    else if (props.items.length > 1) map.fitBounds(L.latLngBounds(props.items.map(i => [i.lat, i.lng] as [number, number])), { padding: [36, 36], maxZoom: 15, animate: false })
    else if (props.user) map.setView([props.user.lat, props.user.lng], 11, { animate: false })
  }
}

onMounted(async () => {
  const mod = await import('leaflet')
  L = (mod as unknown as { default?: typeof import('leaflet') }).default ?? mod
  if (!el.value) return
  map = L.map(el.value, {
    zoomControl: !props.mini,
    dragging: !props.mini,
    scrollWheelZoom: !props.mini,
    doubleClickZoom: !props.mini,
    touchZoom: !props.mini,
    boxZoom: false,
    keyboard: false,
    // Sans animation : la carte peut être retirée de l'écran à tout moment sans erreur.
    zoomAnimation: false,
    fadeAnimation: false,
    markerZoomAnimation: false,
  }).setView([GUADELOUPE_CENTER.lat, GUADELOUPE_CENTER.lng], 10)
  // Fond de carte épuré (CARTO, données OpenStreetMap) ; sombre avec la charte Nuit.
  const dark = document.documentElement.dataset.charte === 'nuit'
  L.tileLayer(`https://{s}.basemaps.cartocdn.com/${dark ? 'dark_all' : 'light_all'}/{z}/{x}/{y}{r}.png`, {
    maxZoom: 19, subdomains: 'abcd', attribution: '&copy; OpenStreetMap &copy; CARTO',
  }).addTo(map)
  layer = L.layerGroup().addTo(map)
  draw()
  // La carte peut être créée avant que son conteneur ait sa taille définitive.
  timer = setTimeout(() => map?.invalidateSize({ animate: false }), 60)
})
watch(() => [props.items, props.selected, props.user], draw, { deep: true })
onBeforeUnmount(() => {
  clearTimeout(timer)
  map?.remove()
  map = null
})
</script>

<template>
  <div ref="el" class="map" :class="mini ? 'mini' : 'full'" role="application" aria-label="Carte des prestataires" />
</template>
