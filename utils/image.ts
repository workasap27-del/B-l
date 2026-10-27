// Réduit une photo avant l'envoi : plus légère, et ré-encodée en JPEG, ce qui retire les données EXIF (dont la position GPS).

export function fitSize(w: number, h: number, max: number): { w: number, h: number } {
  if (w <= max && h <= max) return { w, h }
  const k = max / Math.max(w, h)
  return { w: Math.round(w * k), h: Math.round(h * k) }
}

export async function shrinkImage(file: Blob, max = 1600, quality = 0.82): Promise<Blob> {
  const bitmap = await createImageBitmap(file, { imageOrientation: 'from-image' } as ImageBitmapOptions)
  const { w, h } = fitSize(bitmap.width, bitmap.height, max)
  const canvas = document.createElement('canvas')
  canvas.width = w
  canvas.height = h
  const ctx = canvas.getContext('2d')!
  ctx.fillStyle = '#fff'
  ctx.fillRect(0, 0, w, h)
  ctx.drawImage(bitmap, 0, 0, w, h)
  bitmap.close?.()
  const blob = await new Promise<Blob | null>(resolve => canvas.toBlob(resolve, 'image/jpeg', quality))
  if (!blob) throw new Error('Photo illisible')
  return blob
}
