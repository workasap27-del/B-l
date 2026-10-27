-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- E-mails de service : confirmations, annulations, rappels et demandes d'avis (patch 008) -------------------
-- La liste des e-mails à envoyer est calculée ici ; l'envoi se fait côté serveur (server/api/notifications),
-- avec la clé de service, déclenché toutes les dix minutes (supabase/cron.sql) et juste après chaque réservation.

alter table bookings add column if not exists notified jsonb not null default '{}';

do $$ begin
  if not exists (select 1 from pg_roles where rolname = 'service_role') then create role service_role nologin; end if;
end $$;

create or replace function notifications_due(p_booking uuid default null)
returns table (kind text, booking_id uuid, to_email text, to_name text, pro_id text, pro_name text, pro_phone text, service_name text,
               starts_at timestamptz, place booking_place, client_address text, price_eur numeric, client_name text, client_phone text,
               commune text, quartier text)
language sql stable security definer set search_path = public, auth as $$
  with b as (
    select bk.*, p.name as p_name, p.phone as p_phone, p.owner_id, p.commune as p_commune, p.quartier as p_quartier, s.name as s_name,
           cu.email as client_email, ow.email as owner_email, pr.display_name as owner_name,
           (now() at time zone 'America/Guadeloupe') as gp_now,
           (bk.starts_at at time zone 'America/Guadeloupe') as gp_start
      from bookings bk
      join pros p on p.id = bk.pro_id and not p.is_demo
      join services s on s.id = bk.service_id
      left join auth.users cu on cu.id = bk.client_id
      left join auth.users ow on ow.id = p.owner_id
      left join profiles pr on pr.id = p.owner_id
     where (p_booking is null or bk.id = p_booking)
       and bk.created_at > now() - interval '30 days'
  ), k as (
    select 'confirmation' as kind, b.*, b.client_email as to_email, b.client_name as to_name from b
      where status = 'confirmed' and starts_at > now() and not notified ? 'confirmation'
    union all
    select 'nouvelle_reservation', b.*, b.owner_email, b.owner_name from b
      where status = 'confirmed' and starts_at > now() and owner_email is not null and not notified ? 'nouvelle_reservation'
    union all
    select 'annulation_pro', b.*, b.owner_email, b.owner_name from b
      where status = 'cancelled' and cancelled_by = 'client' and starts_at > now() and owner_email is not null and not notified ? 'annulation_pro'
    union all
    select 'annulation_client', b.*, b.client_email, b.client_name from b
      where status = 'cancelled' and cancelled_by = 'pro' and starts_at > now() and not notified ? 'annulation_client'
    union all
    -- La veille à partir de 18 h, sauf si le rendez-vous a été pris dans les six dernières heures.
    select 'rappel_veille', b.*, b.client_email, b.client_name from b
      where status = 'confirmed' and gp_start::date = gp_now::date + 1 and gp_now::time >= time '18:00'
        and created_at < now() - interval '6 hours' and not notified ? 'rappel_veille'
    union all
    -- Deux heures avant, sauf si le rendez-vous a été pris moins de trois heures avant.
    select 'rappel_2h', b.*, b.client_email, b.client_name from b
      where status = 'confirmed' and starts_at > now() and starts_at <= now() + interval '2 hours 10 minutes'
        and created_at < starts_at - interval '3 hours' and not notified ? 'rappel_2h'
    union all
    -- Deux heures après la fin, une seule demande d'avis, s'il n'y en a pas déjà un.
    select 'avis', b.*, b.client_email, b.client_name from b
      where status = 'confirmed' and no_show is null and ends_at <= now() - interval '2 hours' and ends_at > now() - interval '3 days'
        and not exists (select 1 from reviews r where r.booking_id = b.id) and not notified ? 'avis'
  )
  select k.kind, k.id, k.to_email, coalesce(nullif(k.to_name, ''), 'Bonjour'), k.pro_id, k.p_name, k.p_phone, k.s_name,
         k.starts_at, k.place, k.client_address, k.price_eur, k.client_name, k.client_phone, k.p_commune, k.p_quartier
    from k
   where k.to_email is not null
   order by k.starts_at;
$$;

create or replace function mark_notified(p_booking uuid, p_kind text) returns void
language sql security definer set search_path = public as $$
  update bookings set notified = notified || jsonb_build_object(p_kind, now()) where id = p_booking;
$$;

revoke execute on function notifications_due(uuid), mark_notified(uuid, text) from public, anon, authenticated;
grant execute on function notifications_due(uuid), mark_notified(uuid, text) to service_role;
