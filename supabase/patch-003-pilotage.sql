-- Patch 003 : pilotage de l'appli par ses propriétaires.
-- Comptes propriétaires, journal de ce qui se passe (inscriptions, fiches, réservations, annulations, avis)
-- et indicateurs calculés par la base. Rien de tout cela n'est lisible par les autres comptes.

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
