-- Données de démonstration (fictives). Fichier généré par scripts/gen-seed.mjs, ne pas modifier à la main.

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g008', 'Goyave Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Les Abymes', 'Petit-Pérou', array['coiffure']::text[], array['Lissage', 'Cheveux texturés', 'Brushing']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1110, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'a', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'b', 'Shampoing + brushing', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'c', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'd', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'e', 'Wash and go', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'f', 'Défrisage + soin', 120, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('kaz', 'Kaz a Zong', 'Maëva L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Les Abymes', 'Raizet', array['ongles']::text[], array['Pose gel', 'Nail art', 'Semi-permanent']::text[], 'Prothésiste ongulaire depuis 6 ans. Reçoit dans son atelier au Raizet ou se déplace dans l''agglomération pointoise.', 540, 1140, array[0]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'b', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'd', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'e', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'f', 'Dépose', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g014', 'Tresses Goyave', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Chauvel', array['tresses']::text[], array['Locks', 'Vanilles', 'Box braids']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 510, 1080, array[0]::smallint[], 273, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'b', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'c', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'd', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g006', 'Coiffure Solèy', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Les Abymes', 'Raizet', array['coiffure', 'tresses']::text[], array['Coloration', 'Balayage', 'Brushing']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 540, 1170, array[0, 1]::smallint[], 29, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'a', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'b', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'c', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'd', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'e', 'Knotless braids', 300, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'f', 'Vanilles', 120, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g013', 'Spa Lanmè', null, 'Institut', array['À l''institut']::text[], 0, 'Les Abymes', 'Grand-Camp', array['soins']::text[], array['Cire tiède', 'Gommage', 'Massage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 540, 1170, array[0, 1]::smallint[], 287, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'a', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'b', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'c', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'd', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'e', 'Épilation aisselles', 30, 10);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g011', 'Chloé Lash', 'Chloé A.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Les Abymes', 'Raizet', array['cils']::text[], array['Volume russe', 'Cil à cil', 'Brow lift']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 510, 1110, array[]::smallint[], 154, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'a', 'Extensions cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'b', 'Volume mixte', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'c', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'd', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'e', 'Restructuration sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'f', 'Sourcils au fil', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g003', 'Joanie Braids', 'Joanie L.', 'Indépendante', array['Chez elle']::text[], 0, 'Les Abymes', 'Petit-Pérou', array['tresses']::text[], array['Enfants', 'Crochet braids', 'Box braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 540, 1140, array[0]::smallint[], 171, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'a', 'Nattes collées', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'b', 'Vanilles', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'c', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'd', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'e', 'Box braids mi-longues', 240, 100);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g015', 'Leslie Coiffure', 'Leslie C.', 'Indépendante', array['Chez elle']::text[], 0, 'Les Abymes', 'Petit-Pérou', array['coiffure', 'tresses']::text[], array['Défrisage', 'Lissage', 'Boucles']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 480, 1170, array[]::smallint[], 339, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'a', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'b', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'c', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'd', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'e', 'Shampoing + brushing', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'f', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'g', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'h', 'Crochet braids', 150, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('bar', 'Barber Lakou', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Grand-Camp', array['barbier']::text[], array['Dégradé', 'Barbe', 'Sans rendez-vous']::text[], 'Trois fauteuils, coupe homme et enfant. Les contours sont offerts dans les 10 jours.', 540, 1140, array[0]::smallint[], 210, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'a', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'b', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'd', 'Coupe enfant', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g022', 'Cils by Johanna', 'Johanna L.', 'Indépendante', array['À domicile']::text[], 8, 'Pointe-à-Pitre', 'Centre-ville', array['cils']::text[], array['Sourcils au fil', 'Brow lift', 'Volume russe']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 480, 1140, array[0, 1]::smallint[], 270, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'b', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'c', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'd', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'e', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'f', 'Volume mixte', 150, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g010', 'Stéphanie Locks', 'Stéphanie R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Les Abymes', 'Raizet', array['tresses']::text[], array['Locks', 'Enfants', 'Nattes collées']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1140, array[0]::smallint[], 83, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'a', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'b', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'c', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'd', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'e', 'Tresses enfant', 90, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'f', 'Fulani braids', 180, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g005', 'L''Atelier Lagon', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Chauvel', array['coiffure', 'tresses']::text[], array['Boucles', 'Défrisage', 'Coloration']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1080, array[0, 1]::smallint[], 308, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'a', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'b', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'c', 'Wash and go', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'd', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'e', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'f', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'g', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'h', 'Tresses enfant', 90, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g009', 'Hair Trois Îlets', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Petit-Pérou', array['coiffure']::text[], array['Balayage', 'Mixte', 'Défrisage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1140, array[0, 1]::smallint[], 15, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'a', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'b', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'c', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'd', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'e', 'Coupe + brushing', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g012', 'Studio Gwada Make-up', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Raizet', array['maquillage']::text[], array['Carnaval', 'Cours', 'Invitée']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 480, 1140, array[0]::smallint[], 302, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'a', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'b', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'c', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'd', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'e', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'f', 'Maquillage carnaval', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('zom', 'Zombi', 'Yolène R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 6, 'Les Abymes', 'Dothémare', array['cils']::text[], array['Cil à cil', 'Volume russe', 'Rehaussement']::text[], 'Un nom qui ne dit rien de son métier : Yolène pose des extensions de cils et travaille les sourcils, chez elle ou chez toi.', 540, 1110, array[0]::smallint[], 280, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'a', 'Extensions cil à cil', 120, 68);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'b', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'c', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'd', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('zom', 'e', 'Sourcils au fil', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g001', 'Ti Très a Joanie', 'Joanie V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Les Abymes', 'Raizet', array['tresses']::text[], array['Crochet braids', 'Knotless', 'Locks']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1050, array[0]::smallint[], 296, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'a', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'c', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'e', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'f', 'Départ de locks', 180, 105);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g002', 'Nail Bar Monbin', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Boisripeaux', array['ongles']::text[], array['Nail art', 'Baby boomer', 'Capsules']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 510, 1080, array[0, 1]::smallint[], 34, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'a', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'b', 'Semi-permanent pieds', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'c', 'Semi-permanent mains', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'd', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'e', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'f', 'Beauté des pieds complète', 60, 37);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g007', 'Ingrid Lash', 'Ingrid K.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Les Abymes', 'Boisripeaux', array['cils']::text[], array['Cil à cil', 'Rehaussement', 'Sourcils au fil']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 510, 1140, array[0, 1]::smallint[], 310, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'a', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'b', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'c', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'd', 'Volume mixte', 150, 85);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g019', 'Le Fauteuil Orchidée', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Bergevin', array['barbier']::text[], array['Contours', 'Enfants', 'Sans rendez-vous']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1140, array[0, 1]::smallint[], 347, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'a', 'Rasage traditionnel', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'b', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'c', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'd', 'Dégradé + contours', 30, 20);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g004', 'Hair Kannèl', null, 'Salon', array['Au salon']::text[], 0, 'Les Abymes', 'Raizet', array['coiffure']::text[], array['Lissage', 'Boucles', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1170, array[0, 1]::smallint[], 8, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'a', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'c', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'd', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'e', 'Coupe enfant', 30, 14);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g025', 'Salon Gwada', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Massabielle', array['coiffure']::text[], array['Mixte', 'Coloration', 'Cheveux texturés']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 510, 1170, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'a', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'b', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'c', 'Wash and go', 60, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'd', 'Défrisage + soin', 120, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g021', 'Spa Colibri Bleu', null, 'Institut', array['À l''institut', 'À domicile']::text[], 15, 'Pointe-à-Pitre', 'Centre-ville', array['soins']::text[], array['Gommage', 'Soin visage', 'Soin éclat']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1140, array[0]::smallint[], 247, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'a', 'Soin visage hydratant', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'b', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'c', 'Gommage corps', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'd', 'Épilation sourcils', 30, 9);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('hib', 'Salon Hibiscus', null, 'Salon', array['Au salon', 'À domicile']::text[], 10, 'Pointe-à-Pitre', 'Centre-ville', array['coiffure']::text[], array['Brushing', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte du centre-ville. Spécialiste du soin et du coiffage des boucles, coloration végétale sur demande.', 540, 1080, array[0, 1]::smallint[], 350, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'a', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'c', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'e', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g020', 'Escale Jasmin', null, 'Institut', array['À l''institut', 'À domicile']::text[], 0, 'Pointe-à-Pitre', 'Lauricisque', array['soins', 'maquillage']::text[], array['Gommage', 'Épilation', 'Soin éclat']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 480, 1080, array[0, 1]::smallint[], 169, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'a', 'Soin visage éclat', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'b', 'Massage dos', 30, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'c', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'd', 'Épilation sourcils', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'e', 'Maquillage shooting', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'f', 'Maquillage mariée + essai', 120, 140);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g017', 'Onglerie Cannelle', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Bergevin', array['ongles']::text[], array['Pose gel', 'Beauté des pieds', 'Capsules']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 480, 1140, array[0]::smallint[], 247, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'a', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'b', 'Semi-permanent mains', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'c', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'd', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'e', 'Nail art 10 doigts', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g016', 'Fabiola Esthétique', 'Fabiola B.', 'Indépendante', array['Chez elle']::text[], 0, 'Pointe-à-Pitre', 'Massabielle', array['soins']::text[], array['Gommage', 'Soin éclat', 'Cire tiède']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 510, 1110, array[0]::smallint[], 359, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'a', 'Épilation demi-jambes', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'b', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'c', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'd', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'e', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'f', 'Massage relaxant', 60, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g023', 'Esther Brows', 'Esther T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Pointe-à-Pitre', 'Bergevin', array['cils']::text[], array['Volume russe', 'Cil à cil', 'Sourcils au fil']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 540, 1080, array[]::smallint[], 4, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'a', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'b', 'Teinture sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'c', 'Restructuration sourcils', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'd', 'Brow lift', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('nai', 'Nail Bar Bas-du-Fort', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bas-du-Fort', array['ongles']::text[], array['Pose gel', 'Beauté des pieds']::text[], 'Bar à ongles près de la marina, quatre postes. Idéal entre midi et deux.', 570, 1110, array[0]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'a', 'Pose gel', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'b', 'Remplissage', 60, 42);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'c', 'Semi-permanent', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'd', 'Beauté des pieds + vernis', 60, 38);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g026', 'Ti Très a Marine', 'Marine L.', 'Indépendante', array['À domicile']::text[], 15, 'Pointe-à-Pitre', 'Lauricisque', array['tresses']::text[], array['Crochet braids', 'Vanilles', 'Nattes collées']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1140, array[]::smallint[], 79, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'a', 'Tresses enfant', 90, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'b', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'c', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'd', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'e', 'Pose de perruque', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g018', 'Nadège Hair', 'Nadège K.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Pointe-à-Pitre', 'Bergevin', array['coiffure', 'tresses']::text[], array['Lissage', 'Cheveux texturés', 'Défrisage']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 480, 1080, array[0]::smallint[], 216, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'a', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'b', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'c', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'd', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'e', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'f', 'Knotless braids', 300, 135);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'g', 'Crochet braids', 150, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tre', 'Tresses Lokal', 'Sandrine D.', 'Indépendante', array['À domicile']::text[], 8, 'Le Gosier', 'Mare-Gaillard', array['tresses', 'coiffure']::text[], array['Box braids', 'Vanilles', 'Locks']::text[], 'Tresseuse à domicile sur toute la Riviera du Levant. Mèches fournies sur demande, comptées en supplément.', 480, 1080, array[0]::smallint[], 25, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'a', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'c', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'd', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'e', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g024', 'Barber Vanille', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-à-Pitre', 'Carénage', array['barbier']::text[], array['Contours', 'Dégradé', 'Rasage']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 510, 1170, array[0]::smallint[], 248, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'a', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'b', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'c', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'd', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'e', 'Coupe + barbe', 60, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g041', 'Samantha Brows', 'Samantha B.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Le Gosier', 'Montauban', array['cils', 'ongles']::text[], array['Rehaussement', 'Volume mixte', 'Sourcils au fil']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 540, 1080, array[0]::smallint[], 153, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'a', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'b', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'c', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'd', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'e', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'f', 'Semi-permanent mains', 45, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g040', 'Tessa Make-up Le Gosier', 'Tessa G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Le Gosier', 'Mare-Gaillard', array['maquillage']::text[], array['Mariée', 'Cours', 'Soirée']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 510, 1140, array[]::smallint[], 231, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'a', 'Maquillage jour', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'b', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'c', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'd', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'e', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'f', 'Maquillage mariée + essai', 120, 160);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g043', 'Salon Lagon', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bas-du-Fort', array['coiffure']::text[], array['Mixte', 'Boucles', 'Lissage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1170, array[0, 1]::smallint[], 219, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'a', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'b', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'c', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'd', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'e', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'f', 'Coupe + brushing', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g036', 'Nail Bar Lagon', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'Convenance', array['ongles']::text[], array['Beauté des pieds', 'Semi-permanent', 'French']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 540, 1140, array[0, 1]::smallint[], 182, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'a', 'Semi-permanent mains', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'b', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'c', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'd', 'Nail art 10 doigts', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'e', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'f', 'Semi-permanent pieds', 45, 32);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('reg', 'Regard Karukera', null, 'Institut', array['À l''institut']::text[], 0, 'Baie-Mahault', 'Jarry', array['cils']::text[], array['Extensions', 'Rehaussement', 'Sourcils au fil']::text[], 'Institut dédié au regard, en zone de Jarry. Parking gratuit devant la porte.', 540, 1110, array[0]::smallint[], 265, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'b', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'c', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'd', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'e', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'f', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g031', 'Barber Bougainvillée', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'La Jaille', array['barbier']::text[], array['Contours', 'Enfants', 'Sans rendez-vous']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1080, array[0, 1]::smallint[], 231, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'a', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'b', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'd', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'e', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'f', 'Coupe + soin', 60, 30);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g035', 'Dimitri le Barbier', 'Dimitri L.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 8, 'Baie-Mahault', 'Jarry', array['barbier']::text[], array['Enfants', 'Dégradé', 'Barbe']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 480, 1140, array[0]::smallint[], 61, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'b', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'c', 'Rasage traditionnel', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'd', 'Coupe + soin', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'e', 'Coupe + barbe', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'f', 'Coupe enfant', 30, 13);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g045', 'Glam by Nadège', 'Nadège C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Le Gosier', 'Mare-Gaillard', array['maquillage']::text[], array['Invitée', 'Mariée', 'Carnaval']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 480, 1080, array[0, 1]::smallint[], 134, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'a', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'b', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'c', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'd', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'e', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'f', 'Maquillage jour', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('col', 'Studio Colibri', null, 'Salon', array['Au salon', 'À domicile']::text[], 12, 'Baie-Mahault', 'Destrellan', array['coiffure', 'maquillage']::text[], array['Chignon', 'Événement', 'Maquillage']::text[], 'Coiffure et maquillage au même endroit pour les baptêmes, mariages et soirées.', 540, 1110, array[0, 1]::smallint[], 160, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'a', 'Coupe + coiffage', 60, 48);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'c', 'Maquillage + coiffure', 120, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'd', 'Brushing', 30, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g047', 'Fabiola Nails', 'Fabiola D.', 'Indépendante', array['Chez elle']::text[], 0, 'Le Gosier', 'Pliane', array['ongles', 'cils']::text[], array['Baby boomer', 'Beauté des pieds', 'Nail art']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 480, 1110, array[0, 1]::smallint[], 38, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'a', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'b', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'c', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'd', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'e', 'Brow lift', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'f', 'Teinture sourcils', 30, 14);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g034', 'Tessa Make-up', 'Tessa M.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Baie-Mahault', 'Destrellan', array['maquillage']::text[], array['Cours', 'Mariée', 'Invitée']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 570, 1110, array[0, 1]::smallint[], 331, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'a', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'b', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'c', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'd', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'e', 'Maquillage invitée', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g032', 'Ti Très a Shaïna', 'Shaïna V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Baie-Mahault', 'Jarry', array['tresses']::text[], array['Box braids', 'Crochet braids', 'Nattes collées']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1080, array[0]::smallint[], 233, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'b', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'c', 'Knotless braids', 300, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'd', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'e', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'f', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g044', 'L''Atelier Zétwal', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Le Gosier', 'Pliane', array['coiffure']::text[], array['Balayage', 'Brushing', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 570, 1050, array[0]::smallint[], 305, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'a', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'b', 'Shampoing + brushing', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'c', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'd', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'e', 'Coloration', 90, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g030', 'Hair Kannèl Baie-Mahault', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Baie-Mahault', 'La Jaille', array['coiffure']::text[], array['Défrisage', 'Lissage', 'Mixte']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 570, 1170, array[0]::smallint[], 316, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'a', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'b', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'c', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'd', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'e', 'Coloration', 90, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g028', 'Le Fauteuil Ylang', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'Bourg', array['barbier']::text[], array['Barbe', 'Sans rendez-vous', 'Enfants']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 570, 1080, array[0, 1]::smallint[], 145, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'a', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'b', 'Coupe + barbe', 60, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'c', 'Coupe homme', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'd', 'Rasage traditionnel', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g042', 'Glam by Léa', 'Léa C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Le Gosier', 'Bas-du-Fort', array['maquillage']::text[], array['Mariée', 'Invitée', 'Soirée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 570, 1170, array[0, 1]::smallint[], 258, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'a', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'b', 'Maquillage mariée + essai', 120, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'c', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'e', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'f', 'Cours d''auto-maquillage', 90, 75);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g027', 'Solène Hair', 'Solène K.', 'Indépendante', array['Chez elle']::text[], 0, 'Baie-Mahault', 'Jarry', array['coiffure', 'tresses']::text[], array['Brushing', 'Cheveux texturés', 'Balayage']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 570, 1050, array[]::smallint[], 173, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'a', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'b', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'c', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'd', 'Soin profond + coiffage boucles', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'e', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'f', 'Nattes collées', 90, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g033', 'Le Regard de Kelly', 'Kelly T.', 'Indépendante', array['Chez elle']::text[], 0, 'Baie-Mahault', 'Jarry', array['cils']::text[], array['Volume mixte', 'Volume russe', 'Rehaussement']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 480, 1170, array[0]::smallint[], 223, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'a', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'b', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'c', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'd', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'e', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g038', 'Salon Ti Kaz', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Le Gosier', 'Pliane', array['coiffure']::text[], array['Défrisage', 'Brushing', 'Lissage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1140, array[0, 1]::smallint[], 81, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'a', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'b', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'c', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'd', 'Soin profond + coiffage boucles', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g039', 'L''Atelier des Ongles Maracudja', null, 'Salon', array['Au salon']::text[], 0, 'Le Gosier', 'Bourg', array['ongles']::text[], array['Baby boomer', 'Semi-permanent', 'Capsules']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1080, array[0, 1]::smallint[], 320, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'a', 'Semi-permanent pieds', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'b', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'c', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'd', 'Beauté des pieds complète', 60, 36);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g046', 'Tessa Nails', 'Tessa F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Le Gosier', 'Bourg', array['ongles']::text[], array['Beauté des pieds', 'Semi-permanent', 'Baby boomer']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1080, array[0, 1]::smallint[], 257, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'a', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'b', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'd', 'Semi-permanent pieds', 45, 32);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g029', 'Maracudja Coiffure', null, 'Salon', array['Au salon']::text[], 0, 'Baie-Mahault', 'Bourg', array['coiffure']::text[], array['Boucles', 'Mixte', 'Coloration']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1050, array[0]::smallint[], 254, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'a', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'c', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'd', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'e', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'f', 'Défrisage + soin', 120, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g037', 'Tresses by Malika', 'Malika P.', 'Indépendante', array['Chez elle']::text[], 0, 'Baie-Mahault', 'Bourg', array['tresses']::text[], array['Nattes collées', 'Enfants', 'Box braids']::text[], 'Spécialiste des locks, du départ à l''entretien.', 510, 1170, array[0]::smallint[], 268, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'a', 'Knotless braids', 300, 130);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'b', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'c', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'd', 'Box braids mi-longues', 240, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'e', 'Pose de perruque', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('fle', 'Institut Fleur de Canne', null, 'Institut', array['À l''institut']::text[], 0, 'Petit-Bourg', 'Bourg', array['soins']::text[], array['Soin visage', 'Épilation', 'Massage']::text[], 'Soins du visage et du corps, cire tiède. Cabine climatisée.', 540, 1080, array[0]::smallint[], 120, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'c', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'd', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'e', 'Massage dos', 30, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g089', 'Les Ongles de Léa', 'Léa D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Morne-à-l''Eau', 'Richeval', array['ongles']::text[], array['Baby boomer', 'Nail art', 'Pose gel']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 540, 1050, array[0]::smallint[], 171, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'a', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'b', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'c', 'Pose gel + couleur', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'd', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'e', 'Dépose', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g088', 'Coiffure by Audrey', 'Audrey N.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Morne-à-l''Eau', 'Bourg', array['coiffure']::text[], array['Défrisage', 'Lissage', 'Mixte']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 510, 1050, array[0]::smallint[], 142, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'a', 'Wash and go', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'c', 'Lissage brésilien', 180, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'd', 'Coloration', 90, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g050', 'Sable Blanc Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 8, 'Petit-Bourg', 'Colin', array['coiffure']::text[], array['Coloration', 'Brushing', 'Balayage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1170, array[0]::smallint[], 157, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'a', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'b', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'c', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'd', 'Shampoing + brushing', 60, 31);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g049', 'Brice le Barbier', 'Brice J.', 'Indépendant', array['Chez lui']::text[], 0, 'Petit-Bourg', 'Vernou', array['barbier']::text[], array['Rasage', 'Enfants', 'Sans rendez-vous']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 480, 1080, array[0]::smallint[], 322, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'a', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'b', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'c', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'd', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'e', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'f', 'Rasage traditionnel', 30, 21);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g090', 'Les Ongles de Yoline', 'Yoline V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Morne-à-l''Eau', 'Perrin', array['ongles', 'cils']::text[], array['Nail art', 'French', 'Baby boomer']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 540, 1110, array[0]::smallint[], 243, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'a', 'Nail art 10 doigts', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'b', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'c', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'd', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'e', 'Volume russe', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'f', 'Rehaussement + teinture', 60, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g087', 'Institut Sable Blanc', null, 'Institut', array['À l''institut']::text[], 0, 'Morne-à-l''Eau', 'Vieux-Bourg', array['soins', 'maquillage']::text[], array['Massage', 'Gommage', 'Épilation']::text[], 'Un moment pour soi, à deux pas du bourg.', 570, 1080, array[0, 1]::smallint[], 322, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'a', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'b', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'c', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'd', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'e', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'f', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'g', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g095', 'Hair Anoli', null, 'Salon', array['Au salon']::text[], 0, 'Lamentin', 'Bourg', array['coiffure', 'tresses']::text[], array['Brushing', 'Lissage', 'Cheveux texturés']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1080, array[0]::smallint[], 222, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'a', 'Lissage brésilien', 180, 175);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'c', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'd', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'e', 'Mèches et balayage', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'f', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'g', 'Départ de locks', 180, 100);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g052', 'Marjorie Coiffure', 'Marjorie L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Petit-Bourg', 'Bourg', array['coiffure']::text[], array['Cheveux texturés', 'Coloration', 'Balayage']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 510, 1080, array[0]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'a', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'c', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'd', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'e', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'f', 'Coupe enfant', 30, 14);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g048', 'L''Atelier Corail', null, 'Salon', array['Au salon']::text[], 0, 'Petit-Bourg', 'Vernou', array['coiffure']::text[], array['Mixte', 'Boucles', 'Brushing']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 510, 1050, array[0, 1]::smallint[], 186, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'a', 'Mèches et balayage', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'b', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'c', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'd', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'e', 'Shampoing + brushing', 60, 27);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g053', 'Érika Coiffure', 'Érika G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Petit-Bourg', 'Arnouville', array['coiffure', 'tresses']::text[], array['Brushing', 'Défrisage', 'Mixte']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 570, 1050, array[]::smallint[], 25, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'a', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'c', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'd', 'Shampoing + brushing', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'e', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'f', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'g', 'Box braids mi-longues', 240, 125);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tib', 'Onglerie Ti Bijou', 'Naomie C.', 'Indépendante', array['À domicile']::text[], 8, 'Lamentin', 'Bourg', array['ongles']::text[], array['Capsules', 'Baby boomer']::text[], 'Se déplace avec tout son matériel sur le nord Basse-Terre : Lamentin, Sainte-Rose, Baie-Mahault.', 540, 1080, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'b', 'Remplissage', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'c', 'Semi-permanent', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'd', 'Baby boomer', 120, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g051', 'Ti Paradis Beauty Studio', null, 'Salon', array['Au salon']::text[], 0, 'Petit-Bourg', 'Colin', array['maquillage']::text[], array['Cours', 'Mariée', 'Carnaval']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 570, 1050, array[0]::smallint[], 24, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'a', 'Maquillage mariée + essai', 120, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'b', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'c', 'Maquillage shooting', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'd', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'e', 'Maquillage soirée', 60, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g094', 'Spa Goyave', null, 'Institut', array['À l''institut']::text[], 0, 'Lamentin', 'Ravine-Chaude', array['soins']::text[], array['Massage', 'Épilation', 'Soin éclat']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1050, array[0]::smallint[], 245, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'a', 'Épilation demi-jambes', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'b', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'c', 'Épilation sourcils', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'd', 'Épilation maillot', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'e', 'Massage relaxant', 60, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g091', 'Maracudja Beauté', null, 'Institut', array['À l''institut']::text[], 0, 'Morne-à-l''Eau', 'Richeval', array['soins']::text[], array['Soin éclat', 'Gommage', 'Cire tiède']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 570, 1080, array[0, 1]::smallint[], 21, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'a', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'b', 'Massage relaxant', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'c', 'Massage dos', 30, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'd', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'e', 'Épilation jambes complètes', 60, 34);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g092', 'Thaïs Nails', 'Thaïs V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Lamentin', 'Bourg', array['ongles', 'cils']::text[], array['Beauté des pieds', 'French', 'Pose gel']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 480, 1110, array[0, 1]::smallint[], 206, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'a', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'b', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'c', 'Manucure express', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'd', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'e', 'Semi-permanent pieds', 45, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'f', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'g', 'Volume mixte', 150, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g054', 'Ti Kaz Lash', null, 'Institut', array['À l''institut']::text[], 0, 'Petit-Bourg', 'Vernou', array['cils']::text[], array['Rehaussement', 'Cil à cil', 'Brow lift']::text[], 'Institut dédié au regard : extensions, rehaussement et sourcils.', 570, 1110, array[0]::smallint[], 33, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'a', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'b', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'c', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'd', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'e', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'f', 'Volume mixte', 150, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g096', 'Barber by Grégory Lamentin', 'Grégory P.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 5, 'Lamentin', 'Ravine-Chaude', array['barbier']::text[], array['Dégradé', 'Enfants', 'Sans rendez-vous']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 570, 1140, array[0]::smallint[], 98, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'a', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'b', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'c', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'd', 'Coupe + soin', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'e', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'f', 'Coupe + barbe', 60, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g107', 'L''Atelier Goyave', null, 'Salon', array['Au salon']::text[], 0, 'Goyave', 'Sainte-Claire', array['coiffure', 'tresses']::text[], array['Balayage', 'Coloration', 'Boucles']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 480, 1170, array[0]::smallint[], 55, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'a', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'b', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'c', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'd', 'Shampoing + brushing', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'e', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'f', 'Tresses enfant', 90, 34);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g059', 'Ti Très a Solène', 'Solène G.', 'Indépendante', array['Chez elle']::text[], 0, 'Sainte-Anne', 'Bourg', array['tresses']::text[], array['Vanilles', 'Knotless', 'Box braids']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 510, 1110, array[0, 1]::smallint[], 281, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'a', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'b', 'Crochet braids', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'c', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'd', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g106', 'Balisier Nails', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Goyave', 'Bourg', array['ongles']::text[], array['French', 'Pose gel', 'Beauté des pieds']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 570, 1050, array[0]::smallint[], 159, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'a', 'Semi-permanent mains', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'b', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'c', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'd', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'e', 'Semi-permanent pieds', 45, 31);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('mad', 'Atelier Madras Beauté', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Sainte-Anne', 'Bourg', array['soins', 'maquillage']::text[], array['Soin éclat', 'Maquillage', 'Épilation']::text[], 'À deux rues de la plage du bourg. Soins, épilation et maquillage sur rendez-vous.', 540, 1080, array[0]::smallint[], 5, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'b', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'c', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'e', 'Massage relaxant', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g057', 'Tresses by Chloé', 'Chloé F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Sainte-Anne', 'Douville', array['tresses']::text[], array['Enfants', 'Box braids', 'Knotless']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1050, array[]::smallint[], 295, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'a', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'b', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'c', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'd', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'e', 'Knotless braids', 300, 130);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'f', 'Retwist locks', 90, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g058', 'Ti Zong a Sandy', 'Sandy D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Sainte-Anne', 'Durivage', array['ongles', 'cils']::text[], array['Semi-permanent', 'Beauté des pieds', 'French']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 570, 1170, array[0]::smallint[], 147, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'a', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'b', 'Beauté des pieds complète', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'c', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'd', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'e', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'f', 'Sourcils au fil', 30, 12);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g093', 'Naïka Hair', 'Naïka N.', 'Indépendante', array['À domicile']::text[], 5, 'Lamentin', 'Caillou', array['coiffure']::text[], array['Cheveux texturés', 'Défrisage', 'Coloration']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 540, 1140, array[]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'a', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'b', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'd', 'Soin profond + coiffage boucles', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'e', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'f', 'Coloration', 90, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g105', 'Coiffure by Léa', 'Léa A.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Goyave', 'Sainte-Claire', array['coiffure']::text[], array['Défrisage', 'Balayage', 'Lissage']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 570, 1050, array[0, 1]::smallint[], 206, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'a', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'c', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'd', 'Défrisage + soin', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'e', 'Wash and go', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g055', 'Ti Zong a Lindsay', 'Lindsay M.', 'Indépendante', array['Chez elle']::text[], 0, 'Sainte-Anne', 'Bourg', array['ongles']::text[], array['Capsules', 'Pose gel', 'Baby boomer']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1080, array[0]::smallint[], 67, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'a', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'b', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'c', 'Beauté des pieds complète', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'd', 'Pose gel + couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g056', 'Orchidée Beauté', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Anne', 'Bourg', array['soins']::text[], array['Épilation', 'Soin visage', 'Massage']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 540, 1140, array[0, 1]::smallint[], 344, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'a', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'b', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'c', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'd', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g060', 'Institut Goyave', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Anne', 'Douville', array['soins', 'maquillage']::text[], array['Soin visage', 'Gommage', 'Soin éclat']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 510, 1140, array[0]::smallint[], 91, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'b', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'c', 'Massage relaxant', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'd', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'e', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'f', 'Maquillage shooting', 60, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('oce', 'Cils by Océane', 'Océane V.', 'Indépendante', array['Chez elle']::text[], 0, 'Le Moule', 'Sergent', array['cils']::text[], array['Cil à cil', 'Volume mixte']::text[], 'Technicienne cils certifiée, reçoit dans une pièce dédiée de sa maison.', 540, 1080, array[0, 1]::smallint[], 245, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'a', 'Cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'b', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'c', 'Remplissage', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'd', 'Rehaussement', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g061', 'Escale Jasmin Sainte-Anne', null, 'Institut', array['À l''institut']::text[], 0, 'Sainte-Anne', 'Douville', array['soins', 'maquillage']::text[], array['Gommage', 'Soin visage', 'Épilation']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1080, array[0]::smallint[], 289, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'a', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'b', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'c', 'Épilation jambes complètes', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'd', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'e', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'f', 'Maquillage invitée', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g108', 'Barber Tamarin', null, 'Salon', array['Au salon']::text[], 0, 'Petit-Canal', 'Bourg', array['barbier']::text[], array['Dégradé', 'Enfants', 'Sans rendez-vous']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1140, array[0]::smallint[], 167, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'a', 'Taille de barbe', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'b', 'Coupe + barbe', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'c', 'Rasage traditionnel', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'd', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'e', 'Dégradé + contours', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'f', 'Coupe + soin', 60, 34);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g110', 'Bougainvillée Beauté', null, 'Institut', array['À l''institut', 'À domicile']::text[], 5, 'Petit-Canal', 'Les Mangles', array['soins']::text[], array['Massage', 'Gommage', 'Soin visage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1050, array[0]::smallint[], 274, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'a', 'Massage dos', 30, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'b', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'd', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'e', 'Épilation demi-jambes', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g067', 'Sandy Beauty', 'Sandy T.', 'Indépendante', array['À domicile']::text[], 5, 'Le Moule', 'Damencourt', array['maquillage']::text[], array['Carnaval', 'Shooting', 'Invitée']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 540, 1050, array[0]::smallint[], 68, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'a', 'Maquillage soirée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'b', 'Maquillage jour', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'c', 'Cours d''auto-maquillage', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'd', 'Maquillage shooting', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g109', 'Coiffure by Audrey Petit-Canal', 'Audrey A.', 'Indépendante', array['À domicile']::text[], 5, 'Petit-Canal', 'Bourg', array['coiffure']::text[], array['Brushing', 'Cheveux texturés', 'Coloration']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 510, 1170, array[0, 1]::smallint[], 314, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'a', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'c', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'd', 'Mèches et balayage', 150, 110);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g068', 'Ti Kaz Beauté', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Le Moule', 'Sergent', array['soins']::text[], array['Massage', 'Épilation', 'Cire tiède']::text[], 'Un moment pour soi, à deux pas du bourg.', 510, 1110, array[0]::smallint[], 317, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'b', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'c', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'd', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'e', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'f', 'Gommage corps', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g062', 'Ti Zong a Lindsay Le Moule', 'Lindsay B.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Le Moule', 'Bourg', array['ongles']::text[], array['Nail art', 'Baby boomer', 'Pose gel']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 510, 1170, array[]::smallint[], 89, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'a', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'b', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'c', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'd', 'Beauté des pieds complète', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'e', 'Semi-permanent mains', 45, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'f', 'Remplissage gel', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g113', 'L''Atelier Kréyol', null, 'Salon', array['Au salon']::text[], 0, 'Port-Louis', 'Pelletan', array['coiffure']::text[], array['Défrisage', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1050, array[0]::smallint[], 220, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'a', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'b', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'c', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'd', 'Wash and go', 60, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'e', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'f', 'Coiffure événement', 60, 60);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g111', 'Clarisse Make-up', 'Clarisse C.', 'Indépendante', array['Chez elle']::text[], 0, 'Port-Louis', 'Pelletan', array['maquillage']::text[], array['Shooting', 'Carnaval', 'Mariée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 480, 1110, array[0]::smallint[], 161, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'a', 'Maquillage mariée + essai', 120, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'b', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'c', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'd', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g073', 'Wesley le Barbier', 'Wesley C.', 'Indépendant', array['Chez lui']::text[], 0, 'Sainte-Rose', 'Viard', array['barbier']::text[], array['Sans rendez-vous', 'Barbe', 'Enfants']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 510, 1140, array[]::smallint[], 261, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'a', 'Coupe + barbe', 60, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'b', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'c', 'Dégradé + contours', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'd', 'Coupe + soin', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'e', 'Rasage traditionnel', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'f', 'Coupe enfant', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g072', 'Barber Vanille Sainte-Rose', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Rose', 'Bourg', array['barbier']::text[], array['Enfants', 'Sans rendez-vous', 'Barbe']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 570, 1080, array[0]::smallint[], 4, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'a', 'Coupe homme', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'b', 'Coupe + barbe', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'c', 'Rasage traditionnel', 30, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'd', 'Coupe + soin', 60, 34);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g063', 'Flamboyant Beauté', null, 'Institut', array['À l''institut']::text[], 0, 'Le Moule', 'Bourg', array['soins']::text[], array['Cire tiède', 'Épilation', 'Gommage']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 480, 1170, array[0, 1]::smallint[], 304, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'a', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'c', 'Épilation demi-jambes', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'd', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'e', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'f', 'Épilation aisselles', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g066', 'Karine Beauty', 'Karine M.', 'Indépendante', array['À domicile']::text[], 0, 'Le Moule', 'Bourg', array['maquillage']::text[], array['Invitée', 'Soirée', 'Mariée']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 570, 1140, array[0]::smallint[], 349, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'a', 'Maquillage mariée + essai', 120, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'b', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'c', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'd', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g074', 'Kréyol Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 15, 'Sainte-Rose', 'Bourg', array['coiffure']::text[], array['Mixte', 'Brushing', 'Cheveux texturés']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 480, 1080, array[0]::smallint[], 299, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'a', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'c', 'Mèches et balayage', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'd', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'e', 'Lissage brésilien', 180, 175);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g065', 'Maïlys Braids', 'Maïlys J.', 'Indépendante', array['Chez elle']::text[], 0, 'Le Moule', 'Bourg', array['tresses']::text[], array['Knotless', 'Nattes collées', 'Crochet braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1080, array[0]::smallint[], 142, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'a', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'b', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'c', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'd', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'e', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'f', 'Knotless braids', 300, 140);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g112', 'Hair Tamarin', null, 'Salon', array['Au salon']::text[], 0, 'Port-Louis', 'Beauport', array['coiffure', 'tresses']::text[], array['Brushing', 'Balayage', 'Lissage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1170, array[0]::smallint[], 223, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'a', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'b', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'd', 'Shampoing + brushing', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'e', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'f', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'g', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'h', 'Tresses enfant', 90, 33);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('ali', 'Coiffure Alizé', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Rose', 'Bourg', array['coiffure', 'barbier']::text[], array['Mixte', 'Défrisage', 'Couleur']::text[], 'Le salon de quartier du bourg, hommes, femmes et enfants.', 510, 1080, array[0]::smallint[], 190, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'a', 'Coupe femme', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'b', 'Brushing', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'c', 'Coupe homme', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'd', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'e', 'Couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g069', 'Malika Bien-être', 'Malika A.', 'Indépendante', array['À domicile']::text[], 8, 'Sainte-Rose', 'La Boucan', array['soins']::text[], array['Cire tiède', 'Épilation', 'Massage']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 570, 1140, array[]::smallint[], 244, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'a', 'Massage dos', 30, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'b', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'c', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'd', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'e', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'f', 'Épilation aisselles', 30, 10);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g064', 'Kannèl Beauté', null, 'Institut', array['À l''institut']::text[], 0, 'Le Moule', 'Sergent', array['soins']::text[], array['Soin visage', 'Soin éclat', 'Gommage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 540, 1050, array[0]::smallint[], 238, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'a', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'b', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'd', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'e', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g070', 'Make-up by Thaïs', 'Thaïs S.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'Sainte-Rose', 'La Boucan', array['maquillage']::text[], array['Cours', 'Invitée', 'Shooting']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 510, 1050, array[0]::smallint[], 341, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'a', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'b', 'Maquillage mariée + essai', 120, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'c', 'Cours d''auto-maquillage', 90, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'd', 'Maquillage soirée', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g071', 'Barbershop Alizés', null, 'Salon', array['Au salon']::text[], 0, 'Sainte-Rose', 'Viard', array['barbier']::text[], array['Sans rendez-vous', 'Enfants', 'Barbe']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1080, array[0]::smallint[], 98, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'a', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'b', 'Taille de barbe', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'c', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'd', 'Dégradé + contours', 30, 23);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g079', 'Barber by Grégory', 'Grégory M.', 'Indépendant', array['À domicile']::text[], 5, 'Capesterre-Belle-Eau', 'Sainte-Marie', array['barbier']::text[], array['Sans rendez-vous', 'Dégradé', 'Enfants']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 570, 1170, array[]::smallint[], 183, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'a', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'b', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'c', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'd', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'e', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'f', 'Coupe + barbe', 60, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('glo', 'Glow Gwada', 'Kéliane P.', 'Indépendante', array['À domicile']::text[], 15, 'Saint-François', 'Bourg', array['maquillage']::text[], array['Mariée', 'Soirée', 'Cours']::text[], 'Maquilleuse mariages et événements, se déplace dans toute la Grande-Terre.', 480, 1200, array[]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'a', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'b', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'c', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'd', 'Cours d''auto-maquillage', 90, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g077', 'Johanna Onglerie', 'Johanna B.', 'Indépendante', array['Chez elle']::text[], 0, 'Capesterre-Belle-Eau', 'Saint-Sauveur', array['ongles']::text[], array['Capsules', 'Baby boomer', 'Beauté des pieds']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 570, 1050, array[0]::smallint[], 343, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'a', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'b', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'c', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'd', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'e', 'Pose gel + couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g078', 'Le Fauteuil Trois Îlets', null, 'Salon', array['Au salon']::text[], 0, 'Capesterre-Belle-Eau', 'Bananier', array['barbier']::text[], array['Barbe', 'Sans rendez-vous', 'Contours']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1170, array[0]::smallint[], 309, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'a', 'Dégradé + contours', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'b', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'c', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'd', 'Coupe + soin', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'e', 'Coupe homme', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g100', 'Locks Maracudja', null, 'Salon', array['Au salon']::text[], 0, 'Saint-François', 'Sainte-Marthe', array['tresses']::text[], array['Crochet braids', 'Locks', 'Nattes collées']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1170, array[0, 1]::smallint[], 285, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'a', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'b', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'c', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'd', 'Knotless braids', 300, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'e', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g080', 'Audrey Lash', 'Audrey D.', 'Indépendante', array['Chez elle']::text[], 0, 'Capesterre-Belle-Eau', 'Sainte-Marie', array['cils']::text[], array['Volume russe', 'Sourcils au fil', 'Rehaussement']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 570, 1050, array[0]::smallint[], 215, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'a', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'b', 'Volume russe', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'c', 'Brow lift', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'd', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'e', 'Restructuration sourcils', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g101', 'Institut Jasmin Regard', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Saint-François', 'Bragelogne', array['cils']::text[], array['Volume russe', 'Brow lift', 'Sourcils au fil']::text[], 'Cabines individuelles, produits hypoallergéniques.', 570, 1080, array[0, 1]::smallint[], 219, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'b', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'c', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'd', 'Extensions cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'e', 'Brow lift', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g098', 'Lorna Onglerie', 'Lorna N.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Saint-François', 'Bourg', array['ongles']::text[], array['Capsules', 'Semi-permanent', 'Beauté des pieds']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1140, array[]::smallint[], 142, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'a', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'b', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'c', 'Beauté des pieds complète', 60, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'd', 'Pose gel + couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g097', 'Marine Brows', 'Marine V.', 'Indépendante', array['À domicile']::text[], 10, 'Saint-François', 'Sainte-Marthe', array['cils']::text[], array['Cil à cil', 'Rehaussement', 'Sourcils au fil']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 480, 1080, array[]::smallint[], 281, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'a', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'b', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'c', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'd', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'e', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'f', 'Volume russe', 150, 95);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g075', 'Make-up by Lorna', 'Lorna J.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Capesterre-Belle-Eau', 'Bananier', array['maquillage']::text[], array['Carnaval', 'Mariée', 'Invitée']::text[], 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 570, 1140, array[]::smallint[], 316, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'a', 'Maquillage mariée + essai', 120, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'b', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'c', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'd', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'e', 'Maquillage carnaval', 60, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g076', 'Studio Cils Mango', null, 'Institut', array['À l''institut']::text[], 0, 'Capesterre-Belle-Eau', 'Bourg', array['cils', 'ongles']::text[], array['Volume mixte', 'Sourcils au fil', 'Cil à cil']::text[], 'Cabines individuelles, produits hypoallergéniques.', 480, 1170, array[0, 1]::smallint[], 182, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'a', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'b', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'c', 'Restructuration sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'd', 'Volume mixte', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'e', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'f', 'Semi-permanent mains', 45, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'g', 'Semi-permanent pieds', 45, 28);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g129', 'Le Regard de Maïlys', 'Maïlys T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Anse-Bertrand', 'Bourg', array['cils']::text[], array['Volume russe', 'Cil à cil', 'Rehaussement']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 510, 1170, array[]::smallint[], 203, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'a', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'b', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'c', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'd', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'e', 'Restructuration sourcils', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g130', 'Les Nattes de Axelle', 'Axelle K.', 'Indépendante', array['Chez elle']::text[], 0, 'Anse-Bertrand', 'Bourg', array['tresses']::text[], array['Enfants', 'Crochet braids', 'Nattes collées']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 570, 1170, array[]::smallint[], 155, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'a', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'c', 'Départ de locks', 180, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'd', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'e', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'f', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g099', 'L''Atelier Caravelle', null, 'Salon', array['Au salon']::text[], 0, 'Saint-François', 'Bragelogne', array['coiffure']::text[], array['Mixte', 'Boucles', 'Cheveux texturés']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 480, 1110, array[0]::smallint[], 45, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'a', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'b', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'c', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'd', 'Soin profond + coiffage boucles', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'e', 'Coiffure événement', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g124', 'Coiffure Frangipane', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Deshaies', 'Grande-Anse', array['coiffure', 'tresses']::text[], array['Mixte', 'Cheveux texturés', 'Coloration']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1080, array[0]::smallint[], 238, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'a', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'b', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'c', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'd', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'e', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'f', 'Wash and go', 60, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'g', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'h', 'Fulani braids', 180, 90);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g126', 'Studio Zandoli Make-up', null, 'Salon', array['Au salon']::text[], 0, 'Pointe-Noire', 'Bourg', array['maquillage']::text[], array['Shooting', 'Mariée', 'Cours']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 510, 1140, array[0, 1]::smallint[], 68, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'a', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'b', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'c', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'd', 'Maquillage invitée', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g123', 'Les Boucles de Nadège', 'Nadège F.', 'Indépendante', array['Chez elle']::text[], 0, 'Deshaies', 'Bourg', array['coiffure']::text[], array['Mixte', 'Défrisage', 'Boucles']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 510, 1050, array[]::smallint[], 214, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'a', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'b', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'c', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'd', 'Coupe enfant', 30, 16);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g134', 'Salon Goyave', null, 'Salon', array['Au salon']::text[], 0, 'Grand-Bourg', 'Grande-Savane', array['coiffure']::text[], array['Lissage', 'Brushing', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 540, 1050, array[0]::smallint[], 26, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'a', 'Soin profond + coiffage boucles', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'b', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'c', 'Lissage brésilien', 180, 145);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'd', 'Coupe enfant', 30, 14);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g125', 'Cils by Léa', 'Léa A.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Pointe-Noire', 'Bourg', array['cils']::text[], array['Brow lift', 'Volume mixte', 'Volume russe']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 510, 1050, array[0]::smallint[], 227, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'b', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'c', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'd', 'Teinture sourcils', 30, 15);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g117', 'Ingrid Hair', 'Ingrid L.', 'Indépendante', array['Chez elle']::text[], 0, 'Trois-Rivières', 'Schoelcher', array['coiffure']::text[], array['Mixte', 'Boucles', 'Brushing']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 540, 1170, array[0]::smallint[], 38, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'a', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'b', 'Défrisage + soin', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'c', 'Wash and go', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'd', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'e', 'Mèches et balayage', 150, 110);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g133', 'Make-up by Priscilla', 'Priscilla P.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Grand-Bourg', 'Grande-Savane', array['maquillage']::text[], array['Cours', 'Mariée', 'Carnaval']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 510, 1080, array[0]::smallint[], 276, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'a', 'Maquillage mariée + essai', 120, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'b', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'c', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'd', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'e', 'Maquillage jour', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g118', 'Spa Alizés', null, 'Institut', array['À l''institut']::text[], 0, 'Trois-Rivières', 'Grande-Anse', array['soins']::text[], array['Soin visage', 'Soin éclat', 'Gommage']::text[], 'Un moment pour soi, à deux pas du bourg.', 570, 1110, array[0, 1]::smallint[], 148, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'a', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'b', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'c', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'd', 'Épilation maillot', 30, 20);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g119', 'Ti Kaz Beauty Studio', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Trois-Rivières', 'Bourg', array['maquillage']::text[], array['Soirée', 'Invitée', 'Shooting']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 540, 1050, array[0]::smallint[], 260, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'a', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'b', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'c', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'e', 'Maquillage mariée + essai', 120, 150);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g122', 'Dimitri le Barbier Bouillante', 'Dimitri A.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 8, 'Bouillante', 'Bourg', array['barbier']::text[], array['Dégradé', 'Rasage', 'Barbe']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 570, 1170, array[0]::smallint[], 268, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'a', 'Coupe homme', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'b', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'c', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'd', 'Rasage traditionnel', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'e', 'Coupe + barbe', 60, 26);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g121', 'Esther Onglerie', 'Esther J.', 'Indépendante', array['Chez elle']::text[], 0, 'Bouillante', 'Pigeon', array['ongles']::text[], array['Capsules', 'Nail art', 'Baby boomer']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 570, 1170, array[0]::smallint[], 46, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'a', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'b', 'Semi-permanent mains', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'c', 'Semi-permanent pieds', 45, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'd', 'Dépose', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g120', 'Natural Péyi', null, 'Salon', array['Au salon']::text[], 0, 'Bouillante', 'Malendure', array['tresses']::text[], array['Box braids', 'Vanilles', 'Crochet braids']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1050, array[0, 1]::smallint[], 132, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'a', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'b', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'c', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'e', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'f', 'Tresses enfant', 90, 39);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g135', 'Les Boucles de Wendy', 'Wendy R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 0, 'Capesterre-de-Marie-Galante', 'Bourg', array['coiffure']::text[], array['Coloration', 'Balayage', 'Lissage']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 480, 1080, array[]::smallint[], 228, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'a', 'Défrisage + soin', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'b', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'c', 'Wash and go', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'd', 'Coupe enfant', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g136', 'Soufrière Lash', null, 'Institut', array['À l''institut', 'À domicile']::text[], 10, 'Saint-Louis', 'Bourg', array['cils']::text[], array['Volume mixte', 'Brow lift', 'Rehaussement']::text[], 'Cabines individuelles, produits hypoallergéniques.', 570, 1110, array[0]::smallint[], 31, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'a', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'b', 'Volume russe', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'c', 'Rehaussement + teinture', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'd', 'Extensions cil à cil', 120, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g116', 'L''Atelier Goyave Gourbeyre', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Gourbeyre', 'Rivière-Sens', array['coiffure']::text[], array['Lissage', 'Coloration', 'Boucles']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 480, 1170, array[0, 1]::smallint[], 229, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'a', 'Shampoing + brushing', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'c', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'd', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'e', 'Lissage brésilien', 180, 155);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g140', 'Le Regard de Maïlys La Désirade', 'Maïlys K.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 15, 'La Désirade', 'Beauséjour', array['cils']::text[], array['Brow lift', 'Cil à cil', 'Sourcils au fil']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 570, 1080, array[0, 1]::smallint[], 11, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'a', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'b', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'c', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'd', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'e', 'Volume mixte', 150, 80);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g115', 'Coiffure Mango', null, 'Salon', array['Au salon']::text[], 0, 'Gourbeyre', 'Dolé', array['coiffure']::text[], array['Balayage', 'Mixte', 'Défrisage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 480, 1140, array[0, 1]::smallint[], 126, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'a', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'b', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'c', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'd', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'e', 'Mèches et balayage', 150, 105);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g114', 'Barber by Grégory Gourbeyre', 'Grégory R.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 8, 'Gourbeyre', 'Rivière-Sens', array['barbier']::text[], array['Rasage', 'Dégradé', 'Sans rendez-vous']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 510, 1140, array[0]::smallint[], 149, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'a', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'b', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'c', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'd', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'e', 'Coupe homme', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'f', 'Coupe + barbe', 60, 26);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g138', 'Orchidée Coiffure', null, 'Salon', array['Au salon', 'À domicile']::text[], 5, 'Terre-de-Haut', 'Bourg', array['coiffure']::text[], array['Défrisage', 'Cheveux texturés', 'Balayage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 540, 1050, array[0]::smallint[], 305, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'a', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'b', 'Coupe enfant', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'c', 'Wash and go', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'e', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'f', 'Shampoing + brushing', 60, 30);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('loc', 'Locks & Nature', null, 'Salon', array['Au salon']::text[], 0, 'Basse-Terre', 'Centre', array['tresses']::text[], array['Locks', 'Soins naturels']::text[], 'Entretien et création de locks, soins à base de plantes locales.', 540, 1080, array[0, 1]::smallint[], 95, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'a', 'Retwist', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'b', 'Entretien locks + soin', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'c', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'd', 'Coiffage locks', 60, 35);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g084', 'Solène Locks', 'Solène N.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Basse-Terre', 'Carmel', array['tresses']::text[], array['Crochet braids', 'Enfants', 'Knotless']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 480, 1050, array[]::smallint[], 163, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'a', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'b', 'Tresses enfant', 90, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'c', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'd', 'Knotless braids', 300, 145);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g082', 'Yaëlle Hair', 'Yaëlle L.', 'Indépendante', array['À domicile']::text[], 5, 'Basse-Terre', 'Petit-Paris', array['coiffure']::text[], array['Coloration', 'Balayage', 'Boucles']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 510, 1110, array[0]::smallint[], 125, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'a', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'b', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'c', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'd', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g102', 'Lindsay Braids', 'Lindsay S.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Saint-Claude', 'Morin', array['tresses']::text[], array['Crochet braids', 'Locks', 'Knotless']::text[], 'Spécialiste des locks, du départ à l''entretien.', 570, 1110, array[0]::smallint[], 194, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'a', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'b', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'c', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'd', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g085', 'Wesley Barber', 'Wesley N.', 'Indépendant', array['À domicile']::text[], 15, 'Basse-Terre', 'Centre', array['barbier']::text[], array['Contours', 'Rasage', 'Dégradé']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 510, 1050, array[0]::smallint[], 219, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'a', 'Coupe homme', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'b', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'c', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'd', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'e', 'Dégradé + contours', 30, 21);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g128', 'Jessica Nails', 'Jessica C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 8, 'Vieux-Habitants', 'Géry', array['ongles']::text[], array['French', 'Nail art', 'Semi-permanent']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 540, 1110, array[0, 1]::smallint[], 333, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'a', 'Beauté des pieds complète', 60, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'b', 'Semi-permanent pieds', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'c', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'd', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'e', 'Manucure express', 30, 19);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g139', 'Priscilla Beauty', 'Priscilla F.', 'Indépendante', array['Chez elle']::text[], 0, 'Terre-de-Bas', 'Petites-Anses', array['maquillage']::text[], array['Shooting', 'Mariée', 'Invitée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 540, 1110, array[0]::smallint[], 293, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'a', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'b', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'c', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'd', 'Maquillage soirée', 60, 65);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g083', 'Brice Barber', 'Brice K.', 'Indépendant', array['Chez lui']::text[], 0, 'Basse-Terre', 'Centre', array['barbier']::text[], array['Barbe', 'Rasage', 'Enfants']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 570, 1140, array[]::smallint[], 29, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'a', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'b', 'Coupe + soin', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'c', 'Rasage traditionnel', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'd', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'e', 'Dégradé + contours', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'f', 'Coupe homme', 30, 17);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g081', 'Tresses by Shaïna', 'Shaïna S.', 'Indépendante', array['Chez elle']::text[], 0, 'Basse-Terre', 'Petit-Paris', array['tresses']::text[], array['Crochet braids', 'Locks', 'Box braids']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 510, 1110, array[0]::smallint[], 96, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'a', 'Knotless braids', 300, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'b', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'c', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'd', 'Pose de perruque', 60, 50);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g127', 'Cynthia Hair', 'Cynthia C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Vieux-Habitants', 'Bourg', array['coiffure']::text[], array['Lissage', 'Mixte', 'Défrisage']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 540, 1170, array[]::smallint[], 310, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'a', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'b', 'Wash and go', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'c', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'd', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'e', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'f', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g137', 'Ti Très a Stéphanie', 'Stéphanie R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 10, 'Vieux-Fort', 'Bourg', array['tresses']::text[], array['Crochet braids', 'Vanilles', 'Nattes collées']::text[], 'Spécialiste des locks, du départ à l''entretien.', 570, 1110, array[0, 1]::smallint[], 335, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'b', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'c', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'd', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'e', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g086', 'Tresses by Doriane', 'Doriane M.', 'Indépendante', array['À domicile']::text[], 5, 'Basse-Terre', 'Petit-Paris', array['tresses']::text[], array['Crochet braids', 'Locks', 'Enfants']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 510, 1110, array[0, 1]::smallint[], 262, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'b', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'c', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'd', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'e', 'Tresses enfant', 90, 39);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g103', 'Natural Zétwal', null, 'Salon', array['Au salon']::text[], 0, 'Saint-Claude', 'Matouba', array['tresses']::text[], array['Locks', 'Nattes collées', 'Vanilles']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 540, 1140, array[0]::smallint[], 127, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'a', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'b', 'Tresses enfant', 90, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'c', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'd', 'Nattes collées', 90, 45);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g104', 'Glam by Solène', 'Solène R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 5, 'Saint-Claude', 'Matouba', array['maquillage']::text[], array['Mariée', 'Invitée', 'Shooting']::text[], 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 480, 1050, array[0, 1]::smallint[], 115, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'a', 'Maquillage mariée + essai', 120, 165);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'b', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'c', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'd', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g131', 'Salon Corail', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Baillif', 'Bourg', array['coiffure']::text[], array['Mixte', 'Lissage', 'Balayage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 510, 1080, array[0]::smallint[], 50, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'a', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'c', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'd', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'e', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'f', 'Wash and go', 60, 37);

insert into pros (id, name, owner_name, kind, places, travel_fee_eur, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g132', 'Vanille Nails', null, 'Salon', array['Au salon', 'À domicile']::text[], 0, 'Baillif', 'Bourg', array['ongles', 'cils']::text[], array['Pose gel', 'Semi-permanent', 'French']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 480, 1080, array[0]::smallint[], 344, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'a', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'b', 'Beauté des pieds complète', 60, 43);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'c', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'd', 'Semi-permanent pieds', 45, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'e', 'Volume russe', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'f', 'Brow lift', 60, 50);
