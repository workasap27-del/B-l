-- Données de démonstration (fictives). Fichier généré par scripts/gen-seed.mjs, ne pas modifier à la main.

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('kaz', 'Kaz a Zong', 'Maëva L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Les Abymes', 'Raizet', 16.26908, -61.50743, array['ongles']::text[], array['Pose gel', 'Nail art', 'Semi-permanent']::text[], 'Prothésiste ongulaire depuis 6 ans. Reçoit dans son atelier au Raizet ou se déplace dans l''agglomération pointoise.', 540, 1140, array[0]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'b', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'd', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'e', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'f', 'Dépose', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('bar', 'Barber Lakou', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Grand-Camp', 16.27051, -61.49762, array['barbier']::text[], array['Dégradé', 'Barbe', 'Sans rendez-vous']::text[], 'Trois fauteuils, coupe homme et enfant. Les contours sont offerts dans les 10 jours.', 540, 1140, array[0]::smallint[], 210, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'a', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'b', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'd', 'Coupe enfant', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('hib', 'Salon Hibiscus', null, 'Salon', array['Au salon', 'À domicile']::text[], 10, 'Pointe-à-Pitre', 'Centre-ville', 16.24259, -61.53250, array['coiffure']::text[], array['Brushing', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte du centre-ville. Spécialiste du soin et du coiffage des boucles, coloration végétale sur demande.', 540, 1080, array[0, 1]::smallint[], 350, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'a', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'c', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'e', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('nai', 'Nail Bar Bas-du-Fort', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bas-du-Fort', 16.20439, -61.49666, array['ongles']::text[], array['Pose gel', 'Beauté des pieds']::text[], 'Bar à ongles près de la marina, quatre postes. Idéal entre midi et deux.', 570, 1110, array[0]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'a', 'Pose gel', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'b', 'Remplissage', 60, 42);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'c', 'Semi-permanent', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'd', 'Beauté des pieds + vernis', 60, 38);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tre', 'Tresses Lokal', 'Sandrine D.', 'Indépendante', array['À domicile']::text[], 8, 'Le Gosier', 'Mare-Gaillard', 16.21432, -61.48594, array['tresses', 'coiffure']::text[], array['Box braids', 'Vanilles', 'Locks']::text[], 'Tresseuse à domicile sur toute la Riviera du Levant. Mèches fournies sur demande, comptées en supplément.', 480, 1080, array[0]::smallint[], 25, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'a', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'c', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'd', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'e', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('reg', 'Regard Karukera', null, 'Institut', array['À l''institut']::text[], 0, 'Baie-Mahault', 'Jarry', 16.26245, -61.58955, array['cils']::text[], array['Extensions', 'Rehaussement', 'Sourcils au fil']::text[], 'Institut dédié au regard, en zone de Jarry. Parking gratuit devant la porte.', 540, 1110, array[0]::smallint[], 265, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'b', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'c', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'd', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'e', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'f', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('col', 'Studio Colibri', null, 'Salon', array['Au salon', 'À domicile']::text[], 12, 'Baie-Mahault', 'Destrellan', 16.26970, -61.58412, array['coiffure', 'maquillage']::text[], array['Chignon', 'Événement', 'Maquillage']::text[], 'Coiffure et maquillage au même endroit pour les baptêmes, mariages et soirées.', 540, 1110, array[0, 1]::smallint[], 160, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'a', 'Coupe + coiffage', 60, 48);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'c', 'Maquillage + coiffure', 120, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'd', 'Brushing', 30, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('fle', 'Institut Fleur de Canne', null, 'Institut', array['À l''institut']::text[], 0, 'Petit-Bourg', 'Bourg', 16.18867, -61.59087, array['soins']::text[], array['Soin visage', 'Épilation', 'Massage']::text[], 'Soins du visage et du corps, cire tiède. Cabine climatisée.', 540, 1080, array[0]::smallint[], 120, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'c', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'd', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'e', 'Massage dos', 30, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tib', 'Onglerie Ti Bijou', 'Naomie C.', 'Indépendante', array['À domicile']::text[], 8, 'Lamentin', 'Bourg', 16.27531, -61.63061, array['ongles']::text[], array['Capsules', 'Baby boomer']::text[], 'Se déplace avec tout son matériel sur le nord Basse-Terre : Lamentin, Sainte-Rose, Baie-Mahault.', 540, 1080, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'b', 'Remplissage', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'c', 'Semi-permanent', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'd', 'Baby boomer', 120, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('mad', 'Atelier Madras Beauté', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Sainte-Anne', 'Bourg', 16.23428, -61.38086, array['soins', 'maquillage']::text[], array['Soin éclat', 'Maquillage', 'Épilation']::text[], 'À deux rues de la plage du bourg. Soins, épilation et maquillage sur rendez-vous.', 540, 1080, array[0]::smallint[], 5, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'b', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'c', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'e', 'Massage relaxant', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('oce', 'Cils by Océane', 'Océane V.', 'Indépendante', array['Chez elle']::text[], 0, 'Le Moule', 'Sergent', 16.33084, -61.35156, array['cils']::text[], array['Cil à cil', 'Volume mixte']::text[], 'Technicienne cils certifiée, reçoit dans une pièce dédiée de sa maison.', 540, 1080, array[0, 1]::smallint[], 245, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'a', 'Cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'b', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'c', 'Remplissage', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'd', 'Rehaussement', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('ali', 'Coiffure Alizé', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Rose', 'Bourg', 16.33773, -61.68995, array['coiffure', 'barbier']::text[], array['Mixte', 'Défrisage', 'Couleur']::text[], 'Le salon de quartier du bourg, hommes, femmes et enfants.', 510, 1080, array[0]::smallint[], 190, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'a', 'Coupe femme', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'b', 'Brushing', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'c', 'Coupe homme', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'd', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'e', 'Couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('glo', 'Glow Gwada', 'Kéliane P.', 'Indépendante', array['À domicile']::text[], 15, 'Saint-François', 'Bourg', 16.25325, -61.28039, array['maquillage']::text[], array['Mariée', 'Soirée', 'Cours']::text[], 'Maquilleuse mariages et événements, se déplace dans toute la Grande-Terre.', 480, 1200, array[]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'a', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'b', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'c', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'd', 'Cours d''auto-maquillage', 90, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('loc', 'Locks & Nature', null, 'Salon', array['Au salon']::text[], 0, 'Basse-Terre', 'Centre', 15.99710, -61.72409, array['tresses']::text[], array['Locks', 'Soins naturels']::text[], 'Entretien et création de locks, soins à base de plantes locales.', 540, 1080, array[0, 1]::smallint[], 95, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'a', 'Retwist', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'b', 'Entretien locks + soin', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'c', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'd', 'Coiffage locks', 60, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('zom', 'Zombi', 'Yolène R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 6, 'Les Abymes', 'Dothémare', 16.27801, -61.49675, array['cils']::text[], array['Cil à cil', 'Volume russe', 'Rehaussement']::text[], 'Un nom qui ne dit rien de son métier : Yolène pose des extensions de cils et travaille les sourcils, chez elle ou chez toi.', 540, 1110, array[0]::smallint[], 280, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'a', 'Extensions cil à cil', 120, 68);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'b', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'c', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'd', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'e', 'Sourcils au fil', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g001', 'Ti Très a Joanie', 'Joanie V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Les Abymes', 'Raizet', 16.27740, -61.49804, array['tresses']::text[], array['Knotless', 'Crochet braids', 'Nattes collées']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 510, 1050, array[0]::smallint[], 275, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'a', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'c', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'e', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'f', 'Départ de locks', 180, 105);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g002', 'Spa Vanille', null, 'Institut', array['À l''institut']::text[], 0, 'Les Abymes', 'Petit-Pérou', 16.26461, -61.50271, array['soins']::text[], array['Gommage', 'Cire tiède', 'Soin visage']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 510, 1170, array[0]::smallint[], 157, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'a', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'b', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'd', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'e', 'Massage dos', 30, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'f', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g003', 'Bougainvillée Barber Shop', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Petit-Pérou', 16.26902, -61.49625, array['barbier']::text[], array['Sans rendez-vous', 'Dégradé', 'Enfants']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 570, 1110, array[0, 1]::smallint[], 334, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'a', 'Rasage traditionnel', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'b', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'c', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'd', 'Coupe enfant', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g004', 'Barber Ti Kaz', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Chauvel', 16.26153, -61.49529, array['barbier']::text[], array['Dégradé', 'Enfants', 'Contours']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1080, array[0, 1]::smallint[], 8, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'a', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'b', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'c', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'd', 'Coupe + soin', 60, 30);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g005', 'L''Atelier Lagon', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Chauvel', 16.27383, -61.50337, array['coiffure', 'tresses']::text[], array['Boucles', 'Coloration', 'Mixte']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 480, 1080, array[0, 1]::smallint[], 12, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'a', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'b', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'c', 'Wash and go', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'd', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'e', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'f', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'g', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'h', 'Tresses enfant', 90, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g006', 'Escale Kannèl', null, 'Institut', array['À l''institut', 'À domicile']::text[], 0, 'Les Abymes', 'Grand-Camp', 16.26601, -61.50015, array['soins', 'maquillage']::text[], array['Soin visage', 'Soin éclat', 'Cire tiède']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 570, 1050, array[0]::smallint[], 216, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'b', 'Épilation maillot', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'c', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'd', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'e', 'Maquillage soirée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'f', 'Maquillage shooting', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g007', 'Onglerie Péyi', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Dothémare', 16.26176, -61.49460, array['ongles', 'cils']::text[], array['Nail art', 'French', 'Baby boomer']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1050, array[0, 1]::smallint[], 230, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'a', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'b', 'Semi-permanent pieds', 45, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'c', 'Semi-permanent mains', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'd', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'e', 'Beauté des pieds complète', 60, 41);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'f', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'g', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'h', 'Brow lift', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g008', 'Bougainvillée Nails', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Raizet', 16.27356, -61.49655, array['ongles']::text[], array['Pose gel', 'Beauté des pieds', 'Nail art']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 480, 1080, array[0, 1]::smallint[], 354, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'a', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'b', 'Semi-permanent pieds', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'c', 'Beauté des pieds complète', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'd', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'e', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'f', 'Remplissage gel', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g009', 'Rébecca Lash', 'Rébecca T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Les Abymes', 'Petit-Pérou', 16.26425, -61.50526, array['cils']::text[], array['Sourcils au fil', 'Cil à cil', 'Rehaussement']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 540, 1170, array[0]::smallint[], 247, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'a', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'b', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'c', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'd', 'Teinture sourcils', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g010', 'Johanna Onglerie', 'Johanna P.', 'Indépendante', array['Chez elle']::text[], 0, 'Les Abymes', 'Petit-Pérou', 16.26189, -61.50027, array['ongles', 'cils']::text[], array['Nail art', 'Capsules', 'Beauté des pieds']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1140, array[0]::smallint[], 306, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'a', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'b', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'c', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'd', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'e', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'f', 'Rehaussement + teinture', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g011', 'Kannèl Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Les Abymes', 'Chauvel', 16.26281, -61.50602, array['coiffure', 'tresses']::text[], array['Cheveux texturés', 'Balayage', 'Mixte']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1170, array[0, 1]::smallint[], 6, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'a', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'b', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'c', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'd', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'e', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'f', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'g', 'Box braids mi-longues', 240, 110);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g012', 'Ti Zong a Vanessa', 'Vanessa C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Les Abymes', 'Chauvel', 16.27158, -61.49881, array['ongles']::text[], array['Capsules', 'Semi-permanent', 'Nail art']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 510, 1170, array[0]::smallint[], 170, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'a', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'b', 'Nail art 10 doigts', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'c', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'd', 'Beauté des pieds complète', 60, 41);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'e', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'f', 'Remplissage gel', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g013', 'Institut Zandoli', null, 'Institut', array['À l''institut']::text[], 0, 'Les Abymes', 'Boisripeaux', 16.27314, -61.50795, array['soins']::text[], array['Soin éclat', 'Épilation', 'Cire tiède']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1110, array[0, 1]::smallint[], 286, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'a', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'b', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'c', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'd', 'Épilation demi-jambes', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'e', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'f', 'Soin visage éclat', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g014', 'Nail Bar Cannelle', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Boisripeaux', 16.26658, -61.49767, array['ongles', 'cils']::text[], array['French', 'Pose gel', 'Capsules']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 480, 1080, array[0]::smallint[], 137, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'a', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'b', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'c', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'd', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'e', 'Semi-permanent mains', 45, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'f', 'Sourcils au fil', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'g', 'Volume mixte', 150, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g015', 'Make-up by Samantha', 'Samantha M.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Les Abymes', 'Chauvel', 16.26747, -61.49592, array['maquillage']::text[], array['Mariée', 'Carnaval', 'Shooting']::text[], 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 480, 1110, array[0]::smallint[], 31, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'a', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'b', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'c', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'd', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'e', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'f', 'Maquillage soirée', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g016', 'Ti Très a Doriane', 'Doriane J.', 'Indépendante', array['À domicile']::text[], 5, 'Pointe-à-Pitre', 'Lauricisque', 16.23780, -61.54093, array['tresses']::text[], array['Box braids', 'Crochet braids', 'Enfants']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1170, array[]::smallint[], 123, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'a', 'Knotless braids', 300, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'b', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'c', 'Tresses enfant', 90, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'd', 'Box braids mi-longues', 240, 120);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g017', 'Colibri Bleu Nails', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Carénage', 16.24474, -61.53900, array['ongles']::text[], array['French', 'Semi-permanent', 'Pose gel']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 540, 1080, array[0, 1]::smallint[], 323, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'a', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'b', 'Beauté des pieds complète', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'd', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'e', 'Semi-permanent mains', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'f', 'Semi-permanent pieds', 45, 29);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g018', 'L''Atelier Lagon Pointe-à-Pitre', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Massabielle', 16.25050, -61.53490, array['coiffure']::text[], array['Brushing', 'Balayage', 'Coloration']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 570, 1080, array[0]::smallint[], 117, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'a', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'b', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'c', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'd', 'Coiffure événement', 60, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g019', 'Hair Bougainvillée', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Pointe-à-Pitre', 'Centre-ville', 16.24667, -61.53184, array['coiffure']::text[], array['Balayage', 'Lissage', 'Boucles']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1140, array[0]::smallint[], 183, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'a', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'b', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'c', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'd', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'e', 'Mèches et balayage', 150, 100);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g020', 'Maïlys Braids', 'Maïlys A.', 'Indépendante', array['À domicile']::text[], 0, 'Pointe-à-Pitre', 'Bergevin', 16.23396, -61.52411, array['tresses']::text[], array['Nattes collées', 'Enfants', 'Locks']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 540, 1110, array[0]::smallint[], 48, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'a', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'b', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'c', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'd', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'e', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'f', 'Knotless braids', 300, 135);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g021', 'Teddy Barber', 'Teddy G.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 0, 'Pointe-à-Pitre', 'Massabielle', 16.24176, -61.52446, array['barbier']::text[], array['Contours', 'Barbe', 'Dégradé']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 480, 1140, array[]::smallint[], 3, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'b', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'c', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'd', 'Coupe + soin', 60, 32);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g022', 'Cils by Audrey', 'Audrey R.', 'Indépendante', array['Chez elle']::text[], 0, 'Pointe-à-Pitre', 'Carénage', 16.24780, -61.53543, array['cils']::text[], array['Sourcils au fil', 'Volume russe', 'Volume mixte']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 570, 1050, array[0]::smallint[], 10, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'a', 'Brow lift', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'b', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'c', 'Rehaussement + teinture', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'd', 'Volume mixte', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'e', 'Teinture sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'f', 'Extensions cil à cil', 120, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g023', 'Kréyol Barber Shop', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Pointe-à-Pitre', 'Massabielle', 16.24193, -61.53807, array['barbier']::text[], array['Contours', 'Sans rendez-vous', 'Rasage']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1110, array[0]::smallint[], 288, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'a', 'Coupe + soin', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'b', 'Rasage traditionnel', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'c', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'd', 'Coupe homme', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'e', 'Coupe + barbe', 60, 23);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g024', 'Ti Très a Esther', 'Esther V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Pointe-à-Pitre', 'Lauricisque', 16.25088, -61.52559, array['tresses']::text[], array['Locks', 'Knotless', 'Enfants']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 570, 1080, array[0]::smallint[], 259, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'a', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'b', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'c', 'Box braids mi-longues', 240, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'd', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'e', 'Vanilles', 120, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g025', 'Make-up by Fabiola', 'Fabiola T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Pointe-à-Pitre', 'Lauricisque', 16.24074, -61.53110, array['maquillage']::text[], array['Invitée', 'Shooting', 'Soirée']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 570, 1110, array[]::smallint[], 79, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'a', 'Maquillage mariée + essai', 120, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'b', 'Maquillage shooting', 60, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'c', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'd', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'e', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'f', 'Maquillage jour', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g026', 'Solène Hair', 'Solène K.', 'Indépendante', array['Chez elle']::text[], 0, 'Pointe-à-Pitre', 'Centre-ville', 16.24422, -61.54141, array['coiffure', 'tresses']::text[], array['Coloration', 'Balayage', 'Brushing']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 570, 1050, array[]::smallint[], 137, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'a', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'b', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'c', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'd', 'Soin profond + coiffage boucles', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'e', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'f', 'Nattes collées', 90, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g027', 'Regard Alizés', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Baie-Mahault', 'La Jaille', 16.26460, -61.58825, array['cils']::text[], array['Cil à cil', 'Brow lift', 'Rehaussement']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 570, 1140, array[0]::smallint[], 79, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'a', 'Volume mixte', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'b', 'Extensions cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'c', 'Brow lift', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'd', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'e', 'Remplissage cils', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g028', 'Coco Braids', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'Destrellan', 16.25801, -61.59481, array['tresses']::text[], array['Locks', 'Enfants', 'Box braids']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1110, array[0]::smallint[], 314, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'a', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'b', 'Tresses enfant', 90, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'c', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'd', 'Knotless braids', 300, 140);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'e', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'f', 'Pose de perruque', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g029', 'L''Atelier Ylang', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Baie-Mahault', 'Bourg', 16.26399, -61.58065, array['coiffure']::text[], array['Balayage', 'Cheveux texturés', 'Mixte']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1140, array[0, 1]::smallint[], 61, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'a', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'b', 'Wash and go', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'c', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'd', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'e', 'Coloration', 90, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g030', 'Karambole Barber Shop', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'La Jaille', 16.27320, -61.58731, array['barbier']::text[], array['Contours', 'Rasage', 'Dégradé']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 510, 1170, array[0]::smallint[], 342, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'a', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'b', 'Coupe + barbe', 60, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'c', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'd', 'Rasage traditionnel', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'e', 'Dégradé + contours', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'f', 'Coupe homme', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g031', 'Make-up by Priscilla', 'Priscilla J.', 'Indépendante', array['À domicile']::text[], 10, 'Baie-Mahault', 'Jarry', 16.26767, -61.58116, array['maquillage']::text[], array['Mariée', 'Shooting', 'Cours']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 480, 1110, array[0]::smallint[], 268, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'a', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'b', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'c', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'd', 'Maquillage shooting', 60, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g032', 'Regard Lalin', null, 'Institut', array['À l''institut']::text[], 0, 'Baie-Mahault', 'La Jaille', 16.26860, -61.58727, array['cils']::text[], array['Cil à cil', 'Brow lift', 'Sourcils au fil']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 570, 1080, array[0]::smallint[], 44, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'a', 'Volume russe', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'b', 'Teinture sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'c', 'Rehaussement + teinture', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'd', 'Restructuration sourcils', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'e', 'Extensions cil à cil', 120, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g033', 'Hair Péyi', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Baie-Mahault', 'Convenance', 16.27726, -61.57642, array['coiffure']::text[], array['Mixte', 'Défrisage', 'Balayage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 480, 1170, array[0]::smallint[], 246, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'a', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'c', 'Shampoing + brushing', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'd', 'Défrisage + soin', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'e', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'f', 'Soin profond + coiffage boucles', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g034', 'Ti Très a Esther Baie-Mahault', 'Esther G.', 'Indépendante', array['À domicile']::text[], 5, 'Baie-Mahault', 'Jarry', 16.26067, -61.58890, array['tresses']::text[], array['Knotless', 'Crochet braids', 'Box braids']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1050, array[0]::smallint[], 345, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'a', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'b', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'c', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'd', 'Box braids mi-longues', 240, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'e', 'Vanilles', 120, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g035', 'Bougainvillée Barber Shop Baie-Mahault', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Baie-Mahault', 'Convenance', 16.25782, -61.58528, array['barbier']::text[], array['Contours', 'Enfants', 'Dégradé']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1110, array[0]::smallint[], 58, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'b', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'c', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'd', 'Coupe + barbe', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'e', 'Coupe + soin', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'f', 'Coupe homme', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g036', 'Ti Très a Émeline', 'Émeline T.', 'Indépendante', array['Chez elle']::text[], 0, 'Baie-Mahault', 'La Jaille', 16.26906, -61.58936, array['tresses']::text[], array['Enfants', 'Nattes collées', 'Vanilles']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1140, array[]::smallint[], 7, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'a', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'b', 'Tresses enfant', 90, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'c', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'd', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'e', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'f', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g037', 'Esther Esthétique', 'Esther S.', 'Indépendante', array['À domicile']::text[], 5, 'Baie-Mahault', 'Convenance', 16.26179, -61.57777, array['soins']::text[], array['Épilation', 'Massage', 'Gommage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 510, 1080, array[]::smallint[], 104, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'a', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'b', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'c', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'd', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'e', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'f', 'Épilation demi-jambes', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g038', 'Sable Blanc Barber Shop', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bourg', 16.19881, -61.48894, array['barbier']::text[], array['Rasage', 'Dégradé', 'Sans rendez-vous']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1080, array[0]::smallint[], 231, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'a', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'b', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'c', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'd', 'Coupe + soin', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'e', 'Dégradé + contours', 30, 21);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g039', 'Barber Lagon', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Montauban', 16.20684, -61.48845, array['barbier']::text[], array['Enfants', 'Rasage', 'Barbe']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1140, array[0, 1]::smallint[], 58, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'a', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'b', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'c', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'd', 'Coupe enfant', 30, 13);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g040', 'Coiffure Mango', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Montauban', 16.21168, -61.48614, array['coiffure']::text[], array['Boucles', 'Brushing', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1050, array[0, 1]::smallint[], 131, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'a', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'b', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'c', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'd', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'e', 'Wash and go', 60, 32);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g041', 'Ludmila Locks', 'Ludmila T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Le Gosier', 'Bas-du-Fort', 16.21075, -61.50038, array['tresses']::text[], array['Vanilles', 'Crochet braids', 'Box braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 480, 1050, array[]::smallint[], 321, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'a', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'b', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'c', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'd', 'Crochet braids', 150, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g042', 'Priscilla Locks', 'Priscilla G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Le Gosier', 'Pliane', 16.20784, -61.49742, array['tresses']::text[], array['Nattes collées', 'Crochet braids', 'Vanilles']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 570, 1050, array[0]::smallint[], 122, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'a', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'b', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'c', 'Tresses enfant', 90, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'd', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'e', 'Vanilles', 120, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g043', 'Nail Bar Vanille', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bourg', 16.21383, -61.50241, array['ongles']::text[], array['Pose gel', 'Nail art', 'Baby boomer']::text[], 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.', 480, 1170, array[0, 1]::smallint[], 111, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'a', 'Beauté des pieds complète', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'b', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'c', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'd', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'e', 'Manucure express', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'f', 'Semi-permanent pieds', 45, 27);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g044', 'Shaïna Onglerie', 'Shaïna G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Le Gosier', 'Pliane', 16.19834, -61.50012, array['ongles']::text[], array['French', 'Beauté des pieds', 'Pose gel']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 510, 1110, array[0, 1]::smallint[], 121, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'a', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'b', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'c', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'd', 'Pose capsules + gel', 120, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g045', 'Jonathan Barber', 'Jonathan C.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 0, 'Le Gosier', 'Bas-du-Fort', 16.20567, -61.50008, array['barbier']::text[], array['Dégradé', 'Barbe', 'Enfants']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 570, 1080, array[0, 1]::smallint[], 247, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'a', 'Rasage traditionnel', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'b', 'Dégradé + contours', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'c', 'Taille de barbe', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'd', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'e', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'f', 'Coupe + barbe', 60, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g046', 'Nails by Christelle', 'Christelle F.', 'Indépendante', array['Chez elle']::text[], 0, 'Le Gosier', 'Pliane', 16.20675, -61.49596, array['ongles']::text[], array['Baby boomer', 'Pose gel', 'Capsules']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 540, 1050, array[]::smallint[], 280, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'a', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'b', 'Semi-permanent mains', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'c', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'd', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'e', 'Nail art 10 doigts', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g047', 'L''Atelier des Ongles Péyi', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Mare-Gaillard', 16.21064, -61.49128, array['ongles', 'cils']::text[], array['Beauté des pieds', 'Semi-permanent', 'Capsules']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1050, array[0, 1]::smallint[], 94, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'a', 'Semi-permanent pieds', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'b', 'Semi-permanent mains', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'c', 'Beauté des pieds complète', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'd', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'e', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'f', 'Volume mixte', 150, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g048', 'Stéphanie Locks', 'Stéphanie F.', 'Indépendante', array['À domicile']::text[], 5, 'Petit-Bourg', 'Vernou', 16.18257, -61.58666, array['tresses']::text[], array['Crochet braids', 'Locks', 'Box braids']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 510, 1140, array[0]::smallint[], 135, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'a', 'Tresses enfant', 90, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'c', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'd', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'e', 'Crochet braids', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'f', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g049', 'Samantha Coiffure', 'Samantha L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Petit-Bourg', 'Colin', 16.18439, -61.59016, array['coiffure']::text[], array['Boucles', 'Lissage', 'Mixte']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 570, 1170, array[]::smallint[], 4, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'a', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'b', 'Lissage brésilien', 180, 185);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'c', 'Mèches et balayage', 150, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'd', 'Wash and go', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g050', 'Escale Jasmin', null, 'Institut', array['À l''institut']::text[], 0, 'Petit-Bourg', 'Vernou', 16.18957, -61.58624, array['soins']::text[], array['Soin éclat', 'Épilation', 'Soin visage']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 480, 1050, array[0]::smallint[], 173, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'a', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'b', 'Soin visage hydratant', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'c', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'd', 'Gommage corps', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'e', 'Épilation jambes complètes', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'f', 'Épilation maillot', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g051', 'Spa Sable Blanc', null, 'Institut', array['À l''institut']::text[], 0, 'Petit-Bourg', 'Arnouville', 16.18252, -61.59080, array['soins']::text[], array['Soin visage', 'Cire tiède', 'Épilation']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 510, 1080, array[0, 1]::smallint[], 283, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'a', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'b', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'c', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'd', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'e', 'Épilation maillot', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'f', 'Soin visage éclat', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g052', 'Karine Onglerie', 'Karine R.', 'Indépendante', array['Chez elle']::text[], 0, 'Petit-Bourg', 'Vernou', 16.18351, -61.58601, array['ongles']::text[], array['Pose gel', 'Semi-permanent', 'Nail art']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 510, 1080, array[0, 1]::smallint[], 331, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'a', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'b', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'c', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'd', 'Nail art 10 doigts', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'e', 'Dépose', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g053', 'Rachelle Nails', 'Rachelle F.', 'Indépendante', array['Chez elle']::text[], 0, 'Petit-Bourg', 'Vernou', 16.18249, -61.59034, array['ongles']::text[], array['Beauté des pieds', 'Nail art', 'Semi-permanent']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 510, 1080, array[]::smallint[], 183, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'a', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'b', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'c', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'd', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'e', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'f', 'Nail art 10 doigts', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g054', 'Barber Cannelle', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Petit-Bourg', 'Vernou', 16.19509, -61.58626, array['barbier']::text[], array['Rasage', 'Dégradé', 'Sans rendez-vous']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1050, array[0, 1]::smallint[], 162, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'a', 'Coupe + soin', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'b', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'c', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'd', 'Dégradé + contours', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'e', 'Rasage traditionnel', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'f', 'Coupe homme', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g055', 'Nail Bar Solèy', null, 'Salon', array['Au salon', 'À domicile']::text[], 10, 'Sainte-Anne', 'Châteaubrun', 16.21969, -61.37839, array['ongles']::text[], array['Nail art', 'Semi-permanent', 'French']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 570, 1110, array[0]::smallint[], 47, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'a', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'b', 'Semi-permanent mains', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'c', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'd', 'Manucure express', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g056', 'Cils by Émeline', 'Émeline R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Sainte-Anne', 'Douville', 16.23205, -61.37687, array['cils']::text[], array['Volume russe', 'Rehaussement', 'Cil à cil']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 540, 1050, array[0]::smallint[], 64, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'a', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'b', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'c', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'd', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'e', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'f', 'Teinture sourcils', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g057', 'Les Ongles de Solène', 'Solène M.', 'Indépendante', array['Chez elle']::text[], 0, 'Sainte-Anne', 'Durivage', 16.22316, -61.38845, array['ongles']::text[], array['Pose gel', 'Semi-permanent', 'Capsules']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 480, 1110, array[0, 1]::smallint[], 165, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'a', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'b', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'd', 'Semi-permanent pieds', 45, 30);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g058', 'Grand Large Nails', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Anne', 'Durivage', 16.23445, -61.37293, array['ongles', 'cils']::text[], array['Pose gel', 'Baby boomer', 'French']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 540, 1110, array[0]::smallint[], 91, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'a', 'Semi-permanent pieds', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'b', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'c', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'd', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'e', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'f', 'Volume mixte', 150, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g059', 'Escale Jasmin Sainte-Anne', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Anne', 'Douville', 16.23301, -61.37656, array['soins', 'maquillage']::text[], array['Soin visage', 'Épilation', 'Gommage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1080, array[0]::smallint[], 70, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'a', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'b', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'c', 'Épilation jambes complètes', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'd', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'e', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'f', 'Maquillage invitée', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g060', 'Tresses by Chloé', 'Chloé S.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Sainte-Anne', 'Bourg', 16.21836, -61.38250, array['tresses']::text[], array['Knotless', 'Locks', 'Box braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 570, 1110, array[]::smallint[], 89, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'a', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'b', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'c', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'd', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'e', 'Knotless braids', 300, 160);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g061', 'Flamboyant Beauté', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Anne', 'Bourg', 16.22961, -61.37580, array['soins']::text[], array['Épilation', 'Gommage', 'Soin visage']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1170, array[0]::smallint[], 235, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'a', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'c', 'Épilation demi-jambes', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'd', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'e', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'f', 'Épilation aisselles', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g062', 'Le Fauteuil Lanmè', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Le Moule', 'Sergent', 16.33955, -61.35385, array['barbier']::text[], array['Sans rendez-vous', 'Enfants', 'Rasage']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1110, array[0]::smallint[], 109, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'a', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'b', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'c', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'd', 'Coupe + soin', 60, 31);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g063', 'Hair Corail', null, 'Salon', array['Au salon']::text[], 0, 'Le Moule', 'Bourg', 16.33733, -61.35334, array['coiffure']::text[], array['Cheveux texturés', 'Balayage', 'Boucles']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 510, 1110, array[0]::smallint[], 316, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'a', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'b', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'c', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'd', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'e', 'Coupe + brushing', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g064', 'Natural Ti Paradis', null, 'Salon', array['Au salon', 'À domicile']::text[], 8, 'Le Moule', 'Bourg', 16.33561, -61.33769, array['tresses']::text[], array['Knotless', 'Vanilles', 'Locks']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1050, array[0, 1]::smallint[], 263, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'a', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'b', 'Tresses enfant', 90, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'c', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'd', 'Crochet braids', 150, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g065', 'Regard Trois Îlets', null, 'Institut', array['À l''institut', 'À domicile']::text[], 8, 'Le Moule', 'L''Autre Bord', 16.34091, -61.33957, array['cils', 'ongles']::text[], array['Rehaussement', 'Sourcils au fil', 'Cil à cil']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 570, 1170, array[0, 1]::smallint[], 81, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'a', 'Extensions cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'b', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'c', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'd', 'Brow lift', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'e', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'f', 'Pose capsules + gel', 120, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g066', 'Locks Alizés', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Le Moule', 'Sergent', 16.32727, -61.34427, array['tresses']::text[], array['Box braids', 'Crochet braids', 'Nattes collées']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 510, 1170, array[0, 1]::smallint[], 103, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'a', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'b', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'c', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'd', 'Knotless braids', 300, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'e', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g067', 'Gwladys Brows', 'Gwladys F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Le Moule', 'Sergent', 16.33600, -61.34989, array['cils']::text[], array['Rehaussement', 'Cil à cil', 'Brow lift']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 540, 1050, array[]::smallint[], 294, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'a', 'Brow lift', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'b', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'c', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'd', 'Volume mixte', 150, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g068', 'Barber Ylang', null, 'Salon', array['Au salon']::text[], 0, 'Le Moule', 'Sergent', 16.33534, -61.33764, array['barbier']::text[], array['Rasage', 'Barbe', 'Enfants']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1170, array[0]::smallint[], 320, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'a', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'b', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'c', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'd', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'e', 'Coupe + soin', 60, 33);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g069', 'Regard Monbin', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Rose', 'La Boucan', 16.33483, -61.69863, array['cils']::text[], array['Cil à cil', 'Volume mixte', 'Volume russe']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 540, 1170, array[0]::smallint[], 61, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'a', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'b', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'c', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'd', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'e', 'Teinture sourcils', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g070', 'Barber by Kévin', 'Kévin B.', 'Indépendant', array['À domicile']::text[], 5, 'Sainte-Rose', 'La Boucan', 16.32266, -61.69772, array['barbier']::text[], array['Sans rendez-vous', 'Barbe', 'Contours']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 510, 1170, array[0, 1]::smallint[], 202, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'a', 'Coupe + barbe', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'b', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'c', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'd', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'e', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'f', 'Coupe + soin', 60, 33);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g071', 'Soufrière Beauty Studio', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Rose', 'Viard', 16.33725, -61.70592, array['maquillage']::text[], array['Cours', 'Carnaval', 'Mariée']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 540, 1140, array[0, 1]::smallint[], 239, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'a', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'b', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'c', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'd', 'Maquillage mariée + essai', 120, 155);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g072', 'Ti Zong a Érika', 'Érika F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Sainte-Rose', 'Viard', 16.33439, -61.69108, array['ongles']::text[], array['Beauté des pieds', 'French', 'Nail art']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 480, 1080, array[]::smallint[], 108, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'a', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'b', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'c', 'Semi-permanent mains', 45, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'd', 'Semi-permanent pieds', 45, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g073', 'Les Boucles de Rachelle', 'Rachelle T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Sainte-Rose', 'La Boucan', 16.33416, -61.69258, array['coiffure', 'tresses']::text[], array['Cheveux texturés', 'Défrisage', 'Mixte']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 540, 1110, array[0]::smallint[], 102, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'a', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'c', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'd', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'e', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'f', 'Box braids mi-longues', 240, 115);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g074', 'Kassandra Onglerie', 'Kassandra C.', 'Indépendante', array['Chez elle']::text[], 0, 'Sainte-Rose', 'Sofaïa', 16.34162, -61.70642, array['ongles']::text[], array['Semi-permanent', 'Baby boomer', 'Pose gel']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 540, 1050, array[0]::smallint[], 142, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'a', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'b', 'Beauté des pieds complète', 60, 41);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'c', 'Nail art 10 doigts', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'd', 'Remplissage gel', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g075', 'Onglerie Frangipane', null, 'Salon', array['Au salon']::text[], 0, 'Capesterre-Belle-Eau', 'Saint-Sauveur', 16.05147, -61.56185, array['ongles']::text[], array['Beauté des pieds', 'French', 'Baby boomer']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 510, 1050, array[0, 1]::smallint[], 345, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'b', 'Baby boomer', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'c', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'd', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'e', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'f', 'Remplissage gel', 60, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g076', 'Spa Coco', null, 'Institut', array['À l''institut', 'À domicile']::text[], 8, 'Capesterre-Belle-Eau', 'Bananier', 16.04014, -61.55827, array['soins']::text[], array['Cire tiède', 'Soin visage', 'Massage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1170, array[0, 1]::smallint[], 342, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'a', 'Épilation jambes complètes', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'b', 'Soin visage hydratant', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'c', 'Massage dos', 30, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'd', 'Épilation sourcils', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'e', 'Soin visage éclat', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'f', 'Épilation aisselles', 30, 9);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g077', 'Coiffure Karambole', null, 'Salon', array['Au salon']::text[], 0, 'Capesterre-Belle-Eau', 'Bourg', 16.05144, -61.56886, array['coiffure']::text[], array['Défrisage', 'Boucles', 'Lissage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 570, 1140, array[0]::smallint[], 290, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'a', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'b', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'c', 'Wash and go', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'd', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'e', 'Coupe + brushing', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g078', 'Coiffure by Shaïna', 'Shaïna N.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Capesterre-Belle-Eau', 'Bourg', 16.05296, -61.56981, array['coiffure']::text[], array['Brushing', 'Lissage', 'Boucles']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 540, 1110, array[0]::smallint[], 239, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'a', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'c', 'Wash and go', 60, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'd', 'Shampoing + brushing', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'e', 'Lissage brésilien', 180, 165);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g079', 'Anaïs Beauty', 'Anaïs G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Capesterre-Belle-Eau', 'Bananier', 16.04109, -61.56755, array['maquillage']::text[], array['Shooting', 'Invitée', 'Soirée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 510, 1110, array[]::smallint[], 164, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'a', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'b', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'c', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'd', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'e', 'Cours d''auto-maquillage', 90, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g080', 'Maïlys Beauty', 'Maïlys L.', 'Indépendante', array['À domicile']::text[], 15, 'Capesterre-Belle-Eau', 'Saint-Sauveur', 16.05308, -61.55790, array['maquillage']::text[], array['Invitée', 'Mariée', 'Cours']::text[], 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 510, 1080, array[0]::smallint[], 72, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'a', 'Maquillage mariée + essai', 120, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'b', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'c', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'e', 'Cours d''auto-maquillage', 90, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g081', 'Institut Ylang Regard', null, 'Institut', array['À l''institut', 'À domicile']::text[], 8, 'Basse-Terre', 'Rivière-des-Pères', 15.98634, -61.73827, array['cils']::text[], array['Cil à cil', 'Volume russe', 'Brow lift']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 540, 1110, array[0]::smallint[], 319, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'a', 'Volume russe', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'b', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'c', 'Rehaussement + teinture', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'd', 'Remplissage cils', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g082', 'Nadège Braids', 'Nadège B.', 'Indépendante', array['Chez elle']::text[], 0, 'Basse-Terre', 'Centre', 16.00413, -61.73243, array['tresses']::text[], array['Box braids', 'Nattes collées', 'Knotless']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 480, 1110, array[0]::smallint[], 158, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'a', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'b', 'Knotless braids', 300, 140);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'c', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'd', 'Fulani braids', 180, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g083', 'Hair Balisier', null, 'Salon', array['Au salon']::text[], 0, 'Basse-Terre', 'Petit-Paris', 16.00515, -61.73058, array['coiffure', 'tresses']::text[], array['Boucles', 'Brushing', 'Cheveux texturés']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1140, array[0]::smallint[], 331, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'a', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'b', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'c', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'd', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'e', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'f', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'g', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g084', 'Barbershop Sable Blanc', null, 'Salon', array['Au salon', 'À domicile']::text[], 10, 'Basse-Terre', 'Rivière-des-Pères', 15.98910, -61.73403, array['barbier']::text[], array['Enfants', 'Sans rendez-vous', 'Barbe']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1050, array[0, 1]::smallint[], 153, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'a', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'b', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'c', 'Coupe + barbe', 60, 24);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'd', 'Coupe homme', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'e', 'Coupe + soin', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'f', 'Rasage traditionnel', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g085', 'Lindsay Esthétique', 'Lindsay F.', 'Indépendante', array['À domicile']::text[], 5, 'Basse-Terre', 'Carmel', 15.99493, -61.73675, array['soins']::text[], array['Soin éclat', 'Soin visage', 'Gommage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 510, 1170, array[0]::smallint[], 301, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'a', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'b', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'c', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'd', 'Épilation aisselles', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g086', 'Nails by Sandy', 'Sandy P.', 'Indépendante', array['À domicile']::text[], 5, 'Basse-Terre', 'Rivière-des-Pères', 15.99925, -61.73712, array['ongles']::text[], array['French', 'Semi-permanent', 'Nail art']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 540, 1050, array[0]::smallint[], 118, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'a', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'b', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'c', 'Baby boomer', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'd', 'Beauté des pieds complète', 60, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g087', 'Gwladys Hair', 'Gwladys C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Morne-à-l''Eau', 'Vieux-Bourg', 16.33232, -61.45667, array['coiffure']::text[], array['Balayage', 'Brushing', 'Mixte']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 540, 1080, array[0, 1]::smallint[], 251, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'a', 'Wash and go', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'b', 'Shampoing + brushing', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'd', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'e', 'Coloration', 90, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g088', 'Le Fauteuil Tamarin', null, 'Salon', array['Au salon']::text[], 0, 'Morne-à-l''Eau', 'Perrin', 16.34015, -61.45199, array['barbier']::text[], array['Barbe', 'Contours', 'Sans rendez-vous']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1140, array[0]::smallint[], 280, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'a', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'b', 'Coupe + barbe', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'c', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'd', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'e', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'f', 'Coupe homme', 30, 20);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g089', 'Regard Solèy', null, 'Institut', array['À l''institut', 'À domicile']::text[], 8, 'Morne-à-l''Eau', 'Vieux-Bourg', 16.32448, -61.45658, array['cils']::text[], array['Sourcils au fil', 'Cil à cil', 'Volume mixte']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 540, 1110, array[0]::smallint[], 65, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'a', 'Sourcils au fil', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'b', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'c', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'd', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'e', 'Restructuration sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'f', 'Extensions cil à cil', 120, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g090', 'Institut Gwada Regard', null, 'Institut', array['À l''institut']::text[], 0, 'Morne-à-l''Eau', 'Perrin', 16.33627, -61.45686, array['cils']::text[], array['Volume mixte', 'Sourcils au fil', 'Rehaussement']::text[], 'Cabines individuelles, produits hypoallergéniques.', 540, 1140, array[0, 1]::smallint[], 140, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'b', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'c', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'd', 'Extensions cil à cil', 120, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g091', 'Les Nattes de Leslie', 'Leslie G.', 'Indépendante', array['À domicile']::text[], 5, 'Morne-à-l''Eau', 'Vieux-Bourg', 16.34067, -61.45390, array['tresses']::text[], array['Crochet braids', 'Nattes collées', 'Enfants']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 540, 1080, array[0]::smallint[], 73, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'a', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'b', 'Crochet braids', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'c', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'd', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g092', 'Joanie Lash', 'Joanie D.', 'Indépendante', array['Chez elle']::text[], 0, 'Lamentin', 'Bourg', 16.28078, -61.63663, array['cils']::text[], array['Volume russe', 'Rehaussement', 'Brow lift']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 570, 1110, array[0]::smallint[], 36, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'a', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'b', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'c', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'd', 'Brow lift', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g093', 'Anaïs Coiffure', 'Anaïs D.', 'Indépendante', array['À domicile']::text[], 10, 'Lamentin', 'Ravine-Chaude', 16.26998, -61.63837, array['coiffure']::text[], array['Balayage', 'Défrisage', 'Mixte']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 570, 1170, array[0]::smallint[], 183, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'a', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'b', 'Wash and go', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'c', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'd', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'e', 'Coupe + brushing', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g094', 'Cils by Lindsay', 'Lindsay B.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Lamentin', 'Caillou', 16.26702, -61.63885, array['cils']::text[], array['Brow lift', 'Cil à cil', 'Volume russe']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 510, 1170, array[0, 1]::smallint[], 13, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'a', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'b', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'c', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'd', 'Restructuration sourcils', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g095', 'L''Atelier Ti Kaz', null, 'Salon', array['Au salon']::text[], 0, 'Lamentin', 'Caillou', 16.26307, -61.62848, array['coiffure']::text[], array['Balayage', 'Boucles', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 480, 1110, array[0]::smallint[], 171, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'a', 'Shampoing + brushing', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'b', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'c', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'd', 'Lissage brésilien', 180, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'e', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'f', 'Wash and go', 60, 36);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g096', 'Institut Lanmè Regard', null, 'Institut', array['À l''institut', 'À domicile']::text[], 0, 'Lamentin', 'Ravine-Chaude', 16.27080, -61.62774, array['cils']::text[], array['Volume mixte', 'Cil à cil', 'Rehaussement']::text[], 'Cabines individuelles, produits hypoallergéniques.', 480, 1110, array[0]::smallint[], 229, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'b', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'c', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'd', 'Volume russe', 150, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g097', 'Tessa Make-up', 'Tessa V.', 'Indépendante', array['Chez elle']::text[], 0, 'Saint-François', 'Bourg', 16.24714, -61.26895, array['maquillage']::text[], array['Invitée', 'Soirée', 'Cours']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 510, 1110, array[]::smallint[], 239, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'a', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'b', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'c', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'd', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'e', 'Maquillage shooting', 60, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g098', 'Locks Anoli', null, 'Salon', array['Au salon', 'À domicile']::text[], 10, 'Saint-François', 'Marina', 16.25793, -61.27648, array['tresses']::text[], array['Knotless', 'Crochet braids', 'Locks']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 570, 1080, array[0, 1]::smallint[], 142, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'b', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'c', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'e', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g099', 'Hair Pomme Cannelle', null, 'Salon', array['Au salon']::text[], 0, 'Saint-François', 'Bragelogne', 16.25836, -61.26746, array['coiffure']::text[], array['Mixte', 'Brushing', 'Balayage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1170, array[0]::smallint[], 68, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'a', 'Wash and go', 60, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'c', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'd', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'e', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'f', 'Soin profond + coiffage boucles', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g100', 'Marine Braids', 'Marine N.', 'Indépendante', array['Chez elle']::text[], 0, 'Saint-François', 'Sainte-Marthe', 16.25630, -61.27175, array['tresses']::text[], array['Nattes collées', 'Crochet braids', 'Vanilles']::text[], 'Spécialiste des locks, du départ à l''entretien.', 540, 1140, array[0]::smallint[], 309, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'a', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'c', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'd', 'Tresses enfant', 90, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'e', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'f', 'Fulani braids', 180, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g101', 'Anoli Coiffure', null, 'Salon', array['Au salon']::text[], 0, 'Saint-François', 'Sainte-Marthe', 16.24331, -61.26772, array['coiffure']::text[], array['Coloration', 'Boucles', 'Mixte']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1140, array[0, 1]::smallint[], 124, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'a', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'c', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'd', 'Shampoing + brushing', 60, 30);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g102', 'Pomme Cannelle Nails', null, 'Salon', array['Au salon']::text[], 0, 'Saint-Claude', 'Bourg', 16.02285, -61.70567, array['ongles']::text[], array['Baby boomer', 'Beauté des pieds', 'Nail art']::text[], 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.', 480, 1110, array[0]::smallint[], 206, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'a', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'b', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'c', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'd', 'Nail art 10 doigts', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g103', 'Balisier Nails', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Saint-Claude', 'Bourg', 16.01884, -61.69219, array['ongles']::text[], array['Pose gel', 'Beauté des pieds', 'French']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1050, array[0, 1]::smallint[], 109, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'a', 'Semi-permanent mains', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'b', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'd', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'e', 'Semi-permanent pieds', 45, 31);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g104', 'Cils by Chloé', 'Chloé A.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Saint-Claude', 'Morin', 16.02204, -61.70056, array['cils']::text[], array['Rehaussement', 'Volume russe', 'Volume mixte']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 480, 1170, array[0]::smallint[], 309, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'b', 'Restructuration sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'c', 'Extensions cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'd', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'e', 'Brow lift', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g105', 'Le Regard de Yoline', 'Yoline D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Goyave', 'Bourg', 16.14043, -61.56630, array['cils']::text[], array['Sourcils au fil', 'Rehaussement', 'Volume russe']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 540, 1050, array[0]::smallint[], 337, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'a', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'b', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'c', 'Restructuration sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'd', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'e', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'f', 'Volume russe', 150, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g106', 'Daphné Esthétique', 'Daphné L.', 'Indépendante', array['Chez elle']::text[], 0, 'Goyave', 'Morne-Rouge', 16.13761, -61.56654, array['soins']::text[], array['Cire tiède', 'Gommage', 'Soin éclat']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 510, 1050, array[]::smallint[], 295, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'a', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'b', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'c', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'd', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'e', 'Massage dos', 30, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'f', 'Épilation jambes complètes', 60, 29);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g107', 'Institut Goyave', null, 'Institut', array['À l''institut', 'À domicile']::text[], 5, 'Goyave', 'Bourg', 16.12997, -61.56873, array['soins']::text[], array['Épilation', 'Soin éclat', 'Massage']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1110, array[0]::smallint[], 144, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'a', 'Gommage corps', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'b', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'c', 'Épilation maillot', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'd', 'Épilation jambes complètes', 60, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g108', 'Studio Solèy Make-up', null, 'Salon', array['Au salon']::text[], 0, 'Petit-Canal', 'Les Mangles', 16.37363, -61.49280, array['maquillage']::text[], array['Invitée', 'Soirée', 'Carnaval']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 510, 1050, array[0]::smallint[], 139, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'a', 'Maquillage jour', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'b', 'Cours d''auto-maquillage', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'c', 'Maquillage shooting', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'd', 'Maquillage soirée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'e', 'Maquillage mariée + essai', 120, 140);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'f', 'Maquillage invitée', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g109', 'Ti Très a Anaïs', 'Anaïs L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Petit-Canal', 'Les Mangles', 16.38014, -61.48993, array['tresses']::text[], array['Vanilles', 'Enfants', 'Nattes collées']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 540, 1170, array[0]::smallint[], 149, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'a', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'b', 'Fulani braids', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'c', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'd', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'e', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'f', 'Knotless braids', 300, 160);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g110', 'Salon Caravelle', null, 'Salon', array['Au salon']::text[], 0, 'Petit-Canal', 'Bourg', 16.39095, -61.49657, array['coiffure']::text[], array['Défrisage', 'Coloration', 'Boucles']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1050, array[0]::smallint[], 193, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'a', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'c', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'd', 'Lissage brésilien', 180, 175);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'e', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'f', 'Soin profond + coiffage boucles', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g111', 'Les Nattes de Wendy', 'Wendy J.', 'Indépendante', array['À domicile']::text[], 5, 'Port-Louis', 'Bourg', 16.41384, -61.53013, array['tresses']::text[], array['Knotless', 'Locks', 'Enfants']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 480, 1140, array[0]::smallint[], 15, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'b', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'c', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'd', 'Tresses enfant', 90, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'e', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g112', 'Ti Très a Axelle', 'Axelle G.', 'Indépendante', array['À domicile']::text[], 5, 'Port-Louis', 'Bourg', 16.42179, -61.52568, array['tresses']::text[], array['Knotless', 'Locks', 'Box braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1080, array[0]::smallint[], 30, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'a', 'Tresses enfant', 90, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'c', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'd', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'e', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'f', 'Vanilles', 120, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g113', 'Gwladys Nails', 'Gwladys V.', 'Indépendante', array['À domicile']::text[], 0, 'Port-Louis', 'Beauport', 16.42753, -61.52803, array['ongles']::text[], array['Beauté des pieds', 'Baby boomer', 'French']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 570, 1080, array[]::smallint[], 174, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'a', 'Semi-permanent pieds', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'b', 'Beauté des pieds complète', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'd', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'e', 'Semi-permanent mains', 45, 27);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g114', 'Marvin Barber', 'Marvin R.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 15, 'Gourbeyre', 'Bourg', 15.99953, -61.70090, array['barbier']::text[], array['Contours', 'Barbe', 'Enfants']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 480, 1140, array[]::smallint[], 169, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'a', 'Coupe homme', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'b', 'Dégradé + contours', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'c', 'Rasage traditionnel', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'd', 'Coupe + barbe', 60, 29);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g115', 'Onglerie Alamanda', null, 'Salon', array['Au salon']::text[], 0, 'Gourbeyre', 'Rivière-Sens', 15.98747, -61.68736, array['ongles']::text[], array['Beauté des pieds', 'Pose gel', 'Semi-permanent']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 510, 1110, array[0, 1]::smallint[], 123, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'a', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'b', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'c', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'd', 'Beauté des pieds complète', 60, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'e', 'Manucure express', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g116', 'Glam by Tessa', 'Tessa R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Gourbeyre', 'Rivière-Sens', 15.99629, -61.68719, array['maquillage']::text[], array['Invitée', 'Cours', 'Mariée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 570, 1170, array[0]::smallint[], 239, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'a', 'Maquillage carnaval', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'b', 'Maquillage mariée + essai', 120, 140);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'c', 'Cours d''auto-maquillage', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'd', 'Maquillage invitée', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'e', 'Maquillage soirée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'f', 'Maquillage shooting', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g117', 'Spa Corail', null, 'Institut', array['À l''institut', 'À domicile']::text[], 5, 'Trois-Rivières', 'Schoelcher', 15.98160, -61.63832, array['soins']::text[], array['Soin éclat', 'Épilation', 'Massage']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1110, array[0, 1]::smallint[], 246, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'a', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'b', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'c', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'd', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g118', 'Corossol Beauté', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Trois-Rivières', 'Bourg', 15.98172, -61.63727, array['soins']::text[], array['Soin éclat', 'Massage', 'Soin visage']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1110, array[0, 1]::smallint[], 208, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'a', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'b', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'c', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'd', 'Épilation maillot', 30, 21);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g119', 'Doriane Hair', 'Doriane C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Trois-Rivières', 'Bourg', 15.97145, -61.64933, array['coiffure', 'tresses']::text[], array['Boucles', 'Mixte', 'Défrisage']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 540, 1140, array[0]::smallint[], 106, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'a', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'b', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'c', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'd', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'e', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'f', 'Nattes collées', 90, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g120', 'Noémie Make-up', 'Noémie G.', 'Indépendante', array['À domicile']::text[], 0, 'Bouillante', 'Bourg', 16.12429, -61.77620, array['maquillage']::text[], array['Shooting', 'Invitée', 'Soirée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 510, 1170, array[0, 1]::smallint[], 304, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'a', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'b', 'Maquillage jour', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'c', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'd', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'e', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g121', 'Institut Mango', null, 'Institut', array['À l''institut', 'À domicile']::text[], 15, 'Bouillante', 'Pigeon', 16.12084, -61.77569, array['soins']::text[], array['Gommage', 'Cire tiède', 'Soin éclat']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 570, 1080, array[0, 1]::smallint[], 168, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'a', 'Soin visage hydratant', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'b', 'Épilation jambes complètes', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'c', 'Soin visage éclat', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'd', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'e', 'Épilation maillot', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'f', 'Épilation sourcils', 30, 9);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g122', 'Flamboyant Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Bouillante', 'Pigeon', 16.12060, -61.76878, array['coiffure']::text[], array['Balayage', 'Cheveux texturés', 'Défrisage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1110, array[0]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'a', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'b', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'd', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'e', 'Wash and go', 60, 32);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g123', 'Priscilla Locks Deshaies', 'Priscilla C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Deshaies', 'Bourg', 16.30906, -61.79981, array['tresses']::text[], array['Enfants', 'Locks', 'Box braids']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1170, array[]::smallint[], 16, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'a', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'b', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'c', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'd', 'Départ de locks', 180, 105);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g124', 'Les Ongles de Christelle', 'Christelle M.', 'Indépendante', array['À domicile']::text[], 15, 'Deshaies', 'Grande-Anse', 16.29962, -61.79763, array['ongles']::text[], array['Nail art', 'French', 'Semi-permanent']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 570, 1110, array[]::smallint[], 209, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'b', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'c', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'd', 'Manucure express', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'e', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'f', 'Nail art 10 doigts', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g125', 'Ti Très a Tatiana', 'Tatiana N.', 'Indépendante', array['Chez elle']::text[], 0, 'Pointe-Noire', 'Bourg', 16.22241, -61.79643, array['tresses']::text[], array['Box braids', 'Enfants', 'Nattes collées']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1170, array[0, 1]::smallint[], 86, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'a', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'b', 'Tresses enfant', 90, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'c', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'd', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'e', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'f', 'Nattes collées', 90, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g126', 'Barber Grand Large', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-Noire', 'Acomat', 16.23990, -61.78260, array['barbier']::text[], array['Rasage', 'Barbe', 'Sans rendez-vous']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1050, array[0, 1]::smallint[], 229, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'a', 'Coupe + barbe', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'b', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'c', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'd', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'e', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'f', 'Coupe homme', 30, 20);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g127', 'Axelle Coiffure', 'Axelle T.', 'Indépendante', array['Chez elle']::text[], 0, 'Vieux-Habitants', 'Géry', 16.05394, -61.75799, array['coiffure']::text[], array['Mixte', 'Lissage', 'Défrisage']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 480, 1050, array[]::smallint[], 350, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'a', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'b', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'c', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'd', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'e', 'Mèches et balayage', 150, 100);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g128', 'Nail Bar Zandoli', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Vieux-Habitants', 'Marigot', 16.06227, -61.77070, array['ongles', 'cils']::text[], array['French', 'Capsules', 'Beauté des pieds']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1050, array[0]::smallint[], 203, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'a', 'Semi-permanent mains', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'b', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'c', 'Semi-permanent pieds', 45, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'd', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'e', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'f', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'g', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'h', 'Volume mixte', 150, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g129', 'Ti Très a Daphné', 'Daphné N.', 'Indépendante', array['À domicile']::text[], 10, 'Anse-Bertrand', 'Bourg', 16.46285, -61.51856, array['tresses']::text[], array['Knotless', 'Crochet braids', 'Locks']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1170, array[]::smallint[], 4, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'a', 'Vanilles', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'b', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'c', 'Nattes collées', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'd', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'e', 'Pose de perruque', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g130', 'Gwladys Lash', 'Gwladys B.', 'Indépendante', array['À domicile']::text[], 15, 'Anse-Bertrand', 'Campêche', 16.46686, -61.51689, array['cils', 'ongles']::text[], array['Sourcils au fil', 'Cil à cil', 'Volume mixte']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 480, 1110, array[]::smallint[], 351, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'a', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'b', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'c', 'Volume russe', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'd', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'e', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'f', 'Beauté des pieds complète', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g131', 'Coiffure Vanille', null, 'Salon', array['Au salon']::text[], 0, 'Baillif', 'Saint-Robert', 16.02259, -61.73844, array['coiffure']::text[], array['Boucles', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1110, array[0]::smallint[], 12, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'a', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'b', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'c', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'd', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'e', 'Coloration', 90, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g132', 'Institut Orchidée', null, 'Institut', array['À l''institut']::text[], 0, 'Baillif', 'Bourg', 16.02069, -61.75463, array['soins']::text[], array['Soin éclat', 'Cire tiède', 'Épilation']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 480, 1140, array[0, 1]::smallint[], 310, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'a', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'b', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'c', 'Massage dos', 30, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'd', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'e', 'Soin visage éclat', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'f', 'Massage relaxant', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g133', 'Institut Caravelle Regard', null, 'Institut', array['À l''institut', 'À domicile']::text[], 15, 'Grand-Bourg', 'Bourg', 15.88810, -61.31904, array['cils']::text[], array['Rehaussement', 'Volume mixte', 'Volume russe']::text[], 'Cabines individuelles, produits hypoallergéniques.', 570, 1110, array[0]::smallint[], 353, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'a', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'b', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'c', 'Volume russe', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'd', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'e', 'Restructuration sourcils', 30, 20);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g134', 'Priscilla Nails', 'Priscilla D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Grand-Bourg', 'Grande-Savane', 15.89243, -61.30892, array['ongles']::text[], array['Pose gel', 'Baby boomer', 'French']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 570, 1140, array[]::smallint[], 104, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'a', 'Beauté des pieds complète', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'b', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'c', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'd', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'e', 'Manucure express', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g135', 'Ti Paradis Coiffure', null, 'Salon', array['Au salon']::text[], 0, 'Capesterre-de-Marie-Galante', 'Bézard', 15.89257, -61.22131, array['coiffure']::text[], array['Cheveux texturés', 'Défrisage', 'Lissage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 510, 1170, array[0]::smallint[], 234, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'a', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'c', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'd', 'Coloration', 90, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g136', 'Tresses by Gwladys', 'Gwladys C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Saint-Louis', 'Vieux-Fort', 15.95009, -61.32332, array['tresses']::text[], array['Box braids', 'Crochet braids', 'Vanilles']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1050, array[0]::smallint[], 284, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'a', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'b', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'c', 'Tresses enfant', 90, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'd', 'Vanilles', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'e', 'Box braids mi-longues', 240, 120);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g137', 'Élodie Esthétique', 'Élodie D.', 'Indépendante', array['Chez elle']::text[], 0, 'Vieux-Fort', 'Bourg', 15.94010, -61.69571, array['soins']::text[], array['Soin visage', 'Cire tiède', 'Épilation']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 480, 1080, array[0, 1]::smallint[], 194, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'b', 'Épilation demi-jambes', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'c', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'd', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'e', 'Épilation jambes complètes', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'f', 'Épilation maillot', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g138', 'Institut Colibri Bleu Regard', null, 'Institut', array['À l''institut']::text[], 0, 'Terre-de-Haut', 'Bourg', 15.85838, -61.58291, array['cils']::text[], array['Volume russe', 'Brow lift', 'Volume mixte']::text[], 'Cabines individuelles, produits hypoallergéniques.', 540, 1110, array[0, 1]::smallint[], 241, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'a', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'b', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'c', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'd', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'e', 'Sourcils au fil', 30, 13);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g139', 'Les Soins de Wendy', 'Wendy A.', 'Indépendante', array['À domicile']::text[], 10, 'Terre-de-Bas', 'Petites-Anses', 15.84622, -61.63382, array['soins']::text[], array['Gommage', 'Soin éclat', 'Soin visage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 510, 1110, array[0, 1]::smallint[], 188, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'a', 'Massage relaxant', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'b', 'Massage dos', 30, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'c', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'd', 'Gommage corps', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, lat, lng, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g140', 'Onglerie Lanmè', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'La Désirade', 'Beauséjour', 16.29992, -61.08174, array['ongles']::text[], array['Capsules', 'Semi-permanent', 'French']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1080, array[0]::smallint[], 328, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'b', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'd', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'e', 'Beauté des pieds complète', 60, 38);
