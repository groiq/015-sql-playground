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

