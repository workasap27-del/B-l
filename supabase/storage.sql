-- Stockage des photos des fiches (Supabase Storage). À lancer une fois sur Supabase, après schema.sql ou le patch 006.
-- Chaque fiche a son dossier, nommé par son identifiant : seul le compte propriétaire de la fiche peut y déposer ou supprimer.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  values ('pro-photos', 'pro-photos', true, 3145728, array['image/jpeg', 'image/webp', 'image/png'])
  on conflict (id) do update set public = true, file_size_limit = 3145728, allowed_mime_types = array['image/jpeg', 'image/webp', 'image/png'];

drop policy if exists "photos des fiches : lecture" on storage.objects;
create policy "photos des fiches : lecture" on storage.objects for select using (bucket_id = 'pro-photos');
drop policy if exists "photos des fiches : dépôt" on storage.objects;
create policy "photos des fiches : dépôt" on storage.objects for insert to authenticated
  with check (bucket_id = 'pro-photos' and public.owns_pro((storage.foldername(name))[1]));
drop policy if exists "photos des fiches : suppression" on storage.objects;
create policy "photos des fiches : suppression" on storage.objects for delete to authenticated
  using (bucket_id = 'pro-photos' and public.owns_pro((storage.foldername(name))[1]));
