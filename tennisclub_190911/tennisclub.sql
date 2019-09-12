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


insert into player (player_name) values ('Ma�lys');
insert into player (player_name) values ('S�l�ne');
insert into player (player_name) values ('Zh�');
insert into player (player_name) values ('Ga�tane');
insert into player (player_name) values ('Est�ve');
insert into player (player_name) values ('C�cilia');
insert into player (player_name) values ('Oc�ane');
insert into player (player_name) values ('Est�e');
insert into player (player_name) values ('M�lia');
insert into player (player_name) values ('Laur�na');
insert into player (player_name) values ('Ad�le');
insert into player (player_name) values ('R�serv�s');
insert into player (player_name) values ('G�rel');
insert into player (player_name) values ('Ma�wenn');
insert into player (player_name) values ('Oph�lie');
insert into player (player_name) values ('B�cassine');
insert into player (player_name) values ('V�nus');
insert into player (player_name) values ('Cr��z');
insert into player (player_name) values ('Oc�anne');
insert into player (player_name) values ('Lo�c');

select * from player;

insert into team (team_name, captain) values ('buprenorphine', 5);
insert into team (team_name, captain) values ('Menthol, Methyl Salicylate', 13);
insert into team (team_name, captain) values ('Acyclovir Sodium', 18);
insert into team (team_name, captain) values ('Polyethylene Glycol 3350', 19);
insert into team (team_name, captain) values ('Sodium Fluoride', 15);

select * from team;

select team_name, player_name as captain from player join team on player.player_id = team.captain;

insert into competition (comp_designation, comp_opponent, team_id, games) values ('Feest LLC', 'Zorro, azara''s', 3, 5);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Donnelly, Swift and Treutel', 'Giant heron', 4, 5);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Lang-Jacobs', 'Dingo', 5, 5);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Rippin-Heathcote', 'Klipspringer', 2, 5);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('O''Keefe Group', 'Crab, sally lightfoot', 1, 5);
insert into competition (comp_designation, comp_opponent, team_id, games) values ('Koss, Spencer and Collier', 'American beaver', 3, 5);

select team_name, comp_designation, comp_opponent, games from competition join team using (team_id);


-- create view competitions_overview as
select
	comp_designation, team_name, comp_opponent
from
	competition join team using (team_id);

select case when sets_won > sets_lost then 1 else 0 end as winner from game;


-- create view games_overview as
select
	comp_id,
	player_name,
	game_opponent,
	sets,
	sets_won,
	sets_lost,
	case when sets_won + sets_lost < sets then 0 else 1 end as finished,
	case when sets_won > sets_lost then 1 else 0 end as won
from
	game
join competition
		using (comp_id)
join player
		using (player_id);