-- Une même cliente ne peut pas avoir deux rendez-vous confirmés à la même heure.
-- À lancer une fois sur la base en production (idempotent).
create extension if not exists btree_gist;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'bookings_client_no_overlap') then
    alter table bookings add constraint bookings_client_no_overlap
      exclude using gist (client_id with =, tstzrange(starts_at, ends_at) with &&) where (status = 'confirmed');
  end if;
end $$;
