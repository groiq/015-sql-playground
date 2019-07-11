/*
SQL Exercises from w3resources (Mysql version)

https://www.w3resource.com/mysql-exercises/
*/

/*
Exercises on Data Manipulation Language (DML) & Data Definition Language (DDL)
*/

/* First round of exercises apparently requires 
a new database, initially empty. */
create database if not exists w3resource_selfmade;

use w3resource_selfmade;

/* MySQL Create Table [20 exercises with solution] */

/* 1. Write a SQL statement to create a simple table countries 
including columns country_id,country_name and region_id. */
drop table if exists countries;
CREATE TABLE countries (
    country_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(32),
    region_id INT
);

insert into countries (country_name,region_id) values ('Australia',6);
insert into countries (country_name,region_id) values ('Belgium',1);
insert into countries (country_name,region_id) values ('Canada',2);

select * from countries;

/* duplicate countries */
drop table if exists dup_countries;
CREATE TABLE dup_countries LIKE countries;
insert into dup_countries (select * from countries);
select * from dup_countries;

