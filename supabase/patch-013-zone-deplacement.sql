-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Zone de déplacement à domicile (patch 013) : les communes où le prestataire se déplace. Vide : partout en Guadeloupe.
alter table pros add column if not exists travel_zone text[] not null default '{}';
alter table pros drop constraint if exists pros_travel_zone_size;
alter table pros add constraint pros_travel_zone_size check (cardinality(travel_zone) <= 40);
