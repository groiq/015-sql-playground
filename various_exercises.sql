/****************
Various exercises
*****************/

/********************************
My first recursive with statement
*********************************/

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
and the contestant who defeated them (called their "slayer"). 
*/

drop table if exists contestant;
CREATE TABLE contestant (
    bib_num INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) UNIQUE NOT NULL,
    hitpoints INTEGER NOT NULL,
    slayer INTEGER,
    FOREIGN KEY (slayer)
        REFERENCES contestant (bib_num)
);

/*
I'll set up a data object for the list of contestants.
First, I'll generate the sql input statements,
then I'll calculate slayers
and then generate update statements accordingly.
Code for that in Python:
*/

/*
#!/usr/bin/env python3

# names from: https://www.name-generator.org.uk/
# random seed was 35
# randomized distribution of hitpoints via https://www.random.org/

names = ['Bathtson Freeger', 'Pointyspen Bellelline', 'Jaenstewart Grangdon', 'Wickedro Elliottshot', 'Hermilawrence Clarkotter', 'Harilda Sandore', 'Mcdonaldcackle Bapower', 'Crawfordbroom Mitcheness', 'Thocat Burpower', 'Greenhar Roness', 'Agadunn Aumrris', 'Cacklegordon Williamsshot', 'Fostercauldron Williamar', 'Hane Grangthompson', 'Davintress Dumbleriffiths', 'Broomtucker Granghoward', 'Fosterhat Williamar', 'Wandper Bapower', 'Elmmos Grangthompson', 'Gandunn Aumrris', 'Gwydvera Mitcheness', 'Merlle Sandore', 'Ronster Elliottshot', 'Harspell Roness', 'Thobus Burpower', 'Crunon Clarkotter', 'Thompsonwand Williamsshot', 'Spenwise Bellelline', 'Filegend Craden', 'Moorerry Freeger', 'Davidalf Dumbleriffiths', 'Gonwizz Granghoward']
hitpoints = [14, 21, 22, 7, 16, 15, 25, 31, 23, 1, 5, 32, 24, 17, 28, 29, 9, 12, 19, 8, 4, 6, 26, 10, 30, 11, 2, 18, 27, 13, 3, 20]

contestants = []

for i in range(len(names)):
    #print(i, names[i], hitpoints[i])
    entry = {}
    entry["bib_num"] = i + 1
    entry["name"] = names[i]
    entry["hitpoints"] = hitpoints[i]
    entry["slayer"] = 0
    contestants.append(entry)
    print("insert into contestant (name,hitpoints) values (\'{}\',{});".format(entry["name"],entry["hitpoints"]))

# for later: throw it all into one python script, use the random.org api,
# find a name generator that offers an api.
*/

-- test data
insert into contestant (name,hitpoints) values ('1',1);
insert into contestant (name,hitpoints) values ('2',2);
insert into contestant (name,hitpoints) values ('3',3);
insert into contestant (name,hitpoints) values ('4',4);
insert into contestant (name,hitpoints) values ('5',5);
insert into contestant (name,hitpoints) values ('6',6);
insert into contestant (name,hitpoints) values ('7',7);
insert into contestant (name,hitpoints) values ('8',8);

insert into contestant (name,hitpoints) values ('Bathtson Freeger',14);
insert into contestant (name,hitpoints) values ('Pointyspen Bellelline',21);
insert into contestant (name,hitpoints) values ('Jaenstewart Grangdon',22);
insert into contestant (name,hitpoints) values ('Wickedro Elliottshot',7);
insert into contestant (name,hitpoints) values ('Hermilawrence Clarkotter',16);
insert into contestant (name,hitpoints) values ('Harilda Sandore',15);
insert into contestant (name,hitpoints) values ('Mcdonaldcackle Bapower',25);
insert into contestant (name,hitpoints) values ('Crawfordbroom Mitcheness',31);
insert into contestant (name,hitpoints) values ('Thocat Burpower',23);
insert into contestant (name,hitpoints) values ('Greenhar Roness',1);
insert into contestant (name,hitpoints) values ('Agadunn Aumrris',5);
insert into contestant (name,hitpoints) values ('Cacklegordon Williamsshot',32);
insert into contestant (name,hitpoints) values ('Fostercauldron Williamar',24);
insert into contestant (name,hitpoints) values ('Hane Grangthompson',17);
insert into contestant (name,hitpoints) values ('Davintress Dumbleriffiths',28);
insert into contestant (name,hitpoints) values ('Broomtucker Granghoward',29);
insert into contestant (name,hitpoints) values ('Fosterhat Williamar',9);
insert into contestant (name,hitpoints) values ('Wandper Bapower',12);
insert into contestant (name,hitpoints) values ('Elmmos Grangthompson',19);
insert into contestant (name,hitpoints) values ('Gandunn Aumrris',8);
insert into contestant (name,hitpoints) values ('Gwydvera Mitcheness',4);
insert into contestant (name,hitpoints) values ('Merlle Sandore',6);
insert into contestant (name,hitpoints) values ('Ronster Elliottshot',26);
insert into contestant (name,hitpoints) values ('Harspell Roness',10);
insert into contestant (name,hitpoints) values ('Thobus Burpower',30);
insert into contestant (name,hitpoints) values ('Crunon Clarkotter',11);
insert into contestant (name,hitpoints) values ('Thompsonwand Williamsshot',2);
insert into contestant (name,hitpoints) values ('Spenwise Bellelline',18);
insert into contestant (name,hitpoints) values ('Filegend Craden',27);
insert into contestant (name,hitpoints) values ('Moorerry Freeger',13);
insert into contestant (name,hitpoints) values ('Davidalf Dumbleriffiths',3);
insert into contestant (name,hitpoints) values ('Gonwizz Granghoward',20);

select * from contestant;

/*
For now, I'll calculate the entire tournament in one go
using the data object in python. 
Later think of some more refined structure. 
*/

/*
Python code to calculate tournament:
*/

/*
winnerFound = False

while not winnerFound:
    redCorner = 0
    for candidate in contestants:
        if candidate["slayer"]: continue
        if redCorner:
            blueCorner = candidate["bib_num"]
            opponent = contestants[redCorner-1]
            print(opponent["name"], "vs.", candidate["name"])
            if opponent["hitpoints"] > candidate["hitpoints"]:
                candidate["slayer"] = opponent["bib_num"]
            else:
                opponent["slayer"] = candidate["bib_num"]
            redCorner = 0
        else:
            redCorner = candidate["bib_num"]
    if redCorner:
        winnerFound = True
*/

/*
generate sql statements:
*/

/*
for contestant in contestants:
    if contestant["slayer"]:
        print("update contestant set slayer = {} where bib_num = {};".format(contestant["slayer"],contestant["bib_num"]))
*/

/*
sql statements:
*/

-- test data
update contestant set slayer = 2 where bib_num = 1;
update contestant set slayer = 4 where bib_num = 2;
update contestant set slayer = 4 where bib_num = 3;
update contestant set slayer = 8 where bib_num = 4;
update contestant set slayer = 6 where bib_num = 5;
update contestant set slayer = 8 where bib_num = 6;
update contestant set slayer = 8 where bib_num = 7;

update contestant set slayer = 2 where bib_num = 1;
update contestant set slayer = 3 where bib_num = 2;
update contestant set slayer = 8 where bib_num = 3;
update contestant set slayer = 3 where bib_num = 4;
update contestant set slayer = 8 where bib_num = 5;
update contestant set slayer = 5 where bib_num = 6;
update contestant set slayer = 8 where bib_num = 7;
update contestant set slayer = 12 where bib_num = 8;
update contestant set slayer = 12 where bib_num = 9;
update contestant set slayer = 9 where bib_num = 10;
update contestant set slayer = 12 where bib_num = 11;
update contestant set slayer = 16 where bib_num = 13;
update contestant set slayer = 13 where bib_num = 14;
update contestant set slayer = 16 where bib_num = 15;
update contestant set slayer = 12 where bib_num = 16;
update contestant set slayer = 18 where bib_num = 17;
update contestant set slayer = 19 where bib_num = 18;
update contestant set slayer = 23 where bib_num = 19;
update contestant set slayer = 19 where bib_num = 20;
update contestant set slayer = 22 where bib_num = 21;
update contestant set slayer = 23 where bib_num = 22;
update contestant set slayer = 25 where bib_num = 23;
update contestant set slayer = 23 where bib_num = 24;
update contestant set slayer = 12 where bib_num = 25;
update contestant set slayer = 25 where bib_num = 26;
update contestant set slayer = 28 where bib_num = 27;
update contestant set slayer = 25 where bib_num = 28;
update contestant set slayer = 25 where bib_num = 29;
update contestant set slayer = 29 where bib_num = 30;
update contestant set slayer = 32 where bib_num = 31;
update contestant set slayer = 29 where bib_num = 32;

select * from contestant;

/*
Now, finally, the recursive with statement I'm doing all this for.
*/

/* okay, some simpler queries first... */

select bib_num, slayer from contestant;

with Defeated(loser,winner) as
	(select bib_num as loser, slayer as winner from contestant)
    select loser, winner from Defeated;

with Defeated(loser,winner) as
	(select bib_num as loser, slayer as winner from contestant)
    select loser, winner from Defeated
    where winner = 8;

/*
And now, this is what I'm after. First, a master list:
*/

with recursive 
	Defeated(loser,winner) as 
		(select bib_num as loser, slayer as winner from contestant 
		union 
		select Defeated.loser, contestant.slayer as winner 
		from Defeated, contestant 
			where Defeated.winner = contestant.bib_num)
select loser,winner from Defeated order by winner;

/*
Selecting subtree from one contestant:
*/

with recursive 
	Defeated(loser,winner) as 
		(select bib_num as loser, slayer as winner from contestant 
		union 
		select Defeated.loser, contestant.slayer as winner 
		from Defeated, contestant 
			where Defeated.winner = contestant.bib_num)
select loser,winner from Defeated where winner = 4;

with recursive
	Indir(indir_bib_num) as
		(select bib_num as indir_bib_num from contestant where bib_num = 4
        union
        select bib_num as indir_bib_num
        from contestant direct_duel, Indir indirect_duel
        where direct_duel.slayer = indirect_duel.indir_bib_num
        
        )
select indir_bib_num from Indir;
-- little blemish: this includes the bib_num of the actual contestant themselves, 
-- not just those they've slain
-- easy fix in the next variant

with recursive
	Indir(indir_bib_num) as
		(select bib_num as indir_bib_num from contestant where slayer = 4
        union
        select bib_num as indir_bib_num
        from contestant direct_duel, Indir indirect_duel
        where direct_duel.slayer = indirect_duel.indir_bib_num
        
        )
select indir_bib_num,bib_num 
from Indir join contestant
where contestant.bib_num = 4;

with recursive
	Seed(bib_num) as (select bib_num from contestant where bib_num = 4),
	Indir(indir_bib_num) as
		(select contestant.bib_num as indir_bib_num from contestant,Seed where contestant.slayer = Seed.bib_num
        union
        select bib_num as indir_bib_num
        from contestant direct_duel, Indir indirect_duel
        where direct_duel.slayer = indirect_duel.indir_bib_num
        
        )
select indir_bib_num,bib_num 
from Indir join Seed;

/************************
Simpler recursion example
*************************/

/*

A simpler example, suggested by essentialsql following Aaron Krolik. 
It uses a line rather than a tree. 

Sources:
https://www.quora.com/How-should-I-explain-recursion-to-a-4-year-old
via https://www.essentialsql.com/recursive-ctes-explained/

You are waiting in a line and wondering how many people are in front of you.
Each person in the line has access to the previous one. 
The position can be determined by these instructions:

- When trying to find out your number, ask the person in front for theirs.
- When told a number, add 1 
- When nobody is in front of you, assume you were given the number zero. 



*/
