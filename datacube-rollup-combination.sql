/**************************************************************/
/* Combine with cube and with rollup techniques in a datacube */
/**************************************************************/

drop database if exists doodles;
create database doodles;
use doodles;

-- dimension tables

CREATE TABLE countries (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name NVARCHAR(32)
);

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name NVARCHAR(32),
    country_id INT,
    FOREIGN KEY (country_id)
        REFERENCES countries (country_id)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name NVARCHAR(32)
);

-- fact tables

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    city_id INT,
    dept_id INT,
    amount DECIMAL(8 , 2 ),
    FOREIGN KEY (city_id)
        REFERENCES cities (city_id),
    FOREIGN KEY (dept_id)
        REFERENCES departments (dept_id)
);

-- views

drop view if exists star_table;
CREATE VIEW star_table AS
    SELECT 
        purchase_id,
        country_id,
        country_name,
        city_id,
        city_name,
        dept_id,
        dept_name,
        amount
    FROM
        purchases
            JOIN
        cities USING (city_id)
            JOIN
        countries USING (country_id)
            JOIN
        departments USING (dept_id);
        
drop view if exists datacube;
CREATE VIEW datacube AS
    SELECT 
        country_id, city_id, dept_id, SUM(amount) as total_amount
    FROM
        purchases
            JOIN
        cities USING (city_id)
    GROUP BY country_id , city_id , dept_id WITH ROLLUP 
    UNION SELECT 
        country_id, city_id, dept_id, SUM(amount) as total_amount
    FROM
        purchases
            JOIN
        cities USING (city_id)
    GROUP BY dept_id , country_id , city_id WITH ROLLUP;

drop view if exists datacube_with_labels;
CREATE VIEW datacube_with_labels AS
    SELECT 
        datacube.country_id,
        country_name,
        datacube.city_id,
        city_name,
        datacube.dept_id,
        dept_name,
        total_amount
    FROM
        datacube
            LEFT JOIN
        cities USING (city_id)
            LEFT JOIN
        countries ON datacube.country_id = countries.country_id
            LEFT JOIN
        departments USING (dept_id);

-- sample core data

insert into countries (country_name) values ("England");
insert into countries (country_name) values ("Westeros");

insert into cities (city_name, country_id) values ("Cheadle", 1); 
insert into cities (city_name, country_id) values ("Macon Heights", 1); 
insert into cities (city_name, country_id) values ("Kings Landing", 2); 
insert into cities (city_name, country_id) values ("Winterfell", 2); 

insert into departments (dept_name) values ("garden furniture");
insert into departments (dept_name) values ("healing potions");

-- sample transactional data

insert into purchases (city_id, dept_id, amount) values (1, 1, 1.0);
insert into purchases (city_id, dept_id, amount) values (1, 1, 2.0);
insert into purchases (city_id, dept_id, amount) values (1, 2, 4.0);

insert into purchases (city_id, dept_id, amount) values (2, 1, 10.0);
insert into purchases (city_id, dept_id, amount) values (2, 1, 20.0);
insert into purchases (city_id, dept_id, amount) values (2, 2, 40.0);

insert into purchases (city_id, dept_id, amount) values (3, 1, 100.0);
insert into purchases (city_id, dept_id, amount) values (3, 1, 200.0);
insert into purchases (city_id, dept_id, amount) values (3, 2, 400.0);

insert into purchases (city_id, dept_id, amount) values (4, 1, 1000.0);
insert into purchases (city_id, dept_id, amount) values (4, 1, 2000.0);
insert into purchases (city_id, dept_id, amount) values (4, 2, 4000.0);

-- interesting queries

select * from star_table;
select * from star_table order by amount;
select * from datacube;
select * from datacube order by total_amount;
select * from datacube_with_labels;
select * from datacube_with_labels order by total_amount;
