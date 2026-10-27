-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Fidélité et parrainage (patch 009) ---------------------------------------------------------------
-- Les paliers et montants sont dans l'appli (RULES.loyalty) ; la base compte les faits.

alter table profiles add column if not exists referral_code text unique;
alter table profiles add column if not exists referred_by uuid references auth.users on delete set null;

create or replace function new_referral_code() returns text
language plpgsql volatile as $$
declare v text;
begin
  loop
    -- Six caractères sans 0, O, 1 ni I, pour pouvoir le dicter.
    v := (select string_agg(substr('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', 1 + floor(random() * 32)::int, 1), '') from generate_series(1, 6));
    exit when not exists (select 1 from profiles where referral_code = v);
  end loop;
  return v;
end $$;

update profiles set referral_code = new_referral_code() where referral_code is null;

create or replace function handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into profiles (id, display_name, role, phone, referral_code, referred_by)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''), split_part(new.email, '@', 1)),
    case when new.raw_user_meta_data ->> 'role' = 'pro' then 'pro' else 'client' end,
    nullif(trim(new.raw_user_meta_data ->> 'phone'), ''),
    new_referral_code(),
    (select id from profiles where referral_code = upper(trim(new.raw_user_meta_data ->> 'referral')) and id <> new.id)
  );
  return new;
end;
$$;

-- Un compte ne peut changer que son prénom, son téléphone, son rôle et sa commune : ni son code ni son parrain.
revoke insert, update on profiles from authenticated;
grant update (display_name, phone, role, commune) on profiles to authenticated;

-- Rendez-vous honorés et filleuls actifs de la personne connectée.
create or replace function my_loyalty() returns jsonb
language plpgsql stable security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'Connexion requise'; end if;
  return jsonb_build_object(
    'visits', (select count(*) from bookings b join pros p on p.id = b.pro_id and not p.is_demo
                where b.client_id = auth.uid() and b.status = 'confirmed' and b.no_show is null and b.ends_at < now()),
    'referrals', (select count(*) from profiles f where f.referred_by = auth.uid()
                   and exists (select 1 from bookings b join pros p on p.id = b.pro_id and not p.is_demo
                                where b.client_id = f.id and b.status = 'confirmed' and b.no_show is null and b.ends_at < now())),
    'code', (select referral_code from profiles where id = auth.uid()));
end $$;
revoke execute on function my_loyalty() from public, anon;
grant execute on function my_loyalty() to authenticated;
