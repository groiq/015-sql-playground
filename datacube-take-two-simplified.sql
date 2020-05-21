-- use with caution!
drop database if exists doodles;
create database doodles;
use doodles;

/*
Simplified version of my datacube thing:

We are tracking two organisations serving two sectors,
an industry sector and an it sector.

Each has two departments, a production dept and a management dept.

Whenever someone uses a product of one of the orgs, its value is tracked,
together with the suppliying sector, the buyer sector and the buyer dept.
*/

-- core data / dimension table setup

CREATE TABLE sectors (
    sector_id INT PRIMARY KEY AUTO_INCREMENT,
    sector_name VARCHAR(32)
);

CREATE TABLE department_types (
    dept_type_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(32)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_type_id int,
    sector_id int,
    FOREIGN KEY (dept_type_id)
        REFERENCES department_types (dept_type_id),
    FOREIGN KEY (sector_id)
        REFERENCES sectors (sector_id),
    UNIQUE (sector_id , dept_type_id)
);

drop view if exists core_data;
CREATE VIEW core_data AS
    SELECT 
        dept_id, sector_id, sector_name, dept_type_id, dept_name
    FROM
        departments
            JOIN
        sectors USING (sector_id)
            JOIN
        department_types USING (dept_type_id);


-- sample core data

insert into sectors (sector_name) values ('industry');
insert into sectors (sector_name) values ('it');

insert into department_types (dept_name) values ('production');
insert into department_types (dept_name) values ('management');

insert into departments (dept_type_id, sector_id) values (1,1);
insert into departments (dept_type_id, sector_id) values (1,2);
insert into departments (dept_type_id, sector_id) values (2,1);
insert into departments (dept_type_id, sector_id) values (2,2);

select * from core_data;

-- fact table
drop table if exists purchases;
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_dept_id INT,
    supplier_sector_id INT,
    amount DECIMAL(8 , 2 ),
    FOREIGN KEY (supplier_sector_id)
        REFERENCES sectors (sector_id),
    FOREIGN KEY (customer_dept_id)
        REFERENCES departments (dept_id)
);

drop view if exists star_table;
CREATE VIEW star_table AS
    SELECT 
        purchase_id,
        customer_dept_id,
        customers.dept_name AS customer_dept_name,
        customers.sector_id AS customer_sector_id,
        customers.sector_name AS customer_sector_name,
        suppliers.sector_id AS supplier_sector_id,
        suppliers.sector_name AS supplier_sector_name,
        amount
    FROM
        purchases
            JOIN
        core_data customers ON customers.dept_id = purchases.customer_dept_id
            JOIN
        sectors suppliers ON suppliers.sector_id = purchases.supplier_sector_id;

-- sample fact data
/*
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 17.44);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 2.85);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 49.15);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 3.13);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 33.27);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 21.95);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 6.29);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 30.98);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 80.2);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 38.41);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 21.57);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 17.46);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 70.16);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 68.74);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 58.58);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 97.83);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 67.74);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 77.56);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 45.12);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 19.5);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 19.35);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 42.49);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 40.14);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 0.51);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 1.98);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 6.7);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 23.79);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 13.54);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 95.28);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 82.24);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 10.25);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 92.23);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 17.46);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 13.08);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 75.65);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 83.93);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 95.48);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 50.35);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 89.1);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 59.97);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 78.45);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 18.07);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 63.06);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 92.23);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 68.2);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 16.13);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 35.34);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 60.64);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 31.84);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 79.66);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 56.67);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 8.01);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 11.85);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 33.91);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 77.39);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 6.11);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 21.79);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 97.92);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 96.57);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 46.22);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 82.59);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 45.94);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 85.74);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 13.99);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 55.58);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 9.98);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 41.98);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 7.82);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 1.93);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 72.81);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 8.77);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 50.77);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 74.1);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 53.7);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 95.3);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 15.67);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 10.67);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 37.12);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 67.19);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 94.78);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 68.61);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 88.41);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 42.81);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 21.79);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 49.72);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 32.25);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 82.39);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 55.22);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 30.44);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 2, 1.26);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 40.9);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 2, 89.34);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 4.77);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2, 1, 61.35);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 56.95);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 2, 86.6);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4, 1, 75.55);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 1, 65.97);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3, 1, 68.13);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1, 2, 34.76);
*/

-- variant with simple fact data

insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1,1,1.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (1,2,2.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2,1,4.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (2,2,8.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3,1,16.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (3,2,32.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4,1,64.0);
insert into purchases (customer_dept_id, supplier_sector_id, amount) values (4,2,128.0);




drop view if exists simple_rollup;
CREATE VIEW simple_rollup AS
    SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY customer_dept_name , customer_sector_name , supplier_sector_name WITH ROLLUP; 

drop view if exists datacube;
CREATE VIEW datacube AS
    SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY customer_dept_name , customer_sector_name , supplier_sector_name WITH ROLLUP 
    UNION SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY customer_dept_name , supplier_sector_name , customer_sector_name WITH ROLLUP 
    UNION SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY customer_sector_name , customer_dept_name , supplier_sector_name WITH ROLLUP 
    UNION SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY customer_sector_name , supplier_sector_name , customer_dept_name WITH ROLLUP 
    UNION SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY supplier_sector_name , customer_dept_name , customer_sector_name WITH ROLLUP 
    UNION SELECT 
        customer_dept_name,
        customer_sector_name,
        supplier_sector_name,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY supplier_sector_name , customer_sector_name , customer_dept_name WITH ROLLUP;
