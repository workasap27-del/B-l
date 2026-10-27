-- À lancer une fois sur Supabase (SQL Editor). Sans danger si relancé.
-- Connexion avec Google ou Apple (patch 012) : le prénom vient du compte du fournisseur.
create or replace function handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into profiles (id, display_name, role, phone, referral_code, referred_by)
  values (
    new.id,
    coalesce(
      nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''),
      nullif(split_part(trim(coalesce(new.raw_user_meta_data ->> 'given_name', new.raw_user_meta_data ->> 'full_name', new.raw_user_meta_data ->> 'name', '')), ' ', 1), ''),
      split_part(new.email, '@', 1)),
    case when new.raw_user_meta_data ->> 'role' = 'pro' then 'pro' else 'client' end,
    nullif(trim(new.raw_user_meta_data ->> 'phone'), ''),
    new_referral_code(),
    (select id from profiles where referral_code = upper(trim(new.raw_user_meta_data ->> 'referral')) and id <> new.id)
  );
  return new;
end;
$$;
