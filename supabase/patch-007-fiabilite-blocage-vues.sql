-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Fiabilité des clientes, blocage par le prestataire et vues des fiches (patch 007) ---------------------

-- Qui a annulé et quand : sert à compter les annulations tardives.
alter table bookings add column if not exists cancelled_at timestamptz;
alter table bookings add column if not exists cancelled_by text check (cancelled_by in ('client', 'pro'));

create or replace function bookings_cancel_stamp() returns trigger
language plpgsql as $$
begin
  if new.status = 'cancelled' and old.status <> 'cancelled' then
    new.cancelled_at := now();
    new.cancelled_by := case when auth.uid() = old.client_id then 'client' else 'pro' end;
  end if;
  return new;
end $$;
drop trigger if exists bookings_cancel_stamp on bookings;
create trigger bookings_cancel_stamp before update on bookings for each row execute function bookings_cancel_stamp();

-- Indicateur de fiabilité, calculé sur douze mois à partir des faits (aucun commentaire, aucune note).
create or replace function reliability_of(p_client uuid) returns jsonb
language sql stable security definer set search_path = public as $$
  select jsonb_build_object(
    'done', count(*) filter (where status = 'confirmed' and ends_at < now() and no_show is null),
    'noShows', count(*) filter (where no_show = 'client' and disputed_at is null),
    'lateCancels', count(*) filter (where status = 'cancelled' and cancelled_by = 'client' and mode = 'classic' and cancelled_at > starts_at - interval '24 hours'),
    'late', count(*) filter (where late_minutes is not null and place = 'pro'))
  from bookings
  where client_id = p_client and starts_at > now() - interval '12 months';
$$;
revoke execute on function reliability_of(uuid) from public, anon, authenticated;

-- Le prestataire voit la fiabilité d'une cliente qui a réservé chez lui, et seulement elle.
create or replace function client_reliability(p_booking uuid) returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare v_client uuid;
begin
  select client_id into v_client from bookings where id = p_booking and owns_pro(pro_id);
  if not found then raise exception 'Accès refusé'; end if;
  return reliability_of(v_client);
end $$;

-- Chaque personne voit son propre indicateur.
create or replace function my_reliability() returns jsonb
language plpgsql stable security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'Connexion requise'; end if;
  return reliability_of(auth.uid());
end $$;

revoke execute on function client_reliability(uuid), my_reliability() from public, anon;
grant execute on function client_reliability(uuid), my_reliability() to authenticated;

-- Blocage d'une cliente par un prestataire : elle ne peut plus réserver chez lui, nulle part ailleurs ce n'est visible.
create table if not exists pro_blocks (
  pro_id text not null references pros on delete cascade,
  client_id uuid not null references auth.users on delete cascade,
  created_at timestamptz not null default now(),
  primary key (pro_id, client_id)
);
alter table pro_blocks enable row level security;
drop policy if exists "blocages : le prestataire" on pro_blocks;
create policy "blocages : le prestataire" on pro_blocks for all using (owns_pro(pro_id)) with check (owns_pro(pro_id));
revoke all on pro_blocks from anon, authenticated;
grant select, insert, delete on pro_blocks to authenticated;

create or replace function bookings_blocked() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  if exists (select 1 from pro_blocks where pro_id = new.pro_id and client_id = new.client_id) then
    raise exception 'Réservation impossible chez ce prestataire';
  end if;
  return new;
end $$;
drop trigger if exists bookings_blocked on bookings;
create trigger bookings_blocked before insert on bookings for each row execute function bookings_blocked();
revoke execute on function bookings_blocked() from public, anon, authenticated;

-- Vues des fiches, par jour : le prestataire voit combien de personnes ont ouvert sa fiche.
create table if not exists pro_views (
  pro_id text not null references pros on delete cascade,
  day date not null default current_date,
  views integer not null default 0,
  primary key (pro_id, day)
);
alter table pro_views enable row level security;
drop policy if exists "vues : le prestataire" on pro_views;
create policy "vues : le prestataire" on pro_views for select using (owns_pro(pro_id));
revoke all on pro_views from anon, authenticated;
grant select on pro_views to authenticated;

create or replace function track_view(p_pro text) returns void
language plpgsql security definer set search_path = public as $$
begin
  -- Les fiches de démonstration et les visites du prestataire sur sa propre fiche ne comptent pas.
  if not exists (select 1 from pros where id = p_pro and not is_demo and owner_id is distinct from auth.uid()) then return; end if;
  insert into pro_views (pro_id, day, views) values (p_pro, (now() at time zone 'America/Guadeloupe')::date, 1)
    on conflict (pro_id, day) do update set views = pro_views.views + 1;
end $$;
revoke execute on function track_view(text) from public;
grant execute on function track_view(text) to anon, authenticated;
