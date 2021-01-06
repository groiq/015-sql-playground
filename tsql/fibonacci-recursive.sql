
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
	return (select @f0 as num);
go

select * from dbo.fibonacciRCTE(0, 1, -5, 5);
