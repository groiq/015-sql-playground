
/******************************************************************************
	Fibonacci sequence using multistatement table-valued function
******************************************************************************/

use doodles;

drop function if exists dbo.fibonacci;
go

create function dbo.fibonacci (@zero as int = 0, @one as int = 1, @limit as int = 12)
returns @Fibonacci table
(
pre1 int,
pre2 int,
curr int,
step int
)
with schemabinding 
as 
begin
	-- insert first two lines
	insert into @fibonacci
		(pre1, pre2, curr, step)
	values 
		((2 * @zero - @one), (@one - @zero), @zero, 0),
		((@one - @zero), @zero, @one, 1);

return;
end;
go

select * from dbo.fibonacci(0,1,12);
