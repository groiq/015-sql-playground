drop database if exists doodles;
create database doodles;
use doodles;

-- assuming the values for gender and classroom are sufficient for primary keys. 

create table gender (gender_id int primary key, gender_short_name nchar(1), gender_name nvarchar(16));

create table person (person_id int primary key, person_first nvarchar(16), person_last nvarchar(16), gender_id int, foreign key (gender_id) references gender (gender_id));

create table classroom (classroom_id nchar(3) primary key, floor int, seat_count int);

create table student (student_id int primary key, advisor_id int, foreign key (student_id) references person (person_id), foreign key (advisor_id) references person (person_id));


