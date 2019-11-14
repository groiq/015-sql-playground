
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

USE `stored_procedures_hello_world`;
DROP function IF EXISTS `fetch_message`;

DELIMITER $$
USE `stored_procedures_hello_world`$$
CREATE FUNCTION `fetch_message` (id int)
RETURNS varchar(64)
BEGIN

RETURN (select message_text from messages where message_id = id);
END$$

DELIMITER ;

select fetch_message(1);

-- try to do the procedure-as-function trick...

DROP function IF EXISTS `display_and_return`;

DELIMITER $$
USE `stored_procedures_hello_world`$$
CREATE FUNCTION `display_and_return` (id int)
RETURNS BIT
BEGIN
	declare is_found bit;
    if (exists (select * from messages where message_id = id)) then
		begin
			-- okay, this doesn't even pass
           -- select * from messages where message_id = id;
			set is_found = 1;
 		end;
	else
		set is_found = 0;
	end if;
RETURN is_found;
END$$

DELIMITER ;

set @tester1 = display_and_return(1);
set @tester2 = display_and_return(99999);

select @tester1, @tester2;

USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `new_procedure`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE PROCEDURE `new_procedure` ()
BEGIN

END$$

DELIMITER ;

