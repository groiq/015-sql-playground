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
and the contestant who defeated them (called their "slayer"). 
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
    entry["number"] = i + 1
    entry["name"] = names[i]
    entry["hitpoints"] = hitpoints[i]
    entry["slayer"] = 0
    contestants.append(entry)
    print("insert into contestant (name,hitpoints) values (\'{}\',{});".format(entry["name"],entry["hitpoints"]))

# for later: throw it all into one python script, use the random.org api,
# find a name generator that offers an api.
*/

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
