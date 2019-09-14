drop database if exists tennisclub;
create database tennisclub;

use tennisclub;

-- create tables

create table player (player_id int primary key auto_increment, player_name varcharacter(32));

create table team (team_id int primary key auto_increment, team_name varcharacter(32), captain int, foreign key (captain) references player (player_id) on update cascade on delete set null);
-- Should the players' primary keys change, that doesn't affect the team-captain connection.
-- If a captain quits, the team is left without a captain. 

-- later: proper on-update-delete restrictions.

create table competition (comp_id int primary key auto_increment,
comp_designation varcharacter(32),
team_id int,
comp_opponent varcharacter(32),
games int,
foreign key (team_id) references team (team_id));


create table game (game_id int primary key auto_increment,
player_id int,
game_opponent varcharacter(32),
comp_id int,
sets int,
sets_won int,
sets_lost int,
foreign key (player_id) references player (player_id),
foreign key (comp_id) references competition (comp_id) );


insert into player (player_name) values ('Anaé');
insert into player (player_name) values ('Mégane');
insert into player (player_name) values ('Jú');
insert into player (player_name) values ('Gaétane');
insert into player (player_name) values ('Gösta');
insert into player (player_name) values ('Réjane');
insert into player (player_name) values ('Sòng');
insert into player (player_name) values ('Lucrèce');
insert into player (player_name) values ('Intéressant');
insert into player (player_name) values ('Alizée');
insert into player (player_name) values ('Publicité');
insert into player (player_name) values ('Clémentine');
insert into player (player_name) values ('Faîtes');
insert into player (player_name) values ('Cléopatre');
insert into player (player_name) values ('Léandre');
insert into player (player_name) values ('Nélie');
insert into player (player_name) values ('Loïs');
insert into player (player_name) values ('Personnalisée');
insert into player (player_name) values ('Estève');
insert into player (player_name) values ('Andréanne');
insert into player (player_name) values ('Östen');
insert into player (player_name) values ('Angèle');
insert into player (player_name) values ('Naëlle');
insert into player (player_name) values ('Irène');
insert into player (player_name) values ('Almérinda');
insert into player (player_name) values ('Mélys');
insert into player (player_name) values ('Léandre');
insert into player (player_name) values ('Lèi');
insert into player (player_name) values ('Séverine');
insert into player (player_name) values ('Agnès');
insert into player (player_name) values ('Chloé');
insert into player (player_name) values ('Loïs');
insert into player (player_name) values ('Illustrée');
insert into player (player_name) values ('Géraldine');
insert into player (player_name) values ('Mårten');
insert into player (player_name) values ('Marie-thérèse');
insert into player (player_name) values ('Séréna');
insert into player (player_name) values ('Cécile');
insert into player (player_name) values ('Magdalène');
insert into player (player_name) values ('Loïc');
insert into player (player_name) values ('Loïc');
insert into player (player_name) values ('Laurène');
insert into player (player_name) values ('Marie-françoise');
insert into player (player_name) values ('Liè');
insert into player (player_name) values ('Gaïa');
insert into player (player_name) values ('Bérénice');
insert into player (player_name) values ('Aurélie');
insert into player (player_name) values ('Yóu');
insert into player (player_name) values ('Joséphine');
insert into player (player_name) values ('Marie-josée');
insert into player (player_name) values ('Uò');
insert into player (player_name) values ('Jú');
insert into player (player_name) values ('Clélia');
insert into player (player_name) values ('Sélène');
insert into player (player_name) values ('Marie-noël');
insert into player (player_name) values ('Angèle');
insert into player (player_name) values ('Maëlann');
insert into player (player_name) values ('Intéressant');
insert into player (player_name) values ('Göran');
insert into player (player_name) values ('Céline');
insert into player (player_name) values ('Ráo');
insert into player (player_name) values ('Bérénice');
insert into player (player_name) values ('Aimée');
insert into player (player_name) values ('Danièle');
insert into player (player_name) values ('Maïté');
insert into player (player_name) values ('Rachèle');
insert into player (player_name) values ('Sélène');
insert into player (player_name) values ('Erwéi');
insert into player (player_name) values ('Estève');
insert into player (player_name) values ('Dà');
insert into player (player_name) values ('Tú');
insert into player (player_name) values ('Eugénie');
insert into player (player_name) values ('Lén');
insert into player (player_name) values ('Táng');
insert into player (player_name) values ('Dorothée');
insert into player (player_name) values ('Maëlyss');
insert into player (player_name) values ('Nélie');
insert into player (player_name) values ('Françoise');
insert into player (player_name) values ('Styrbjörn');
insert into player (player_name) values ('Torbjörn');
insert into player (player_name) values ('Ráo');
insert into player (player_name) values ('Andrée');
insert into player (player_name) values ('Dù');
insert into player (player_name) values ('Solène');
insert into player (player_name) values ('Angèle');
insert into player (player_name) values ('Léana');
insert into player (player_name) values ('Maëlann');
insert into player (player_name) values ('Anaëlle');
insert into player (player_name) values ('Yóu');
insert into player (player_name) values ('Kù');
insert into player (player_name) values ('Nadège');
insert into player (player_name) values ('Börje');
insert into player (player_name) values ('Geneviève');
insert into player (player_name) values ('Mélia');
insert into player (player_name) values ('Célestine');
insert into player (player_name) values ('Eléa');
insert into player (player_name) values ('Åke');
insert into player (player_name) values ('Cunégonde');
insert into player (player_name) values ('Gaïa');
insert into player (player_name) values ('Nuó');
insert into player (player_name) values ('Océane');
insert into player (player_name) values ('Gérald');
insert into player (player_name) values ('Cléa');
insert into player (player_name) values ('Göran');
insert into player (player_name) values ('Yáo');
insert into player (player_name) values ('Yú');
insert into player (player_name) values ('Maëlys');
insert into player (player_name) values ('Marie-hélène');
insert into player (player_name) values ('Célia');
insert into player (player_name) values ('Médiamass');
insert into player (player_name) values ('Personnalisée');
insert into player (player_name) values ('Aloïs');
insert into player (player_name) values ('Gaëlle');
insert into player (player_name) values ('Publicité');
insert into player (player_name) values ('Néhémie');
insert into player (player_name) values ('Geneviève');
insert into player (player_name) values ('Thérèse');
insert into player (player_name) values ('Danièle');
insert into player (player_name) values ('Cléa');
insert into player (player_name) values ('Clémentine');
insert into player (player_name) values ('Andrée');
insert into player (player_name) values ('Maïwenn');
insert into player (player_name) values ('Cléa');
insert into player (player_name) values ('Géraldine');
insert into player (player_name) values ('Eloïse');
insert into player (player_name) values ('Yénora');
insert into player (player_name) values ('Mélinda');
insert into player (player_name) values ('Véronique');
insert into player (player_name) values ('Geneviève');
insert into player (player_name) values ('Kuí');
insert into player (player_name) values ('Félicie');
insert into player (player_name) values ('Anaël');
insert into player (player_name) values ('Miléna');
insert into player (player_name) values ('Cunégonde');
insert into player (player_name) values ('Åslög');
insert into player (player_name) values ('Océanne');
insert into player (player_name) values ('Dorothée');
insert into player (player_name) values ('Cécile');
insert into player (player_name) values ('Östen');
insert into player (player_name) values ('Publicité');
insert into player (player_name) values ('Célia');
insert into player (player_name) values ('Vérane');
insert into player (player_name) values ('Uò');
insert into player (player_name) values ('Adélie');
insert into player (player_name) values ('Maëly');
insert into player (player_name) values ('Mén');
insert into player (player_name) values ('Célestine');
insert into player (player_name) values ('Börje');
insert into player (player_name) values ('Mélodie');
insert into player (player_name) values ('Lorène');
insert into player (player_name) values ('Médiamass');
insert into player (player_name) values ('Pål');
insert into player (player_name) values ('Anaïs');
insert into player (player_name) values ('Angélique');
insert into player (player_name) values ('Réjane');
insert into player (player_name) values ('Andréa');
insert into player (player_name) values ('Véronique');
insert into player (player_name) values ('Adélaïde');
insert into player (player_name) values ('Marie-hélène');
insert into player (player_name) values ('Nélie');
insert into player (player_name) values ('Lén');
insert into player (player_name) values ('Jú');
insert into player (player_name) values ('Céline');
insert into player (player_name) values ('Tán');
insert into player (player_name) values ('Marie-ève');
insert into player (player_name) values ('Danièle');
insert into player (player_name) values ('Félicie');
insert into player (player_name) values ('Célia');
insert into player (player_name) values ('Tú');
insert into player (player_name) values ('Réservés');
insert into player (player_name) values ('Kù');
insert into player (player_name) values ('Géraldine');
insert into player (player_name) values ('Cloé');
insert into player (player_name) values ('Océanne');
insert into player (player_name) values ('Mélanie');
insert into player (player_name) values ('Intéressant');
insert into player (player_name) values ('Maïté');
insert into player (player_name) values ('Lài');
insert into player (player_name) values ('Léane');
insert into player (player_name) values ('Eloïse');
insert into player (player_name) values ('Renée');
insert into player (player_name) values ('André');
insert into player (player_name) values ('Yénora');
insert into player (player_name) values ('Estève');
insert into player (player_name) values ('Léone');
insert into player (player_name) values ('Vérane');
insert into player (player_name) values ('Cléa');
insert into player (player_name) values ('Cunégonde');
insert into player (player_name) values ('Lèi');
insert into player (player_name) values ('Esbjörn');
insert into player (player_name) values ('Naéva');
insert into player (player_name) values ('Cinéma');
insert into player (player_name) values ('Lucrèce');
insert into player (player_name) values ('Estève');
insert into player (player_name) values ('Jú');
insert into player (player_name) values ('Solène');
insert into player (player_name) values ('Publicité');
insert into player (player_name) values ('Dorothée');
insert into player (player_name) values ('Tú');
insert into player (player_name) values ('Gisèle');
insert into player (player_name) values ('Fèi');
insert into player (player_name) values ('Cloé');
insert into player (player_name) values ('Kallisté');
insert into player (player_name) values ('Östen');
insert into player (player_name) values ('Aí');
insert into player (player_name) values ('Bérangère');
insert into player (player_name) values ('Mårten');
insert into player (player_name) values ('Clémence');
insert into player (player_name) values ('Alizée');
insert into player (player_name) values ('Frédérique');
insert into player (player_name) values ('Thérèse');
insert into player (player_name) values ('Maëly');
insert into player (player_name) values ('Annotée');
insert into player (player_name) values ('Loïca');
insert into player (player_name) values ('Anaëlle');
insert into player (player_name) values ('Edmée');
insert into player (player_name) values ('Marylène');
insert into player (player_name) values ('Maëlann');
insert into player (player_name) values ('Géraldine');
insert into player (player_name) values ('Méthode');
insert into player (player_name) values ('Maëlyss');
insert into player (player_name) values ('Hélèna');
insert into player (player_name) values ('Marie-françoise');
insert into player (player_name) values ('Intéressant');
insert into player (player_name) values ('Fèi');
insert into player (player_name) values ('Léonie');
insert into player (player_name) values ('Audréanne');
insert into player (player_name) values ('Michèle');
insert into player (player_name) values ('Mélys');
insert into player (player_name) values ('Garçon');
insert into player (player_name) values ('Alizée');
insert into player (player_name) values ('Thérèsa');
insert into player (player_name) values ('Méthode');
insert into player (player_name) values ('Pélagie');
insert into player (player_name) values ('Yóu');
insert into player (player_name) values ('Yénora');
insert into player (player_name) values ('Léandre');
insert into player (player_name) values ('Illustrée');
insert into player (player_name) values ('Océanne');
insert into player (player_name) values ('Cunégonde');
insert into player (player_name) values ('Anaïs');
insert into player (player_name) values ('Nélie');
insert into player (player_name) values ('Maëly');
insert into player (player_name) values ('Eliès');
insert into player (player_name) values ('Pélagie');
insert into player (player_name) values ('Tán');
insert into player (player_name) values ('Nuó');
insert into player (player_name) values ('Crééz');
insert into player (player_name) values ('Anaé');
insert into player (player_name) values ('Méng');

-- select * from player;

insert into team (team_name, captain) values ('Magpie, black-backed', 230);
insert into team (team_name, captain) values ('Beaver, american', 63);
insert into team (team_name, captain) values ('Langur, gray', 92);
insert into team (team_name, captain) values ('Grenadier, purple', 153);
insert into team (team_name, captain) values ('Swan, black', 100);
insert into team (team_name, captain) values ('Hartebeest, red', 129);
insert into team (team_name, captain) values ('Sidewinder', 80);
insert into team (team_name, captain) values ('Baboon, chacma', 66);
insert into team (team_name, captain) values ('Arctic hare', 2);
insert into team (team_name, captain) values ('Flicker, field', 92);
insert into team (team_name, captain) values ('Phascogale, brush-tailed', 161);
insert into team (team_name, captain) values ('Monkey, rhesus', 201);
insert into team (team_name, captain) values ('Parakeet, rose-ringed', 85);
insert into team (team_name, captain) values ('Great kiskadee', 41);
insert into team (team_name, captain) values ('Black-tailed deer', 101);
insert into team (team_name, captain) values ('Grenadier, purple', 144);
insert into team (team_name, captain) values ('Squirrel, indian giant', 207);
insert into team (team_name, captain) values ('Levaillant''s barbet', 70);
insert into team (team_name, captain) values ('Wild water buffalo', 163);
insert into team (team_name, captain) values ('Lion, steller''s sea', 156);

-- select * from team;

-- select team_name, player_name as captain from player join team on player.player_id = team.captain;

insert into competition (comp_designation, comp_opponent, team_id, games) values ('Greece', 'Prickly Bog Sedge', 7, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Portugal', 'Dacite Manzanita', 11, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Bahia', 6, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Philippines', 'Heartleaf Twistflower', 5, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Pakistan', 'Gold Coast Jasmine', 17, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Indonesia', 'Tolmie''s Penstemon', 5, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Mexico', 'Smallanthus', 11, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Uganda', 'Tulare Gooseberry', 13, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Kazakhstan', 'Arabian Coffee', 19, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Uzbekistan', 'Sobralia', 12, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Malta', 'Othake', 13, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Greece', 'Gray Globemallow', 15, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Palmer''s Monkeyflower', 2, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('France', 'Orange Lichen', 2, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Sticky Monkeyflower', 9, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Russia', 'Shrubby Lespedeza', 3, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Tajikistan', 'Glandular False Calico', 3, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Yellow Prickle', 17, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Fewflower Meadow-rue', 15, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Hoffmann''s Buckwheat', 18, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Luxembourg', 'Longbeard Mariposa Lily', 6, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Jackfruit', 17, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Serbia', 'Oahu False Ohelo', 5, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Croatia', 'Sticky Cinquefoil', 3, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Indonesia', 'Alliaria', 2, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Belarus', 'Peters'' Blackthread Lichen', 13, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Canada', 'Brachythecium Moss', 17, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Cracked Lichen', 19, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('New Zealand', 'Lodgepole Lupine', 10, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Philippines', 'Dicranum Moss', 7, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Thailand', 'Isopterygium Moss', 20, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Russia', 'Klamath Erigeron', 10, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Narrowleaf Bedstraw', 15, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('China', 'Hammitt''s Claycress', 6, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Japan', 'Broom', 6, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Brazil', 'Thinleaf Alder', 3, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Brazil', 'Neoparrya', 19, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Vietnam', 'Tepary Bean', 11, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Philippines', 'Boxelder', 1, 10);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Croatia', 'Utah Agave', 3, 10);

-- select team_name, comp_designation, comp_opponent, games from competition join team using (team_id);

-- select * from player;

Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (157, 'Lecordier', 1, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (217, 'Peal', 2, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (10, 'Vuittet', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (184, 'Byars', 4, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (176, 'Kenewell', 5, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (115, 'Guilloneau', 6, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (96, 'Eschelle', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (75, 'Lesper', 8, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (122, 'Galer', 9, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (237, 'Hatliffe', 10, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (21, 'Horsey', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (147, 'Folks', 2, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (144, 'Gallant', 3, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (158, 'Shipp', 4, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (223, 'Ladley', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (91, 'Vannini', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (150, 'Grimley', 7, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (98, 'Taft', 8, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (110, 'Eustes', 9, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (155, 'Lambourn', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (105, 'Barritt', 1, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (160, 'Hartburn', 2, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (80, 'Wenden', 3, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (119, 'Faloon', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (1, 'Riha', 5, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (198, 'Tocknell', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (234, 'Bickley', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (34, 'Cutmere', 8, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (52, 'Otteridge', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (109, 'Gateshill', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (230, 'Ferfulle', 1, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (237, 'Bugbird', 2, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (73, 'Purcer', 3, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (203, 'Le Frank', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (8, 'Smeeth', 5, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (33, 'Wrate', 6, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (101, 'Pinckney', 7, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (59, 'Anglin', 8, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (233, 'Detoc', 9, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (154, 'Shortall', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (76, 'Matchitt', 1, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (3, 'Schulter', 2, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (148, 'Tern', 3, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (199, 'Fatharly', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (166, 'Saffe', 5, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (51, 'Dykes', 6, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (22, 'Welbeck', 7, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (155, 'MacHostie', 8, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (249, 'Mahy', 9, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (96, 'Baike', 10, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (154, 'Quinton', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (63, 'Van Oort', 2, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (181, 'Binham', 3, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (134, 'Haily', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (47, 'MacVagh', 5, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (215, 'Hasty', 6, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (58, 'Culham', 7, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (211, 'Wardall', 8, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (95, 'Matasov', 9, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (78, 'Gaize', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (108, 'Sawkin', 1, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (94, 'Lanning', 2, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (175, 'Mousdall', 3, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (89, 'Culshew', 4, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (111, 'Cohn', 5, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (64, 'Butterwick', 6, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (136, 'Rosendahl', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (174, 'Drillingcourt', 8, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (4, 'Everall', 9, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (228, 'Clever', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (57, 'Gruby', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (142, 'Serjeantson', 2, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (5, 'Joska', 3, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (52, 'Humberstone', 4, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (144, 'Kellington', 5, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (94, 'Westbury', 6, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (114, 'Ashburne', 7, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (157, 'Wessel', 8, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (10, 'Cardenas', 9, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (93, 'Briance', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (225, 'Stolte', 1, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (110, 'Everall', 2, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (151, 'Friberg', 3, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (16, 'Blakemore', 4, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (232, 'Colegate', 5, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (76, 'McGurn', 6, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (215, 'Sarah', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (148, 'Frunks', 8, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (165, 'Gretton', 9, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (248, 'Nayshe', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (228, 'Lentsch', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (121, 'Zorro', 2, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (224, 'Dunbleton', 3, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (245, 'Cosslett', 4, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (173, 'Caldero', 5, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (120, 'Degoy', 6, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (53, 'Verrier', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (184, 'Strettle', 8, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (196, 'Armiger', 9, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (36, 'Eaken', 10, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (244, 'Maggill\'Andreis', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (200, 'Fenne', 2, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (55, 'Ghione', 3, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (229, 'Buglar', 4, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (23, 'Redmayne', 5, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (238, 'Gosker', 6, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (173, 'Hundley', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (175, 'Durtnel', 8, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (233, 'Cumbes', 9, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (61, 'Rabbitts', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (210, 'Zanuciolii', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (226, 'Sparhawk', 2, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (219, 'Schimek', 3, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (195, 'Hugonnet', 4, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (12, 'Dockrell', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (237, 'Bibby', 6, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (193, 'O\'Gorman', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (78, 'Haws', 8, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (160, 'Tape', 9, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (234, 'Malter', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (102, 'Renton', 1, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (123, 'Gillani', 2, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (93, 'Hayzer', 3, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (93, 'Derye-Barrett', 4, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (199, 'Backler', 5, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (10, 'Hartop', 6, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (86, 'Cominetti', 7, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (246, 'Ennever', 8, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (152, 'Matus', 9, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (190, 'Lanchbery', 10, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (165, 'Queripel', 1, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (149, 'Switland', 2, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (9, 'Kidde', 3, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (176, 'Koppeck', 4, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (119, 'Dorin', 5, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (141, 'Tafani', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (2, 'Gorelli', 7, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (45, 'Lanfranconi', 8, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (152, 'Leving', 9, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (213, 'Oloshkin', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (167, 'Fathers', 1, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (98, 'Corner', 2, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (154, 'Frankema', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (44, 'Sannes', 4, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (179, 'Stanbrooke', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (158, 'Treweela', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (2, 'Hinckes', 7, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (127, 'Imort', 8, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (213, 'Crumly', 9, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (91, 'Brasseur', 10, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (224, 'Swaisland', 1, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (74, 'Cressar', 2, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (175, 'Rablan', 3, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Ferencowicz', 4, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (143, 'Satch', 5, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (59, 'Durbridge', 6, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (89, 'Risborough', 7, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (1, 'Poytheras', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (163, 'Cristofor', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (28, 'Astall', 10, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (81, 'Spurdens', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (193, 'Hambling', 2, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (187, 'Morrilly', 3, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (182, 'Whitwam', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (94, 'Heibl', 5, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (122, 'Yarrell', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (74, 'Yukhtin', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (109, 'Sheppey', 8, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (19, 'Flieger', 9, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (224, 'Wales', 10, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (135, 'Sansun', 1, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (248, 'Wearne', 2, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (129, 'Codrington', 3, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (196, 'Servis', 4, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (240, 'Maffione', 5, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (169, 'Blois', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (25, 'Hawke', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (67, 'Klees', 8, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Foster', 9, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (3, 'Sybe', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (215, 'Vizor', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (76, 'Vernall', 2, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (123, 'Pagram', 3, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (100, 'Reckus', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (38, 'Allden', 5, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (97, 'Gallegos', 6, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (61, 'Fucher', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (165, 'Headey', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (213, 'Diglin', 9, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (103, 'Edgworth', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (175, 'Gosnall', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (109, 'Seer', 2, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (174, 'Simione', 3, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (75, 'Mc Corley', 4, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (125, 'Cobbold', 5, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (211, 'Bartusek', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (129, 'Elliss', 7, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (138, 'Sowersby', 8, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (138, 'Behling', 9, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (214, 'Truder', 10, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (14, 'Cobbledick', 1, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (86, 'Webling', 2, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (110, 'Gathercoal', 3, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (222, 'Le Guin', 4, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (163, 'Rigbye', 5, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Virgoe', 6, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (62, 'Durie', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (159, 'Perfect', 8, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (144, 'Punchard', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (69, 'Hegdonne', 10, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (55, 'Clears', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (110, 'Fairfoul', 2, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (155, 'Davoren', 3, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (171, 'Gorusso', 4, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (75, 'Ollin', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (92, 'Foulks', 6, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (190, 'Sinnock', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (150, 'Elcox', 8, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (206, 'Mcasparan', 9, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (46, 'Sueter', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (116, 'Lissaman', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (45, 'Huburn', 2, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (131, 'Cleghorn', 3, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (41, 'Dutch', 4, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (223, 'Broseke', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (9, 'Claiton', 6, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (138, 'Alltimes', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (53, 'McCook', 8, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (132, 'Mahaddy', 9, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (179, 'Lowson', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (151, 'Pervew', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (96, 'Cyples', 2, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (127, 'Bakeup', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (91, 'Francescoccio', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (32, 'Beebee', 5, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (2, 'Osipenko', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (48, 'Wheater', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (41, 'Castles', 8, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (123, 'Harome', 9, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (93, 'Garlicke', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (221, 'Mitchenson', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (14, 'Samsin', 2, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (121, 'Ulrik', 3, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (108, 'Brear', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (120, 'Muspratt', 5, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (212, 'L\'argent', 6, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (71, 'De Ruggero', 7, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (143, 'Mackett', 8, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (103, 'Sterrie', 9, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (241, 'Witherop', 10, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (218, 'Dendle', 1, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (94, 'McVane', 2, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (108, 'Wigglesworth', 3, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (7, 'Martyn', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (173, 'Tredwell', 5, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (76, 'Grigorey', 6, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (87, 'Kopf', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (233, 'Ciotti', 8, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (157, 'Saltrese', 9, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (118, 'Szwarc', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (189, 'Eymer', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (3, 'Lukacs', 2, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (171, 'Whaymand', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (162, 'Crayke', 4, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (22, 'Jaggar', 5, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (172, 'Juett', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (42, 'Gatman', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (230, 'Charte', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (164, 'Prandin', 9, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (181, 'Cornner', 10, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (162, 'Nafziger', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (92, 'Raun', 2, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (183, 'Vowels', 3, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (117, 'Emmines', 4, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (173, 'Bispham', 5, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (200, 'Pattillo', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (131, 'Segot', 7, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (108, 'Idel', 8, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (159, 'Joanaud', 9, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (57, 'Bleasby', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (188, 'Ricards', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (143, 'Graysmark', 2, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (220, 'Glazyer', 3, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (185, 'Gallard', 4, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (145, 'Brightie', 5, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (249, 'Twentyman', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (26, 'Eisold', 7, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (4, 'Melton', 8, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (202, 'Melchior', 9, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (61, 'Woodier', 10, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (19, 'Heenan', 1, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (170, 'Ridings', 2, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (56, 'McCroary', 3, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Aslott', 4, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (65, 'Davage', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (179, 'O\'Breen', 6, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (130, 'Maith', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (8, 'Martyn', 8, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (81, 'Seers', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (59, 'Eden', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (228, 'Couroy', 1, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (249, 'Littrell', 2, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (130, 'MacGeffen', 3, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (131, 'Grasha', 4, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (53, 'Todhunter', 5, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (9, 'Darrigrand', 6, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (54, 'Disney', 7, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (154, 'Hazael', 8, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (164, 'Boldra', 9, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (112, 'Mackie', 10, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (146, 'Kwietek', 1, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (15, 'Wise', 2, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (246, 'Bourne', 3, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (56, 'Skerritt', 4, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Purvess', 5, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (111, 'Tevelov', 6, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (198, 'Hainey', 7, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (145, 'Cordey', 8, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (40, 'Lippard', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (166, 'Snel', 10, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (97, 'Ratke', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (204, 'Dripps', 2, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (41, 'Alster', 3, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (65, 'Raffin', 4, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (56, 'Blankhorn', 5, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (93, 'Dimblebee', 6, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (10, 'Luparto', 7, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (199, 'Denmead', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (25, 'Fairs', 9, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (72, 'Quested', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (66, 'Kloisner', 1, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (134, 'Airlie', 2, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (156, 'Bohl', 3, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (217, 'Gregh', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (98, 'Bunnell', 5, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (97, 'Tregenza', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (75, 'Attenbarrow', 7, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (180, 'Slucock', 8, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (122, 'Sheaf', 9, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (167, 'Henken', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (65, 'Pedican', 1, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (8, 'L\'argent', 2, 4, 2, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (243, 'Bellerby', 3, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (208, 'Stoute', 4, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (187, 'Bayston', 5, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (117, 'Segrott', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (143, 'Meech', 7, 4, 0, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (217, 'Ickovicz', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (61, 'Crayker', 9, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (78, 'Arbon', 10, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (64, 'Winnett', 1, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (72, 'Follit', 2, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (165, 'Dadds', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (115, 'Commander', 4, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (39, 'Astbury', 5, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (191, 'Beville', 6, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (137, 'Eltune', 7, 4, 0, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (46, 'McMonies', 8, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (144, 'Carter', 9, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (74, 'Burlay', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (35, 'McFarland', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (87, 'Stoaks', 2, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (69, 'Brownlee', 3, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (9, 'Seres', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (18, 'Heaslip', 5, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (152, 'Besson', 6, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (163, 'Rathborne', 7, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (95, 'Masser', 8, 4, 0, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (215, 'Cowdrey', 9, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (216, 'Kynaston', 10, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (116, 'Quinney', 1, 4, 1, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (147, 'Dutnell', 2, 4, 1, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (160, 'Wilshaw', 3, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (114, 'Fairweather', 4, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (19, 'Haruard', 5, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (177, 'Durno', 6, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (17, 'Kendle', 7, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (186, 'Bolitho', 8, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (31, 'Brass', 9, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (152, 'Lovemore', 10, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (11, 'Edney', 1, 4, 3, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (126, 'Aloway', 2, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (139, 'Gilroy', 3, 4, 2, 2);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (132, 'Bosley', 4, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (139, 'Bras', 5, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (225, 'Gong', 6, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (119, 'Arnaudot', 7, 4, 4, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (122, 'Kurt', 8, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (148, 'Grimbaldeston', 9, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (107, 'Di Biasi', 10, 4, 0, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (60, 'Eton', 1, 4, 1, 3);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (209, 'Prout', 2, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (171, 'Bamlett', 3, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (128, 'Summerson', 4, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (249, 'Schoenrock', 5, 4, 1, 0);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (132, 'Barkaway', 6, 4, 3, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (234, 'Allnatt', 7, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (133, 'Dalbey', 8, 4, 2, 1);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (80, 'Cardnell', 9, 4, 0, 4);
Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values (39, 'McGinnell', 10, 4, 0, 1);

select * from game;



select case when sets_won > sets_lost then 1 else 0 end as winner from game;


-- create view team_members as
 select
	team_name,
	player_name,
	comp_designation
from
	player
join game
		using (player_id)
join competition
		using (comp_id)
join team
		using (team_id)
order by
	team_name,
	player_name,
	comp_designation;

drop view if exists games_overview;

create view games_overview as
select
	comp_id,
	player_id,
	comp_designation,
	player_name,
	game_opponent,
	sets,
	sets_won,
	sets_lost,
	case
		when sets_won + sets_lost < sets then 0
		else 1
	end as finished,
	case
		when sets_won = sets_lost then 'X'
		when sets_won > sets_lost then '1'
		else '2'
	end as result
from
	game
join competition
		using (comp_id)
join player
		using (player_id);
	
select * from games_overview;	
	
-- create view competitions_overview as
 select
	comp_designation,
	team_name,
	comp_opponent
	-- result - with unfinished
	-- games won
	-- games lost
	-- draws
	-- result - finished only
	-- games won
	-- games lost
	-- draws
	-- todo: results, competition finished, competition won.
from
	competition
join team
		using (team_id);
	