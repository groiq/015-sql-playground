
/***************************************************
	A file for exercises in TSQL
***************************************************/

use doodles;

/*
Using a table-valued function to iteratively fill a table
example: some kind of tournament
*/

-- Data setup 

-- note that this has some elements I won't be using in the example. I'll just use player.pid and player.score.)

use doodles;

drop table if exists player;
drop table if exists country;

create table country (cid int primary key, cname varchar(32));
create table player (pid int primary key identity(1,1), cid int, pname varchar(32), score decimal(8,2), foreign key (cid) references country (cid));
go

insert into country (cid, cname) values (1, 'metrica'), (2, 'caledon'), (3, 'kryta'), (4, 'shiverpeaks'), (5, 'ascalon'), (6, 'orr'), (7, 'cantha'), (8, 'elona');

-- sample data courtesy of mockaroo.com
insert into player (pname, cid, score) values ('Hamlin Maxwaile', 7, 95.86);
insert into player (pname, cid, score) values ('Pavia Barca', 3, 9119.54);
insert into player (pname, cid, score) values ('Ardys Eskrigg', 6, 6478.94);
insert into player (pname, cid, score) values ('Tammy Scullion', 8, 2073.73);
insert into player (pname, cid, score) values ('Junette Drissell', 4, 3070.97);
insert into player (pname, cid, score) values ('Martica Carloni', 4, 4670.03);
insert into player (pname, cid, score) values ('Gilbert Hartop', 2, 3616.18);
insert into player (pname, cid, score) values ('Lisha Uzielli', 8, 2813.28);
insert into player (pname, cid, score) values ('Mindy Crampin', 7, 2502.54);
insert into player (pname, cid, score) values ('Lucille Filpo', 3, 6369.03);
insert into player (pname, cid, score) values ('Frankie Harlick', 7, 7689.23);
insert into player (pname, cid, score) values ('Bernelle Fallis', 7, 3741.3);
insert into player (pname, cid, score) values ('Chilton Wogdon', 3, 8065.07);
insert into player (pname, cid, score) values ('Tore Dunstan', 1, 7612.31);
insert into player (pname, cid, score) values ('Quinn Dubs', 4, 5179.91);
insert into player (pname, cid, score) values ('Wally Hawkshaw', 4, 8772.83);
insert into player (pname, cid, score) values ('Lesley Reddecliffe', 7, 1178.09);
insert into player (pname, cid, score) values ('Glenn Brazil', 2, 3904.45);
insert into player (pname, cid, score) values ('Georgianna Greenhouse', 4, 5717.94);
insert into player (pname, cid, score) values ('Katrine Kinastan', 3, 8494.34);
insert into player (pname, cid, score) values ('Giacinta Wyley', 4, 3789.38);
insert into player (pname, cid, score) values ('Karlotte Treamayne', 6, 693.72);
insert into player (pname, cid, score) values ('Judi Laughren', 2, 2063.38);
insert into player (pname, cid, score) values ('Barnebas Griffey', 7, 691.75);
insert into player (pname, cid, score) values ('Carlie Crocroft', 4, 2692.93);
insert into player (pname, cid, score) values ('Nathaniel Napoli', 3, 2804.36);
insert into player (pname, cid, score) values ('Bee Pollen', 6, 4455.58);
insert into player (pname, cid, score) values ('Allegra Fawcett', 2, 9426.94);
insert into player (pname, cid, score) values ('Estele Woolstenholmes', 1, 618.68);
insert into player (pname, cid, score) values ('Fonz Toms', 7, 7358.37);
insert into player (pname, cid, score) values ('Peyter Sievewright', 1, 2745.64);
insert into player (pname, cid, score) values ('Tobe Flisher', 5, 3034.52);
insert into player (pname, cid, score) values ('Elroy MacDavitt', 5, 5652.6);
insert into player (pname, cid, score) values ('Nadya Yurukhin', 2, 8580.08);
insert into player (pname, cid, score) values ('Oralla Crips', 1, 749.31);
insert into player (pname, cid, score) values ('Drusi Postins', 4, 7095.68);
insert into player (pname, cid, score) values ('Leilah Beisley', 8, 3093.15);
insert into player (pname, cid, score) values ('Dode Bannon', 6, 319.9);
insert into player (pname, cid, score) values ('Tomaso Janda', 8, 3193.51);
insert into player (pname, cid, score) values ('Sig Arpur', 1, 2559.01);
insert into player (pname, cid, score) values ('Jock Cannavan', 6, 5760.64);
insert into player (pname, cid, score) values ('Bald Rojas', 6, 8260.64);
insert into player (pname, cid, score) values ('Lainey Jarmaine', 7, 7735.57);
insert into player (pname, cid, score) values ('Gigi Meacher', 5, 9449.43);
insert into player (pname, cid, score) values ('Hyacinth Squier', 3, 2220.34);
insert into player (pname, cid, score) values ('Farra Gontier', 2, 3399.55);
insert into player (pname, cid, score) values ('Deeyn Poletto', 1, 8407.88);
insert into player (pname, cid, score) values ('Brien MacGillavery', 8, 8253.31);
insert into player (pname, cid, score) values ('Ruthie Carbine', 2, 6347.77);
insert into player (pname, cid, score) values ('Tan Cast', 6, 4124.37);
insert into player (pname, cid, score) values ('Gregoire Scorey', 3, 1981.92);
insert into player (pname, cid, score) values ('Luci Vasilov', 4, 150.19);
insert into player (pname, cid, score) values ('Francisca Rapper', 5, 581.73);
insert into player (pname, cid, score) values ('Ellery Cuskery', 1, 5675.14);
insert into player (pname, cid, score) values ('Teddy Hardware', 3, 1573.01);
insert into player (pname, cid, score) values ('Nicolina Book', 2, 5947.94);
insert into player (pname, cid, score) values ('Kirstyn Chable', 6, 2517.76);
insert into player (pname, cid, score) values ('Sander Cowe', 2, 3710.09);
insert into player (pname, cid, score) values ('Stepha Handlin', 7, 41.69);
insert into player (pname, cid, score) values ('Bunny Moutray Read', 4, 3146.83);
insert into player (pname, cid, score) values ('Bruce Annice', 4, 8852.36);
insert into player (pname, cid, score) values ('Sander Willans', 8, 2332.34);
insert into player (pname, cid, score) values ('Aviva De Dei', 5, 4327.82);
insert into player (pname, cid, score) values ('Lindsay Shenton', 4, 8393.15);

go


