
-- Hello world as a session variable
set @message = 'Hello world!';
select @message;

-- Hello world in a database

-- db setup
-- drop database if exists stored_procedures_hello_world;
create database stored_procedures_hello_world;
use stored_procedures_hello_world;
create table messages (message_id int primary key auto_increment, message_text varchar(64));
insert into messages (message_text) values ('Hello world!');

-- standard select
select message_text from messages;

select * from messages;

-- write to variable
-- select message_text from messages where message_id = 1 into @message_text; -- deprecated!
insert into messages (message_text) values ('Hallo Welt!');
select @message_text := (select message_text from messages where message_id = 2);
select @message_text;

-- alternative:
set @message_text = (select message_text from messages where message_id = 1);
select @message_text;

-- actually storing a procedure
DROP procedure IF EXISTS `call_hello_world`;
DELIMITER $$
CREATE PROCEDURE `call_hello_world` ()
BEGIN
 select message_text from messages where message_id = 1;
END$$

DELIMITER ;

call call_hello_world();

-- a procedure that calls another one

drop procedure if exists `call_hello_world_recurse`;
delimiter $$
create procedure `call_hello_world_recurse` ()
begin
	call call_hello_world();
end $$

call call_hello_world_recurse;


