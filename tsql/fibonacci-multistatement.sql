
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
	
return;
end;
go

select * from dbo.fibonacci(0,1,12);
