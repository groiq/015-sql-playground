drop database if exists doodles;
create database doodles;
use doodles;

/******************************************************/
/* Building a datacube step by step using with rollup */
/******************************************************/

/*
This is about emulating the with cube command using with rollup. I'm doing this step by step.

Using a 2d setup for clarity. 
*/

/*
Setting up files

My standard scenario: Tracking the flow of goods to and from various sectors. 

I imagine there's a smith and a carpenter and I'm tracking 
how each is using items (of what cost) from each. 

note: for presenting better take something that works without self joins, e.g. store depts and cities.
*/

-- core data / dimension table

CREATE TABLE sectors (
    sector_id INT PRIMARY KEY,
    sector_name VARCHAR(32)
);

insert into sectors (sector_id, sector_name) values (1, "carpenter");
insert into sectors (sector_id, sector_name) values (2, "smith");

-- fact table

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    supplier_id INT,
    customer_id INT,
    amount DECIMAL(8 , 2 ),
    FOREIGN KEY (supplier_id)
        REFERENCES sectors (sector_id),
    FOREIGN KEY (customer_id)
        REFERENCES sectors (sector_id)
);

insert into purchases (purchase_id, supplier_id, customer_id, amount) values (1,1,1,1.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (2,1,1,2.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (3,1,2,10.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (4,1,2,20.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (5,2,1,100.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (6,2,1,200.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (7,2,2,1000.0);
insert into purchases (purchase_id, supplier_id, customer_id, amount) values (8,2,2,2000.0);

-- star table
drop view if exists star_table;
CREATE VIEW star_table AS
    SELECT 
        purchase_id,
        supplier_id,
        suppliers.sector_name AS supplier_name,
        customer_id,
        customers.sector_name AS customer_name,
        amount
    FROM
        purchases
            JOIN
        sectors suppliers ON purchases.supplier_id = suppliers.sector_id
            JOIN
        sectors customers ON purchases.customer_id = customers.sector_id;

/*
MariaDB [doodles]> select * from star_table;
+-------------+-------------+---------------+-------------+---------------+---------+
| purchase_id | supplier_id | supplier_name | customer_id | customer_name | amount  |
+-------------+-------------+---------------+-------------+---------------+---------+
|           1 |           1 | carpenter     |           1 | carpenter     |    1.00 |
|           2 |           1 | carpenter     |           1 | carpenter     |    2.00 |
|           3 |           1 | carpenter     |           2 | smith         |   10.00 |
|           4 |           1 | carpenter     |           2 | smith         |   20.00 |
|           5 |           2 | smith         |           1 | carpenter     |  100.00 |
|           6 |           2 | smith         |           1 | carpenter     |  200.00 |
|           7 |           2 | smith         |           2 | smith         | 1000.00 |
|           8 |           2 | smith         |           2 | smith         | 2000.00 |
+-------------+-------------+---------------+-------------+---------------+---------+
8 rows in set (0.000 sec)
*/

/*
MariaDB [doodles]> -- now, first aggregate for every combination of supplier and customer id:
MariaDB [doodles]> select supplier_id, customer_id, sum(amount) from purchases group by supplier_id, customer_id;
+-------------+-------------+-------------+
| supplier_id | customer_id | sum(amount) |
+-------------+-------------+-------------+
|           1 |           1 |        3.00 |
|           1 |           2 |       30.00 |
|           2 |           1 |      300.00 |
|           2 |           2 |     3000.00 |
+-------------+-------------+-------------+
4 rows in set (0.000 sec)

MariaDB [doodles]> -- then add a rollup
MariaDB [doodles]> select supplier_id, customer_id, sum(amount) from purchases group by supplier_id, customer_id with rollup;
+-------------+-------------+-------------+
| supplier_id | customer_id | sum(amount) |
+-------------+-------------+-------------+
|           1 |           1 |        3.00 |
|           1 |           2 |       30.00 |
|           1 |        NULL |       33.00 |
|           2 |           1 |      300.00 |
|           2 |           2 |     3000.00 |
|           2 |        NULL |     3300.00 |
|        NULL |        NULL |     3333.00 |
+-------------+-------------+-------------+
7 rows in set (0.000 sec)

MariaDB [doodles]> -- Now I know from each supplier how much they supplied to both customers added up.
MariaDB [doodles]> -- What I don
MariaDB [doodles]> -- What I don't know is how much each customer has purchased from each supplier.
MariaDB [doodles]> -- e.g. I can see that supplier 1 delivered goods for 33.0 E to all the parties together.
MariaDB [doodles]> -- But I cannot see how much customer 1 bought from all the parties.
MariaDB [doodles]> -- For this, I need to change the order in the group by clause:
MariaDB [doodles]> select supplier_id, customer_id, sum(amount) from purchases group by customer_id, supplier_id with rollup;
+-------------+-------------+-------------+
| supplier_id | customer_id | sum(amount) |
+-------------+-------------+-------------+
|           1 |           1 |        3.00 |
|           2 |           1 |      300.00 |
|        NULL |           1 |      303.00 |
|           1 |           2 |       30.00 |
|           2 |           2 |     3000.00 |
|        NULL |           2 |     3030.00 |
|        NULL |        NULL |     3333.00 |
+-------------+-------------+-------------+
7 rows in set (0.001 sec)

MariaDB [doodles]> -- ...and we see that customer 1 spent 303 euro in total.
MariaDB [doodles]> -- For a complete data cube, we need to union that:
MariaDB [doodles]> select supplier_id, customer_id, sum(amount) from purchases group by supplier_id, customer_id with rollup
    -> union
    -> select supplier_id, customer_id, sum(amount) from purchases group by customer_id, supplier_id with rollup;
+-------------+-------------+-------------+
| supplier_id | customer_id | sum(amount) |
+-------------+-------------+-------------+
|           1 |           1 |        3.00 |
|           1 |           2 |       30.00 |
|           1 |        NULL |       33.00 |
|           2 |           1 |      300.00 |
|           2 |           2 |     3000.00 |
|           2 |        NULL |     3300.00 |
|        NULL |        NULL |     3333.00 |
|        NULL |           1 |      303.00 |
|        NULL |           2 |     3030.00 |
+-------------+-------------+-------------+
9 rows in set (0.001 sec)

MariaDB [doodles]> -- ... and we can see both that supplier 1 earned 33 E and that supplier 1 spent 303 E in total.
MariaDB [doodles]> --
MariaDB [doodles]> -- Now, for a 3d cube we need *six* selects, with the group by orders being
MariaDB [doodles]> -- 1-2-3, 1-3-2, 2-1-3, 2-3-1, 3-1-2, 3-2-1
MariaDB [doodles]>
*/