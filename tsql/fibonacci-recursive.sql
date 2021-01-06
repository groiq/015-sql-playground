
/******************************************************************************
	Fibonacci sequence using multistatement table-valued function
******************************************************************************/

use doodles;

drop function if exists dbo.fibonacciRCTE;
go

create or alter function dbo.fibonacciRCTE ()
returns table
with schemabinding
as 
	return (select 'hello world!' as message);
go

select * from dbo.fibonacciRCTE();