-- Vérifie les règles essentielles. Chaque bloc lève une erreur si une règle ne tient pas.
\set ON_ERROR_STOP on
insert into auth.users (id, email, raw_user_meta_data) values
  ('00000000-0000-0000-0000-0000000000a1', 'ines@test.gp', '{"display_name":"Inès","role":"client"}'),
  ('00000000-0000-0000-0000-0000000000a2', 'lea@test.gp', '{}'),
  ('00000000-0000-0000-0000-0000000000b1', 'maeva@test.gp', '{"display_name":"Maëva","role":"pro"}'),
  ('00000000-0000-0000-0000-0000000000b2', 'nouvelle@test.gp', '{"display_name":"Nadia","role":"pro"}');
-- 0. Le profil est créé à l'inscription, avec le bon rôle.
do $$ begin
  if (select role from profiles where id = '00000000-0000-0000-0000-0000000000b1') <> 'pro' then raise exception 'rôle pro non enregistré'; end if;
  if (select display_name from profiles where id = '00000000-0000-0000-0000-0000000000a2') <> 'lea' then raise exception 'nom par défaut absent'; end if;
end $$;
update pros set owner_id = '00000000-0000-0000-0000-0000000000b1' where id = 'kaz';

-- 1. Une visiteuse non connectée lit le catalogue mais aucune réservation.
set role anon;
do $$ begin
  if (select count(*) from pros) < 14 then raise exception 'catalogue illisible en anonyme'; end if;
  begin
    perform count(*) from bookings;
    raise exception 'un anonyme lit les réservations';
  exception when insufficient_privilege then null; end;
end $$;
reset role;

-- 2. La cliente A réserve ; la cliente B ne peut pas prendre un créneau qui chevauche.
set role authenticated;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', false);
insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
  select 'kaz', id, auth.uid(), now() + interval '2 days', now() + interval '2 days 45 minutes', 28, 6 from services where pro_id = 'kaz' and code = 'c';
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a2', false);
do $$ begin
  begin
    insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
      select 'kaz', id, auth.uid(), now() + interval '2 days 30 minutes', now() + interval '2 days 90 minutes', 40, 8 from services where pro_id = 'kaz' and code = 'b';
    raise exception 'double réservation acceptée';
  exception when exclusion_violation then null; end;
  -- 3. B ne voit pas la réservation de A, mais voit la plage occupée.
  if (select count(*) from bookings) <> 0 then raise exception 'B voit les réservations de A'; end if;
  if (select count(*) from busy_intervals('kaz', now(), now() + interval '7 days')) <> 1 then raise exception 'plage occupée invisible'; end if;
  -- 4. B ne peut pas réserver au nom de A.
  begin
    insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
      select 'kaz', id, '00000000-0000-0000-0000-0000000000a1', now() + interval '4 days', now() + interval '4 days 30 minutes', 15, 3 from services where pro_id = 'kaz' and code = 'f';
    raise exception 'réservation au nom d''une autre acceptée';
  exception when insufficient_privilege then null; end;
  -- 5. B ne peut pas publier de créneau Konyéla chez Kaz a Zong.
  begin
    insert into konyela_slots (pro_id, service_id, starts_at, discount_pct) select 'kaz', id, now() + interval '3 hours', 30 from services where pro_id = 'kaz' and code = 'e';
    raise exception 'une cliente publie un créneau Konyéla';
  exception when insufficient_privilege then null; end;
end $$;

-- 6. La propriétaire publie un créneau et voit la réservation de A.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000b1', false);
insert into konyela_slots (id, pro_id, service_id, starts_at, discount_pct)
  select '00000000-0000-0000-0000-00000000c001', 'kaz', id, now() + interval '3 hours', 30 from services where pro_id = 'kaz' and code = 'a';
do $$ begin
  if (select count(*) from bookings) <> 1 then raise exception 'la pro ne voit pas ses réservations'; end if;
end $$;

-- 7. B prend le créneau Konyéla au prix remisé ; A arrive trop tard.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a2', false);
do $$ declare b bookings; begin
  b := book_konyela_slot('00000000-0000-0000-0000-00000000c001');
  if b.price_eur <> 39 or b.deposit_eur <> 8 or b.mode <> 'konyela' then raise exception 'prix Konyéla faux : % / %', b.price_eur, b.deposit_eur; end if;
end $$;
-- La pro publie un second créneau, pris chez la cliente : 15 € remisés de 20 % = 12 €, plus 5 € de déplacement.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000b1', false);
insert into konyela_slots (id, pro_id, service_id, starts_at, discount_pct)
  select '00000000-0000-0000-0000-00000000c002', 'kaz', id, now() + interval '6 hours', 20 from services where pro_id = 'kaz' and code = 'e';
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a2', false);
do $$ declare b bookings; begin
  b := book_konyela_slot('00000000-0000-0000-0000-00000000c002', 'client', '12 rue des Flamboyants, Les Abymes');
  if b.price_eur <> 17 or b.travel_fee_eur <> 5 or b.place <> 'client' then raise exception 'prix à domicile faux : % dont % de déplacement', b.price_eur, b.travel_fee_eur; end if;
end $$;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', false);
do $$ begin
  begin
    perform book_konyela_slot('00000000-0000-0000-0000-00000000c001');
    raise exception 'créneau Konyéla réservé deux fois';
  exception when raise_exception then
    if sqlerrm not like 'Ce créneau%' then raise; end if;
  end;
  -- 8. Chez la cliente : adresse obligatoire, frais de déplacement ajoutés par le serveur.
  begin
    insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur, place)
      select 'kaz', id, auth.uid(), now() + interval '5 days', now() + interval '5 days 30 minutes', 20, 4, 'client' from services where pro_id = 'kaz' and code = 'f';
    raise exception 'prestation chez la cliente acceptée sans adresse';
  exception when check_violation then null; end;
  -- 9. Pas d'avis avant la fin du rendez-vous.
  begin
    insert into reviews (booking_id, pro_id, client_id, stars) select id, pro_id, client_id, 5 from bookings;
    raise exception 'avis accepté avant le rendez-vous';
  exception when insufficient_privilege then null; end;
end $$;
-- 9 bis. Le prix est imposé par la base, pas par l'appli.
do $$ declare v bookings; begin
  insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
    select 'kaz', id, auth.uid(), now() + interval '6 days', now() + interval '6 days 1 minute', 1, 0 from services where pro_id = 'kaz' and code = 'a'
    returning * into v;
  if v.price_eur <> 55 or v.deposit_eur <> 11 or v.ends_at - v.starts_at <> interval '90 minutes' then raise exception 'prix non recalculé : %', v.price_eur; end if;
  if (select count(*) from busy_all(now(), now() + interval '10 days') where pro_id = 'kaz') < 2 then raise exception 'busy_all incomplet'; end if;
end $$;

-- 10. Une cliente ne peut pas modifier le prix de sa réservation, seulement l'annuler.
do $$ begin
  begin
    update bookings set price_eur = 1 where client_id = auth.uid();
    raise exception 'prix modifiable par la cliente';
  exception when insufficient_privilege then null; end;
  update bookings set status = 'cancelled' where client_id = auth.uid() and mode = 'classic';
end $$;

-- 11. Une nouvelle prestataire crée sa fiche, avec SIREN obligatoire, et une seule.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000b2', false);
do $$ begin
  begin
    insert into pros (id, owner_id, name, kind, commune, lat, lng, opens_at, closes_at) values ('sans-siren', auth.uid(), 'Test', 'Indépendante', 'Les Abymes', 16.27, -61.5, 540, 1080);
    raise exception 'fiche acceptée sans SIREN';
  exception when check_violation then null; end;
  begin
    insert into pros (id, owner_id, name, kind, commune, lat, lng, opens_at, closes_at, siren) values ('pour-une-autre', '00000000-0000-0000-0000-0000000000a1', 'Test', 'Indépendante', 'Les Abymes', 16.27, -61.5, 540, 1080, '552032534');
    raise exception 'fiche créée au nom d''une autre';
  exception when insufficient_privilege then null; end;
  begin
    insert into pros (id, owner_id, name, kind, commune, lat, lng, opens_at, closes_at, siren) values ('faux-siren', auth.uid(), 'Test', 'Indépendante', 'Les Abymes', 16.27, -61.5, 540, 1080, '123456789');
    raise exception 'fiche acceptée avec un SIREN inventé';
  exception when check_violation then null; end;
  insert into pros (id, owner_id, name, kind, places, commune, lat, lng, opens_at, closes_at, siren, categories) values ('nadia-ongles', auth.uid(), 'Nadia Ongles', 'Indépendante', array['Chez elle'], 'Le Gosier', 16.21, -61.49, 540, 1080, '552032534', array['ongles']);
  insert into services (pro_id, code, name, duration_min, price_eur) values ('nadia-ongles', 'a', 'Pose gel', 90, 50);
  begin
    insert into pros (id, owner_id, name, kind, commune, lat, lng, opens_at, closes_at, siren) values ('nadia-2', auth.uid(), 'Doublon', 'Indépendante', 'Le Gosier', 16.21, -61.49, 540, 1080, '552032534');
    raise exception 'deux fiches pour un compte';
  exception when unique_violation then null; end;
  begin
    insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'zz', 'Intrus', 30, 1);
    raise exception 'prestation ajoutée chez une autre';
  exception when insufficient_privilege then null; end;
end $$;
reset role;

-- 12. Pilotage : une cliente ne voit ni le journal ni les indicateurs, et ne peut pas se déclarer propriétaire.
set role authenticated;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', false);
do $$ begin
  if is_admin() then raise exception 'cliente vue comme propriétaire'; end if;
  begin
    perform admin_stats(30);
    raise exception 'indicateurs lisibles par une cliente';
  exception when raise_exception then
    if sqlerrm not like 'Accès réservé%' then raise; end if;
  end;
  begin
    perform count(*) from app_events;
    raise exception 'journal lisible par une cliente';
  exception when insufficient_privilege then null; end;
  begin
    insert into admins (user_id) values (auth.uid());
    raise exception 'une cliente s''est déclarée propriétaire';
  exception when insufficient_privilege then null; end;
end $$;
reset role;

-- 13. Un compte propriétaire lit le journal et les indicateurs, sans les fiches de démonstration.
insert into admins (user_id) values ('00000000-0000-0000-0000-0000000000a2');
set role authenticated;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a2', false);
do $$
declare s jsonb;
begin
  if not is_admin() then raise exception 'propriétaire non reconnu'; end if;
  s := admin_stats(30);
  if (s -> 'accounts' ->> 'total')::int < 4 then raise exception 'comptes mal comptés : %', s -> 'accounts'; end if;
  if (s -> 'fiches' ->> 'total')::int <> 1 then raise exception 'les fiches de démonstration sont comptées : %', s -> 'fiches'; end if;
  if jsonb_array_length(s -> 'daily') < 30 then raise exception 'série journalière incomplète'; end if;
  if (select count(*) from admin_events(500, 'inscription')) < 4 then raise exception 'inscriptions absentes du journal'; end if;
  if (select count(*) from admin_events(500, 'reservation')) < 1 then raise exception 'réservations absentes du journal'; end if;
  if (select count(*) from admin_events(500, 'annulation')) < 1 then raise exception 'annulation absente du journal'; end if;
  if (select count(*) from admin_events(500, 'fiche_creee')) < 1 then raise exception 'création de fiche absente du journal'; end if;
  perform admin_stats(0);
  perform * from admin_bookings(0);
end $$;
reset role;
-- 14. Une même cliente ne peut pas avoir deux rendez-vous à la même heure, chez deux prestataires différents.
set role authenticated;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', false);
do $$
declare v_p1 text; v_s1 uuid; v_p2 text; v_s2 uuid;
begin
  select p.id, s.id into v_p1, v_s1 from pros p join services s on s.pro_id = p.id where s.active order by p.id limit 1;
  select p.id, s.id into v_p2, v_s2 from pros p join services s on s.pro_id = p.id where s.active and p.id <> v_p1 order by p.id limit 1;
  insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
    values (v_p1, v_s1, auth.uid(), now() + interval '9 days', now() + interval '9 days 60 minutes', 0, 0);
  begin
    insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
      values (v_p2, v_s2, auth.uid(), now() + interval '9 days 15 minutes', now() + interval '9 days 75 minutes', 0, 0);
    raise exception 'deux rendez-vous à la même heure acceptés';
  exception when exclusion_violation then null; end;
  -- Juste après la fin du premier rendez-vous, c'est permis.
  insert into bookings (pro_id, service_id, client_id, starts_at, ends_at, price_eur, deposit_eur)
    values (v_p2, v_s2, auth.uid(), now() + interval '9 days 60 minutes', now() + interval '9 days 120 minutes', 0, 0);
end $$;
reset role;
-- 15. Les fiches créées avec les anciennes catégories sont converties, sans doublon et sans toucher aux autres.
insert into pros (id, name, kind, places, commune, lat, lng, categories, opens_at, closes_at, hue, is_demo)
  values ('old-cat', 'Ancienne fiche', 'Salon', array['Au salon']::text[], 'Les Abymes', 16.27, -61.5, array['tresses', 'coiffure', 'soins', 'ongles']::text[], 540, 1080, 10, true);
\ir ../patch-005-categories.sql
do $$
declare v text[];
begin
  select categories into v from pros where id = 'old-cat';
  if v is distinct from array['coiffure', 'locks', 'visage', 'epilation', 'ongles']::text[] then raise exception 'conversion des catégories incorrecte : %', v; end if;
  if exists (select 1 from pros where categories && array['tresses', 'soins', 'spa', 'hotel']) then raise exception 'anciennes catégories restantes'; end if;
end $$;
delete from pros where id = 'old-cat';
select 'tous les contrôles passent' as resultat;
