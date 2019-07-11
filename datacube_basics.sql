/* Try With Rollup on a two-dimensional cube */

drop table if exists customer;
drop table if exists item;
drop table if exists purchase;


create table customer (cid int primary key, cname varchar(32));
create table item (iid int primary key, iname varchar(32));
create table purchase (cid int , iid int , quantity int);

insert into customer values (1,'ann');
insert into customer values (2,'bob');

insert into item values (11,'jacket');
insert into item values (12,'shirt');

insert into purchase values (1,11,1);
insert into purchase values (1,12,10);
insert into purchase values (2,11,100);
insert into purchase values (2,12,1000);

select cname,iname,quantity,sum(quantity) from customer join purchase using(cid) join item using(iid) group by cid,iid with rollup;

select cid,iid,sum(quantity) from purchase P group by cid,iid with rollup;

/* set up a three-dimensional cube */

drop table if exists t1;
drop table if exists t2;
drop table if exists t3;

create table t1 (id1 int, name1 varchar(8));
create table t2 (id2 int, name2 varchar(8));
create table t3 (id3 int, name3 varchar(8));

insert into t1 values(1,'A');
insert into t1 values(2,'B');
insert into t2 values(1,'C');
insert into t2 values(2,'D');
insert into t3 values(1,'E');
insert into t3 values(2,'F');

create table t3dim (id1 int, id2 int, id3 int, value varchar(8));

/* (stopping there for now) */
