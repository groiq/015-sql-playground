/*
mysql stored procedures exercise 1
*/

/*
Erstelle eine Stored Function GEHALT, die zu einem Angestellten (Eingabepara- meter EMPNO) SAL+COMM berechnet und zurückgibt. Teste die Funktion.
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `gehalt`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `gehalt` (empno int)
RETURNS DECIMAL(8,2)
BEGIN
	declare commission decimal(8,2);
    declare gehalt decimal(8,2);
	set gehalt = (select salary from employees where employee_id = empno);
    set commission = (select commission_pct from employees where employee_id = empno);
    if(commission is null) then
		set commission = 0;
	end if;
    set gehalt = gehalt + (gehalt * commission);
    return gehalt;

END$$

DELIMITER ;

/*
querying one employee with and one without commission
select employee_id, salary, commission_pct from employees where employee_id = 101 or employee_id = 149;
	employee_id	salary		commission_pct
	101			17000.00	null
	149			10500.00	0.20

expected result:
	employee_id	salary		commission_pct	gehalt
	101			17000.00	null			17000.00
	149			10500.00	0.20			12600.00
    */
    
select employee_id, salary, commission_pct, gehalt(employee_id) as gehalt from employees where employee_id = 101 or employee_id = 149;

/*
seems to match.
*/

/*
ErstelleeineStoredFunctionDIFF,diedieTagesdifferenzbezüglichdesAnstel- lungsdatums zweier Angestellter (Eingabeparameter 2x EMPNO) ausgibt.
Die Ausgabe soll folgende Format haben: ... 65 Tage vor ...
Teste die Funktion.
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `diff_as_number`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `diff_as_number` (emp_id_1 int, emp_id_2 int)
RETURNS INTEGER
BEGIN
	declare date1 date;
    declare date2 date;
	set date1 = (select hire_date from employees where employee_id = emp_id_1);
    set date2 = (select hire_date from employees where employee_id = emp_id_2);
    return datediff(date1,date2);
END$$

DELIMITER ;

-- select @datediff, diff_as_number(100,200);

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `diff`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `diff` (emp_id_1 int, emp_id_2 int)
RETURNS VARCHAR(64)
BEGIN
	
    declare result varchar(64);
    declare diff_number integer;
    
    if emp_id_1 = emp_id_2  then
		set result = 'error: same employee given twice.';
	else
		set diff_number = diff_as_number(emp_id_1,emp_id_2);
        -- if diff_number is a negative number -n, then emp 2 was hired n days before emp 1.
		if diff_number < 0 then
			begin
				declare placeholder integer;
				set placeholder = emp_id_1;
				set emp_id_1 = emp_id_2;
				set emp_id_2 = placeholder;
				set diff_number = diff_number * (-1);
			end;
        end if;
        begin
			declare first_1 varchar(20);
            declare first_2 varchar(20);
            declare last_1 varchar(20);
            declare last_2 varchar(20);
			select first_name, last_name into first_1, last_1 from employees where employee_id = emp_id_1;
			select first_name, last_name into first_2, last_2 from employees where employee_id = emp_id_2;
			set result = concat_ws(" ", first_1, last_1, 'was hired', diff_number, 'days before', first_2, last_2);
        end;
    end if;
    
	return result;
    
END$$

DELIMITER ;

/*
Employee 100 was hired on 87-06-17. 200 was hired on 87-09-17,
that's 92 days later.
205 and 206 were both hired on 94-06-07.
So, both (100,200) and (200,100) should report that 200 was hired 92 days after 100.
(205,206) should report that 206 was hired 0 days after 205.
*/

select e1.employee_id, e1.first_name, e1.last_name, 
			e2.employee_id, e2.first_name, e2.last_name, 
            e1.hire_date, e2.hire_date, diff(e1.employee_id,e2.employee_id) as diff
            from employees e1 join employees e2 
            where (e1.employee_id = 100 and e2.employee_id = 200)
			   or (e1.employee_id = 200 and e2.employee_id = 100) 
			   or (e1.employee_id = 205 and e2.employee_id = 206) ;
            
/*
Output looks alright.
*/

