-- Données de démonstration (fictives). Fichier généré par scripts/gen-seed.mjs, ne pas modifier à la main.

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('kaz', 'Kaz a Zong', 'Maëva L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Les Abymes', 'Raizet', array['ongles']::text[], array['Pose gel', 'Nail art', 'Semi-permanent']::text[], 'Prothésiste ongulaire depuis 6 ans. Reçoit dans son atelier au Raizet ou se déplace dans l''agglomération pointoise.', 540, 1140, array[0]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'b', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'd', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'e', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'f', 'Dépose', 30, 15);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('bar', 'Barber Lakou', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Grand-Camp', array['barbier']::text[], array['Dégradé', 'Barbe', 'Sans rendez-vous']::text[], 'Trois fauteuils, coupe homme et enfant. Les contours sont offerts dans les 10 jours.', 540, 1140, array[0]::smallint[], 210, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'a', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'b', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'd', 'Coupe enfant', 30, 12);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('hib', 'Salon Hibiscus', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Centre-ville', array['coiffure']::text[], array['Brushing', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte du centre-ville. Spécialiste du soin et du coiffage des boucles, coloration végétale sur demande.', 540, 1080, array[0, 1]::smallint[], 350, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'a', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'c', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'e', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('nai', 'Nail Bar Bas-du-Fort', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Bas-du-Fort', array['ongles']::text[], array['Pose gel', 'Beauté des pieds']::text[], 'Bar à ongles près de la marina, quatre postes. Idéal entre midi et deux.', 570, 1110, array[0]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'a', 'Pose gel', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'b', 'Remplissage', 60, 42);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'c', 'Semi-permanent', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'd', 'Beauté des pieds + vernis', 60, 38);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tre', 'Tresses Lokal', 'Sandrine D.', 'Indépendante', array['À domicile']::text[], 'Le Gosier', 'Mare-Gaillard', array['tresses', 'coiffure']::text[], array['Box braids', 'Vanilles', 'Locks']::text[], 'Tresseuse à domicile sur toute la Riviera du Levant. Mèches fournies sur demande, comptées en supplément.', 480, 1080, array[0]::smallint[], 25, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'a', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'c', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'd', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'e', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('reg', 'Regard Karukera', null, 'Institut', array['À l''institut']::text[], 'Baie-Mahault', 'Jarry', array['cils']::text[], array['Extensions', 'Rehaussement', 'Sourcils au fil']::text[], 'Institut dédié au regard, en zone de Jarry. Parking gratuit devant la porte.', 540, 1110, array[0]::smallint[], 265, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'b', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'c', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'd', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'e', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'f', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('col', 'Studio Colibri', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Destrellan', array['coiffure', 'maquillage']::text[], array['Chignon', 'Événement', 'Maquillage']::text[], 'Coiffure et maquillage au même endroit pour les baptêmes, mariages et soirées.', 540, 1110, array[0, 1]::smallint[], 160, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'a', 'Coupe + coiffage', 60, 48);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'c', 'Maquillage + coiffure', 120, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'd', 'Brushing', 30, 28);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('fle', 'Institut Fleur de Canne', null, 'Institut', array['À l''institut']::text[], 'Petit-Bourg', 'Bourg', array['soins']::text[], array['Soin visage', 'Épilation', 'Massage']::text[], 'Soins du visage et du corps, cire tiède. Cabine climatisée.', 540, 1080, array[0]::smallint[], 120, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'c', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'd', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'e', 'Massage dos', 30, 35);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tib', 'Onglerie Ti Bijou', 'Naomie C.', 'Indépendante', array['À domicile']::text[], 'Lamentin', 'Bourg', array['ongles']::text[], array['Capsules', 'Baby boomer']::text[], 'Se déplace avec tout son matériel sur le nord Basse-Terre : Lamentin, Sainte-Rose, Baie-Mahault.', 540, 1080, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'b', 'Remplissage', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'c', 'Semi-permanent', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'd', 'Baby boomer', 120, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('mad', 'Atelier Madras Beauté', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Bourg', array['soins', 'maquillage']::text[], array['Soin éclat', 'Maquillage', 'Épilation']::text[], 'À deux rues de la plage du bourg. Soins, épilation et maquillage sur rendez-vous.', 540, 1080, array[0]::smallint[], 5, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'b', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'c', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'e', 'Massage relaxant', 60, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('oce', 'Cils by Océane', 'Océane V.', 'Indépendante', array['Chez elle']::text[], 'Le Moule', 'Sergent', array['cils']::text[], array['Cil à cil', 'Volume mixte']::text[], 'Technicienne cils certifiée, reçoit dans une pièce dédiée de sa maison.', 540, 1080, array[0, 1]::smallint[], 245, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'a', 'Cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'b', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'c', 'Remplissage', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'd', 'Rehaussement', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('ali', 'Coiffure Alizé', null, 'Salon', array['Au salon']::text[], 'Sainte-Rose', 'Bourg', array['coiffure', 'barbier']::text[], array['Mixte', 'Défrisage', 'Couleur']::text[], 'Le salon de quartier du bourg, hommes, femmes et enfants.', 510, 1080, array[0]::smallint[], 190, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'a', 'Coupe femme', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'b', 'Brushing', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'c', 'Coupe homme', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'd', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'e', 'Couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('glo', 'Glow Gwada', 'Kéliane P.', 'Indépendante', array['À domicile']::text[], 'Saint-François', 'Bourg', array['maquillage']::text[], array['Mariée', 'Soirée', 'Cours']::text[], 'Maquilleuse mariages et événements, se déplace dans toute la Grande-Terre.', 480, 1200, array[]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'a', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'b', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'c', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'd', 'Cours d''auto-maquillage', 90, 70);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('loc', 'Locks & Nature', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Centre', array['tresses']::text[], array['Locks', 'Soins naturels']::text[], 'Entretien et création de locks, soins à base de plantes locales.', 540, 1080, array[0, 1]::smallint[], 95, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'a', 'Retwist', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'b', 'Entretien locks + soin', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'c', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'd', 'Coiffage locks', 60, 35);
