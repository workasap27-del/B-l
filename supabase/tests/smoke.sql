-- Vérifie les règles essentielles. Chaque bloc lève une erreur si une règle ne tient pas.
\set ON_ERROR_STOP on
insert into auth.users (id) values ('00000000-0000-0000-0000-0000000000a1'), ('00000000-0000-0000-0000-0000000000a2'), ('00000000-0000-0000-0000-0000000000b1');
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
reset role;
select 'tous les contrôles passent' as resultat;
