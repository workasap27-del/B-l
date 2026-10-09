-- Bèl : schéma de base de données pour Supabase (PostgreSQL).
-- À coller dans l'éditeur SQL de Supabase, puis lancer supabase/seed.sql pour les données de démonstration.
-- Hypothèse du MVP : un prestataire = un seul poste. Deux rendez-vous confirmés ne peuvent pas se chevaucher chez lui.

create extension if not exists btree_gist;

create type pro_kind as enum ('Salon', 'Institut', 'Indépendante');
create type booking_mode as enum ('classic', 'konyela');
create type booking_status as enum ('confirmed', 'cancelled');
create type slot_status as enum ('open', 'booked', 'withdrawn');

-- Comptes ---------------------------------------------------------------
create table profiles (
  id uuid primary key references auth.users on delete cascade,
  display_name text not null,
  commune text,
  created_at timestamptz not null default now()
);

-- Prestataires et prestations --------------------------------------------
create table pros (
  id text primary key,
  owner_id uuid references auth.users on delete set null,
  name text not null,
  owner_name text,
  kind pro_kind not null,
  places text[] not null default '{}',
  commune text not null,
  quartier text,
  categories text[] not null default '{}',
  tags text[] not null default '{}',
  about text,
  opens_at smallint not null check (opens_at between 0 and 1439),
  closes_at smallint not null check (closes_at between 1 and 1440),
  closed_weekdays smallint[] not null default '{}',
  hue smallint not null default 330,
  is_demo boolean not null default false,
  created_at timestamptz not null default now(),
  check (closes_at > opens_at)
);

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
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  price_eur numeric(7, 2) not null,
  deposit_eur numeric(7, 2) not null,
  mode booking_mode not null default 'classic',
  status booking_status not null default 'confirmed',
  slot_id uuid references konyela_slots on delete set null,
  created_at timestamptz not null default now(),
  check (ends_at > starts_at),
  -- Empêche la double réservation, même si deux clientes valident en même temps.
  constraint bookings_no_overlap exclude using gist (pro_id with =, tstzrange(starts_at, ends_at) with &&) where (status = 'confirmed')
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
create function book_konyela_slot(p_slot uuid, p_deposit_rate numeric default 0.2)
returns bookings
language plpgsql security definer set search_path = public as $$
declare
  v_slot konyela_slots;
  v_service services;
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
  v_price := round(v_service.price_eur * (100 - v_slot.discount_pct) / 100.0);
  update konyela_slots set status = 'booked' where id = p_slot;
  insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur, mode, slot_id)
  values (v_slot.pro_id, v_service.id, auth.uid(), v_slot.starts_at,
          v_slot.starts_at + make_interval(mins => v_service.duration_min),
          v_price, round(v_price * p_deposit_rate), 'konyela', p_slot)
  returning * into v_booking;
  return v_booking;
end;
$$;

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

grant usage on schema public to anon, authenticated;
grant select on pros, services, konyela_slots, reviews, pro_ratings to anon, authenticated;
grant select, insert, update, delete on profiles, favorites, konyela_slots, services to authenticated;
grant update on pros to authenticated;
grant select, insert, update on bookings to authenticated;
grant insert on reviews to authenticated;
grant execute on function busy_intervals(text, timestamptz, timestamptz) to anon, authenticated;
grant execute on function book_konyela_slot(uuid, numeric) to authenticated;
revoke execute on function book_konyela_slot(uuid, numeric) from public, anon;
