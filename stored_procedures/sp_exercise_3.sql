/*
Stored procedures exercises 3
*/

USE `ue_6_oder_auch_ue_5_employees`;

/*
1. Create a Stored Procedure NEW_SAL with two parameter (empno and new_sal). The purpose of this procedure is to update the attribute sal in the table. The up- date is allowed only between 9:00 AM and 5.00 PM.
         When you run the test block, you will receive the message 
         Salary Updated.
         You are doing this lesson at night, else you will receive the message Try again tomorrow            morning.
*/

-- Making the time limits editable so I don't have to wait till night for testing.

drop table if exists time_options;
create table time_options (id int primary key auto_increment, time_description varchar(32) unique, time_value time);

insert into time_options values (default,'workday_start','09:00:00');
insert into time_options values (default,'workday_end','17:00:00');

-- select * from time_options;
-- desc employees;

USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `NEW_SAL`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE PROCEDURE `NEW_SAL` (empno int, new_sal decimal(8,2))
BEGIN
	set @start = (select time_value from time_options where time_description = 'workday_start');
    set @end = (select time_value from time_options where time_description = 'workday_end');
    if 
		(time(sysdate()) >= (select time_value from time_options where time_description = 'workday_start') and
		 time(sysdate()) <= (select time_value from time_options where time_description = 'workday_end')) 
	then
		update employees set salary = new_sal where employee_id = empno;
        select 'Salary Updated.';
	else
		select 'Try again tomorrow morning.';
    end if;
END$$

DELIMITER ;

-- call new_sal(100,100);

/*
test 1: valid query

MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,salary from employees where employee_id = 100;
+-------------+----------+
| employee_id | salary   |
+-------------+----------+
|         100 | 24000.00 |
+-------------+----------+
1 row in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call new_sal(100,100);
+-----------------+
| Salary Updated. |
+-----------------+
| Salary Updated. |
+-----------------+
1 row in set (0.006 sec)

Query OK, 1 row affected (0.012 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,salary from employees where employee_id = 100;
+-------------+--------+
| employee_id | salary |
+-------------+--------+
|         100 | 100.00 |
+-------------+--------+
1 row in set (0.000 sec)
*/

/*
Test 2: fail at workday_start

MariaDB [ue_6_oder_auch_ue_5_employees]> select time_description,time_value,time(sysdate()) from time_options;
+------------------+------------+-----------------+
| time_description | time_value | time(sysdate()) |
+------------------+------------+-----------------+
| workday_start    | 09:00:00   | 11:05:35        |
| workday_end      | 17:00:00   | 11:05:35        |
+------------------+------------+-----------------+
2 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> update time_options set time_value = '16:59:00'
    -> where time_description = 'workday_start';
Query OK, 1 row affected (0.002 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [ue_6_oder_auch_ue_5_employees]> select time_description,time_value,time(sysdate()) from time_options;
+------------------+------------+-----------------+
| time_description | time_value | time(sysdate()) |
+------------------+------------+-----------------+
| workday_start    | 16:59:00   | 11:06:01        |
| workday_end      | 17:00:00   | 11:06:01        |
+------------------+------------+-----------------+
2 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call new_sal(100,200);
+-----------------------------+
| Try again tomorrow morning. |
+-----------------------------+
| Try again tomorrow morning. |
+-----------------------------+
1 row in set (0.002 sec)

Query OK, 0 rows affected (0.007 sec)
*/

/*
reset

MariaDB [ue_6_oder_auch_ue_5_employees]> update time_options set time_value = '09:00:00'
    -> where time_description = 'workday_start';
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [ue_6_oder_auch_ue_5_employees]> select time_description,time_value,time(sysdate()) from time_options;
+------------------+------------+-----------------+
| time_description | time_value | time(sysdate()) |
+------------------+------------+-----------------+
| workday_start    | 09:00:00   | 11:07:34        |
| workday_end      | 17:00:00   | 11:07:34        |
+------------------+------------+-----------------+
2 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call new_sal(100,200);
+-----------------+
| Salary Updated. |
+-----------------+
| Salary Updated. |
+-----------------+
1 row in set (0.006 sec)

Query OK, 1 row affected (0.016 sec)
*/

/*
test 3: fail at workday_end

MariaDB [ue_6_oder_auch_ue_5_employees]> update time_options set time_value = '09:01:00'
    -> where time_description = 'workday_end';
Query OK, 1 row affected (0.005 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [ue_6_oder_auch_ue_5_employees]> select time_description,time_value,time(sysdate()) from time_options;
+------------------+------------+-----------------+
| time_description | time_value | time(sysdate()) |
+------------------+------------+-----------------+
| workday_start    | 09:00:00   | 11:09:36        |
| workday_end      | 09:01:00   | 11:09:36        |
+------------------+------------+-----------------+
2 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call new_sal(100,300);
+-----------------------------+
| Try again tomorrow morning. |
+-----------------------------+
| Try again tomorrow morning. |
+-----------------------------+
1 row in set (0.001 sec)

Query OK, 0 rows affected (0.020 sec)
*/

/*
2. stelle eine Stored Procedure SAL_BEST mit folgenden Parametern: Eingabeparameter: ANZAHL
Die ersten ANZAHL Mitarbeiter mit dem höchsten Gehalt sollen in die Tabelle BEST_SAL eingetragen werden. Vorher soll die Prozedur eventuell noch vorhan- dene Sätze aus der Tabelle BEST_SAL löschen.
Die Tabelle BEST_SAL soll außerhalb der Prozedur mit den Spalten ENAME und SAL erstellt werden.
Teste die Prozedur.

*/

-- wait, I *still* don't have a function for employee name?

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `empname`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `empname` (empno int)
RETURNS VARCHAR(64)
BEGIN
	declare first varchar(20);
    declare last varchar(20);
    set first = (select first_name from employees where employee_id = empno);
    set last = (select last_name from employees where employee_id = empno);
    return concat(first, ' ', last);
END$$

DELIMITER ;

-- and I better have aliases for both 'empname' and 'ename'

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `ename`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `ename` (empno int)
RETURNS VARCHAR(64)
BEGIN
	return empname(empno);
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,first_name,last_name,empname(employee_id),ename(employee_id) from employees;
+-------------+------------+-----------+----------------------+--------------------+
| employee_id | first_name | last_name | empname(employee_id) | ename(employee_id) |
+-------------+------------+-----------+----------------------+--------------------+
|         100 | Steven     | King      | Steven King          | Steven King        |
|         101 | Neena      | Kochhar   | Neena Kochhar        | Neena Kochhar      |
|         102 | Lex        | De Haan   | Lex De Haan          | Lex De Haan        |
|         103 | Alexander  | Hunold    | Alexander Hunold     | Alexander Hunold   |
|         104 | Bruce      | Ernst     | Bruce Ernst          | Bruce Ernst        |
|         107 | Diana      | Lorentz   | Diana Lorentz        | Diana Lorentz      |
|         124 | Kevin      | Mourgos   | Kevin Mourgos        | Kevin Mourgos      |
|         141 | Trenna     | Rajs      | Trenna Rajs          | Trenna Rajs        |
|         142 | Curtis     | Davies    | Curtis Davies        | Curtis Davies      |
|         143 | Randall    | Matos     | Randall Matos        | Randall Matos      |
|         144 | Peter      | Vargas    | Peter Vargas         | Peter Vargas       |
|         149 | Eleni      | Zlotkey   | Eleni Zlotkey        | Eleni Zlotkey      |
|         174 | Ellen      | Abel      | Ellen Abel           | Ellen Abel         |
|         176 | Jonathon   | Taylor    | Jonathon Taylor      | Jonathon Taylor    |
|         178 | Kimberely  | Grant     | Kimberely Grant      | Kimberely Grant    |
|         200 | Jennifer   | Whalen    | Jennifer Whalen      | Jennifer Whalen    |
|         201 | Michael    | Hartstein | Michael Hartstein    | Michael Hartstein  |
|         202 | Pat        | Fay       | Pat Fay              | Pat Fay            |
|         205 | Shelley    | Higgins   | Shelley Higgins      | Shelley Higgins    |
|         206 | William    | Gietz     | William Gietz        | William Gietz      |
+-------------+------------+-----------+----------------------+--------------------+
20 rows in set (0.002 sec)

Okay, that works.
*/

drop table if exists best_sal;
create table BEST_SAL (employee_id int primary key, ENAME varchar(64), SAL decimal(8,2));

USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `SAL_BEST`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE PROCEDURE `SAL_BEST` (ANZAHL int)
BEGIN
	-- safe mode prevents me from deleting without a proper where clause,
    -- and I don't intend to turn it off.
	delete from best_sal where employee_id < 0;
    delete from best_sal where employee_id > -1;
    insert into best_sal 
		(select employee_id, empname(employee_id), salary from employees order by salary desc limit anzahl);
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> call sal_best(3);
Query OK, 6 rows affected (0.002 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> select * from best_sal order by sal desc;
+-------------+---------------+----------+
| employee_id | ENAME         | SAL      |
+-------------+---------------+----------+
|         100 | Steven King   | 24000.00 |
|         101 | Neena Kochhar | 17000.00 |
|         102 | Lex De Haan   | 17000.00 |
+-------------+---------------+----------+
3 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call sal_best(100);
Query OK, 23 rows affected (0.009 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> select * from best_sal order by sal desc;
+-------------+-------------------+----------+
| employee_id | ENAME             | SAL      |
+-------------+-------------------+----------+
|         100 | Steven King       | 24000.00 |
|         101 | Neena Kochhar     | 17000.00 |
|         102 | Lex De Haan       | 17000.00 |
|         201 | Michael Hartstein | 13000.00 |
|         205 | Shelley Higgins   | 12000.00 |
|         174 | Ellen Abel        | 11000.00 |
|         149 | Eleni Zlotkey     | 10500.00 |
|         103 | Alexander Hunold  |  9000.00 |
|         176 | Jonathon Taylor   |  8600.00 |
|         206 | William Gietz     |  8300.00 |
|         178 | Kimberely Grant   |  7000.00 |
|         104 | Bruce Ernst       |  6000.00 |
|         202 | Pat Fay           |  6000.00 |
|         124 | Kevin Mourgos     |  5800.00 |
|         200 | Jennifer Whalen   |  4400.00 |
|         107 | Diana Lorentz     |  4200.00 |
|         141 | Trenna Rajs       |  3500.00 |
|         142 | Curtis Davies     |  3100.00 |
|         143 | Randall Matos     |  2600.00 |
|         144 | Peter Vargas      |  2500.00 |
+-------------+-------------------+----------+
20 rows in set (0.000 sec)
*/


/*
3. Erstelle eine StoredProcedure TABSTRUCT mit folgenden Parametern: Eingabeparameter: TABNAME
Zum übergebenen Tabellennamen soll die Tabellenstruktur ermittelt und ausge- geben werden.
Die Ausgabe sollte folgendes Aussehen haben (z.B. für DEPT):

         DEPTNO NUMBER(2) DNAME VARCHAR2(14) LOC VARCHAR2(13) Teste die Prozedur.

     NOT NULL
     NULL
     NULL
 */

USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `TABSTRUCT`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE PROCEDURE `TABSTRUCT` (TABNAME varchar(64))
BEGIN
	/*
    -- variant using mysql's describe command
    set @querystr = concat('describe ',tabname);
    prepare stmt from @querystr;
    execute stmt;
    */
    -- information_schema variant
    SELECT 
    column_name,column_default,is_nullable,column_type,column_key,extra
	FROM
		information_schema.columns
	WHERE
		table_schema = 'ue_6_oder_auch_ue_5_employees' and table_name = tabname;

    
END$$

DELIMITER ;

call tabstruct('employees');

/*
-- variant using describe
MariaDB [ue_6_oder_auch_ue_5_employees]> call tabstruct('employees');
+----------------+--------------+------+-----+---------+-------+
| Field          | Type         | Null | Key | Default | Extra |
+----------------+--------------+------+-----+---------+-------+
| employee_id    | int(6)       | NO   | PRI | NULL    |       |
| first_name     | varchar(20)  | YES  |     | NULL    |       |
| last_name      | varchar(20)  | NO   |     | NULL    |       |
| email          | varchar(25)  | NO   | UNI | NULL    |       |
| phone_number   | varchar(20)  | YES  |     | NULL    |       |
| hire_date      | date         | NO   |     | NULL    |       |
| job_id         | varchar(10)  | NO   | MUL | NULL    |       |
| salary         | decimal(8,2) | YES  |     | NULL    |       |
| commission_pct | decimal(2,2) | YES  |     | NULL    |       |
| manager_id     | int(6)       | YES  | MUL | NULL    |       |
| department_id  | int(4)       | YES  | MUL | NULL    |       |
+----------------+--------------+------+-----+---------+-------+
11 rows in set (0.030 sec)

Query OK, 0 rows affected (0.063 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call tabstruct('departments');
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| department_id   | int(4)      | NO   | PRI | NULL    |       |
| department_name | varchar(30) | NO   |     | NULL    |       |
| manager_id      | int(6)      | YES  |     | NULL    |       |
| location_id     | int(4)      | YES  | MUL | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
4 rows in set (0.027 sec)

Query OK, 0 rows affected (0.043 sec)
*/
 
/*
-- variant using information_schema
MariaDB [ue_6_oder_auch_ue_5_employees]> call tabstruct('employees');
+----------------+----------------+-------------+--------------+------------+-------+
| column_name    | column_default | is_nullable | column_type  | column_key | extra |
+----------------+----------------+-------------+--------------+------------+-------+
| employee_id    | NULL           | NO          | int(6)       | PRI        |       |
| first_name     | NULL           | YES         | varchar(20)  |            |       |
| last_name      | NULL           | NO          | varchar(20)  |            |       |
| email          | NULL           | NO          | varchar(25)  | UNI        |       |
| phone_number   | NULL           | YES         | varchar(20)  |            |       |
| hire_date      | NULL           | NO          | date         |            |       |
| job_id         | NULL           | NO          | varchar(10)  | MUL        |       |
| salary         | NULL           | YES         | decimal(8,2) |            |       |
| commission_pct | NULL           | YES         | decimal(2,2) |            |       |
| manager_id     | NULL           | YES         | int(6)       | MUL        |       |
| department_id  | NULL           | YES         | int(4)       | MUL        |       |
+----------------+----------------+-------------+--------------+------------+-------+
11 rows in set (0.040 sec)

Query OK, 0 rows affected (0.117 sec)
*/

 /*
 4.  Erstelle eine StoredProcedure TABCONS mit folgenden Parametern: Eingabeparameter: TABNAME
Zum übergebenen Tabellennamen soll die Constraints dieser Tabelle ermittelt und ausgegeben werden.
Die Ausgabe sollte folgendes Aussehen haben (z.B. für EMP):

Teste die Prozedur.
 */

/*
This probably means that the requested constraints are those covered by information_schema.table_constraints,
but to make it more interesting I'll assume that the following are requested:
primary key
foreign key
unique
non-null
check constraints
default values
(These are listed as common constraints at https://www.w3schools.com/sql/sql_constraints.asp )
*/

-- for testing, I need some check constraint.
alter table employees add constraint chk_kollektivvertrag check (salary > 1500);

-- and a default value...
alter table employees 
alter salary set default 15000.0;

-- and I'd also like a composite key, 
-- so I'll assume that everyone uses landline
-- and identifies with a combinaton of phone and first name.
alter table employees
add constraint telephone unique (first_name,phone_number);

-- table_constraints covers PK, FK, Unique and checks.

/*
SELECT 
    constraint_name,constraint_type 
FROM 
    information_schema.table_constraints 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees';

+----------------------+-----------------+
| constraint_name      | constraint_type |
+----------------------+-----------------+
| PRIMARY              | PRIMARY KEY     |
| email                | UNIQUE          |
| telephone            | UNIQUE          |
| chk_kollektivvertrag | CHECK           |
| employees_ibfk_1     | FOREIGN KEY     |
| employees_ibfk_2     | FOREIGN KEY     |
| employees_ibfk_3     | FOREIGN KEY     |
+----------------------+-----------------+
7 rows in set (0.000 sec)
*/

-- columns covers non-null and default values.
        
/*
SELECT 
    column_name,column_default,is_nullable 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees';
        
+----------------+----------------+-------------+
| column_name    | column_default | is_nullable |
+----------------+----------------+-------------+
| employee_id    | NULL           | NO          |
| first_name     | NULL           | YES         |
| last_name      | NULL           | NO          |
| email          | NULL           | NO          |
| phone_number   | NULL           | YES         |
| hire_date      | NULL           | NO          |
| job_id         | NULL           | NO          |
| salary         | 15000.00       | YES         |
| commission_pct | NULL           | YES         |
| manager_id     | NULL           | YES         |
| department_id  | NULL           | YES         |
+----------------+----------------+-------------+
11 rows in set (0.022 sec)
*/        

/*
-- Okay, I'll try and union those two. For this, I'll reformat the view on columns.
-- First, filter all tuples that have either a non-null constraint
-- or a non-null default value.

SELECT 
    column_name,column_default,is_nullable 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees' 
        AND (
			is_nullable = 'NO'
            OR (
				column_default IS NOT NULL
                AND column_default != 'NULL'
                )
            )
;

+-------------+----------------+-------------+
| column_name | column_default | is_nullable |
+-------------+----------------+-------------+
| employee_id | NULL           | NO          |
| last_name   | NULL           | NO          |
| email       | NULL           | NO          |
| hire_date   | NULL           | NO          |
| job_id      | NULL           | NO          |
| salary      | 15000.00       | YES         |
+-------------+----------------+-------------+
6 rows in set (0.022 sec)
*/

-- No wait, if I want a proper list of *constraints*,
-- I want to have a non-null constraint and a default constraint on two lines,
-- even if they affect the same column!

alter table employees 
alter hire_date set default '1970-01-01';

/*
+-------------+----------------+-------------+
| column_name | column_default | is_nullable |
+-------------+----------------+-------------+
| employee_id | NULL           | NO          |
| last_name   | NULL           | NO          |
| email       | NULL           | NO          |
| hire_date   | '1970-01-01'   | NO          |
| job_id      | NULL           | NO          |
| salary      | 15000.00       | YES         |
+-------------+----------------+-------------+
6 rows in set (0.021 sec)
*/

/*
SELECT 
    column_name,column_default,is_nullable 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND is_nullable = 'NO' 
UNION ALL 
SELECT 
    column_name,column_default,is_nullable 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND (
		column_default IS NOT NULL
        AND column_default != 'NULL'
        )
;
+-------------+----------------+-------------+
| column_name | column_default | is_nullable |
+-------------+----------------+-------------+
| employee_id | NULL           | NO          |
| last_name   | NULL           | NO          |
| email       | NULL           | NO          |
| hire_date   | '1970-01-01'   | NO          |
| job_id      | NULL           | NO          |
| hire_date   | '1970-01-01'   | NO          |
| salary      | 15000.00       | YES         |
+-------------+----------------+-------------+
7 rows in set (0.033 sec)
*/

/*
Now to get the information into two columns.
For simplicity, I'll just track the kind of constraint, not its value,
meaning I'll record the default constraints as default
without telling what the default value is.
*/

/*
SELECT 
    column_name as identifier,'non-null' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND is_nullable = 'NO' 
UNION ALL 
SELECT 
    column_name as identifier,'default value' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND (
		column_default IS NOT NULL
        AND column_default != 'NULL'
        )
;
+-------------+-----------------+
| identifier  | constraint_type |
+-------------+-----------------+
| employee_id | non-null        |
| last_name   | non-null        |
| email       | non-null        |
| hire_date   | non-null        |
| job_id      | non-null        |
| hire_date   | default value   |
| salary      | default value   |
+-------------+-----------------+
7 rows in set (0.033 sec)
*/

/*
This identifies a constraint by column name, whereas table_constraint uses constraint name.
I'll include a field telling which one it is...
*/
/*
SELECT 
    'column_name' as name_type,column_name as name,'non-null' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND is_nullable = 'NO' 
UNION ALL 
SELECT 
    'column_name' as name_type,column_name as name,'default value' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND (
		column_default IS NOT NULL
        AND column_default != 'NULL'
        )
;
+-------------+-------------+-----------------+
| name_type   | name        | constraint_type |
+-------------+-------------+-----------------+
| column_name | employee_id | non-null        |
| column_name | last_name   | non-null        |
| column_name | email       | non-null        |
| column_name | hire_date   | non-null        |
| column_name | job_id      | non-null        |
| column_name | hire_date   | default value   |
| column_name | salary      | default value   |
+-------------+-------------+-----------------+
7 rows in set (0.028 sec)
*/
-- ...and now to adapt table_constraints...

/*
SELECT 
    constraint_name,constraint_type 
FROM 
    information_schema.table_constraints 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees';

+----------------------+-----------------+
| constraint_name      | constraint_type |
+----------------------+-----------------+
| PRIMARY              | PRIMARY KEY     |
| email                | UNIQUE          |
| telephone            | UNIQUE          |
| chk_kollektivvertrag | CHECK           |
| employees_ibfk_1     | FOREIGN KEY     |
| employees_ibfk_2     | FOREIGN KEY     |
| employees_ibfk_3     | FOREIGN KEY     |
+----------------------+-----------------+
7 rows in set (0.000 sec)


SELECT 
    'constraint_name' as name_type,constraint_name as name,constraint_type 
FROM 
    information_schema.table_constraints 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees';

+-----------------+----------------------+-----------------+
| name_type       | name                 | constraint_type |
+-----------------+----------------------+-----------------+
| constraint_name | PRIMARY              | PRIMARY KEY     |
| constraint_name | email                | UNIQUE          |
| constraint_name | telephone            | UNIQUE          |
| constraint_name | chk_kollektivvertrag | CHECK           |
| constraint_name | employees_ibfk_1     | FOREIGN KEY     |
| constraint_name | employees_ibfk_2     | FOREIGN KEY     |
| constraint_name | employees_ibfk_3     | FOREIGN KEY     |
+-----------------+----------------------+-----------------+
7 rows in set (0.000 sec)
*/

-- ... and I hope we can throw it all together ...

/*
SELECT 
    'constraint_name' as name_type,constraint_name as name,constraint_type 
FROM 
    information_schema.table_constraints 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
        AND table_name = 'employees'
UNION ALL 
SELECT 
    'column_name' as name_type,column_name as name,'non-null' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND is_nullable = 'NO' 
UNION ALL 
SELECT 
    'column_name' as name_type,column_name as name,'default value' as constraint_type 
FROM 
    information_schema.columns 
WHERE 
    table_schema = 'ue_6_oder_auch_ue_5_employees' 
	AND table_name = 'employees' 
	AND (
		column_default IS NOT NULL
        AND column_default != 'NULL'
        )
;
+-----------------+----------------------+-----------------+
| name_type       | name                 | constraint_type |
+-----------------+----------------------+-----------------+
| constraint_name | PRIMARY              | PRIMARY KEY     |
| constraint_name | email                | UNIQUE          |
| constraint_name | telephone            | UNIQUE          |
| constraint_name | chk_kollektivvertrag | CHECK           |
| constraint_name | employees_ibfk_1     | FOREIGN KEY     |
| constraint_name | employees_ibfk_2     | FOREIGN KEY     |
| constraint_name | employees_ibfk_3     | FOREIGN KEY     |
| column_name     | employee_id          | non-null        |
| column_name     | last_name            | non-null        |
| column_name     | email                | non-null        |
| column_name     | hire_date            | non-null        |
| column_name     | job_id               | non-null        |
| column_name     | hire_date            | default value   |
| column_name     | salary               | default value   |
+-----------------+----------------------+-----------------+
14 rows in set (0.038 sec)
*/

 -- ...and gift-wrap it.
 
USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `TABCONS`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE PROCEDURE `TABCONS` (TABNAME varchar(64))
BEGIN
	SELECT 
		'constraint_name' as name_type,constraint_name as name,constraint_type 
	FROM 
		information_schema.table_constraints 
	WHERE 
		table_schema = 'ue_6_oder_auch_ue_5_employees' 
			AND table_name = tabname
	UNION ALL
	SELECT 
		'column_name' as name_type,column_name as name,'non-null' as constraint_type 
	FROM 
		information_schema.columns 
	WHERE 
		table_schema = 'ue_6_oder_auch_ue_5_employees' 
		AND table_name = tabname 
		AND is_nullable = 'NO' 
	UNION ALL 
	SELECT 
		'column_name' as name_type,column_name as name,'default value' as constraint_type 
	FROM 
		information_schema.columns 
	WHERE 
		table_schema = 'ue_6_oder_auch_ue_5_employees' 
		AND table_name = tabname 
		AND (
			column_default IS NOT NULL
			AND column_default != 'NULL'
			)
	;
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> call tabcons('employees');
+-----------------+----------------------+-----------------+
| name_type       | name                 | constraint_type |
+-----------------+----------------------+-----------------+
| constraint_name | PRIMARY              | PRIMARY KEY     |
| constraint_name | email                | UNIQUE          |
| constraint_name | telephone            | UNIQUE          |
| constraint_name | chk_kollektivvertrag | CHECK           |
| constraint_name | employees_ibfk_1     | FOREIGN KEY     |
| constraint_name | employees_ibfk_2     | FOREIGN KEY     |
| constraint_name | employees_ibfk_3     | FOREIGN KEY     |
| column_name     | employee_id          | non-null        |
| column_name     | last_name            | non-null        |
| column_name     | email                | non-null        |
| column_name     | hire_date            | non-null        |
| column_name     | job_id               | non-null        |
| column_name     | hire_date            | default value   |
| column_name     | salary               | default value   |
+-----------------+----------------------+-----------------+
14 rows in set (0.034 sec)

Query OK, 0 rows affected (0.079 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> call tabcons('departments');
+-----------------+--------------------+-----------------+
| name_type       | name               | constraint_type |
+-----------------+--------------------+-----------------+
| constraint_name | PRIMARY            | PRIMARY KEY     |
| constraint_name | departments_ibfk_1 | FOREIGN KEY     |
| column_name     | department_id      | non-null        |
| column_name     | department_name    | non-null        |
+-----------------+--------------------+-----------------+
4 rows in set (0.027 sec)

Query OK, 0 rows affected (0.045 sec)
*/
