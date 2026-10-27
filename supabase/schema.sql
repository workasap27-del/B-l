-- VLADI : schéma de base de données pour Supabase (PostgreSQL).
-- À coller dans l'éditeur SQL de Supabase. Les fiches de démonstration restent dans l'appli (data/pros.ts) :
-- la base ne contient que les vrais comptes. supabase/seed.sql sert uniquement aux tests en local.
-- Hypothèse du MVP : un prestataire = un seul poste. Deux rendez-vous confirmés ne peuvent pas se chevaucher chez lui.

create extension if not exists btree_gist;

create type pro_kind as enum ('Salon', 'Institut', 'Indépendante', 'Indépendant', 'Studio', 'Spa', 'Hôtel');
create type booking_mode as enum ('classic', 'konyela');
create type booking_status as enum ('confirmed', 'cancelled');
create type slot_status as enum ('open', 'booked', 'withdrawn');
-- Lieu de la prestation : chez le prestataire (salon, institut, son domicile) ou chez la cliente.
create type booking_place as enum ('pro', 'client');

-- Comptes ---------------------------------------------------------------
create table profiles (
  id uuid primary key references auth.users on delete cascade,
  display_name text not null,
  role text not null default 'client' check (role in ('client', 'pro')),
  phone text,
  commune text,
  created_at timestamptz not null default now()
);

-- Le profil est créé automatiquement à l'inscription, à partir du prénom et du rôle choisis.
create function handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into profiles (id, display_name, role, phone)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''), split_part(new.email, '@', 1)),
    case when new.raw_user_meta_data ->> 'role' = 'pro' then 'pro' else 'client' end,
    nullif(trim(new.raw_user_meta_data ->> 'phone'), '')
  );
  return new;
end;
$$;
create trigger on_auth_user_created after insert on auth.users for each row execute function handle_new_user();

-- Prestataires et prestations --------------------------------------------
-- Contrôle d'un SIREN : 9 chiffres dont la clé de Luhn est correcte (même règle que l'appli).
create or replace function siren_ok(s text) returns boolean language plpgsql immutable as $$
declare total int := 0; d int; i int;
begin
  if s is null or s !~ '^[0-9]{9}$' then return false; end if;
  for i in 0..8 loop
    d := substr(s, 9 - i, 1)::int;
    if i % 2 = 1 then d := d * 2; if d > 9 then d := d - 9; end if; end if;
    total := total + d;
  end loop;
  return total % 10 = 0;
end $$;

create table pros (
  id text primary key,
  owner_id uuid references auth.users on delete set null,
  name text not null,
  owner_name text,
  kind pro_kind not null,
  -- Seuls les prestataires déclarés sont acceptés (SIREN à 9 chiffres). Les fiches de test en sont dispensées.
  siren text check (siren is null or siren_ok(siren)),
  phone text,
  photo_url text,
  -- 'Au salon', 'À l''institut', 'Chez elle', 'Chez lui' (chez le prestataire) et 'À domicile' (chez la cliente)
  places text[] not null default '{}',
  travel_fee_eur numeric(6, 2) not null default 0 check (travel_fee_eur >= 0),
  commune text not null,
  quartier text,
  -- position, pour la carte et le calcul de distance
  lat double precision not null check (lat between -90 and 90),
  lng double precision not null check (lng between -180 and 180),
  categories text[] not null default '{}',
  tags text[] not null default '{}',
  about text,
  opens_at smallint not null check (opens_at between 0 and 1439),
  closes_at smallint not null check (closes_at between 1 and 1440),
  closed_weekdays smallint[] not null default '{}',
  hue smallint not null default 330,
  is_demo boolean not null default false,
  created_at timestamptz not null default now(),
  check (closes_at > opens_at),
  check (is_demo or siren is not null)
);
-- Un compte prestataire = une fiche.
create unique index pros_one_per_owner on pros (owner_id) where owner_id is not null;

create table services (
  id uuid primary key default gen_random_uuid(),
  pro_id text not null references pros on delete cascade,
  code text not null,
  name text not null,
  duration_min smallint not null check (duration_min > 0),
  price_eur numeric(7, 2) not null check (price_eur >= 0),
  active boolean not null default true,
  unique (pro_id, code)
);

-- Créneaux de dernière minute --------------------------------------------
create table konyela_slots (
  id uuid primary key default gen_random_uuid(),
  pro_id text not null references pros on delete cascade,
  service_id uuid not null references services on delete cascade,
  starts_at timestamptz not null,
  discount_pct smallint not null check (discount_pct between 5 and 70),
  status slot_status not null default 'open',
  created_at timestamptz not null default now()
);
create index konyela_slots_open on konyela_slots (starts_at) where status = 'open';

-- Réservations -------------------------------------------------------------
create table bookings (
  id uuid primary key default gen_random_uuid(),
  pro_id text not null references pros on delete cascade,
  service_id uuid not null references services,
  client_id uuid not null references auth.users on delete cascade,
  -- Nom et téléphone recopiés à la réservation : le prestataire n'a pas accès aux profils des clientes.
  client_name text not null default '',
  client_phone text,
  -- Ce que la cliente veut signaler (grossesse, allergie, cheveux fragiles...). Rien n'est vérifié par VLADI.
  client_note text,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  price_eur numeric(7, 2) not null,
  deposit_eur numeric(7, 2) not null,
  mode booking_mode not null default 'classic',
  status booking_status not null default 'confirmed',
  slot_id uuid references konyela_slots on delete set null,
  place booking_place not null default 'pro',
  client_address text,
  travel_fee_eur numeric(6, 2) not null default 0,
  -- Suivi d'arrivée le jour J (celui qui se déplace signale, l'autre confirme)
  arrived_at timestamptz,
  arrival_confirmed_at timestamptz,
  late_minutes smallint check (late_minutes between 5 and 15),
  wait_until timestamptz,
  no_show text check (no_show in ('client', 'pro')),
  disputed_at timestamptz,
  created_at timestamptz not null default now(),
  check (ends_at > starts_at),
  -- Une prestation chez la cliente a forcément une adresse.
  check (place = 'pro' or length(trim(coalesce(client_address, ''))) >= 5),
  -- Empêche la double réservation, même si deux clientes valident en même temps.
  constraint bookings_no_overlap exclude using gist (pro_id with =, tstzrange(starts_at, ends_at) with &&) where (status = 'confirmed'),
  -- Une même cliente ne peut pas avoir deux rendez-vous à la même heure.
  constraint bookings_client_no_overlap exclude using gist (client_id with =, tstzrange(starts_at, ends_at) with &&) where (status = 'confirmed')
);
create index bookings_client on bookings (client_id, starts_at);

-- Avis et favoris ------------------------------------------------------------
create table reviews (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null unique references bookings on delete cascade,
  pro_id text not null references pros on delete cascade,
  client_id uuid not null references auth.users on delete cascade,
  stars smallint not null check (stars between 1 and 5),
  body text,
  created_at timestamptz not null default now()
);

create table favorites (
  client_id uuid not null references auth.users on delete cascade,
  pro_id text not null references pros on delete cascade,
  primary key (client_id, pro_id)
);

create view pro_ratings with (security_invoker = true) as
  select pro_id, round(avg(stars), 1) as rating, count(*) as review_count from reviews group by pro_id;

-- Fonctions ------------------------------------------------------------------

create function owns_pro(p_pro text) returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from pros where id = p_pro and owner_id = auth.uid());
$$;

-- Plages occupées d'un prestataire sur une période, sans révéler qui a réservé.
-- L'appli s'en sert pour calculer les heures libres.
create function busy_intervals(p_pro text, p_from timestamptz, p_to timestamptz)
returns table (starts_at timestamptz, ends_at timestamptz)
language sql stable security definer set search_path = public as $$
  select b.starts_at, b.ends_at from bookings b
   where b.pro_id = p_pro and b.status = 'confirmed' and b.starts_at < p_to and b.ends_at > p_from
  union all
  select k.starts_at, k.starts_at + make_interval(mins => s.duration_min) from konyela_slots k
    join services s on s.id = k.service_id
   where k.pro_id = p_pro and k.status = 'open' and k.starts_at < p_to and k.starts_at + make_interval(mins => s.duration_min) > p_from;
$$;

-- Réserve un créneau Konyéla de façon atomique : le premier arrivé l'emporte.
create function book_konyela_slot(p_slot uuid, p_place booking_place default 'pro', p_address text default null, p_deposit_rate numeric default 0.2, p_client_name text default '', p_client_phone text default null, p_client_note text default null)
returns bookings
language plpgsql security definer set search_path = public as $$
declare
  v_slot konyela_slots;
  v_service services;
  v_pro pros;
  v_fee numeric(6, 2) := 0;
  v_price numeric(7, 2);
  v_booking bookings;
begin
  if auth.uid() is null then
    raise exception 'Connexion requise';
  end if;
  select * into v_slot from konyela_slots where id = p_slot for update;
  if not found or v_slot.status <> 'open' or v_slot.starts_at <= now() then
    raise exception 'Ce créneau n''est plus disponible';
  end if;
  select * into v_service from services where id = v_slot.service_id;
  select * into v_pro from pros where id = v_slot.pro_id;
  if p_place = 'client' then
    if not ('À domicile' = any (v_pro.places)) then
      raise exception 'Ce prestataire ne se déplace pas';
    end if;
    v_fee := v_pro.travel_fee_eur;
  elsif v_pro.places = array['À domicile'] then
    raise exception 'Ce prestataire ne reçoit pas, il se déplace uniquement';
  end if;
  v_price := round(v_service.price_eur * (100 - v_slot.discount_pct) / 100.0) + v_fee;
  update konyela_slots set status = 'booked' where id = p_slot;
  insert into bookings (pro_id, service_id, client_id, client_name, client_phone, client_note, starts_at, ends_at, price_eur, deposit_eur, mode, slot_id, place, client_address, travel_fee_eur)
  values (v_slot.pro_id, v_service.id, auth.uid(), coalesce(p_client_name, ''), p_client_phone, p_client_note, v_slot.starts_at,
          v_slot.starts_at + make_interval(mins => v_service.duration_min),
          v_price, round(v_price * p_deposit_rate), 'konyela', p_slot, p_place, p_address, v_fee)
  returning * into v_booking;
  return v_booking;
end;
$$;

-- Le prix, l'acompte, les frais de déplacement et l'heure de fin sont calculés ici, jamais par l'appli.
create function bookings_fill() returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_service services;
  v_pro pros;
begin
  select * into v_service from services where id = new.service_id and pro_id = new.pro_id and active;
  if not found then
    raise exception 'Prestation inconnue chez ce prestataire';
  end if;
  select * into v_pro from pros where id = new.pro_id;
  if new.mode = 'classic' then
    if new.starts_at < now() then
      raise exception 'Ce créneau est déjà passé';
    end if;
    if new.place = 'client' and not ('À domicile' = any (v_pro.places)) then
      raise exception 'Ce prestataire ne se déplace pas';
    end if;
    if new.place = 'pro' and v_pro.places <@ array['À domicile'] then
      raise exception 'Ce prestataire se déplace uniquement';
    end if;
    new.travel_fee_eur := case when new.place = 'client' then v_pro.travel_fee_eur else 0 end;
    new.price_eur := v_service.price_eur + new.travel_fee_eur;
    new.deposit_eur := round(new.price_eur * 0.2);
    new.ends_at := new.starts_at + make_interval(mins => v_service.duration_min);
  end if;
  return new;
end;
$$;
create trigger bookings_fill before insert on bookings for each row execute function bookings_fill();
revoke execute on function bookings_fill() from public, anon, authenticated;

-- Plages occupées de tous les prestataires sur une période, sans dire qui a réservé.
create function busy_all(p_from timestamptz, p_to timestamptz)
returns table (pro_id text, starts_at timestamptz, ends_at timestamptz)
language sql stable security definer set search_path = public as $$
  select b.pro_id, b.starts_at, b.ends_at from bookings b
   where b.status = 'confirmed' and b.starts_at < p_to and b.ends_at > p_from
  union all
  select k.pro_id, k.starts_at, k.starts_at + make_interval(mins => s.duration_min) from konyela_slots k
    join services s on s.id = k.service_id
   where k.status = 'open' and k.starts_at < p_to and k.starts_at + make_interval(mins => s.duration_min) > p_from;
$$;
grant execute on function busy_all(timestamptz, timestamptz) to anon, authenticated;

-- Droits d'accès (RLS) -------------------------------------------------------
alter table profiles enable row level security;
alter table pros enable row level security;
alter table services enable row level security;
alter table konyela_slots enable row level security;
alter table bookings enable row level security;
alter table reviews enable row level security;
alter table favorites enable row level security;

create policy "profil : le sien" on profiles for all using (id = auth.uid()) with check (id = auth.uid());

create policy "pros : lecture publique" on pros for select using (true);
create policy "pros : création par son propriétaire" on pros for insert with check (owner_id = auth.uid() and not is_demo);
create policy "pros : modification par le propriétaire" on pros for update using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy "prestations : lecture publique" on services for select using (true);
create policy "prestations : gestion par le propriétaire" on services for all using (owns_pro(pro_id)) with check (owns_pro(pro_id));

create policy "konyéla : lecture publique" on konyela_slots for select using (true);
create policy "konyéla : gestion par le propriétaire" on konyela_slots for all using (owns_pro(pro_id)) with check (owns_pro(pro_id));

create policy "réservations : la cliente voit les siennes" on bookings for select using (client_id = auth.uid());
create policy "réservations : le pro voit les siennes" on bookings for select using (owns_pro(pro_id));
create policy "réservations : créer pour soi" on bookings for insert with check (client_id = auth.uid() and mode = 'classic');
create policy "réservations : annuler la sienne" on bookings for update using (client_id = auth.uid()) with check (client_id = auth.uid());
create policy "réservations : le pro peut annuler" on bookings for update using (owns_pro(pro_id)) with check (owns_pro(pro_id));

create policy "avis : lecture publique" on reviews for select using (true);
create policy "avis : un par rendez-vous terminé" on reviews for insert with check (
  client_id = auth.uid()
  and exists (select 1 from bookings b where b.id = booking_id and b.client_id = auth.uid() and b.pro_id = reviews.pro_id and b.status = 'confirmed' and b.ends_at <= now())
);

create policy "favoris : les siens" on favorites for all using (client_id = auth.uid()) with check (client_id = auth.uid());

-- Supabase donne par défaut tous les droits sur les nouvelles tables : on repart de zéro, puis on accorde le strict nécessaire.
revoke all on profiles, pros, services, konyela_slots, bookings, reviews, favorites, pro_ratings from anon, authenticated;
grant usage on schema public to anon, authenticated;
grant select on pros, services, konyela_slots, reviews, pro_ratings to anon, authenticated;
grant select, insert, update, delete on profiles, favorites, konyela_slots, services to authenticated;
grant insert, update on pros to authenticated;
grant select, insert on bookings to authenticated;
-- Une réservation ne se modifie que pour l'annuler ou suivre l'arrivée : ni le prix, ni l'heure, ni le prestataire.
grant update (status, arrived_at, arrival_confirmed_at, late_minutes, wait_until, no_show, disputed_at) on bookings to authenticated;
grant insert on reviews to authenticated;
grant execute on function busy_intervals(text, timestamptz, timestamptz) to anon, authenticated;
grant execute on function book_konyela_slot(uuid, booking_place, text, numeric, text, text, text) to authenticated;
revoke execute on function book_konyela_slot(uuid, booking_place, text, numeric, text, text, text) from public, anon;
revoke execute on function handle_new_user() from public, anon, authenticated;

-- Pilotage par les propriétaires de l'appli (patch 003)

-- Comptes propriétaires ------------------------------------------------------
create table admins (
  user_id uuid primary key references auth.users on delete cascade,
  created_at timestamptz not null default now()
);
alter table admins enable row level security;
revoke all on admins from anon, authenticated;

create function is_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from admins where user_id = auth.uid());
$$;

-- Journal ---------------------------------------------------------------------
create table app_events (
  id bigint generated always as identity primary key,
  at timestamptz not null default now(),
  actor uuid,
  kind text not null,
  pro_id text,
  booking_id uuid,
  detail jsonb not null default '{}'
);
create index app_events_at on app_events (at desc);
alter table app_events enable row level security;
revoke all on app_events from anon, authenticated;

create function log_event() returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_actor uuid := auth.uid();
begin
  if tg_table_name = 'profiles' then
    if tg_op = 'INSERT' then
      insert into app_events (actor, kind, detail) values (new.id, 'inscription', jsonb_build_object('role', new.role));
    elsif new.role is distinct from old.role then
      insert into app_events (actor, kind, detail) values (new.id, 'role', jsonb_build_object('role', new.role));
    end if;
  elsif tg_table_name = 'pros' then
    if new.is_demo then return new; end if;
    if tg_op = 'INSERT' then
      insert into app_events (actor, kind, pro_id, detail)
      values (coalesce(v_actor, new.owner_id), 'fiche_creee', new.id, jsonb_build_object('name', new.name, 'commune', new.commune, 'categories', new.categories));
    else
      insert into app_events (actor, kind, pro_id, detail)
      values (coalesce(v_actor, new.owner_id), 'fiche_modifiee', new.id, jsonb_build_object('name', new.name));
    end if;
  elsif tg_table_name = 'services' then
    if tg_op = 'DELETE' then
      insert into app_events (actor, kind, pro_id, detail) values (v_actor, 'prestation_retiree', old.pro_id, jsonb_build_object('name', old.name));
      return old;
    elsif tg_op = 'INSERT' then
      insert into app_events (actor, kind, pro_id, detail) values (v_actor, 'prestation_ajoutee', new.pro_id, jsonb_build_object('name', new.name, 'price', new.price_eur));
    elsif new.price_eur is distinct from old.price_eur or new.active is distinct from old.active or new.name is distinct from old.name then
      insert into app_events (actor, kind, pro_id, detail) values (v_actor, 'prestation_modifiee', new.pro_id, jsonb_build_object('name', new.name, 'price', new.price_eur, 'active', new.active));
    end if;
  elsif tg_table_name = 'konyela_slots' then
    if tg_op = 'INSERT' then
      insert into app_events (actor, kind, pro_id, detail) values (v_actor, 'konyela_publie', new.pro_id, jsonb_build_object('discount', new.discount_pct, 'at', new.starts_at));
    end if;
  elsif tg_table_name = 'bookings' then
    if tg_op = 'INSERT' then
      insert into app_events (actor, kind, pro_id, booking_id, detail)
      values (coalesce(v_actor, new.client_id), 'reservation', new.pro_id, new.id,
              jsonb_build_object('price', new.price_eur, 'mode', new.mode, 'place', new.place, 'at', new.starts_at));
    else
      if new.status = 'cancelled' and old.status <> 'cancelled' then
        insert into app_events (actor, kind, pro_id, booking_id, detail)
        values (v_actor, 'annulation', new.pro_id, new.id,
                jsonb_build_object('by', case when v_actor = new.client_id then 'client' else 'pro' end,
                                   'hoursBefore', round(extract(epoch from (new.starts_at - now())) / 3600)));
      end if;
      if new.no_show is not null and old.no_show is null then
        insert into app_events (actor, kind, pro_id, booking_id, detail) values (v_actor, 'absence', new.pro_id, new.id, jsonb_build_object('who', new.no_show));
      end if;
      if new.disputed_at is not null and old.disputed_at is null then
        insert into app_events (actor, kind, pro_id, booking_id) values (v_actor, 'litige', new.pro_id, new.id);
      end if;
    end if;
  elsif tg_table_name = 'reviews' then
    insert into app_events (actor, kind, pro_id, booking_id, detail) values (coalesce(v_actor, new.client_id), 'avis', new.pro_id, new.booking_id, jsonb_build_object('stars', new.stars));
  end if;
  return coalesce(new, old);
end;
$$;
revoke execute on function log_event() from public, anon, authenticated;

create trigger log_profiles after insert or update of role on profiles for each row execute function log_event();
create trigger log_pros after insert or update on pros for each row execute function log_event();
create trigger log_services after insert or update or delete on services for each row execute function log_event();
create trigger log_konyela after insert on konyela_slots for each row execute function log_event();
create trigger log_bookings after insert or update on bookings for each row execute function log_event();
create trigger log_reviews after insert on reviews for each row execute function log_event();

-- Indicateurs -------------------------------------------------------------------
-- p_days : période étudiée (7, 30, 90...), 0 pour tout l'historique. Les réservations sont comptées à la date où elles ont été faites.
create function admin_stats(p_days int default 30) returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare
  v_to timestamptz := now();
  v_from timestamptz;
  v_prev timestamptz;
  v_series_from date;
  v_out jsonb;
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  if coalesce(p_days, 0) <= 0 then
    v_from := '-infinity';
    v_prev := '-infinity';
    v_series_from := coalesce((select min(created_at)::date from profiles), current_date);
  else
    v_from := v_to - make_interval(days => p_days);
    v_prev := v_from - make_interval(days => p_days);
    v_series_from := v_from::date;
  end if;

  with b as (
    select bk.*, coalesce(p.categories[1], 'autre') as cat, p.commune, p.name as pro_name, s.name as service_name
      from bookings bk join pros p on p.id = bk.pro_id join services s on s.id = bk.service_id
     where not p.is_demo
  ),
  cur as (select * from b where created_at >= v_from),
  prev as (select * from b where created_at >= v_prev and created_at < v_from),
  per_client as (select client_id, count(*) as n from b where status = 'confirmed' group by client_id)
  select jsonb_build_object(
    'from', case when v_from = '-infinity' then null else v_from end,
    'accounts', (select jsonb_build_object(
        'total', count(*),
        'clients', count(*) filter (where role = 'client'),
        'pros', count(*) filter (where role = 'pro'),
        'new', count(*) filter (where created_at >= v_from),
        'newClients', count(*) filter (where created_at >= v_from and role = 'client'),
        'newPros', count(*) filter (where created_at >= v_from and role = 'pro'),
        'prevNew', count(*) filter (where created_at >= v_prev and created_at < v_from)) from profiles),
    'fiches', (select jsonb_build_object(
        'total', count(*),
        'new', count(*) filter (where created_at >= v_from),
        'withServices', count(*) filter (where exists (select 1 from services s where s.pro_id = pros.id and s.active)),
        'withBooking', count(*) filter (where exists (select 1 from bookings x where x.pro_id = pros.id)),
        'atHome', count(*) filter (where 'À domicile' = any (places))) from pros where not is_demo),
    'bookings', (select jsonb_build_object(
        'total', count(*),
        'confirmed', count(*) filter (where status = 'confirmed'),
        'cancelled', count(*) filter (where status = 'cancelled'),
        'noShow', count(*) filter (where no_show is not null),
        'disputed', count(*) filter (where disputed_at is not null),
        'konyela', count(*) filter (where mode = 'konyela'),
        'atHome', count(*) filter (where place = 'client'),
        'gmv', coalesce(sum(price_eur) filter (where status = 'confirmed'), 0),
        'deposits', coalesce(sum(deposit_eur) filter (where status = 'confirmed'), 0),
        'avgBasket', coalesce(round(avg(price_eur) filter (where status = 'confirmed'), 2), 0),
        'avgLeadHours', coalesce(round((extract(epoch from avg(starts_at - created_at)) / 3600)::numeric, 1), 0),
        'clients', count(distinct client_id),
        'pros', count(distinct pro_id)) from cur),
    'previous', (select jsonb_build_object(
        'total', count(*),
        'gmv', coalesce(sum(price_eur) filter (where status = 'confirmed'), 0),
        'cancelled', count(*) filter (where status = 'cancelled'),
        'clients', count(distinct client_id)) from prev),
    'loyalty', (select jsonb_build_object(
        'clients', count(*),
        'once', count(*) filter (where n = 1),
        'twoToThree', count(*) filter (where n between 2 and 3),
        'fourPlus', count(*) filter (where n >= 4),
        'avgPerClient', coalesce(round(avg(n), 2), 0)) from per_client),
    'reviews', (select jsonb_build_object(
        'total', count(*),
        'period', count(*) filter (where r.created_at >= v_from),
        'avg', coalesce(round(avg(stars), 2), 0))
        from reviews r join pros p on p.id = r.pro_id where not p.is_demo),
    'daily', (select coalesce(jsonb_agg(jsonb_build_object('d', d, 'bookings', nb, 'signups', ns, 'gmv', gmv) order by d), '[]')
        from (select g::date as d,
                     (select count(*) from b where b.created_at::date = g::date) as nb,
                     (select count(*) from profiles pr where pr.created_at::date = g::date) as ns,
                     (select coalesce(sum(price_eur), 0) from b where b.created_at::date = g::date and b.status = 'confirmed') as gmv
                from generate_series(v_series_from, current_date, interval '1 day') g) t),
    'byCategory', (select coalesce(jsonb_agg(jsonb_build_object('cat', cat, 'bookings', n, 'gmv', gmv, 'clients', c) order by n desc), '[]')
        from (select cat, count(*) as n, coalesce(sum(price_eur) filter (where status = 'confirmed'), 0) as gmv, count(distinct client_id) as c from cur group by cat) t),
    'byCommune', (select coalesce(jsonb_agg(jsonb_build_object('commune', commune, 'bookings', n, 'gmv', gmv) order by n desc), '[]')
        from (select commune, count(*) as n, coalesce(sum(price_eur) filter (where status = 'confirmed'), 0) as gmv from cur group by commune) t),
    'fichesByCommune', (select coalesce(jsonb_agg(jsonb_build_object('commune', commune, 'fiches', n) order by n desc), '[]')
        from (select commune, count(*) as n from pros where not is_demo group by commune) t),
    'byWeekday', (select coalesce(jsonb_agg(jsonb_build_object('dow', dow, 'bookings', n) order by dow), '[]')
        from (select extract(isodow from starts_at at time zone 'America/Guadeloupe')::int as dow, count(*) as n from cur where status = 'confirmed' group by 1) t),
    'byHour', (select coalesce(jsonb_agg(jsonb_build_object('h', h, 'bookings', n) order by h), '[]')
        from (select extract(hour from starts_at at time zone 'America/Guadeloupe')::int as h, count(*) as n from cur where status = 'confirmed' group by 1) t),
    'topPros', (select coalesce(jsonb_agg(t order by t.bookings desc, t.gmv desc), '[]') from (
        select pro_id as id, pro_name as name, commune, count(*) as bookings,
               coalesce(sum(price_eur) filter (where status = 'confirmed'), 0) as gmv,
               count(*) filter (where status = 'cancelled') as cancelled,
               (select round(avg(stars), 1) from reviews r where r.pro_id = cur.pro_id) as rating
          from cur group by pro_id, pro_name, commune order by count(*) desc limit 10) t),
    'topServices', (select coalesce(jsonb_agg(t order by t.bookings desc), '[]') from (
        select service_name as name, cat, count(*) as bookings, round(avg(price_eur), 2) as avg_price
          from cur group by service_name, cat order by count(*) desc limit 10) t)
  ) into v_out
  from (select 1) one;
  return v_out;
end;
$$;

-- Journal lisible : qui a fait quoi, du plus récent au plus ancien.
create function admin_events(p_limit int default 100, p_kind text default null)
returns table (id bigint, at timestamptz, kind text, actor_name text, actor_role text, pro_name text, detail jsonb)
language plpgsql stable security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  return query
    select e.id, e.at, e.kind, pr.display_name, pr.role, p.name, e.detail
      from app_events e
      left join profiles pr on pr.id = e.actor
      left join pros p on p.id = e.pro_id
     where p_kind is null or e.kind = p_kind
     order by e.at desc
     limit least(greatest(coalesce(p_limit, 100), 1), 1000);
end;
$$;

-- Export des réservations de la période, pour un tableur.
create function admin_bookings(p_days int default 30)
returns table (created_at timestamptz, starts_at timestamptz, pro_name text, commune text, category text, service_name text,
               client_name text, price_eur numeric, deposit_eur numeric, mode booking_mode, place booking_place, status booking_status, no_show text)
language plpgsql stable security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  return query
    select b.created_at, b.starts_at, p.name, p.commune, coalesce(p.categories[1], 'autre'), s.name,
           b.client_name, b.price_eur, b.deposit_eur, b.mode, b.place, b.status, b.no_show
      from bookings b join pros p on p.id = b.pro_id join services s on s.id = b.service_id
     where not p.is_demo and (coalesce(p_days, 0) <= 0 or b.created_at >= now() - make_interval(days => p_days))
     order by b.created_at desc;
end;
$$;

revoke execute on function is_admin(), admin_stats(int), admin_events(int, text), admin_bookings(int) from public, anon;
grant execute on function is_admin(), admin_stats(int), admin_events(int, text), admin_bookings(int) to authenticated;

-- Pour donner l'accès au pilotage à un compte (à lancer à la main, une fois par propriétaire) :
-- insert into admins (user_id) select id from auth.users where email = 'adresse@exemple.fr';

-- Réponses aux avis, photos des fiches et signalements (patch 006) --------------------

-- Le prestataire peut répondre une fois à chaque avis, et modifier sa réponse.
alter table reviews add column if not exists reply text check (reply is null or length(reply) <= 1000);
alter table reviews add column if not exists replied_at timestamptz;

create or replace function reviews_reply_stamp() returns trigger
language plpgsql as $$
begin
  -- Seule la réponse change : la note, le texte et l'auteur de l'avis restent tels quels.
  new.booking_id := old.booking_id; new.pro_id := old.pro_id; new.client_id := old.client_id;
  new.stars := old.stars; new.body := old.body; new.created_at := old.created_at;
  new.reply := nullif(trim(new.reply), '');
  new.replied_at := case when new.reply is null then null when new.reply is distinct from old.reply then now() else old.replied_at end;
  return new;
end $$;
drop trigger if exists reviews_reply on reviews;
create trigger reviews_reply before update on reviews for each row execute function reviews_reply_stamp();
drop policy if exists "avis : réponse du prestataire" on reviews;
create policy "avis : réponse du prestataire" on reviews for update using (owns_pro(pro_id)) with check (owns_pro(pro_id));
grant update (reply) on reviews to authenticated;

-- Galerie de réalisations : 12 photos au plus par fiche, déposées dans le stockage « pro-photos ».
create table if not exists pro_photos (
  id uuid primary key default gen_random_uuid(),
  pro_id text not null references pros on delete cascade,
  path text not null check (path ~ '^[^/]+/[^/]+$'),
  url text not null check (url ~ '^https://'),
  position smallint not null default 0,
  created_at timestamptz not null default now()
);
create index if not exists pro_photos_pro on pro_photos (pro_id, position);
alter table pro_photos enable row level security;

create or replace function pro_photos_check() returns trigger
language plpgsql as $$
begin
  if split_part(new.path, '/', 1) <> new.pro_id then raise exception 'Photo rangée dans le dossier d''une autre fiche'; end if;
  if (select count(*) from pro_photos where pro_id = new.pro_id) >= 12 then raise exception 'Douze photos au plus par fiche'; end if;
  return new;
end $$;
drop trigger if exists pro_photos_limit on pro_photos;
create trigger pro_photos_limit before insert on pro_photos for each row execute function pro_photos_check();

drop policy if exists "photos : lecture publique" on pro_photos;
create policy "photos : lecture publique" on pro_photos for select using (true);
drop policy if exists "photos : le propriétaire de la fiche" on pro_photos;
create policy "photos : le propriétaire de la fiche" on pro_photos for all using (owns_pro(pro_id)) with check (owns_pro(pro_id));
revoke all on pro_photos from anon, authenticated;
grant select on pro_photos to anon, authenticated;
grant insert, update (position), delete on pro_photos to authenticated;

-- Signalements d'une fiche ou d'un avis, traités depuis le pilotage.
create table if not exists reports (
  id uuid primary key default gen_random_uuid(),
  reporter uuid references auth.users on delete set null default auth.uid(),
  pro_id text references pros on delete cascade,
  review_id uuid references reviews on delete cascade,
  reason text not null check (length(trim(reason)) between 5 and 1000),
  status text not null default 'ouvert' check (status in ('ouvert', 'traité')),
  created_at timestamptz not null default now(),
  check (pro_id is not null or review_id is not null)
);
alter table reports enable row level security;

create or replace function reports_check() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  new.reporter := auth.uid();
  new.status := 'ouvert';
  new.created_at := now();
  if new.review_id is not null then new.pro_id := (select pro_id from reviews where id = new.review_id); end if;
  -- Dix signalements par jour et par compte, pour éviter les abus.
  if (select count(*) from reports where reporter = auth.uid() and created_at > now() - interval '1 day') >= 10 then
    raise exception 'Trop de signalements aujourd''hui, réessaie demain';
  end if;
  return new;
end $$;
drop trigger if exists reports_before on reports;
create trigger reports_before before insert on reports for each row execute function reports_check();

drop policy if exists "signalements : dépôt" on reports;
create policy "signalements : dépôt" on reports for insert to authenticated with check (auth.uid() is not null);
revoke all on reports from anon, authenticated;
grant insert (pro_id, review_id, reason) on reports to authenticated;

create or replace function admin_reports(p_status text default 'ouvert')
returns table (id uuid, created_at timestamptz, status text, reason text, pro_id text, pro_name text, review_body text, review_stars smallint, reporter_name text)
language plpgsql stable security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  return query
    select r.id, r.created_at, r.status, r.reason, r.pro_id, p.name, rv.body, rv.stars, pr.display_name
      from reports r
      left join pros p on p.id = r.pro_id
      left join reviews rv on rv.id = r.review_id
      left join profiles pr on pr.id = r.reporter
     where p_status is null or r.status = p_status
     order by r.created_at desc
     limit 200;
end $$;

create or replace function admin_close_report(p_id uuid) returns void
language plpgsql security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  update reports set status = 'traité' where id = p_id;
end $$;

revoke execute on function admin_reports(text), admin_close_report(uuid) from public, anon;
grant execute on function admin_reports(text), admin_close_report(uuid) to authenticated;
