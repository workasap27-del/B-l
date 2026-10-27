-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Avant de le lancer : activer la double authentification sur le compte propriétaire depuis /pilotage (sinon l'accès est demandé à la prochaine connexion).
-- Sécurité : double authentification pour le pilotage, fermeture de compte (patch 010) -----------------------

-- Le pilotage exige une connexion avec double authentification (code d'une appli d'authentification).
create or replace function is_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from admins where user_id = auth.uid()) and coalesce(auth.jwt() ->> 'aal', '') = 'aal2';
$$;

-- Propriétaire de l'appli connecté sans le second facteur : le pilotage lui demande son code.
create or replace function admin_needs_mfa() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from admins where user_id = auth.uid()) and coalesce(auth.jwt() ->> 'aal', '') <> 'aal2';
$$;
revoke execute on function admin_needs_mfa() from public, anon;
grant execute on function admin_needs_mfa() to authenticated;

-- L'auteur d'une annulation peut être indiqué par le serveur (fermeture de compte) ; sinon il est déduit du compte connecté.
create or replace function bookings_cancel_stamp() returns trigger
language plpgsql as $$
begin
  if new.status = 'cancelled' and old.status <> 'cancelled' then
    new.cancelled_at := now();
    new.cancelled_by := coalesce(new.cancelled_by, case when auth.uid() = old.client_id then 'client' else 'pro' end);
  end if;
  return new;
end $$;

-- Fermeture de compte, par le serveur : annule les rendez-vous à venir (les autres personnes sont prévenues par e-mail),
-- puis retire la fiche du prestataire. Le compte lui-même est supprimé ensuite par le serveur.
create or replace function close_account_prepare(p_user uuid) returns table (booking_id uuid)
language plpgsql security definer set search_path = public as $$
begin
  return query
    update bookings set status = 'cancelled', cancelled_by = 'client'
     where client_id = p_user and status = 'confirmed' and starts_at > now()
     returning id;
  return query
    update bookings set status = 'cancelled', cancelled_by = 'pro'
     where pro_id in (select id from pros where owner_id = p_user) and status = 'confirmed' and starts_at > now()
     returning id;
end $$;

create or replace function close_account_finish(p_user uuid) returns setof text
language plpgsql security definer set search_path = public as $$
begin
  -- Renvoie les chemins des photos à retirer du stockage, puis supprime la fiche.
  return query select path from pro_photos where pro_id in (select id from pros where owner_id = p_user);
  delete from pros where owner_id = p_user;
end $$;

revoke execute on function close_account_prepare(uuid), close_account_finish(uuid) from public, anon, authenticated;
grant execute on function close_account_prepare(uuid), close_account_finish(uuid) to service_role;
