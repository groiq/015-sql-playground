
drop database if exists doodles;
create database doodles;
use doodles;

-- Hypothesis: An FK can only point to a key. 

/*
How about partial keys?
How about unique values that are not keys?
Can I have a double PK?
*/

CREATE TABLE double_pk (
    surrogate_key INT PRIMARY KEY,
    natural_first_part INT,
    natural_second_part INT,
    PRIMARY KEY (natural_first_part , natural_second_part)
);
