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

