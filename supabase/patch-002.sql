-- Patch 002 : prix recalculé par la base à chaque réservation, et créneaux occupés de tous les prestataires en une requête.

-- Le prix, l'acompte, les frais de déplacement et l'heure de fin sont calculés ici, jamais par l'appli.
create function bookings_fill() returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_service services;
  v_pro pros;
begin
  select * into v_service from services where id = new.service_id and pro_id = new.pro_id and active;
  if not found then
    raise exception 'Prestation inconnue chez ce prestataire';
  end if;
  select * into v_pro from pros where id = new.pro_id;
  if new.mode = 'classic' then
    if new.starts_at < now() then
      raise exception 'Ce créneau est déjà passé';
    end if;
    if new.place = 'client' and not ('À domicile' = any (v_pro.places)) then
      raise exception 'Ce prestataire ne se déplace pas';
    end if;
    if new.place = 'pro' and v_pro.places <@ array['À domicile'] then
      raise exception 'Ce prestataire se déplace uniquement';
    end if;
    new.travel_fee_eur := case when new.place = 'client' then v_pro.travel_fee_eur else 0 end;
    new.price_eur := v_service.price_eur + new.travel_fee_eur;
    new.deposit_eur := round(new.price_eur * 0.2);
    new.ends_at := new.starts_at + make_interval(mins => v_service.duration_min);
  end if;
  return new;
end;
$$;
create trigger bookings_fill before insert on bookings for each row execute function bookings_fill();
revoke execute on function bookings_fill() from public, anon, authenticated;

-- Plages occupées de tous les prestataires sur une période, sans dire qui a réservé.
create function busy_all(p_from timestamptz, p_to timestamptz)
returns table (pro_id text, starts_at timestamptz, ends_at timestamptz)
language sql stable security definer set search_path = public as $$
  select b.pro_id, b.starts_at, b.ends_at from bookings b
   where b.status = 'confirmed' and b.starts_at < p_to and b.ends_at > p_from
  union all
  select k.pro_id, k.starts_at, k.starts_at + make_interval(mins => s.duration_min) from konyela_slots k
    join services s on s.id = k.service_id
   where k.status = 'open' and k.starts_at < p_to and k.starts_at + make_interval(mins => s.duration_min) > p_from;
$$;
grant execute on function busy_all(timestamptz, timestamptz) to anon, authenticated;
