// Ajout d'un rendez-vous à l'agenda du téléphone (.ics) ou à Google Agenda.
import { toIso } from './time'

export interface CalendarEvent { id: string, title: string, date: string, time: number, dur: number, place: string, details: string }

/** 2026-10-20T14:00:00.000Z -> 20261020T140000Z */
const stamp = (iso: string) => iso.replace(/[-:]/g, '').replace(/\.\d{3}/, '')
const esc = (s: string) => s.replace(/\\/g, '\\\\').replace(/\n/g, '\\n').replace(/([,;])/g, '\\$1')

export function icsText(e: CalendarEvent, now = new Date()): string {
  const start = stamp(toIso(e.date, e.time))
  const end = stamp(toIso(e.date, e.time + e.dur))
  return [
    'BEGIN:VCALENDAR', 'VERSION:2.0', 'PRODID:-//VLADI//Rendez-vous//FR', 'CALSCALE:GREGORIAN', 'METHOD:PUBLISH',
    'BEGIN:VEVENT',
    `UID:${e.id}@vladi`,
    `DTSTAMP:${stamp(now.toISOString())}`,
    `DTSTART:${start}`,
    `DTEND:${end}`,
    `SUMMARY:${esc(e.title)}`,
    `LOCATION:${esc(e.place)}`,
    `DESCRIPTION:${esc(e.details)}`,
    'BEGIN:VALARM', 'ACTION:DISPLAY', 'DESCRIPTION:Rappel VLADI', 'TRIGGER:-PT2H', 'END:VALARM',
    'END:VEVENT', 'END:VCALENDAR', '',
  ].join('\r\n')
}

export function googleCalendarUrl(e: CalendarEvent): string {
  const dates = `${stamp(toIso(e.date, e.time))}/${stamp(toIso(e.date, e.time + e.dur))}`
  const q = new URLSearchParams({ action: 'TEMPLATE', text: e.title, dates, location: e.place, details: e.details })
  return `https://calendar.google.com/calendar/render?${q.toString()}`
}

export function downloadIcs(e: CalendarEvent) {
  const url = URL.createObjectURL(new Blob([icsText(e)], { type: 'text/calendar;charset=utf-8' }))
  const a = document.createElement('a')
  a.href = url
  a.download = 'rendez-vous-vladi.ics'
  document.body.appendChild(a)
  a.click()
  a.remove()
  setTimeout(() => URL.revokeObjectURL(url), 1000)
}
