
/******************************************************************************
	Fibonacci sequence using multistatement table-valued function
******************************************************************************/

use doodles;

drop function if exists dbo.fibonacciRCTE;
go

create or alter function dbo.fibonacciRCTE (@f0 as int, @f1 as int, @min as int, @max as int)
returns table
with schemabinding
as 
return
(
	with fiborec as 
		(
			select @f0 as pparent, @f1 as parent, (@f0 + @f1) as curr, 2 as step
		union
			select parent as pparent, curr as parent, (parent + curr) as curr, (step + 1) as step 
			from fiborec 
			where step < @max
		--union
		--	select (parent - pparent) as pparent, pparent as parent, parent as curr, (step - 1) as step
		--	from fiborec 
		--	where step > @min
		)

	select curr, step from fiborec
);
go

select * from dbo.fibonacciRCTE(0, 1, 2, 3) order by step;
