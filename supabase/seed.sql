-- Données de démonstration (fictives). Fichier généré par scripts/gen-seed.mjs, ne pas modifier à la main.

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('kaz', 'Kaz a Zong', 'Maëva L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Les Abymes', 'Raizet', array['ongles']::text[], array['Pose gel', 'Nail art', 'Semi-permanent']::text[], 'Prothésiste ongulaire depuis 6 ans. Reçoit dans son atelier au Raizet ou se déplace dans l''agglomération pointoise.', 540, 1140, array[0]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'b', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'd', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'e', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('kaz', 'f', 'Dépose', 30, 15);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g001', 'Ti Très a Joanie', 'Joanie P.', 'Indépendante', array['Chez elle']::text[], 'Les Abymes', 'Petit-Pérou', array['tresses']::text[], array['Crochet braids', 'Locks', 'Knotless']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1050, array[0]::smallint[], 163, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'a', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'c', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'e', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g001', 'f', 'Départ de locks', 180, 105);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g006', 'L''Atelier des Ongles Goyave', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Raizet', array['ongles', 'cils']::text[], array['Nail art', 'Baby boomer', 'French']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 540, 1110, array[0]::smallint[], 260, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'a', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'b', 'Baby boomer', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'c', 'Semi-permanent pieds', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'd', 'Manucure express', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'e', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'f', 'Volume russe', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g006', 'g', 'Extensions cil à cil', 120, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g004', 'Monbin Coiffure', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Grand-Camp', array['coiffure']::text[], array['Mixte', 'Défrisage', 'Brushing']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1140, array[0, 1]::smallint[], 215, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'a', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'b', 'Mèches et balayage', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'c', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'd', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'e', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g004', 'f', 'Défrisage + soin', 120, 80);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g013', 'Wendy Esthétique', 'Wendy R.', 'Indépendante', array['Chez elle']::text[], 'Les Abymes', 'Boisripeaux', array['soins']::text[], array['Épilation', 'Gommage', 'Massage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 480, 1140, array[0]::smallint[], 269, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'b', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'c', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g013', 'd', 'Épilation jambes complètes', 60, 34);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g008', 'Trois Îlets Coiffure', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Chauvel', array['coiffure']::text[], array['Brushing', 'Défrisage', 'Coloration']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1050, array[0, 1]::smallint[], 19, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'a', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'c', 'Mèches et balayage', 150, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'd', 'Coiffure événement', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g008', 'e', 'Shampoing + brushing', 60, 34);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g012', 'Sabrina Bien-être', 'Sabrina F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Les Abymes', 'Boisripeaux', array['soins']::text[], array['Massage', 'Cire tiède', 'Soin visage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 510, 1170, array[0]::smallint[], 85, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'a', 'Massage dos', 30, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'b', 'Soin visage éclat', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'c', 'Épilation sourcils', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'd', 'Épilation aisselles', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g012', 'e', 'Soin visage hydratant', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('bar', 'Barber Lakou', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Grand-Camp', array['barbier']::text[], array['Dégradé', 'Barbe', 'Sans rendez-vous']::text[], 'Trois fauteuils, coupe homme et enfant. Les contours sont offerts dans les 10 jours.', 540, 1140, array[0]::smallint[], 210, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'a', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'b', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('bar', 'd', 'Coupe enfant', 30, 12);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g015', 'Institut Alamanda', null, 'Institut', array['À l''institut']::text[], 'Les Abymes', 'Chauvel', array['soins', 'maquillage']::text[], array['Épilation', 'Soin éclat', 'Cire tiède']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1080, array[0, 1]::smallint[], 3, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'a', 'Épilation jambes complètes', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'b', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'c', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'd', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'e', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g015', 'f', 'Maquillage soirée', 60, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g009', 'Loïc Barber', 'Loïc L.', 'Indépendant', array['Chez lui', 'À domicile']::text[], 'Les Abymes', 'Boisripeaux', array['barbier']::text[], array['Rasage', 'Sans rendez-vous', 'Barbe']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 510, 1110, array[0, 1]::smallint[], 326, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'a', 'Coupe homme', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'b', 'Rasage traditionnel', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'c', 'Coupe + barbe', 60, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'd', 'Coupe + soin', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'e', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g009', 'f', 'Dégradé + contours', 30, 21);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g023', 'Monbin Coiffure Pointe-à-Pitre', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Bergevin', array['coiffure', 'tresses']::text[], array['Lissage', 'Balayage', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 540, 1080, array[0, 1]::smallint[], 2, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'a', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'b', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'c', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'e', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g023', 'f', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g018', 'Institut Sable Blanc', null, 'Institut', array['À l''institut']::text[], 'Pointe-à-Pitre', 'Centre-ville', array['soins']::text[], array['Soin éclat', 'Gommage', 'Épilation']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1080, array[0]::smallint[], 135, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'b', 'Épilation maillot', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'c', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'd', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g018', 'e', 'Soin visage hydratant', 60, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g002', 'Malika Esthétique', 'Malika J.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Les Abymes', 'Dothémare', array['soins']::text[], array['Gommage', 'Soin éclat', 'Soin visage']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 480, 1140, array[0]::smallint[], 260, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'a', 'Massage dos', 30, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'b', 'Épilation sourcils', 30, 9);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'c', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g002', 'd', 'Gommage corps', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g003', 'L''Atelier des Ongles Gwada', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Boisripeaux', array['ongles']::text[], array['Capsules', 'Baby boomer', 'French']::text[], 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.', 540, 1050, array[0]::smallint[], 237, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'a', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'b', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'c', 'Semi-permanent pieds', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g003', 'd', 'Semi-permanent mains', 45, 28);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g010', 'Studio Cils Kannèl', null, 'Institut', array['À l''institut']::text[], 'Les Abymes', 'Raizet', array['cils']::text[], array['Brow lift', 'Volume mixte', 'Cil à cil']::text[], 'Cabines individuelles, produits hypoallergéniques.', 480, 1110, array[0]::smallint[], 47, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'a', 'Rehaussement + teinture', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'b', 'Sourcils au fil', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'c', 'Extensions cil à cil', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g010', 'd', 'Remplissage cils', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g005', 'Léa Lash', 'Léa D.', 'Indépendante', array['Chez elle']::text[], 'Les Abymes', 'Grand-Camp', array['cils']::text[], array['Volume mixte', 'Cil à cil', 'Volume russe']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 570, 1080, array[]::smallint[], 135, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'a', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'b', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'c', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'd', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g005', 'e', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g011', 'Le Regard de Esther', 'Esther G.', 'Indépendante', array['À domicile']::text[], 'Les Abymes', 'Grand-Camp', array['cils', 'ongles']::text[], array['Cil à cil', 'Rehaussement', 'Sourcils au fil']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 540, 1140, array[0]::smallint[], 210, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'a', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'b', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'c', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'd', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'e', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'f', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'g', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g011', 'h', 'Beauté des pieds complète', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g017', 'Les Nattes de Cynthia', 'Cynthia T.', 'Indépendante', array['À domicile']::text[], 'Pointe-à-Pitre', 'Centre-ville', array['tresses']::text[], array['Nattes collées', 'Locks', 'Knotless']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 570, 1050, array[0, 1]::smallint[], 164, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'a', 'Tresses enfant', 90, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'b', 'Crochet braids', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'c', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'd', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'e', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g017', 'f', 'Fulani braids', 180, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g007', 'Ti Kaz Barber Shop', null, 'Salon', array['Au salon']::text[], 'Les Abymes', 'Chauvel', array['barbier']::text[], array['Contours', 'Barbe', 'Enfants']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1140, array[0, 1]::smallint[], 303, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'a', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'b', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'c', 'Coupe homme', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'd', 'Coupe + soin', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'e', 'Dégradé + contours', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g007', 'f', 'Rasage traditionnel', 30, 18);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g014', 'Loïc le Barbier', 'Loïc N.', 'Indépendant', array['Chez lui']::text[], 'Les Abymes', 'Grand-Camp', array['barbier']::text[], array['Barbe', 'Sans rendez-vous', 'Rasage']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 510, 1170, array[0]::smallint[], 267, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'a', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'b', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'c', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'd', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'e', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g014', 'f', 'Coupe homme', 30, 19);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g019', 'Corail Nails', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Lauricisque', array['ongles']::text[], array['Baby boomer', 'Semi-permanent', 'French']::text[], 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.', 480, 1080, array[0]::smallint[], 43, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'a', 'Semi-permanent mains', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'b', 'Nail art 10 doigts', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'c', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'd', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g019', 'e', 'Beauté des pieds complète', 60, 43);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g022', 'Natural Karambole', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Carénage', array['tresses']::text[], array['Locks', 'Box braids', 'Crochet braids']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 480, 1110, array[0]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'a', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'b', 'Knotless braids', 300, 130);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'c', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g022', 'd', 'Tresses enfant', 90, 33);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('hib', 'Salon Hibiscus', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Centre-ville', array['coiffure']::text[], array['Brushing', 'Lissage', 'Cheveux texturés']::text[], 'Salon mixte du centre-ville. Spécialiste du soin et du coiffage des boucles, coloration végétale sur demande.', 540, 1080, array[0, 1]::smallint[], 350, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'a', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'b', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'c', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'd', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('hib', 'e', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g020', 'Les Boucles de Nadège', 'Nadège G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Pointe-à-Pitre', 'Massabielle', array['coiffure', 'tresses']::text[], array['Cheveux texturés', 'Mixte', 'Défrisage']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 510, 1110, array[0, 1]::smallint[], 311, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'a', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'b', 'Lissage brésilien', 180, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'c', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'd', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'e', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g020', 'f', 'Crochet braids', 150, 80);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g046', 'Mango Braids', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Bas-du-Fort', array['tresses']::text[], array['Crochet braids', 'Locks', 'Enfants']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1050, array[0, 1]::smallint[], 22, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'a', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'b', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'c', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'd', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g046', 'e', 'Pose de perruque', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g047', 'Studio Flamboyant Make-up', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Bas-du-Fort', array['maquillage']::text[], array['Soirée', 'Cours', 'Invitée']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 510, 1170, array[0]::smallint[], 193, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'a', 'Maquillage mariée + essai', 120, 140);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'b', 'Maquillage carnaval', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'c', 'Maquillage shooting', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'd', 'Cours d''auto-maquillage', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g047', 'e', 'Maquillage invitée', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('nai', 'Nail Bar Bas-du-Fort', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Bas-du-Fort', array['ongles']::text[], array['Pose gel', 'Beauté des pieds']::text[], 'Bar à ongles près de la marina, quatre postes. Idéal entre midi et deux.', 570, 1110, array[0]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'a', 'Pose gel', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'b', 'Remplissage', 60, 42);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'c', 'Semi-permanent', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('nai', 'd', 'Beauté des pieds + vernis', 60, 38);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g039', 'Jasmin Braids', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Montauban', array['tresses']::text[], array['Crochet braids', 'Knotless', 'Locks']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 570, 1110, array[0]::smallint[], 272, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'b', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'c', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g039', 'd', 'Vanilles', 120, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g026', 'Ti Zong a Audrey', 'Audrey B.', 'Indépendante', array['À domicile']::text[], 'Pointe-à-Pitre', 'Lauricisque', array['ongles']::text[], array['Baby boomer', 'French', 'Capsules']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 510, 1080, array[0, 1]::smallint[], 125, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'a', 'Manucure express', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'b', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'c', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'd', 'Beauté des pieds complète', 60, 43);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'e', 'Semi-permanent pieds', 45, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g026', 'f', 'Remplissage gel', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g044', 'Tresses Zétwal', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Pliane', array['tresses']::text[], array['Crochet braids', 'Knotless', 'Box braids']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 480, 1050, array[0]::smallint[], 47, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'a', 'Knotless braids', 300, 130);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'b', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'c', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'd', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g044', 'e', 'Fulani braids', 180, 80);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g038', 'Barbershop Jasmin', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Mare-Gaillard', array['barbier']::text[], array['Rasage', 'Contours', 'Dégradé']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 480, 1050, array[0, 1]::smallint[], 292, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'a', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'b', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'c', 'Coupe homme', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'd', 'Rasage traditionnel', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g038', 'e', 'Coupe + barbe', 60, 23);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tre', 'Tresses Lokal', 'Sandrine D.', 'Indépendante', array['À domicile']::text[], 'Le Gosier', 'Mare-Gaillard', array['tresses', 'coiffure']::text[], array['Box braids', 'Vanilles', 'Locks']::text[], 'Tresseuse à domicile sur toute la Riviera du Levant. Mèches fournies sur demande, comptées en supplément.', 480, 1080, array[0]::smallint[], 25, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'a', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'c', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'd', 'Retwist locks', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tre', 'e', 'Départ de locks', 180, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g016', 'Ludmila Hair', 'Ludmila K.', 'Indépendante', array['À domicile']::text[], 'Pointe-à-Pitre', 'Lauricisque', array['coiffure']::text[], array['Boucles', 'Balayage', 'Coloration']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 570, 1140, array[0]::smallint[], 163, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'a', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'b', 'Wash and go', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'c', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'd', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g016', 'e', 'Défrisage + soin', 120, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g021', 'Cils by Nadège', 'Nadège K.', 'Indépendante', array['À domicile']::text[], 'Pointe-à-Pitre', 'Lauricisque', array['cils']::text[], array['Rehaussement', 'Volume russe', 'Brow lift']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 510, 1140, array[0]::smallint[], 51, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'b', 'Sourcils au fil', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'c', 'Volume mixte', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'd', 'Restructuration sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g021', 'e', 'Volume russe', 150, 85);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g025', 'L''Atelier des Ongles Bougainvillée', null, 'Salon', array['Au salon']::text[], 'Pointe-à-Pitre', 'Massabielle', array['ongles']::text[], array['Beauté des pieds', 'Semi-permanent', 'Pose gel']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 510, 1050, array[0, 1]::smallint[], 303, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'a', 'Semi-permanent mains', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'b', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'c', 'Dépose', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'd', 'Manucure express', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g025', 'e', 'Nail art 10 doigts', 30, 16);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g035', 'Doriane Brows', 'Doriane J.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Baie-Mahault', 'La Jaille', array['cils']::text[], array['Sourcils au fil', 'Volume russe', 'Brow lift']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 510, 1170, array[0]::smallint[], 170, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'a', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'b', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'c', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g035', 'd', 'Brow lift', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g033', 'Ti Zong a Ingrid', 'Ingrid T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Baie-Mahault', 'Bourg', array['ongles']::text[], array['Capsules', 'Pose gel', 'French']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 480, 1080, array[]::smallint[], 106, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'a', 'Beauté des pieds complète', 60, 44);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'b', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'c', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'd', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'e', 'Manucure express', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g033', 'f', 'Semi-permanent pieds', 45, 34);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g024', 'Ruddy le Barbier', 'Ruddy A.', 'Indépendant', array['À domicile']::text[], 'Pointe-à-Pitre', 'Bergevin', array['barbier']::text[], array['Sans rendez-vous', 'Rasage', 'Contours']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 480, 1110, array[0, 1]::smallint[], 300, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'b', 'Coupe + barbe', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'c', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'd', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g024', 'e', 'Coupe + soin', 60, 33);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g040', 'Barber Goyave', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Bourg', array['barbier']::text[], array['Barbe', 'Sans rendez-vous', 'Dégradé']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 480, 1050, array[0, 1]::smallint[], 207, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'a', 'Coupe homme', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'b', 'Coupe + barbe', 60, 23);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'c', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'd', 'Coupe enfant', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g040', 'e', 'Dégradé + contours', 30, 18);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('reg', 'Regard Karukera', null, 'Institut', array['À l''institut']::text[], 'Baie-Mahault', 'Jarry', array['cils']::text[], array['Extensions', 'Rehaussement', 'Sourcils au fil']::text[], 'Institut dédié au regard, en zone de Jarry. Parking gratuit devant la porte.', 540, 1110, array[0]::smallint[], 265, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'b', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'c', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'd', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'e', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('reg', 'f', 'Brow lift', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g043', 'Sabrina Braids', 'Sabrina N.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Le Gosier', 'Bourg', array['tresses']::text[], array['Vanilles', 'Box braids', 'Crochet braids']::text[], 'Spécialiste des locks, du départ à l''entretien.', 510, 1080, array[]::smallint[], 161, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'a', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'b', 'Tresses enfant', 90, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'c', 'Box braids mi-longues', 240, 115);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g043', 'd', 'Fulani braids', 180, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('col', 'Studio Colibri', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Destrellan', array['coiffure', 'maquillage']::text[], array['Chignon', 'Événement', 'Maquillage']::text[], 'Coiffure et maquillage au même endroit pour les baptêmes, mariages et soirées.', 540, 1110, array[0, 1]::smallint[], 160, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'a', 'Coupe + coiffage', 60, 48);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'c', 'Maquillage + coiffure', 120, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('col', 'd', 'Brushing', 30, 28);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g042', 'Monbin Coiffure Le Gosier', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Pliane', array['coiffure']::text[], array['Balayage', 'Cheveux texturés', 'Boucles']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1140, array[0, 1]::smallint[], 9, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'a', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'c', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g042', 'd', 'Lissage brésilien', 180, 160);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g031', 'Tresses Karambole', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'La Jaille', array['tresses']::text[], array['Crochet braids', 'Knotless', 'Enfants']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 480, 1080, array[0]::smallint[], 316, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'a', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'b', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'c', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'd', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'e', 'Tresses enfant', 90, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g031', 'f', 'Pose de perruque', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g027', 'Le Fauteuil Corossol', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Bourg', array['barbier']::text[], array['Contours', 'Rasage', 'Barbe']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 510, 1110, array[0]::smallint[], 257, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'a', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'b', 'Coupe + soin', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'c', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'd', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'e', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g027', 'f', 'Rasage traditionnel', 30, 20);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g037', 'Vanille Coiffure', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Convenance', array['coiffure']::text[], array['Brushing', 'Coloration', 'Balayage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 510, 1170, array[0, 1]::smallint[], 261, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'a', 'Shampoing + brushing', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'b', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'd', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'e', 'Coupe + brushing', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g037', 'f', 'Coupe enfant', 30, 14);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g032', 'Barber Bougainvillée', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Convenance', array['barbier']::text[], array['Contours', 'Barbe', 'Enfants']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 540, 1080, array[0]::smallint[], 141, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'a', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'b', 'Coupe homme', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'c', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'd', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'e', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g032', 'f', 'Coupe + soin', 60, 30);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g045', 'Rachelle Bien-être', 'Rachelle A.', 'Indépendante', array['Chez elle']::text[], 'Le Gosier', 'Montauban', array['soins']::text[], array['Gommage', 'Épilation', 'Soin éclat']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 540, 1170, array[0]::smallint[], 205, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'a', 'Massage dos', 30, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'b', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'c', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'd', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g045', 'e', 'Soin visage éclat', 60, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g041', 'L''Atelier Monbin', null, 'Salon', array['Au salon']::text[], 'Le Gosier', 'Mare-Gaillard', array['coiffure']::text[], array['Balayage', 'Brushing', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 510, 1170, array[0]::smallint[], 297, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'a', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'c', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'd', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g041', 'e', 'Coupe + brushing', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g028', 'Les Ongles de Ketsia', 'Ketsia B.', 'Indépendante', array['Chez elle']::text[], 'Baie-Mahault', 'Destrellan', array['ongles']::text[], array['Pose gel', 'Semi-permanent', 'Beauté des pieds']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 510, 1050, array[0]::smallint[], 219, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'a', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'b', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'c', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g028', 'd', 'Remplissage gel', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g029', 'Frangipane Barber Shop', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Destrellan', array['barbier']::text[], array['Enfants', 'Barbe', 'Contours']::text[], 'Plusieurs fauteuils, coupe homme et enfant, contours offerts dans les 10 jours.', 570, 1140, array[0, 1]::smallint[], 149, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'a', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'b', 'Rasage traditionnel', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'c', 'Coupe + barbe', 60, 24);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g029', 'd', 'Coupe + soin', 60, 29);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g036', 'Barber Monbin', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Convenance', array['barbier']::text[], array['Barbe', 'Rasage', 'Enfants']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1140, array[0, 1]::smallint[], 48, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'a', 'Rasage traditionnel', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'b', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'c', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'd', 'Dégradé + contours', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g036', 'e', 'Coupe + barbe', 60, 24);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g054', 'Ruddy le Barbier Petit-Bourg', 'Ruddy T.', 'Indépendant', array['À domicile']::text[], 'Petit-Bourg', 'Colin', array['barbier']::text[], array['Contours', 'Barbe', 'Dégradé']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 570, 1170, array[0]::smallint[], 226, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'b', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'c', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g054', 'd', 'Coupe + soin', 60, 33);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g034', 'Hair Balisier', null, 'Salon', array['Au salon']::text[], 'Baie-Mahault', 'Convenance', array['coiffure', 'tresses']::text[], array['Lissage', 'Défrisage', 'Mixte']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 480, 1170, array[0, 1]::smallint[], 47, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'a', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'b', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'c', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'd', 'Mèches et balayage', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'e', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g034', 'f', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g048', 'Corossol Coiffure', null, 'Salon', array['Au salon']::text[], 'Petit-Bourg', 'Arnouville', array['coiffure']::text[], array['Coloration', 'Balayage', 'Mixte']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 480, 1170, array[0, 1]::smallint[], 339, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'a', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'b', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'c', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g048', 'd', 'Shampoing + brushing', 60, 32);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g052', 'Hair Coco', null, 'Salon', array['Au salon']::text[], 'Petit-Bourg', 'Vernou', array['coiffure']::text[], array['Cheveux texturés', 'Coloration', 'Défrisage']::text[], 'Le salon de quartier où on entre aussi sans rendez-vous quand il y a de la place.', 540, 1110, array[0]::smallint[], 239, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'a', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'b', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'c', 'Wash and go', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'd', 'Coupe enfant', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'e', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g052', 'f', 'Coloration', 90, 70);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('fle', 'Institut Fleur de Canne', null, 'Institut', array['À l''institut']::text[], 'Petit-Bourg', 'Bourg', array['soins']::text[], array['Soin visage', 'Épilation', 'Massage']::text[], 'Soins du visage et du corps, cire tiède. Cabine climatisée.', 540, 1080, array[0]::smallint[], 120, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'b', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'c', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'd', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('fle', 'e', 'Massage dos', 30, 35);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g030', 'Ketsia Brows', 'Ketsia T.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Baie-Mahault', 'Convenance', array['cils']::text[], array['Rehaussement', 'Cil à cil', 'Volume russe']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 480, 1080, array[]::smallint[], 111, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'a', 'Volume russe', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'b', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'c', 'Teinture sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'd', 'Brow lift', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g030', 'e', 'Restructuration sourcils', 30, 20);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g051', 'Pomme Cannelle Beauté', null, 'Institut', array['À l''institut']::text[], 'Petit-Bourg', 'Vernou', array['soins']::text[], array['Cire tiède', 'Massage', 'Gommage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1050, array[0, 1]::smallint[], 223, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'a', 'Gommage corps', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'b', 'Massage relaxant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'c', 'Épilation demi-jambes', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'd', 'Soin visage hydratant', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g051', 'e', 'Épilation maillot', 30, 17);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g049', 'Salon Péyi', null, 'Salon', array['Au salon']::text[], 'Petit-Bourg', 'Bourg', array['coiffure']::text[], array['Boucles', 'Balayage', 'Lissage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 480, 1050, array[0]::smallint[], 204, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'a', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'b', 'Coupe + brushing', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'c', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g049', 'd', 'Shampoing + brushing', 60, 33);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g089', 'Hair Lanmè', null, 'Salon', array['Au salon']::text[], 'Morne-à-l''Eau', 'Perrin', array['coiffure', 'tresses']::text[], array['Défrisage', 'Lissage', 'Boucles']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1050, array[0, 1]::smallint[], 249, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'a', 'Wash and go', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'b', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'c', 'Shampoing + brushing', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'd', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'e', 'Vanilles', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g089', 'f', 'Pose de perruque', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g091', 'Les Nattes de Nadège', 'Nadège F.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Morne-à-l''Eau', 'Perrin', array['tresses']::text[], array['Crochet braids', 'Vanilles', 'Nattes collées']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1110, array[0]::smallint[], 309, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'a', 'Nattes collées', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'b', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'c', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g091', 'd', 'Knotless braids', 300, 135);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g087', 'Les Nattes de Tatiana', 'Tatiana D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Morne-à-l''Eau', 'Perrin', array['tresses']::text[], array['Crochet braids', 'Enfants', 'Locks']::text[], 'Spécialiste des locks, du départ à l''entretien.', 510, 1050, array[0]::smallint[], 197, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'a', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'b', 'Tresses enfant', 90, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'c', 'Knotless braids', 300, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'd', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'e', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g087', 'f', 'Vanilles', 120, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g090', 'L''Atelier des Ongles Flamboyant', null, 'Salon', array['Au salon']::text[], 'Morne-à-l''Eau', 'Richeval', array['ongles', 'cils']::text[], array['French', 'Capsules', 'Beauté des pieds']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 540, 1170, array[0, 1]::smallint[], 278, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'a', 'Beauté des pieds complète', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'b', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'c', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'd', 'Manucure express', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'e', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'f', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'g', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g090', 'h', 'Sourcils au fil', 30, 12);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g092', 'Nadège Esthétique', 'Nadège C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Lamentin', 'Caillou', array['soins']::text[], array['Massage', 'Cire tiède', 'Épilation']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 510, 1050, array[0]::smallint[], 346, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'a', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'b', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'c', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'd', 'Épilation jambes complètes', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g092', 'e', 'Épilation demi-jambes', 30, 18);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('tib', 'Onglerie Ti Bijou', 'Naomie C.', 'Indépendante', array['À domicile']::text[], 'Lamentin', 'Bourg', array['ongles']::text[], array['Capsules', 'Baby boomer']::text[], 'Se déplace avec tout son matériel sur le nord Basse-Terre : Lamentin, Sainte-Rose, Baie-Mahault.', 540, 1080, array[0, 1]::smallint[], 315, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'a', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'b', 'Remplissage', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'c', 'Semi-permanent', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('tib', 'd', 'Baby boomer', 120, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g050', 'Coiffure Gwada', null, 'Salon', array['Au salon']::text[], 'Petit-Bourg', 'Colin', array['coiffure']::text[], array['Brushing', 'Boucles', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1110, array[0]::smallint[], 156, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'a', 'Shampoing + brushing', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'c', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'd', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'e', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g050', 'f', 'Mèches et balayage', 150, 90);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g088', 'Christelle Locks', 'Christelle C.', 'Indépendante', array['Chez elle']::text[], 'Morne-à-l''Eau', 'Richeval', array['tresses']::text[], array['Vanilles', 'Locks', 'Nattes collées']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1140, array[0]::smallint[], 323, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'a', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'b', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'c', 'Knotless braids', 300, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g088', 'd', 'Départ de locks', 180, 100);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g053', 'Jonathan Barber', 'Jonathan G.', 'Indépendant', array['Chez lui']::text[], 'Petit-Bourg', 'Arnouville', array['barbier']::text[], array['Sans rendez-vous', 'Rasage', 'Enfants']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 480, 1080, array[0]::smallint[], 206, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'a', 'Rasage traditionnel', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'b', 'Coupe homme', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'c', 'Dégradé + contours', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g053', 'd', 'Coupe + soin', 60, 29);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g096', 'Les Nattes de Vanessa', 'Vanessa B.', 'Indépendante', array['À domicile']::text[], 'Lamentin', 'Caillou', array['tresses']::text[], array['Knotless', 'Enfants', 'Box braids']::text[], 'Spécialiste des locks, du départ à l''entretien.', 480, 1110, array[0]::smallint[], 113, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'a', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'b', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'c', 'Knotless braids', 300, 130);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'd', 'Tresses enfant', 90, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'e', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g096', 'f', 'Nattes collées', 90, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g059', 'Orchidée Beauté', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Douville', array['soins']::text[], array['Cire tiède', 'Épilation', 'Soin visage']::text[], 'Un moment pour soi, à deux pas du bourg.', 540, 1140, array[0, 1]::smallint[], 4, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'a', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'b', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'c', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g059', 'd', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g094', 'Cils by Marjorie', 'Marjorie V.', 'Indépendante', array['À domicile']::text[], 'Lamentin', 'Caillou', array['cils', 'ongles']::text[], array['Cil à cil', 'Volume mixte', 'Sourcils au fil']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 540, 1170, array[0]::smallint[], 243, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'a', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'b', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'c', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'd', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'e', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'f', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'g', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g094', 'h', 'Baby boomer', 120, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('mad', 'Atelier Madras Beauté', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Bourg', array['soins', 'maquillage']::text[], array['Soin éclat', 'Maquillage', 'Épilation']::text[], 'À deux rues de la plage du bourg. Soins, épilation et maquillage sur rendez-vous.', 540, 1080, array[0]::smallint[], 5, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'b', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'c', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('mad', 'e', 'Massage relaxant', 60, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g093', 'Léa Brows', 'Léa G.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Lamentin', 'Bourg', array['cils']::text[], array['Rehaussement', 'Brow lift', 'Volume russe']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 540, 1050, array[0]::smallint[], 159, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'a', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'b', 'Sourcils au fil', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'c', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'd', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'e', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g093', 'f', 'Teinture sourcils', 30, 16);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g055', 'Karambole Beauté', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Durivage', array['soins']::text[], array['Soin éclat', 'Épilation', 'Massage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 510, 1080, array[0]::smallint[], 126, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'a', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'b', 'Épilation maillot', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'c', 'Épilation jambes complètes', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'd', 'Épilation demi-jambes', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g055', 'e', 'Massage dos', 30, 35);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g060', 'Cils by Ingrid', 'Ingrid C.', 'Indépendante', array['Chez elle']::text[], 'Sainte-Anne', 'Châteaubrun', array['cils']::text[], array['Volume russe', 'Volume mixte', 'Cil à cil']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 510, 1140, array[0, 1]::smallint[], 58, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'a', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'b', 'Restructuration sourcils', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'c', 'Brow lift', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g060', 'd', 'Rehaussement + teinture', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g095', 'Maracudja Beauté', null, 'Institut', array['À l''institut']::text[], 'Lamentin', 'Blachon', array['soins']::text[], array['Soin éclat', 'Cire tiède', 'Massage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1080, array[0]::smallint[], 339, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'a', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'b', 'Massage relaxant', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'c', 'Massage dos', 30, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'd', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g095', 'e', 'Épilation jambes complètes', 60, 34);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g058', 'Coiffure by Rachelle', 'Rachelle M.', 'Indépendante', array['À domicile']::text[], 'Sainte-Anne', 'Bourg', array['coiffure']::text[], array['Boucles', 'Brushing', 'Défrisage']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 570, 1080, array[0]::smallint[], 67, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'a', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'b', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'c', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'd', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g058', 'e', 'Shampoing + brushing', 60, 29);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g106', 'Les Boucles de Samantha', 'Samantha J.', 'Indépendante', array['Chez elle']::text[], 'Goyave', 'Sainte-Claire', array['coiffure']::text[], array['Boucles', 'Mixte', 'Cheveux texturés']::text[], 'Coiffeuse diplômée, elle se déplace avec tout son matériel.', 540, 1110, array[0]::smallint[], 7, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'a', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'c', 'Shampoing + brushing', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g106', 'd', 'Coloration', 90, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g056', 'Institut Lalin', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Bourg', array['soins']::text[], array['Soin éclat', 'Cire tiède', 'Gommage']::text[], 'Un moment pour soi, à deux pas du bourg.', 570, 1140, array[0]::smallint[], 202, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'a', 'Épilation sourcils', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'b', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'c', 'Massage dos', 30, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g056', 'd', 'Épilation demi-jambes', 30, 19);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g107', 'Pomme Cannelle Lash', null, 'Institut', array['À l''institut']::text[], 'Goyave', 'Bourg', array['cils']::text[], array['Sourcils au fil', 'Rehaussement', 'Brow lift']::text[], 'Cabines individuelles, produits hypoallergéniques.', 480, 1110, array[0]::smallint[], 94, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'a', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'b', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'c', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'd', 'Brow lift', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'e', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g107', 'f', 'Volume russe', 150, 100);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g109', 'Cils by Nadège Petit-Canal', 'Nadège G.', 'Indépendante', array['À domicile']::text[], 'Petit-Canal', 'Les Mangles', array['cils']::text[], array['Cil à cil', 'Volume russe', 'Brow lift']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 510, 1170, array[]::smallint[], 302, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'a', 'Restructuration sourcils', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'b', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'c', 'Brow lift', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'd', 'Remplissage cils', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g109', 'e', 'Rehaussement + teinture', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g057', 'Escale Ti Kaz', null, 'Institut', array['À l''institut']::text[], 'Sainte-Anne', 'Douville', array['soins']::text[], array['Soin éclat', 'Massage', 'Soin visage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1110, array[0]::smallint[], 317, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'b', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'c', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g057', 'd', 'Soin visage éclat', 60, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g061', 'Vanille Nails', null, 'Salon', array['Au salon']::text[], 'Sainte-Anne', 'Châteaubrun', array['ongles']::text[], array['Beauté des pieds', 'French', 'Capsules']::text[], 'Spécialiste du gel et du nail art, matériel stérilisé à chaque cliente.', 540, 1050, array[0]::smallint[], 272, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'a', 'Semi-permanent pieds', 45, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'b', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'c', 'Pose gel + couleur', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'd', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g061', 'e', 'Dépose', 30, 17);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g110', 'Barbershop Alamanda', null, 'Salon', array['Au salon']::text[], 'Petit-Canal', 'Gros-Cap', array['barbier']::text[], array['Sans rendez-vous', 'Contours', 'Enfants']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 480, 1050, array[0]::smallint[], 198, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'a', 'Dégradé + contours', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'b', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'c', 'Rasage traditionnel', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g110', 'd', 'Coupe + soin', 60, 31);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g105', 'Joanie Braids', 'Joanie L.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Goyave', 'Morne-Rouge', array['tresses']::text[], array['Crochet braids', 'Nattes collées', 'Enfants']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 510, 1140, array[0]::smallint[], 124, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'a', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'b', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'c', 'Box braids mi-longues', 240, 120);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'd', 'Crochet braids', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'e', 'Départ de locks', 180, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g105', 'f', 'Retwist locks', 90, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('oce', 'Cils by Océane', 'Océane V.', 'Indépendante', array['Chez elle']::text[], 'Le Moule', 'Sergent', array['cils']::text[], array['Cil à cil', 'Volume mixte']::text[], 'Technicienne cils certifiée, reçoit dans une pièce dédiée de sa maison.', 540, 1080, array[0, 1]::smallint[], 245, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'a', 'Cil à cil', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'b', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'c', 'Remplissage', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('oce', 'd', 'Rehaussement', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g108', 'Wesley le Barbier', 'Wesley M.', 'Indépendant', array['À domicile']::text[], 'Petit-Canal', 'Les Mangles', array['barbier']::text[], array['Sans rendez-vous', 'Contours', 'Barbe']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 540, 1050, array[0]::smallint[], 63, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'a', 'Coupe + soin', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'b', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'c', 'Coupe enfant', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'd', 'Coupe + barbe', 60, 25);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g108', 'e', 'Rasage traditionnel', 30, 20);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g062', 'Sabrina Nails', 'Sabrina B.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Le Moule', 'Sergent', array['ongles']::text[], array['Capsules', 'Semi-permanent', 'Nail art']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 510, 1080, array[0]::smallint[], 299, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'a', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'b', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'c', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'd', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g062', 'e', 'Manucure express', 30, 18);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g068', 'Locks Trois Îlets', null, 'Salon', array['Au salon']::text[], 'Le Moule', 'L''Autre Bord', array['tresses']::text[], array['Nattes collées', 'Crochet braids', 'Knotless']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 510, 1170, array[0, 1]::smallint[], 94, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'a', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'b', 'Tresses enfant', 90, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'c', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'd', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'e', 'Knotless braids', 300, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g068', 'f', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g064', 'Natural Balisier', null, 'Salon', array['Au salon']::text[], 'Le Moule', 'Bourg', array['tresses']::text[], array['Enfants', 'Nattes collées', 'Knotless']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1080, array[0]::smallint[], 229, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'a', 'Vanilles', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'b', 'Fulani braids', 180, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'c', 'Pose de perruque', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'd', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'e', 'Retwist locks', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g064', 'f', 'Tresses enfant', 90, 32);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g065', 'Glam by Cynthia', 'Cynthia C.', 'Indépendante', array['Chez elle']::text[], 'Le Moule', 'Damencourt', array['maquillage']::text[], array['Invitée', 'Shooting', 'Cours']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 540, 1140, array[0]::smallint[], 304, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'a', 'Maquillage jour', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'b', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'c', 'Maquillage carnaval', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'd', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'e', 'Maquillage mariée + essai', 120, 170);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g065', 'f', 'Maquillage shooting', 60, 75);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g070', 'Cils by Samantha', 'Samantha D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Sainte-Rose', 'Viard', array['cils']::text[], array['Cil à cil', 'Rehaussement', 'Volume russe']::text[], 'Spécialiste du regard, conseils d''entretien à chaque pose.', 570, 1140, array[0]::smallint[], 138, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'b', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'c', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'd', 'Brow lift', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g070', 'e', 'Restructuration sourcils', 30, 17);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g113', 'Nail Bar Goyave', null, 'Salon', array['Au salon']::text[], 'Port-Louis', 'Pelletan', array['ongles']::text[], array['Nail art', 'Beauté des pieds', 'French']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 480, 1110, array[0, 1]::smallint[], 70, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'a', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'b', 'Manucure express', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'c', 'Nail art 10 doigts', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'd', 'Pose capsules + gel', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'e', 'Semi-permanent mains', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g113', 'f', 'Remplissage gel', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g074', 'Glam by Gwladys', 'Gwladys G.', 'Indépendante', array['Chez elle']::text[], 'Sainte-Rose', 'La Boucan', array['maquillage']::text[], array['Invitée', 'Cours', 'Carnaval']::text[], 'Teint sur mesure pour toutes les carnations, tenue longue durée.', 540, 1080, array[]::smallint[], 63, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'a', 'Maquillage invitée', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'b', 'Maquillage shooting', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'c', 'Maquillage soirée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'd', 'Maquillage mariée + essai', 120, 135);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'e', 'Maquillage carnaval', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g074', 'f', 'Cours d''auto-maquillage', 90, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g063', 'Barber Grand Large', null, 'Salon', array['Au salon']::text[], 'Le Moule', 'Sergent', array['barbier']::text[], array['Dégradé', 'Barbe', 'Contours']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 510, 1050, array[0, 1]::smallint[], 296, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'a', 'Rasage traditionnel', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'b', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'c', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g063', 'd', 'Dégradé + contours', 30, 22);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g066', 'Les Ongles de Rachelle', 'Rachelle M.', 'Indépendante', array['À domicile']::text[], 'Le Moule', 'L''Autre Bord', array['ongles', 'cils']::text[], array['Baby boomer', 'Nail art', 'Semi-permanent']::text[], 'Reçoit dans un espace dédié, au calme, une cliente à la fois.', 510, 1110, array[]::smallint[], 324, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'a', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'b', 'Semi-permanent pieds', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'c', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'd', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'e', 'Teinture sourcils', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g066', 'f', 'Sourcils au fil', 30, 11);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g112', 'Locks Vanille', null, 'Salon', array['Au salon']::text[], 'Port-Louis', 'Beauport', array['tresses']::text[], array['Vanilles', 'Crochet braids', 'Enfants']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 570, 1080, array[0]::smallint[], 130, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'a', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'b', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'c', 'Fulani braids', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g112', 'd', 'Box braids mi-longues', 240, 125);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('ali', 'Coiffure Alizé', null, 'Salon', array['Au salon']::text[], 'Sainte-Rose', 'Bourg', array['coiffure', 'barbier']::text[], array['Mixte', 'Défrisage', 'Couleur']::text[], 'Le salon de quartier du bourg, hommes, femmes et enfants.', 510, 1080, array[0]::smallint[], 190, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'a', 'Coupe femme', 60, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'b', 'Brushing', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'c', 'Coupe homme', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'd', 'Défrisage + soin', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('ali', 'e', 'Couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g067', 'Lagon Nails', null, 'Salon', array['Au salon']::text[], 'Le Moule', 'L''Autre Bord', array['ongles']::text[], array['Capsules', 'Nail art', 'Semi-permanent']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 570, 1170, array[0, 1]::smallint[], 63, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'a', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'b', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'c', 'Semi-permanent mains', 45, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'd', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'e', 'Baby boomer', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g067', 'f', 'Nail art 10 doigts', 30, 14);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g111', 'Le Regard de Clarisse', 'Clarisse M.', 'Indépendante', array['À domicile']::text[], 'Port-Louis', 'Bourg', array['cils', 'ongles']::text[], array['Rehaussement', 'Volume russe', 'Sourcils au fil']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 570, 1170, array[]::smallint[], 20, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'a', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'b', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'c', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'd', 'Volume russe', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'e', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'f', 'Manucure express', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g111', 'g', 'Pose gel + couleur', 90, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g073', 'Locks Corossol', null, 'Salon', array['Au salon']::text[], 'Sainte-Rose', 'Bourg', array['tresses']::text[], array['Nattes collées', 'Crochet braids', 'Knotless']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 480, 1140, array[0, 1]::smallint[], 330, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'a', 'Nattes collées', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'b', 'Crochet braids', 150, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'c', 'Vanilles', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g073', 'd', 'Fulani braids', 180, 75);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g072', 'Hair Soufrière', null, 'Salon', array['Au salon']::text[], 'Sainte-Rose', 'La Boucan', array['coiffure']::text[], array['Défrisage', 'Lissage', 'Cheveux texturés']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 540, 1140, array[0]::smallint[], 177, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'a', 'Shampoing + brushing', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'b', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'c', 'Lissage brésilien', 180, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'd', 'Coloration', 90, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g072', 'e', 'Wash and go', 60, 34);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g076', 'Rébecca Make-up', 'Rébecca D.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Capesterre-Belle-Eau', 'Sainte-Marie', array['maquillage']::text[], array['Invitée', 'Mariée', 'Cours']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 480, 1110, array[0, 1]::smallint[], 240, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'a', 'Maquillage mariée + essai', 120, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'b', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'c', 'Maquillage jour', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'd', 'Cours d''auto-maquillage', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'e', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g076', 'f', 'Maquillage shooting', 60, 70);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g071', 'Jonathan le Barbier', 'Jonathan J.', 'Indépendant', array['À domicile']::text[], 'Sainte-Rose', 'Sofaïa', array['barbier']::text[], array['Rasage', 'Enfants', 'Contours']::text[], 'Coupe à la maison pour toute la famille, matériel désinfecté.', 540, 1140, array[]::smallint[], 93, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'a', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'b', 'Coupe + barbe', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'c', 'Coupe + soin', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'd', 'Coupe homme', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g071', 'e', 'Rasage traditionnel', 30, 22);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g069', 'Tresses by Priscilla', 'Priscilla S.', 'Indépendante', array['Chez elle']::text[], 'Sainte-Rose', 'Viard', array['tresses']::text[], array['Crochet braids', 'Box braids', 'Vanilles']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 570, 1170, array[0, 1]::smallint[], 32, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'a', 'Départ de locks', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'b', 'Pose de perruque', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'c', 'Fulani braids', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'd', 'Box braids mi-longues', 240, 110);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'e', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g069', 'f', 'Vanilles', 120, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g077', 'Institut Jasmin', null, 'Institut', array['À l''institut']::text[], 'Capesterre-Belle-Eau', 'Bananier', array['soins']::text[], array['Épilation', 'Soin éclat', 'Gommage']::text[], 'Un moment pour soi, à deux pas du bourg.', 480, 1140, array[0, 1]::smallint[], 98, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'b', 'Épilation maillot', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g077', 'd', 'Massage dos', 30, 39);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('glo', 'Glow Gwada', 'Kéliane P.', 'Indépendante', array['À domicile']::text[], 'Saint-François', 'Bourg', array['maquillage']::text[], array['Mariée', 'Soirée', 'Cours']::text[], 'Maquilleuse mariages et événements, se déplace dans toute la Grande-Terre.', 480, 1200, array[]::smallint[], 40, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'a', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'b', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'c', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('glo', 'd', 'Cours d''auto-maquillage', 90, 70);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g079', 'Les Boucles de Rachelle', 'Rachelle F.', 'Indépendante', array['Chez elle']::text[], 'Capesterre-Belle-Eau', 'Saint-Sauveur', array['coiffure', 'tresses']::text[], array['Boucles', 'Balayage', 'Coloration']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 540, 1110, array[]::smallint[], 136, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'a', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'b', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'c', 'Défrisage + soin', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'd', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'e', 'Pose de perruque', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g079', 'f', 'Box braids mi-longues', 240, 115);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g130', 'Cils by Léa', 'Léa M.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Anse-Bertrand', 'Bourg', array['cils']::text[], array['Sourcils au fil', 'Brow lift', 'Volume mixte']::text[], 'Reçoit dans une pièce dédiée, climatisée et au calme.', 510, 1050, array[]::smallint[], 168, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'a', 'Remplissage cils', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'b', 'Rehaussement + teinture', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'c', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g130', 'd', 'Teinture sourcils', 30, 15);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g129', 'Maïlys Make-up', 'Maïlys J.', 'Indépendante', array['À domicile']::text[], 'Anse-Bertrand', 'Campêche', array['maquillage']::text[], array['Invitée', 'Shooting', 'Soirée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 480, 1080, array[0]::smallint[], 238, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'a', 'Maquillage mariée + essai', 120, 155);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'b', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'c', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'd', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g129', 'e', 'Maquillage shooting', 60, 65);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g099', 'Les Nattes de Flora', 'Flora J.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Saint-François', 'Marina', array['tresses']::text[], array['Box braids', 'Enfants', 'Vanilles']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 570, 1110, array[0, 1]::smallint[], 313, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'a', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'b', 'Crochet braids', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'c', 'Knotless braids', 300, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'd', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'e', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g099', 'f', 'Pose de perruque', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g078', 'Tresses by Ingrid', 'Ingrid V.', 'Indépendante', array['À domicile']::text[], 'Capesterre-Belle-Eau', 'Bananier', array['tresses']::text[], array['Crochet braids', 'Enfants', 'Knotless']::text[], 'Tresseuse rapide et soignée, tresses régulières et pas trop serrées.', 540, 1110, array[]::smallint[], 108, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'a', 'Vanilles', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'b', 'Tresses enfant', 90, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'c', 'Box braids mi-longues', 240, 125);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g078', 'd', 'Fulani braids', 180, 95);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g098', 'Institut Péyi', null, 'Institut', array['À l''institut']::text[], 'Saint-François', 'Marina', array['soins']::text[], array['Massage', 'Soin éclat', 'Gommage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 510, 1050, array[0]::smallint[], 347, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'a', 'Soin visage éclat', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'b', 'Soin visage hydratant', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'c', 'Massage relaxant', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'd', 'Épilation aisselles', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g098', 'e', 'Épilation demi-jambes', 30, 19);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g075', 'Gwladys Braids', 'Gwladys F.', 'Indépendante', array['À domicile']::text[], 'Capesterre-Belle-Eau', 'Sainte-Marie', array['tresses']::text[], array['Enfants', 'Knotless', 'Box braids']::text[], 'Se déplace à domicile, mèches fournies sur demande en supplément.', 480, 1170, array[0]::smallint[], 217, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'a', 'Départ de locks', 180, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'b', 'Tresses enfant', 90, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'c', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'd', 'Vanilles', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'e', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g075', 'f', 'Nattes collées', 90, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g080', 'Coiffure by Vanessa', 'Vanessa C.', 'Indépendante', array['À domicile']::text[], 'Capesterre-Belle-Eau', 'Bananier', array['coiffure']::text[], array['Brushing', 'Cheveux texturés', 'Défrisage']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 540, 1050, array[0]::smallint[], 63, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'a', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'b', 'Shampoing + brushing', 60, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'c', 'Wash and go', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'd', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'e', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g080', 'f', 'Coupe + brushing', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g101', 'Flamboyant Beauté', null, 'Institut', array['À l''institut']::text[], 'Saint-François', 'Sainte-Marthe', array['soins', 'maquillage']::text[], array['Soin éclat', 'Gommage', 'Cire tiède']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 540, 1170, array[0]::smallint[], 20, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'a', 'Épilation jambes complètes', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'b', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'c', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'd', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'e', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'f', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g101', 'g', 'Maquillage jour', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g097', 'Goyave Barber Shop', null, 'Salon', array['Au salon']::text[], 'Saint-François', 'Bragelogne', array['barbier']::text[], array['Enfants', 'Sans rendez-vous', 'Contours']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 570, 1110, array[0, 1]::smallint[], 347, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'a', 'Coupe + barbe', 60, 24);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'b', 'Taille de barbe', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'c', 'Coupe homme', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'd', 'Coupe + soin', 60, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g097', 'e', 'Coupe enfant', 30, 11);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g100', 'Nadège Nails', 'Nadège L.', 'Indépendante', array['À domicile']::text[], 'Saint-François', 'Sainte-Marthe', array['ongles']::text[], array['Pose gel', 'Beauté des pieds', 'Semi-permanent']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 510, 1140, array[0, 1]::smallint[], 332, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'a', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'b', 'Remplissage gel', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'c', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g100', 'd', 'Baby boomer', 120, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g123', 'Kelly Esthétique', 'Kelly S.', 'Indépendante', array['Chez elle']::text[], 'Deshaies', 'Ferry', array['soins']::text[], array['Soin visage', 'Soin éclat', 'Gommage']::text[], 'Massages et soins du visage, table et matériel apportés chez toi.', 540, 1140, array[0]::smallint[], 148, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'a', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'b', 'Massage dos', 30, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'c', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'd', 'Épilation jambes complètes', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'e', 'Épilation demi-jambes', 30, 20);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g123', 'f', 'Épilation aisselles', 30, 11);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g124', 'Ti Kaz Beauty Studio', null, 'Salon', array['Au salon']::text[], 'Deshaies', 'Bourg', array['maquillage']::text[], array['Mariée', 'Shooting', 'Soirée']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 540, 1050, array[0, 1]::smallint[], 42, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'a', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'b', 'Maquillage carnaval', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'c', 'Maquillage invitée', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'd', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g124', 'e', 'Maquillage mariée + essai', 120, 150);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g133', 'Les Ongles de Vanessa', 'Vanessa R.', 'Indépendante', array['Chez elle']::text[], 'Grand-Bourg', 'Grande-Savane', array['ongles']::text[], array['French', 'Capsules', 'Beauté des pieds']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1140, array[0, 1]::smallint[], 348, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'a', 'Semi-permanent pieds', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'b', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'c', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'd', 'Pose gel + couleur', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g133', 'e', 'Baby boomer', 120, 55);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g134', 'Le Fauteuil Péyi', null, 'Salon', array['Au salon']::text[], 'Grand-Bourg', 'Grande-Savane', array['barbier']::text[], array['Sans rendez-vous', 'Contours', 'Dégradé']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 540, 1170, array[0]::smallint[], 28, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'a', 'Coupe + barbe', 60, 26);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'b', 'Taille de barbe', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'c', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'd', 'Dégradé + contours', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g134', 'e', 'Rasage traditionnel', 30, 21);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g126', 'L''Atelier Solèy', null, 'Salon', array['Au salon']::text[], 'Pointe-Noire', 'Bourg', array['coiffure']::text[], array['Cheveux texturés', 'Boucles', 'Coloration']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 570, 1170, array[0]::smallint[], 177, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'a', 'Coupe enfant', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'b', 'Shampoing + brushing', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'c', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'd', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'e', 'Lissage brésilien', 180, 175);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g126', 'f', 'Coiffure événement', 60, 60);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g125', 'Spa Ti Paradis', null, 'Institut', array['À l''institut']::text[], 'Pointe-Noire', 'Bourg', array['soins']::text[], array['Soin éclat', 'Gommage', 'Soin visage']::text[], 'Cabines climatisées, cire tiède et produits à base de plantes locales.', 570, 1170, array[0, 1]::smallint[], 233, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'a', 'Massage dos', 30, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'b', 'Épilation sourcils', 30, 10);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'c', 'Gommage corps', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'd', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'e', 'Épilation jambes complètes', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g125', 'f', 'Épilation aisselles', 30, 10);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g136', 'Glam by Sandy', 'Sandy J.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Saint-Louis', 'Bourg', array['maquillage']::text[], array['Cours', 'Shooting', 'Soirée']::text[], 'Maquilleuse professionnelle, mariages et événements dans toute l''île.', 570, 1050, array[0]::smallint[], 342, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'a', 'Maquillage mariée + essai', 120, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'b', 'Maquillage shooting', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'c', 'Cours d''auto-maquillage', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'd', 'Maquillage soirée', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'e', 'Maquillage jour', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g136', 'f', 'Maquillage invitée', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g117', 'Nails by Tessa', 'Tessa V.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Trois-Rivières', 'Schoelcher', array['ongles', 'cils']::text[], array['Capsules', 'Semi-permanent', 'Pose gel']::text[], 'Passionnée de nail art, elle reproduit le modèle que tu lui montres.', 480, 1140, array[0, 1]::smallint[], 326, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'a', 'Beauté des pieds complète', 60, 38);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'b', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'c', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'd', 'Semi-permanent pieds', 45, 30);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'e', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g117', 'f', 'Remplissage cils', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g119', 'Le Regard de Thaïs', 'Thaïs N.', 'Indépendante', array['Chez elle']::text[], 'Trois-Rivières', 'Grande-Anse', array['cils']::text[], array['Brow lift', 'Rehaussement', 'Volume mixte']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 510, 1110, array[0, 1]::smallint[], 227, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'a', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'b', 'Restructuration sourcils', 30, 18);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'c', 'Volume mixte', 150, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'd', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g119', 'e', 'Sourcils au fil', 30, 12);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g120', 'Hair Karambole', null, 'Salon', array['Au salon']::text[], 'Bouillante', 'Pigeon', array['coiffure', 'tresses']::text[], array['Mixte', 'Boucles', 'Défrisage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 510, 1050, array[0]::smallint[], 105, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'a', 'Coupe enfant', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'b', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'd', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'e', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'f', 'Box braids mi-longues', 240, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g120', 'g', 'Knotless braids', 300, 135);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g118', 'Rachelle Brows', 'Rachelle F.', 'Indépendante', array['Chez elle']::text[], 'Trois-Rivières', 'Bourg', array['cils']::text[], array['Brow lift', 'Cil à cil', 'Sourcils au fil']::text[], 'Technicienne cils certifiée, pose naturelle ou sophistiquée selon l''envie.', 510, 1140, array[0]::smallint[], 84, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'a', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'b', 'Sourcils au fil', 30, 12);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'c', 'Extensions cil à cil', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'd', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g118', 'e', 'Remplissage cils', 60, 45);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g121', 'Priscilla Coiffure', 'Priscilla C.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Bouillante', 'Bourg', array['coiffure']::text[], array['Lissage', 'Coloration', 'Cheveux texturés']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 540, 1050, array[0]::smallint[], 112, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'a', 'Coloration', 90, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'b', 'Soin profond + coiffage boucles', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'c', 'Shampoing + brushing', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'd', 'Coiffure événement', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'e', 'Mèches et balayage', 150, 100);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g121', 'f', 'Défrisage + soin', 120, 75);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g122', 'Le Fauteuil Frangipane', null, 'Salon', array['Au salon']::text[], 'Bouillante', 'Malendure', array['barbier']::text[], array['Enfants', 'Sans rendez-vous', 'Dégradé']::text[], 'Barbershop : dégradés nets, barbe taillée, bonne ambiance.', 570, 1140, array[0]::smallint[], 1, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'b', 'Rasage traditionnel', 30, 21);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'c', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'd', 'Coupe + soin', 60, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'e', 'Coupe homme', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g122', 'f', 'Coupe + barbe', 60, 26);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g140', 'Regard Maracudja', null, 'Institut', array['À l''institut']::text[], 'La Désirade', 'Beauséjour', array['cils', 'ongles']::text[], array['Sourcils au fil', 'Rehaussement', 'Volume mixte']::text[], 'Cabines individuelles, produits hypoallergéniques.', 480, 1170, array[0, 1]::smallint[], 57, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'a', 'Extensions cil à cil', 120, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'b', 'Rehaussement + teinture', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'c', 'Volume mixte', 150, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'd', 'Restructuration sourcils', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'e', 'Volume russe', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'f', 'Teinture sourcils', 30, 16);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'g', 'Remplissage gel', 60, 40);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g140', 'h', 'Nail art 10 doigts', 30, 16);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g115', 'Bougainvillée Beauté', null, 'Institut', array['À l''institut']::text[], 'Gourbeyre', 'Bourg', array['soins']::text[], array['Massage', 'Gommage', 'Épilation']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1050, array[0]::smallint[], 38, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'a', 'Massage dos', 30, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'b', 'Épilation maillot', 30, 19);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'd', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g115', 'e', 'Épilation demi-jambes', 30, 19);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g135', 'Make-up by Élodie', 'Élodie P.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Capesterre-de-Marie-Galante', 'Bourg', array['maquillage']::text[], array['Soirée', 'Invitée', 'Cours']::text[], 'Se déplace avec sa valise et sa lumière, essai possible avant le grand jour.', 570, 1050, array[0, 1]::smallint[], 340, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'a', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'b', 'Maquillage shooting', 60, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'c', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'd', 'Cours d''auto-maquillage', 90, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g135', 'e', 'Maquillage carnaval', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g114', 'Orchidée Braids', null, 'Salon', array['Au salon']::text[], 'Gourbeyre', 'Bourg', array['tresses']::text[], array['Box braids', 'Vanilles', 'Nattes collées']::text[], 'Deux tresseuses pour aller plus vite sur les longues coiffures.', 510, 1050, array[0]::smallint[], 314, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'a', 'Crochet braids', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'b', 'Vanilles', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'c', 'Tresses enfant', 90, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g114', 'd', 'Knotless braids', 300, 145);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g116', 'Karine Esthétique', 'Karine G.', 'Indépendante', array['Chez elle']::text[], 'Gourbeyre', 'Bourg', array['soins']::text[], array['Soin visage', 'Massage', 'Gommage']::text[], 'Esthéticienne diplômée, soins et épilation à domicile.', 570, 1050, array[0]::smallint[], 175, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'a', 'Massage relaxant', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'b', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'c', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g116', 'd', 'Épilation sourcils', 30, 11);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g127', 'Ti Zong a Joanie', 'Joanie F.', 'Indépendante', array['À domicile']::text[], 'Vieux-Habitants', 'Marigot', array['ongles', 'cils']::text[], array['Baby boomer', 'Pose gel', 'Capsules']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1110, array[0, 1]::smallint[], 232, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'a', 'Baby boomer', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'b', 'Nail art 10 doigts', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'c', 'Pose gel + couleur', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'd', 'Semi-permanent pieds', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'e', 'Semi-permanent mains', 45, 28);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'f', 'Dépose', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'g', 'Teinture sourcils', 30, 15);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g127', 'h', 'Restructuration sourcils', 30, 18);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('loc', 'Locks & Nature', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Centre', array['tresses']::text[], array['Locks', 'Soins naturels']::text[], 'Entretien et création de locks, soins à base de plantes locales.', 540, 1080, array[0, 1]::smallint[], 95, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'a', 'Retwist', 90, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'b', 'Entretien locks + soin', 120, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'c', 'Départ de locks', 180, 85);
insert into services (pro_id, code, name, duration_min, price_eur) values ('loc', 'd', 'Coiffage locks', 60, 35);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g083', 'Hair Alizés', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Petit-Paris', array['coiffure', 'tresses']::text[], array['Boucles', 'Mixte', 'Cheveux texturés']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1170, array[0, 1]::smallint[], 217, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'a', 'Shampoing + brushing', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'b', 'Lissage brésilien', 180, 180);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'c', 'Défrisage + soin', 120, 80);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'd', 'Mèches et balayage', 150, 105);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'e', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'f', 'Wash and go', 60, 39);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'g', 'Retwist locks', 90, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g083', 'h', 'Fulani braids', 180, 95);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g128', 'Les Ongles de Karine', 'Karine R.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Vieux-Habitants', 'Géry', array['ongles', 'cils']::text[], array['Semi-permanent', 'Capsules', 'Beauté des pieds']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 510, 1110, array[0]::smallint[], 204, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'a', 'Semi-permanent pieds', 45, 29);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'b', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'c', 'Beauté des pieds complète', 60, 36);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'd', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'e', 'Semi-permanent mains', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'f', 'Volume mixte', 150, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g128', 'g', 'Remplissage cils', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g085', 'Barber by Jordan', 'Jordan L.', 'Indépendant', array['À domicile']::text[], 'Basse-Terre', 'Rivière-des-Pères', array['barbier']::text[], array['Contours', 'Barbe', 'Enfants']::text[], 'Barbier à domicile, précis sur les dégradés et les contours.', 570, 1170, array[0]::smallint[], 269, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'a', 'Taille de barbe', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'b', 'Dégradé + contours', 30, 22);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'c', 'Coupe + soin', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'd', 'Coupe enfant', 30, 13);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g085', 'e', 'Rasage traditionnel', 30, 22);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g102', 'Nail Bar Ti Paradis', null, 'Salon', array['Au salon']::text[], 'Saint-Claude', 'Bourg', array['ongles']::text[], array['Semi-permanent', 'Nail art', 'Capsules']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 510, 1140, array[0, 1]::smallint[], 243, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'a', 'Semi-permanent pieds', 45, 27);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'b', 'Pose capsules + gel', 120, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'c', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g102', 'd', 'Semi-permanent mains', 45, 25);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g082', 'Natural Colibri Bleu', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Centre', array['tresses']::text[], array['Enfants', 'Knotless', 'Crochet braids']::text[], 'Salon dédié aux tresses et aux locks, mèches disponibles sur place.', 570, 1170, array[0, 1]::smallint[], 290, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'a', 'Fulani braids', 180, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'b', 'Knotless braids', 300, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'c', 'Tresses enfant', 90, 37);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'd', 'Nattes collées', 90, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g082', 'e', 'Box braids mi-longues', 240, 115);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g138', 'Ti Zong a Yoline', 'Yoline S.', 'Indépendante', array['À domicile']::text[], 'Terre-de-Haut', 'Marigot', array['ongles']::text[], array['Capsules', 'Nail art', 'Baby boomer']::text[], 'Prothésiste ongulaire diplômée, travail soigné et pose qui tient.', 570, 1080, array[0]::smallint[], 195, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'a', 'Nail art 10 doigts', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'b', 'Remplissage gel', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'c', 'Dépose', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'd', 'Baby boomer', 120, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g138', 'e', 'Manucure express', 30, 20);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g131', 'Flamboyant Coiffure', null, 'Salon', array['Au salon']::text[], 'Baillif', 'Bourg', array['coiffure']::text[], array['Coloration', 'Brushing', 'Défrisage']::text[], 'Salon mixte, conseils personnalisés et produits adaptés à tous les types de cheveux.', 540, 1110, array[0, 1]::smallint[], 68, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'a', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'b', 'Défrisage + soin', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'c', 'Lissage brésilien', 180, 150);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'd', 'Coiffure événement', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g131', 'e', 'Wash and go', 60, 32);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g086', 'Hair Corail', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Rivière-des-Pères', array['coiffure']::text[], array['Mixte', 'Lissage', 'Défrisage']::text[], 'Équipe de trois coiffeuses, spécialiste couleur et soins profonds.', 510, 1080, array[0]::smallint[], 88, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'a', 'Soin profond + coiffage boucles', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'b', 'Shampoing + brushing', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'c', 'Coloration', 90, 75);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g086', 'd', 'Défrisage + soin', 120, 80);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g137', 'Tamarin Beauty Studio', null, 'Salon', array['Au salon']::text[], 'Vieux-Fort', 'Bourg', array['maquillage']::text[], array['Mariée', 'Cours', 'Invitée']::text[], 'Studio maquillage et mise en beauté pour tous les événements.', 480, 1140, array[0, 1]::smallint[], 133, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'a', 'Maquillage shooting', 60, 70);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'b', 'Maquillage soirée', 60, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'c', 'Maquillage invitée', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g137', 'd', 'Maquillage carnaval', 60, 50);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g132', 'Cynthia Hair', 'Cynthia P.', 'Indépendante', array['Chez elle', 'À domicile']::text[], 'Baillif', 'Bourg', array['coiffure']::text[], array['Défrisage', 'Lissage', 'Mixte']::text[], 'Coiffe à la maison pour les familles, enfants compris.', 540, 1170, array[0, 1]::smallint[], 205, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'a', 'Coiffure événement', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'b', 'Wash and go', 60, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'c', 'Coloration', 90, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'd', 'Coupe + brushing', 60, 45);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'e', 'Mèches et balayage', 150, 90);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g132', 'f', 'Soin profond + coiffage boucles', 60, 40);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g084', 'Onglerie Kannèl', null, 'Salon', array['Au salon']::text[], 'Basse-Terre', 'Centre', array['ongles']::text[], array['French', 'Pose gel', 'Semi-permanent']::text[], 'Bar à ongles avec plusieurs postes, sans attente sur rendez-vous.', 540, 1110, array[0, 1]::smallint[], 246, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'a', 'Semi-permanent mains', 45, 31);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'b', 'Semi-permanent pieds', 45, 33);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'c', 'Pose capsules + gel', 120, 65);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g084', 'd', 'Nail art 10 doigts', 30, 17);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g081', 'Flora Coiffure', 'Flora J.', 'Indépendante', array['À domicile']::text[], 'Basse-Terre', 'Centre', array['coiffure']::text[], array['Balayage', 'Mixte', 'Cheveux texturés']::text[], 'Spécialiste des cheveux naturels et des boucles, soins sur mesure.', 480, 1050, array[0]::smallint[], 118, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'a', 'Wash and go', 60, 34);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'b', 'Mèches et balayage', 150, 95);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'c', 'Lissage brésilien', 180, 160);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g081', 'd', 'Défrisage + soin', 120, 70);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g139', 'Institut Anoli', null, 'Institut', array['À l''institut']::text[], 'Terre-de-Bas', 'Petites-Anses', array['soins']::text[], array['Soin visage', 'Épilation', 'Massage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 480, 1140, array[0, 1]::smallint[], 237, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'a', 'Soin visage hydratant', 60, 55);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'b', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'c', 'Gommage corps', 60, 50);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'd', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g139', 'e', 'Massage dos', 30, 38);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g103', 'Grand Large Beauté', null, 'Institut', array['À l''institut']::text[], 'Saint-Claude', 'Matouba', array['soins']::text[], array['Massage', 'Soin visage', 'Gommage']::text[], 'Institut de beauté : soins du visage, du corps et épilation.', 570, 1140, array[0, 1]::smallint[], 167, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'a', 'Soin visage éclat', 60, 60);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'b', 'Épilation jambes complètes', 60, 32);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'c', 'Épilation aisselles', 30, 11);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g103', 'd', 'Massage dos', 30, 37);

insert into pros (id, name, owner_name, kind, places, commune, quartier, categories, tags, about, opens_at, closes_at, closed_weekdays, hue, is_demo) values ('g104', 'L''Atelier des Ongles Alizés', null, 'Salon', array['Au salon']::text[], 'Saint-Claude', 'Bourg', array['ongles']::text[], array['Semi-permanent', 'Pose gel', 'Capsules']::text[], 'Onglerie de quartier, hygiène stricte et large choix de couleurs.', 540, 1170, array[0]::smallint[], 352, true);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'a', 'Nail art 10 doigts', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'b', 'Beauté des pieds complète', 60, 35);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'c', 'Manucure express', 30, 17);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'd', 'Dépose', 30, 14);
insert into services (pro_id, code, name, duration_min, price_eur) values ('g104', 'e', 'Semi-permanent pieds', 45, 28);
