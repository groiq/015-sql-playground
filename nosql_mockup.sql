/********************/
/*  Emulating NoSQL */
/********************/

/*
The main advantage of NoSQL - as I see it - is its flexibility in generating metadata. Meaning I can tag stuff flexibly. 
How can I achieve the same thing in SQL?
*/

drop database if exists doodles;
create database doodles;
use doodles;

/*
Let's assume I want to track various items. Each item has a name, so this is a field to be hard-coded into the database.

But the items should also have other stats. Those stats differ from item to item and are not known in advance. 

For example, I want to store this:

Name	Inscription	Hitpoints	weight
Hammer	Thor's rune	6.0			2.3 kg


*/

-- first, a table for items:

CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name NVARCHAR(32)
);

-- Now to set up values of type string:

CREATE TABLE string_types (
    string_type_id INT PRIMARY KEY AUTO_INCREMENT,
    string_type_name NVARCHAR(32)
);

CREATE TABLE string_instances (
    string_instance_id INT PRIMARY KEY AUTO_INCREMENT,
    string_type_id INT,
    item_id INT,
    string_instance_value NVARCHAR(32),
    FOREIGN KEY (item_id)
        REFERENCES items (item_id),
    FOREIGN KEY (string_type_id)
        REFERENCES string_types (string_type_id),
    UNIQUE (item_id , string_type_id)
);

-- note that with this setup, each field can be used once per item. 
-- A field that has a set as value will be handled later. 

-- same pattern, values of type float:

CREATE TABLE float_types (
    float_type_id INT PRIMARY KEY AUTO_INCREMENT,
    float_type_name NVARCHAR(32),
    float_type_unit NVARCHAR(16)
);

CREATE TABLE float_instances (
    float_instance_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    float_type_id INT,
    float_instance_value DECIMAL(8 , 2 ),
    FOREIGN KEY (item_id)
        REFERENCES items (item_id),
    FOREIGN KEY (float_type_id)
        REFERENCES float_types (float_type_id),
    UNIQUE (item_id , float_type_id)
);

-- sample data:

insert into items (item_name) values ("hammer");
insert into items (item_name) values ("unidentified thing");

insert into string_types (string_type_name) values ("description");
insert into string_types (string_type_name) values ("inscription");
insert into string_instances (item_id, string_type_id, string_instance_value) values (1, 1, "thors rune");
insert into string_instances (item_id, string_type_id, string_instance_value) values (1, 2, "pretty heavy");

insert into string_instances (string_type_id,item_id,string_instance_value) values (2,2,"unidentifiable");

insert into float_types (float_type_name) values ("hitpoints");
insert into float_types (float_type_name, float_type_unit) values ("weight", "kg");
insert into float_instances (item_id, float_type_id, float_instance_value) values (1, 1, 6.0);
insert into float_instances (item_id, float_type_id, float_instance_value) values (1, 2, 3.0);

-- querying only the string types:

/*
SELECT 
    item_name, string_type_name, string_instance_value
FROM
    items
        LEFT JOIN
    string_instances USING (item_id)
        LEFT JOIN
    string_types USING (string_type_id);
*/

-- final query:

-- short notation (for command line)
/*
select item_name, string_type_name, string_instance_value, float_type_name, float_type_unit, float_instance_value
from items left join string_instances using (item_id) left join string_types using (string_type_id)
left join float_instances using (item_id) left join float_types using (float_type_id);
*/

SELECT 
    item_name,
    string_type_name,
    string_instance_value,
    float_type_name,
    float_type_unit,
    float_instance_value
FROM
    items
        LEFT JOIN
    string_instances USING (item_id)
        LEFT JOIN
    string_types USING (string_type_id)
        LEFT JOIN
    float_instances USING (item_id)
        LEFT JOIN
    float_types USING (float_type_id);

