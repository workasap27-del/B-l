-- À lancer une fois sur Supabase (SQL Editor), puis supabase/storage.sql. Sans danger si relancé.
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
