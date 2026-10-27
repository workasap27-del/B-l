-- Rappels et e-mails de service toutes les dix minutes, depuis Supabase (extensions pg_cron et pg_net).
-- 1. Dans Supabase, Database > Extensions : activer pg_cron et pg_net.
-- 2. Remplacer SECRET par la valeur de NUXT_CRON_SECRET configurée sur Vercel, puis lancer ce script une fois.
select cron.unschedule('vladi-emails') where exists (select 1 from cron.job where jobname = 'vladi-emails');
select cron.schedule('vladi-emails', '*/10 * * * *', $$
  select net.http_post(
    url := 'https://bel-manzel.vercel.app/api/notifications/run',
    headers := jsonb_build_object('Authorization', 'Bearer SECRET', 'Content-Type', 'application/json'),
    body := '{}'::jsonb
  );
$$);
