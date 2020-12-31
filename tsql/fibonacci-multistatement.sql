
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
	declare @step as int = 1;

	-- insert first two lines
	insert into @fibonacci
		(pre1, pre2, curr, step)
	values 
		((2 * @zero - @one), (@one - @zero), @zero, 0),
		((@one - @zero), @zero, @one, 1);

	-- do the loop
	while @step < @limit 
	begin
		set @step += 1;
		insert into @fibonacci
			(pre2, pre1, curr, step)
		select 
			pre1, curr, (pre1 + curr), @step 
		from @fibonacci 
		where step = @step - 1;
	end;
return;
end;
go

select * from dbo.fibonacci(0,1,12);
