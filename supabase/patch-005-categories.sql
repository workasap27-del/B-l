-- Nouvelles catégories (19). À lancer une fois sur Supabase après avoir mis l'appli en ligne.
-- Les fiches réelles déjà créées gardent leurs anciennes catégories jusqu'ici : cette mise à jour les convertit.
--   tresses -> coiffure + locks      soins -> visage + epilation
--   spa     -> corps + massage       hotel -> massage
-- Les autres (ongles, cils, coiffure, maquillage, barbier, tatouage, piercing, massage) ne changent pas.
-- Sans danger si elle est relancée : les anciens identifiants n'existent plus après le premier passage.

create or replace function convert_old_categories(p_old text[]) returns text[]
language plpgsql immutable as $$
declare
  v_out text[] := '{}';
  v_c text;
  v_n text;
  v_new text[];
begin
  foreach v_c in array coalesce(p_old, '{}') loop
    v_new := case v_c
      when 'tresses' then array['coiffure', 'locks']
      when 'soins' then array['visage', 'epilation']
      when 'spa' then array['massage', 'corps']
      when 'hotel' then array['massage']
      else array[v_c]
    end;
    foreach v_n in array v_new loop
      if not (v_n = any (v_out)) then v_out := v_out || v_n; end if;
    end loop;
  end loop;
  return v_out;
end $$;

update pros set categories = convert_old_categories(categories)
  where categories && array['tresses', 'soins', 'spa', 'hotel'];

drop function convert_old_categories(text[]);
