-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Mise en avant payante des fiches (patch 011). Utilisée seulement quand RULES.sponsored est vrai dans l'appli.
create table if not exists promotions (
  id uuid primary key default gen_random_uuid(),
  pro_id text not null references pros on delete cascade,
  placement text not null check (placement in ('resultats', 'accueil')),
  starts_at timestamptz not null default now(),
  ends_at timestamptz not null,
  created_at timestamptz not null default now(),
  check (ends_at > starts_at)
);
create index if not exists promotions_live on promotions (placement, ends_at);
alter table promotions enable row level security;
drop policy if exists "mises en avant : lecture publique" on promotions;
create policy "mises en avant : lecture publique" on promotions for select using (true);
revoke all on promotions from anon, authenticated;
grant select on promotions to anon, authenticated;

-- Créée depuis le pilotage. Refusée pour une fiche mal notée ou dont le prestataire a manqué des rendez-vous.
create or replace function admin_promote(p_pro text, p_placement text, p_days int) returns uuid
language plpgsql security definer set search_path = public as $$
declare v_id uuid; v_rating numeric; v_absences int;
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  if not exists (select 1 from pros where id = p_pro and not is_demo) then raise exception 'Fiche inconnue'; end if;
  if p_days not between 1 and 92 then raise exception 'Durée entre 1 et 92 jours'; end if;
  select avg(stars) into v_rating from reviews where pro_id = p_pro;
  if v_rating is not null and v_rating < 3.5 then raise exception 'Fiche trop mal notée pour être mise en avant'; end if;
  select count(*) into v_absences from bookings where pro_id = p_pro and no_show = 'pro' and starts_at > now() - interval '90 days';
  if v_absences >= 2 then raise exception 'Prestataire absent à plusieurs rendez-vous : mise en avant refusée'; end if;
  insert into promotions (pro_id, placement, ends_at) values (p_pro, p_placement, now() + make_interval(days => p_days)) returning id into v_id;
  return v_id;
end $$;

create or replace function admin_end_promotion(p_id uuid) returns void
language plpgsql security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'Accès réservé aux propriétaires de l''appli'; end if;
  update promotions set ends_at = now() where id = p_id and ends_at > now();
end $$;

revoke execute on function admin_promote(text, text, int), admin_end_promotion(uuid) from public, anon;
grant execute on function admin_promote(text, text, int), admin_end_promotion(uuid) to authenticated;
