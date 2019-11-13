
/*
    STORED PROCEDURES EXERCISE 2
*/

USE `ue_6_oder_auch_ue_5_employees`;

/*
 1.   Erstelle eine StoredFunction EMPCOUNT mit folgenden Parametern: Eingabeparameter: DEPTNO
Zur DEPTNO soll die Anzahl der Angestellten ermittelt und zurückgegeben wer- den. Teste die Funktion.
*/

/*
expected values:

MariaDB [ue_6_oder_auch_ue_5_employees]> select department_id, department_name, count(*) from employees join departments using(department_id) group by department_id;
+---------------+-----------------+----------+
| department_id | department_name | count(*) |
+---------------+-----------------+----------+
|            10 | Administration  |        1 |
|            20 | Marketing       |        2 |
|            50 | Shipping        |        5 |
|            60 | IT              |        3 |
|            80 | Sales           |        3 |
|            90 | Executive       |        3 |
|           110 | Accounting      |        2 |
+---------------+-----------------+----------+
7 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id, department_id, department_name, count(*) from employees right join departments using(department_id) group by department_id;
+-------------+---------------+-----------------+----------+
| employee_id | department_id | department_name | count(*) |
+-------------+---------------+-----------------+----------+
|         200 |            10 | Administration  |        1 |
|         201 |            20 | Marketing       |        2 |
|         124 |            50 | Shipping        |        5 |
|         103 |            60 | IT              |        3 |
|         149 |            80 | Sales           |        3 |
|         100 |            90 | Executive       |        3 |
|         205 |           110 | Accounting      |        2 |
|        NULL |           190 | Contracting     |        1 |
+-------------+---------------+-----------------+----------+
8 rows in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]> select count(*) from employees where department_id = 190;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.001 sec)

Query should return 8 rows as above, but with 0 employees for dept. #190.
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `EMPCOUNT`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `EMPCOUNT` (DEPTNO int)
RETURNS INTEGER
BEGIN
	RETURN (select count(*) from employees where department_id = DEPTNO);
END$$

DELIMITER ;

select department_id,department_name,empcount(department_id) as employees from departments;
/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select department_id,department_name,empcount(department_id) as employees from departments;
+---------------+-----------------+-----------+
| department_id | department_name | employees |
+---------------+-----------------+-----------+
|            10 | Administration  |         1 |
|            20 | Marketing       |         2 |
|            50 | Shipping        |         5 |
|            60 | IT              |         3 |
|            80 | Sales           |         3 |
|            90 | Executive       |         3 |
|           110 | Accounting      |         2 |
|           190 | Contracting     |         0 |
+---------------+-----------------+-----------+
8 rows in set (0.001 sec)
*/


/*
2. Erstelle eine Stored Procedure EMPNAME mit folgenden Parametern: Eingabeparameter: EMPNO

CODE (1 oder 2)
Zur EMPNO soll ENAME ermittelt und als Parameter werden.

Zusätzlich werden in Abhängigkeit vom Code folgende Werte ermittelt und eben- falls als Parameter zurückgegeben:

wenn CODE 1, dann SAL+COMM,

wenn CODE 2, dann nur SAL.
Falls die Prozedur den Angestellten nicht finden kann, soll für ENAME 'Unbe- kannt' und für das Gehalt NULL ausgegeben werden.
Teste die Prozedur, indem Sie aus einem unnamed block aufgerufen wird.

*/

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id, first_name, last_name, salary, gehalt(employee_id) from employees where employee_id = 149;
+-------------+------------+-----------+----------+---------------------+
| employee_id | first_name | last_name | salary   | gehalt(employee_id) |
+-------------+------------+-----------+----------+---------------------+
|         149 | Eleni      | Zlotkey   | 10500.00 |            12600.00 |
+-------------+------------+-----------+----------+---------------------+
1 row in set (0.001 sec)
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP procedure IF EXISTS `EMPNAME`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMPNAME`(in EMPNO int, in CODE tinyint, out ename varchar(64), out gehalt decimal(8,2))
BEGIN
	-- select * from employees where employee_id = empno;
    -- select employee_id, first_name, code from employees where employee_id = empno;
    if exists (select * from employees where employee_id = empno) then
		BEGIN
			select concat(first_name, " ", last_name) 
				from employees 
                where employee_id = empno 
                into ename;
			if (code = 1) then
				begin
					set gehalt = gehalt(empno);
                end;
            elseif (code = 2) then
				begin
					select salary from employees where employee_id = empno into gehalt;
				end;
            else
				begin
					set ename = '<invalid salary code>';
					set gehalt = null;
                    
                end;
            end if;
        END;
	else
		begin
			set ename = 'unbekannt';
            set gehalt = null;
        end;
	end if;
END$$

DELIMITER ;

-- select * from employees;
set @empid = 149;
call empname(@empid,1,@ename1,@gehalt1);
call empname(@empid,2,@ename2,@gehalt2);
call empname(@empid,3,@ename3,@gehalt3);
select employee_id,first_name,last_name,salary,commission_pct,@ename1,@ename2,@gehalt1,@gehalt2,@ename3,@gehalt3 from employees where employee_id = @empid;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,first_name,last_name,salary,commission_pct
    -> from employees
    -> where employee_id = @empid;
+-------------+------------+-----------+----------+----------------+
| employee_id | first_name | last_name | salary   | commission_pct |
+-------------+------------+-----------+----------+----------------+
|         149 | Eleni      | Zlotkey   | 10500.00 |           0.20 |
+-------------+------------+-----------+----------+----------------+
1 row in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]>

MariaDB [ue_6_oder_auch_ue_5_employees]> select @ename1,@gehalt1,@ename2,@gehalt2,@ename3,@gehalt3;
+---------------+----------+---------------+----------+-----------------------+----------+
| @ename1       | @gehalt1 | @ename2       | @gehalt2 | @ename3               | @gehalt3 |
+---------------+----------+---------------+----------+-----------------------+----------+
| Eleni Zlotkey | 12600.00 | Eleni Zlotkey | 10500.00 | <invalid salary code> |     NULL |
+---------------+----------+---------------+----------+-----------------------+----------+
1 row in set (0.000 sec)

MariaDB [ue_6_oder_auch_ue_5_employees]>

*/


/*
3. ErstelleeineStoredFunctionSAL_COMMmitfolgendenParametern: Eingabeparameter: EMPNO
Zur EMPNO soll das Verhältnis zwischen SAL und COMM (Wert SAL/COMM) be- rechnet und folgender String zurückgeliefert werden: 'Verhältnis: ...'.
Hat ein Angestellter keine Provision, so soll 'Keine Provision!' zurückgeliefert wer- den (Verwende dazu die eingebaute Exception ZERO_DIVIDE).
Teste die Funktion.

*/

/*
If salary is 100 and commission is 20%, then commission_pct is 0.2.
Then commission is 100 x 0.2 = 20.
Then sal / com is 100 / (100x0.2) = 1 / (1x0.2) = 1 / 0.2 = 5
(salary is five times the commission).
Thus, the relation between sal and comm is 1 / commission_pct:

MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id, commission_pct, (1/commission_pct) from employees;
+-------------+----------------+--------------------+
| employee_id | commission_pct | (1/commission_pct) |
+-------------+----------------+--------------------+
|         100 |           NULL |               NULL |
|         101 |           NULL |               NULL |
|         102 |           NULL |               NULL |
|         103 |           NULL |               NULL |
|         104 |           NULL |               NULL |
|         107 |           NULL |               NULL |
|         124 |           NULL |               NULL |
|         141 |           NULL |               NULL |
|         142 |           NULL |               NULL |
|         143 |           NULL |               NULL |
|         144 |           NULL |               NULL |
|         149 |           0.20 |             5.0000 |
|         174 |           0.30 |             3.3333 |
|         176 |           0.20 |             5.0000 |
|         178 |           0.15 |             6.6667 |
|         200 |           NULL |               NULL |
|         201 |           NULL |               NULL |
|         202 |           NULL |               NULL |
|         205 |           NULL |               NULL |
|         206 |           NULL |               NULL |
+-------------+----------------+--------------------+
20 rows in set (0.000 sec)

So, simplest way would be to check for null and then divide 1 by commission_pct.
But a zero_divide check assumes that we already have the commisison as a numerical value.
For this, I'll first refactor commission calculation out of the gehalt function and then reuse it here.
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `commission`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `commission` (empno int)
RETURNS DECIMAL(8,2)
BEGIN
	declare interim_result decimal(8,2);
    set interim_result = (select salary from employees where employee_id = empno);
    set interim_result = interim_result * (select commission_pct from employees where employee_id = empno);
    if (interim_result is null) then
		set interim_result = 0.0;
	end if;
	RETURN interim_result;
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,salary,commission_pct,commission(employee_id) from employees;
+-------------+----------+----------------+-------------------------+
| employee_id | salary   | commission_pct | commission(employee_id) |
+-------------+----------+----------------+-------------------------+
|         100 | 24000.00 |           NULL |                    0.00 |
|         101 | 17000.00 |           NULL |                    0.00 |
|         102 | 17000.00 |           NULL |                    0.00 |
|         103 |  9000.00 |           NULL |                    0.00 |
|         104 |  6000.00 |           NULL |                    0.00 |
|         107 |  4200.00 |           NULL |                    0.00 |
|         124 |  5800.00 |           NULL |                    0.00 |
|         141 |  3500.00 |           NULL |                    0.00 |
|         142 |  3100.00 |           NULL |                    0.00 |
|         143 |  2600.00 |           NULL |                    0.00 |
|         144 |  2500.00 |           NULL |                    0.00 |
|         149 | 10500.00 |           0.20 |                 2100.00 |
|         174 | 11000.00 |           0.30 |                 3300.00 |
|         176 |  8600.00 |           0.20 |                 1720.00 |
|         178 |  7000.00 |           0.15 |                 1050.00 |
|         200 |  4400.00 |           NULL |                    0.00 |
|         201 | 13000.00 |           NULL |                    0.00 |
|         202 |  6000.00 |           NULL |                    0.00 |
|         205 | 12000.00 |           NULL |                    0.00 |
|         206 |  8300.00 |           NULL |                    0.00 |
+-------------+----------+----------------+-------------------------+
20 rows in set (0.002 sec)
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `gehalt`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `gehalt`(empno int) RETURNS decimal(8,2)
BEGIN
    return (select salary from employees where employee_id = empno) + commission(empno);
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,salary,commission_pct,gehalt(employee_id) from employees;
+-------------+----------+----------------+---------------------+
| employee_id | salary   | commission_pct | gehalt(employee_id) |
+-------------+----------+----------------+---------------------+
|         100 | 24000.00 |           NULL |            24000.00 |
|         101 | 17000.00 |           NULL |            17000.00 |
|         102 | 17000.00 |           NULL |            17000.00 |
|         103 |  9000.00 |           NULL |             9000.00 |
|         104 |  6000.00 |           NULL |             6000.00 |
|         107 |  4200.00 |           NULL |             4200.00 |
|         124 |  5800.00 |           NULL |             5800.00 |
|         141 |  3500.00 |           NULL |             3500.00 |
|         142 |  3100.00 |           NULL |             3100.00 |
|         143 |  2600.00 |           NULL |             2600.00 |
|         144 |  2500.00 |           NULL |             2500.00 |
|         149 | 10500.00 |           0.20 |            12600.00 |
|         174 | 11000.00 |           0.30 |            14300.00 |
|         176 |  8600.00 |           0.20 |            10320.00 |
|         178 |  7000.00 |           0.15 |             8050.00 |
|         200 |  4400.00 |           NULL |             4400.00 |
|         201 | 13000.00 |           NULL |            13000.00 |
|         202 |  6000.00 |           NULL |             6000.00 |
|         205 | 12000.00 |           NULL |            12000.00 |
|         206 |  8300.00 |           NULL |             8300.00 |
+-------------+----------+----------------+---------------------+
20 rows in set (0.003 sec)
*/

USE `ue_6_oder_auch_ue_5_employees`;
DROP function IF EXISTS `SAL_COMM`;

DELIMITER $$
USE `ue_6_oder_auch_ue_5_employees`$$
CREATE FUNCTION `SAL_COMM`(EMPNO int)
RETURNS VARCHAR(32)
BEGIN
	declare result varchar(32);
    declare amount decimal(8,2);
	/*declare continue handler for divide_by_zero
    begin
		set result = 'Keine Provision!';
	end;*/
    set amount = (select salary from employees where employee_id = EMPNO) / commission(empno);
    -- set result = concat('Verhaeltnis: ', amount);
    set result = ifnull(concat('Verhaeltnis: ', amount),'Keine Provision!');
	RETURN result;
END$$

DELIMITER ;

/*
MariaDB [ue_6_oder_auch_ue_5_employees]> select employee_id,salary,commission_pct,commission(employee_id),sal_comm(employee_id) from employees;
+-------------+----------+----------------+-------------------------+-----------------------+
| employee_id | salary   | commission_pct | commission(employee_id) | sal_comm(employee_id) |
+-------------+----------+----------------+-------------------------+-----------------------+
|         100 | 24000.00 |           NULL |                    0.00 | Keine Provision!      |
|         101 | 17000.00 |           NULL |                    0.00 | Keine Provision!      |
|         102 | 17000.00 |           NULL |                    0.00 | Keine Provision!      |
|         103 |  9000.00 |           NULL |                    0.00 | Keine Provision!      |
|         104 |  6000.00 |           NULL |                    0.00 | Keine Provision!      |
|         107 |  4200.00 |           NULL |                    0.00 | Keine Provision!      |
|         124 |  5800.00 |           NULL |                    0.00 | Keine Provision!      |
|         141 |  3500.00 |           NULL |                    0.00 | Keine Provision!      |
|         142 |  3100.00 |           NULL |                    0.00 | Keine Provision!      |
|         143 |  2600.00 |           NULL |                    0.00 | Keine Provision!      |
|         144 |  2500.00 |           NULL |                    0.00 | Keine Provision!      |
|         149 | 10500.00 |           0.20 |                 2100.00 | Verhaeltnis: 5.00     |
|         174 | 11000.00 |           0.30 |                 3300.00 | Verhaeltnis: 3.33     |
|         176 |  8600.00 |           0.20 |                 1720.00 | Verhaeltnis: 5.00     |
|         178 |  7000.00 |           0.15 |                 1050.00 | Verhaeltnis: 6.67     |
|         200 |  4400.00 |           NULL |                    0.00 | Keine Provision!      |
|         201 | 13000.00 |           NULL |                    0.00 | Keine Provision!      |
|         202 |  6000.00 |           NULL |                    0.00 | Keine Provision!      |
|         205 | 12000.00 |           NULL |                    0.00 | Keine Provision!      |
|         206 |  8300.00 |           NULL |                    0.00 | Keine Provision!      |
+-------------+----------+----------------+-------------------------+-----------------------+
20 rows in set (0.004 sec)
*/


/*
4. The purpose of the procedure sell is to accept the paint_id parameter passed and update the stock on hand quantity by the qty value parameter. If there is insufficient stock then we need to produce an error message.
Before we get started with the procedure we need to quickly create the table (paints) that our Procedure will update.

The desc(ription) of our table should be.

   SQL> desc paints;
   Name                            Null?    Type
   ------------------------------- -------- ----
PT_ID
PT_NAME
PT_STK_ON_HAND
*/

drop database if exists paint_shop;
create database paint_shop;
use paint_shop;

create table paints (pt_id int primary key auto_increment, pt_name varchar(32), pt_stk_on_hand int );

USE `paint_shop`;
DROP procedure IF EXISTS `sell`;

DELIMITER $$
USE `paint_shop`$$
CREATE PROCEDURE `sell` (paint_id int,qty int)
BEGIN
	set qty = (select pt_stk_on_hand from paints where pt_id = paint_id) - qty;
	if (qty < 0) then
		signal sqlstate '45000'
        set message_text = 'attempting to sell more than is in stock';
    else
		update paints set pt_stk_on_hand = qty where pt_id = paint_id;
    end if;
END$$

DELIMITER ;

insert into paints (pt_name, pt_stk_on_hand) values ('#000000', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#0000FF', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#00FF00', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#00FFFF', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#FF0000', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#FF00FF', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#FFFF00', 100);
insert into paints (pt_name, pt_stk_on_hand) values ('#FFFFFF', 100);

/*
MariaDB [paint_shop]> select * from paints;
+-------+---------+----------------+
| pt_id | pt_name | pt_stk_on_hand |
+-------+---------+----------------+
|     1 | #000000 |            100 |
|     2 | #0000FF |            100 |
|     3 | #00FF00 |            100 |
|     4 | #00FFFF |            100 |
|     5 | #FF0000 |            100 |
|     6 | #FF00FF |            100 |
|     7 | #FFFF00 |            100 |
|     8 | #FFFFFF |            100 |
+-------+---------+----------------+
8 rows in set (0.000 sec)

MariaDB [paint_shop]> call sell(1,75);
Query OK, 1 row affected (0.005 sec)

MariaDB [paint_shop]> select * from paints;
+-------+---------+----------------+
| pt_id | pt_name | pt_stk_on_hand |
+-------+---------+----------------+
|     1 | #000000 |             25 |
|     2 | #0000FF |            100 |
|     3 | #00FF00 |            100 |
|     4 | #00FFFF |            100 |
|     5 | #FF0000 |            100 |
|     6 | #FF00FF |            100 |
|     7 | #FFFF00 |            100 |
|     8 | #FFFFFF |            100 |
+-------+---------+----------------+
8 rows in set (0.000 sec)

MariaDB [paint_shop]> call sell(2,150);
ERROR 1644 (45000): attempting to sell more than is in stock
MariaDB [paint_shop]> select * from paints;
+-------+---------+----------------+
| pt_id | pt_name | pt_stk_on_hand |
+-------+---------+----------------+
|     1 | #000000 |             25 |
|     2 | #0000FF |            100 |
|     3 | #00FF00 |            100 |
|     4 | #00FFFF |            100 |
|     5 | #FF0000 |            100 |
|     6 | #FF00FF |            100 |
|     7 | #FFFF00 |            100 |
|     8 | #FFFFFF |            100 |
+-------+---------+----------------+
8 rows in set (0.001 sec)

MariaDB [paint_shop]>
*/
