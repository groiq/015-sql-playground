/* Various exercises */

/* My first recursive with statement */

/*
Okay, so I need to generate some sort of tree structure.

How about this: I'll model some sort of tournament.

We have a list of contestants, each with a number of hit points. 
They are pitched against each others in pairs until one is left.
Contestant with higher hit point number wins. 

In the end I'll have a tree of duels.

I'll have 2^n contestants, let's say 16.
For hit points assigment I'll take the sequence of numbers from 1 to 16
and randomize it. 

Data-wise, each contestant has a bib number, name, hit points 
and the contestant who defeated them. 
*/

drop table if exists contestant;
CREATE TABLE contestant (
    number INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) UNIQUE NOT NULL,
    hitpoints INTEGER NOT NULL,
    slayer INTEGER,
    FOREIGN KEY (slayer)
        REFERENCES contestant (number)
);

/*
Code for generating input statements:

names = "Anfroy Bodoloff Chrodegang Drimylos Engelke Folcard Gilpin Hegesandros Ixidor Jorin Kendrick Leudbald Meginhard Nidungus Orkatz Piligrim Quenall Raynoldus Sigibuld Theutgaud Unigild Vitigis Widigast Xabier Ypolitus Zindel"
names = names.split()
#print(names)

hitpointList = "11	2	10	1	5	9	4	13	16	7	12	6	8	15	14	3".split()
for i in range(len(hitpointList)):
    hitpointList[i] = int(hitpointList[i])
#print(hitpointList)

for i in range(len(hitpointList)):
    print("insert into contestant (name,hitpoints) values (\'{}\',{});".format(names[i],hitpointList[i]))

*/

/*
Names taken from https://www.mithrilandmages.com/utilities/MedievalBrowse.php
Hitpoint list ranomized using random.org
*/

insert into contestant (name,hitpoints) values ('Anfroy',11);
insert into contestant (name,hitpoints) values ('Bodoloff',2);
insert into contestant (name,hitpoints) values ('Chrodegang',10);
insert into contestant (name,hitpoints) values ('Drimylos',1);
insert into contestant (name,hitpoints) values ('Engelke',5);
insert into contestant (name,hitpoints) values ('Folcard',9);
insert into contestant (name,hitpoints) values ('Gilpin',4);
insert into contestant (name,hitpoints) values ('Hegesandros',13);
insert into contestant (name,hitpoints) values ('Ixidor',16);
insert into contestant (name,hitpoints) values ('Jorin',7);
insert into contestant (name,hitpoints) values ('Kendrick',12);
insert into contestant (name,hitpoints) values ('Leudbald',6);
insert into contestant (name,hitpoints) values ('Meginhard',8);
insert into contestant (name,hitpoints) values ('Nidungus',15);
insert into contestant (name,hitpoints) values ('Orkatz',14);
insert into contestant (name,hitpoints) values ('Piligrim',3);


select * from contestant;


