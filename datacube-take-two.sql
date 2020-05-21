drop database if exists doodles;
create database doodles;
use doodles;

/*
using date from mockaroo, i can do this:

We have a list of people for some reason. 
Everybody is in a specific company, in a specific corporate department, and lives in a specific city.
Each company is in a stock industry.

Or:

A company is in a sector. A person is responsible for a department of a company.
For this dept, they purchase stuff from a different company. 
Thus, we can model how goods or their values flow from one company (/sector) to a company or dept. 

Or:
Mockaroo also has a field for "department (retail)". So we can model how a company sells goods to a retail dept
which are in turn purchased by a second retail dept. 

I kinda like the second idea. It contains (1) the dynamics of means and ends and 
(2) differentiation between a company / its sector and a dept,
i.e. (so to say) between a project and a role within a project. 
*/

/*
numbers:
10 sectors
10 depts
50 companies
250 company depts, identified by a responsible purchaser
1000 purchases
*/

/*
create table sectors (sector_id int primary key auto_increment, sector_name varchar(64), unique (sector_name));
insert into sectors (sector_name) values ('Energy');
insert into sectors (sector_name) values ('Health Care');
insert into sectors (sector_name) values ('Consumer Services');
insert into sectors (sector_name) values ('Finance');
insert into sectors (sector_name) values ('Technology');
insert into sectors (sector_name) values ('Consumer Non-Durables');
insert into sectors (sector_name) values ('Public Utilities');
insert into sectors (sector_name) values ('Basic Industries');
insert into sectors (sector_name) values ('Capital Goods');
insert into sectors (sector_name) values ('Transportation');
*/

/*
revised numbers:
20 companies
100 company depts, identified by a responsible purchaser
500 purchases
*/

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(64),
    sector VARCHAR(64),
    UNIQUE (company_name)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    company_id INT,
    dept_name VARCHAR(64),
    head_name VARCHAR(64),
    FOREIGN KEY (company_id)
        REFERENCES companies (company_id),
    UNIQUE (company_id , dept_name)
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_id INT,
    supplier_id INT,
    amount DECIMAL(8 , 2 ),
    FOREIGN KEY (dept_id)
        REFERENCES departments (dept_id),
    FOREIGN KEY (supplier_id)
        REFERENCES companies (company_id)
);

insert into companies (company_name, sector) values ('Durgan, Nicolas and Kuvalis', 'n/a');
insert into companies (company_name, sector) values ('Zulauf-Monahan', 'Energy');
insert into companies (company_name, sector) values ('Farrell-Nienow', 'Technology');
insert into companies (company_name, sector) values ('Nitzsche-Little', 'Energy');
insert into companies (company_name, sector) values ('Kohler, Kautzer and Green', 'Public Utilities');
insert into companies (company_name, sector) values ('Dare, Corkery and Klocko', 'Capital Goods');
insert into companies (company_name, sector) values ('Bernhard-Johnston', 'Finance');
insert into companies (company_name, sector) values ('Fay, Crona and Hickle', 'Basic Industries');
insert into companies (company_name, sector) values ('Doyle, Hills and Abshire', 'Finance');
insert into companies (company_name, sector) values ('Yost and Sons', 'Consumer Services');
insert into companies (company_name, sector) values ('Gorczany and Sons', 'n/a');
insert into companies (company_name, sector) values ('Hackett LLC', 'Health Care');
insert into companies (company_name, sector) values ('Klocko and Sons', 'n/a');
insert into companies (company_name, sector) values ('Bosco-Barton', 'Technology');
insert into companies (company_name, sector) values ('Botsford-Leannon', 'Consumer Services');
insert into companies (company_name, sector) values ('Gislason, Bauch and Daugherty', 'Finance');
insert into companies (company_name, sector) values ('Kutch, Schuppe and Emard', 'Consumer Durables');
insert into companies (company_name, sector) values ('Ernser and Sons', 'Health Care');
insert into companies (company_name, sector) values ('Wunsch, Quigley and Klocko', 'Finance');
insert into companies (company_name, sector) values ('Schneider Inc', 'Finance');

-- dept inserts - first block, with duplicates removed

insert into departments (dept_id, company_id, dept_name, head_name) values (1, 12, 'Sales', 'Caesar Buey');
insert into departments (dept_id, company_id, dept_name, head_name) values (2, 15, 'Engineering', 'Colline Dounbare');
insert into departments (dept_id, company_id, dept_name, head_name) values (3, 1, 'Accounting', 'Lola Hoppner');
insert into departments (dept_id, company_id, dept_name, head_name) values (4, 7, 'Business Development', 'Ricca Braz');
insert into departments (dept_id, company_id, dept_name, head_name) values (5, 14, 'Services', 'Haily Iwanczyk');
insert into departments (dept_id, company_id, dept_name, head_name) values (6, 8, 'Research and Development', 'Kara Clemencon');
insert into departments (dept_id, company_id, dept_name, head_name) values (7, 17, 'Product Management', 'Sheila Levington');
insert into departments (dept_id, company_id, dept_name, head_name) values (8, 20, 'Research and Development', 'Lionel Elders');
insert into departments (dept_id, company_id, dept_name, head_name) values (9, 4, 'Engineering', 'Clareta Burcher');
insert into departments (dept_id, company_id, dept_name, head_name) values (10, 12, 'Training', 'Harlen McCotter');
insert into departments (dept_id, company_id, dept_name, head_name) values (11, 20, 'Human Resources', 'Maggee Adlem');
insert into departments (dept_id, company_id, dept_name, head_name) values (12, 19, 'Accounting', 'Gauthier Sacker');
insert into departments (dept_id, company_id, dept_name, head_name) values (13, 12, 'Services', 'Friedrich Beaumont');
insert into departments (dept_id, company_id, dept_name, head_name) values (14, 13, 'Training', 'Bili Barbey');
insert into departments (dept_id, company_id, dept_name, head_name) values (15, 12, 'Accounting', 'Brook Velez');
insert into departments (dept_id, company_id, dept_name, head_name) values (16, 3, 'Human Resources', 'Ilse Tivolier');
insert into departments (dept_id, company_id, dept_name, head_name) values (17, 13, 'Engineering', 'Nettie Petruk');
insert into departments (dept_id, company_id, dept_name, head_name) values (18, 2, 'Support', 'Daisi Drust');
insert into departments (dept_id, company_id, dept_name, head_name) values (19, 5, 'Business Development', 'Brigida Westwell');
insert into departments (dept_id, company_id, dept_name, head_name) values (20, 8, 'Marketing', 'Magdalena Szantho');
insert into departments (dept_id, company_id, dept_name, head_name) values (21, 1, 'Legal', 'Durante Ridley');
insert into departments (dept_id, company_id, dept_name, head_name) values (22, 2, 'Services', 'Ava Northcott');
insert into departments (dept_id, company_id, dept_name, head_name) values (23, 19, 'Training', 'Sukey Edlington');
insert into departments (dept_id, company_id, dept_name, head_name) values (24, 19, 'Product Management', 'Cross Pawnsford');
insert into departments (dept_id, company_id, dept_name, head_name) values (25, 10, 'Engineering', 'Alwin Yerill');
insert into departments (dept_id, company_id, dept_name, head_name) values (26, 3, 'Engineering', 'Alastair Burdus');
insert into departments (dept_id, company_id, dept_name, head_name) values (27, 13, 'Services', 'Daryl Syder');
insert into departments (dept_id, company_id, dept_name, head_name) values (28, 13, 'Human Resources', 'Chadwick Hirtzmann');
insert into departments (dept_id, company_id, dept_name, head_name) values (29, 15, 'Accounting', 'Alfi Pickerin');
insert into departments (dept_id, company_id, dept_name, head_name) values (30, 4, 'Services', 'Carolan Helks');
insert into departments (dept_id, company_id, dept_name, head_name) values (32, 6, 'Business Development', 'Benoite Pele');
insert into departments (dept_id, company_id, dept_name, head_name) values (34, 2, 'Accounting', 'Jorrie Hrynczyk');
insert into departments (dept_id, company_id, dept_name, head_name) values (35, 4, 'Business Development', 'Nicolais Claremont');
insert into departments (dept_id, company_id, dept_name, head_name) values (36, 5, 'Marketing', 'Gaynor Gontier');
insert into departments (dept_id, company_id, dept_name, head_name) values (37, 19, 'Human Resources', 'Sonnie Sarfatti');
insert into departments (dept_id, company_id, dept_name, head_name) values (38, 1, 'Product Management', 'Amii Anthony');
insert into departments (dept_id, company_id, dept_name, head_name) values (39, 3, 'Business Development', 'Aeriel Ciccottio');
insert into departments (dept_id, company_id, dept_name, head_name) values (41, 15, 'Support', 'Johnny Beer');
insert into departments (dept_id, company_id, dept_name, head_name) values (42, 16, 'Sales', 'Phillipe Wildsmith');
insert into departments (dept_id, company_id, dept_name, head_name) values (44, 14, 'Accounting', 'Ikey Insko');
insert into departments (dept_id, company_id, dept_name, head_name) values (45, 7, 'Accounting', 'Ramona Erie');
insert into departments (dept_id, company_id, dept_name, head_name) values (46, 16, 'Product Management', 'Marsiella Cawsy');
insert into departments (dept_id, company_id, dept_name, head_name) values (47, 18, 'Sales', 'Gale Vasey');
insert into departments (dept_id, company_id, dept_name, head_name) values (48, 6, 'Support', 'Giovanna Drepp');
insert into departments (dept_id, company_id, dept_name, head_name) values (49, 6, 'Legal', 'Leonard Gettens');
insert into departments (dept_id, company_id, dept_name, head_name) values (50, 19, 'Marketing', 'Winslow Joselson');
insert into departments (dept_id, company_id, dept_name, head_name) values (51, 15, 'Sales', 'Scotty Gantzman');
insert into departments (dept_id, company_id, dept_name, head_name) values (52, 6, 'Product Management', 'Chase Reach');
insert into departments (dept_id, company_id, dept_name, head_name) values (53, 3, 'Training', 'Abie Everington');
insert into departments (dept_id, company_id, dept_name, head_name) values (54, 12, 'Product Management', 'Jessamyn Reddington');
insert into departments (dept_id, company_id, dept_name, head_name) values (55, 8, 'Product Management', 'Kristine Cruickshanks');
insert into departments (dept_id, company_id, dept_name, head_name) values (56, 13, 'Sales', 'Xerxes Tatlow');
insert into departments (dept_id, company_id, dept_name, head_name) values (57, 5, 'Legal', 'Lizette Poge');
insert into departments (dept_id, company_id, dept_name, head_name) values (58, 17, 'Accounting', 'Lucia Elnough');
insert into departments (dept_id, company_id, dept_name, head_name) values (59, 11, 'Legal', 'Uta Dows');
insert into departments (dept_id, company_id, dept_name, head_name) values (60, 18, 'Business Development', 'Marlowe Briggs');
insert into departments (dept_id, company_id, dept_name, head_name) values (61, 3, 'Research and Development', 'Diana Malpas');
insert into departments (dept_id, company_id, dept_name, head_name) values (62, 14, 'Training', 'Natividad Hallbord');
insert into departments (dept_id, company_id, dept_name, head_name) values (63, 11, 'Research and Development', 'Harvey Frensche');
insert into departments (dept_id, company_id, dept_name, head_name) values (64, 5, 'Training', 'Matilda Nottingam');
insert into departments (dept_id, company_id, dept_name, head_name) values (65, 1, 'Business Development', 'Joelynn Tweddell');
insert into departments (dept_id, company_id, dept_name, head_name) values (66, 15, 'Training', 'Shandra Dawber');
insert into departments (dept_id, company_id, dept_name, head_name) values (69, 19, 'Business Development', 'Sherye Boig');
insert into departments (dept_id, company_id, dept_name, head_name) values (70, 15, 'Business Development', 'Jacquette Chantree');
insert into departments (dept_id, company_id, dept_name, head_name) values (71, 5, 'Human Resources', 'Gunner Bramelt');
insert into departments (dept_id, company_id, dept_name, head_name) values (72, 4, 'Accounting', 'Adora Ades');
insert into departments (dept_id, company_id, dept_name, head_name) values (73, 7, 'Legal', 'Celestina Sayward');
insert into departments (dept_id, company_id, dept_name, head_name) values (76, 20, 'Marketing', 'Asa Dofty');
insert into departments (dept_id, company_id, dept_name, head_name) values (77, 15, 'Marketing', 'Clemente Wallas');
insert into departments (dept_id, company_id, dept_name, head_name) values (79, 1, 'Support', 'Alexandre Verrillo');
insert into departments (dept_id, company_id, dept_name, head_name) values (80, 15, 'Product Management', 'Kathrine Geck');
insert into departments (dept_id, company_id, dept_name, head_name) values (83, 9, 'Product Management', 'Hali Jacquemy');
insert into departments (dept_id, company_id, dept_name, head_name) values (84, 7, 'Product Management', 'Adrianne Ferrige');
insert into departments (dept_id, company_id, dept_name, head_name) values (85, 7, 'Training', 'Gage Grimestone');
insert into departments (dept_id, company_id, dept_name, head_name) values (87, 16, 'Human Resources', 'Eadmund Roux');
insert into departments (dept_id, company_id, dept_name, head_name) values (89, 19, 'Sales', 'Noami Demangel');
insert into departments (dept_id, company_id, dept_name, head_name) values (90, 11, 'Business Development', 'Marys Landers');
insert into departments (dept_id, company_id, dept_name, head_name) values (91, 14, 'Sales', 'Sophronia Dangl');
insert into departments (dept_id, company_id, dept_name, head_name) values (92, 7, 'Research and Development', 'Cris Towsey');
insert into departments (dept_id, company_id, dept_name, head_name) values (93, 8, 'Support', 'Gladys Frarey');
insert into departments (dept_id, company_id, dept_name, head_name) values (94, 9, 'Research and Development', 'George Blencoe');
insert into departments (dept_id, company_id, dept_name, head_name) values (96, 1, 'Marketing', 'Fred Leng');
insert into departments (dept_id, company_id, dept_name, head_name) values (98, 16, 'Business Development', 'Hashim Lawey');
insert into departments (dept_id, company_id, dept_name, head_name) values (99, 20, 'Support', 'Aurlie felip');

-- dept inserts - second block, filling the blanks

insert into departments (dept_id, company_id, dept_name, head_name) values (31, 16, 'Marketing', 'Adamo Beentjes');
insert into departments (dept_id, company_id, dept_name, head_name) values (33, 7, 'Marketing', 'Belicia Molan');
insert into departments (dept_id, company_id, dept_name, head_name) values (40, 13, 'Support', 'Kial Widdup');
insert into departments (dept_id, company_id, dept_name, head_name) values (43, 17, 'Sales', 'Paloma Swindley');
insert into departments (dept_id, company_id, dept_name, head_name) values (67, 11, 'Engineering', 'Kingsley Ditchburn');
insert into departments (dept_id, company_id, dept_name, head_name) values (68, 20, 'Training', 'Obed Way');
insert into departments (dept_id, company_id, dept_name, head_name) values (74, 9, 'Marketing', 'Juliann Roast');
insert into departments (dept_id, company_id, dept_name, head_name) values (75, 17, 'Services', 'Sheree Burdis');
insert into departments (dept_id, company_id, dept_name, head_name) values (78, 11, 'Support', 'Laurena Mountain');
insert into departments (dept_id, company_id, dept_name, head_name) values (81, 10, 'Marketing', 'Ingar Suddaby');
insert into departments (dept_id, company_id, dept_name, head_name) values (82, 9, 'Sales', 'Miranda Saffle');
insert into departments (dept_id, company_id, dept_name, head_name) values (86, 19, 'Support', 'Marcela Gashion');
insert into departments (dept_id, company_id, dept_name, head_name) values (88, 19, 'Legal', 'Austine Barfield');
insert into departments (dept_id, company_id, dept_name, head_name) values (95, 1, 'Training', 'Wye Kellitt');
insert into departments (dept_id, company_id, dept_name, head_name) values (97, 8, 'Business Development', 'Carmela Penhale');
insert into departments (dept_id, company_id, dept_name, head_name) values (100 , 3, 'Marketing', 'Cora Presman');

-- backup dept inserts
/*
insert into departments (dept_id, company_id, dept_name, head_name) values (130, 14, 'Human Resources', 'Rob Faraday');
insert into departments (dept_id, company_id, dept_name, head_name) values (131, 20, 'Marketing', 'Tyson Nicolson');
insert into departments (dept_id, company_id, dept_name, head_name) values (132, 12, 'Research and Development', 'Tracie Wassell');
insert into departments (dept_id, company_id, dept_name, head_name) values (133, 16, 'Support', 'Butch Pohls');
insert into departments (dept_id, company_id, dept_name, head_name) values (134, 7, 'Training', 'Florencia Grim');
insert into departments (dept_id, company_id, dept_name, head_name) values (135, 13, 'Accounting', 'Tamarra Haxley');
insert into departments (dept_id, company_id, dept_name, head_name) values (136, 18, 'Legal', 'Decca Kattenhorn');
insert into departments (dept_id, company_id, dept_name, head_name) values (137, 16, 'Support', 'Leroy Hassekl');
insert into departments (dept_id, company_id, dept_name, head_name) values (138, 20, 'Support', 'Neils McNickle');
insert into departments (dept_id, company_id, dept_name, head_name) values (139, 4, 'Support', 'Lyndsey Bleakman');
insert into departments (dept_id, company_id, dept_name, head_name) values (140, 9, 'Legal', 'Mohandis Taleworth');
insert into departments (dept_id, company_id, dept_name, head_name) values (141, 14, 'Support', 'Livvy Stiant');
insert into departments (dept_id, company_id, dept_name, head_name) values (142, 13, 'Marketing', 'Stephan Krikorian');
insert into departments (dept_id, company_id, dept_name, head_name) values (143, 6, 'Business Development', 'Reggy Fairn');
insert into departments (dept_id, company_id, dept_name, head_name) values (144, 9, 'Human Resources', 'Carmen Cases');
insert into departments (dept_id, company_id, dept_name, head_name) values (145, 6, 'Services', 'Joyann Phethean');
insert into departments (dept_id, company_id, dept_name, head_name) values (146, 17, 'Marketing', 'Nichole Fairbourne');
insert into departments (dept_id, company_id, dept_name, head_name) values (147, 3, 'Services', 'Georgetta Avery');
insert into departments (dept_id, company_id, dept_name, head_name) values (148, 6, 'Engineering', 'Haze McMearty');
insert into departments (dept_id, company_id, dept_name, head_name) values (149, 18, 'Sales', 'Kristel Whitney');
insert into departments (dept_id, company_id, dept_name, head_name) values (150, 1, 'Support', 'Spencer Sollowaye');
insert into departments (dept_id, company_id, dept_name, head_name) values (151, 20, 'Support', 'Nathanial Stutard');
insert into departments (dept_id, company_id, dept_name, head_name) values (152, 4, 'Human Resources', 'Corilla Lynett');
insert into departments (dept_id, company_id, dept_name, head_name) values (153, 11, 'Research and Development', 'Harmon Blaxter');
insert into departments (dept_id, company_id, dept_name, head_name) values (154, 8, 'Product Management', 'Artair Tuer');
insert into departments (dept_id, company_id, dept_name, head_name) values (155, 13, 'Human Resources', 'Emlynne Buffham');
insert into departments (dept_id, company_id, dept_name, head_name) values (156, 1, 'Product Management', 'Hailey Ventham');
insert into departments (dept_id, company_id, dept_name, head_name) values (157, 19, 'Training', 'Weston Franciottoi');
insert into departments (dept_id, company_id, dept_name, head_name) values (158, 17, 'Business Development', 'Evered Amdohr');
insert into departments (dept_id, company_id, dept_name, head_name) values (159, 1, 'Product Management', 'Enrico Dimelow');
insert into departments (dept_id, company_id, dept_name, head_name) values (160, 13, 'Engineering', 'Peterus Cogar');
insert into departments (dept_id, company_id, dept_name, head_name) values (161, 4, 'Business Development', 'Orel Leftwich');
insert into departments (dept_id, company_id, dept_name, head_name) values (162, 11, 'Research and Development', 'Bonnibelle Rozzell');
insert into departments (dept_id, company_id, dept_name, head_name) values (163, 14, 'Engineering', 'Elisha Pomfrett');
insert into departments (dept_id, company_id, dept_name, head_name) values (164, 7, 'Marketing', 'Westley Braiden');
insert into departments (dept_id, company_id, dept_name, head_name) values (165, 16, 'Research and Development', 'Randy Akid');
insert into departments (dept_id, company_id, dept_name, head_name) values (166, 14, 'Research and Development', 'Goldie Cattlemull');
insert into departments (dept_id, company_id, dept_name, head_name) values (167, 1, 'Engineering', 'Byrle Sporton');
insert into departments (dept_id, company_id, dept_name, head_name) values (168, 9, 'Research and Development', 'Averill Ledes');
insert into departments (dept_id, company_id, dept_name, head_name) values (169, 10, 'Human Resources', 'Boot Geake');
insert into departments (dept_id, company_id, dept_name, head_name) values (170, 2, 'Legal', 'Julita Coverly');
insert into departments (dept_id, company_id, dept_name, head_name) values (171, 8, 'Marketing', 'Jessie Burkwood');
insert into departments (dept_id, company_id, dept_name, head_name) values (172, 14, 'Engineering', 'Aretha Patriche');
insert into departments (dept_id, company_id, dept_name, head_name) values (173, 20, 'Marketing', 'Cthrine Pettie');
insert into departments (dept_id, company_id, dept_name, head_name) values (174, 2, 'Sales', 'Asia de Leon');
insert into departments (dept_id, company_id, dept_name, head_name) values (175, 5, 'Engineering', 'Aile Kinglake');
insert into departments (dept_id, company_id, dept_name, head_name) values (176, 19, 'Product Management', 'Korney O''Deegan');
insert into departments (dept_id, company_id, dept_name, head_name) values (177, 16, 'Human Resources', 'Frazer Coverly');
insert into departments (dept_id, company_id, dept_name, head_name) values (178, 18, 'Support', 'Domeniga Agnew');
insert into departments (dept_id, company_id, dept_name, head_name) values (179, 4, 'Human Resources', 'Marleen M''Quhan');
insert into departments (dept_id, company_id, dept_name, head_name) values (180, 4, 'Research and Development', 'Darrelle Wabersinke');
insert into departments (dept_id, company_id, dept_name, head_name) values (181, 1, 'Business Development', 'Kalvin Callister');
insert into departments (dept_id, company_id, dept_name, head_name) values (182, 18, 'Research and Development', 'Gabbi Deuss');
insert into departments (dept_id, company_id, dept_name, head_name) values (183, 6, 'Product Management', 'Bevan Haggis');
insert into departments (dept_id, company_id, dept_name, head_name) values (184, 6, 'Services', 'Honoria Meiningen');
insert into departments (dept_id, company_id, dept_name, head_name) values (185, 3, 'Engineering', 'Nissa Vegas');
insert into departments (dept_id, company_id, dept_name, head_name) values (186, 20, 'Engineering', 'Yovonnda Rhodes');
insert into departments (dept_id, company_id, dept_name, head_name) values (187, 5, 'Training', 'Eloisa Eakens');
insert into departments (dept_id, company_id, dept_name, head_name) values (188, 8, 'Marketing', 'Dudley Domingues');
insert into departments (dept_id, company_id, dept_name, head_name) values (189, 19, 'Business Development', 'Lilly Robiou');
insert into departments (dept_id, company_id, dept_name, head_name) values (190, 7, 'Marketing', 'Pauline Cello');
insert into departments (dept_id, company_id, dept_name, head_name) values (191, 2, 'Research and Development', 'Kerri Scalera');
insert into departments (dept_id, company_id, dept_name, head_name) values (192, 4, 'Support', 'Callean Burwood');
insert into departments (dept_id, company_id, dept_name, head_name) values (193, 5, 'Product Management', 'Tracie Rist');
insert into departments (dept_id, company_id, dept_name, head_name) values (194, 17, 'Product Management', 'Nerti Walsom');
insert into departments (dept_id, company_id, dept_name, head_name) values (195, 15, 'Business Development', 'Kiley Roundtree');
insert into departments (dept_id, company_id, dept_name, head_name) values (196, 3, 'Support', 'Becca Healings');
insert into departments (dept_id, company_id, dept_name, head_name) values (197, 5, 'Research and Development', 'Whitney Battin');
insert into departments (dept_id, company_id, dept_name, head_name) values (198, 11, 'Engineering', 'Oliy Gookes');
insert into departments (dept_id, company_id, dept_name, head_name) values (199, 14, 'Legal', 'Nicole Peacock');
insert into departments (dept_id, company_id, dept_name, head_name) values (200, 6, 'Business Development', 'Karney Gilpin');
*/

insert into purchases (dept_id, supplier_id, amount) values (13, 12, 27.99);
insert into purchases (dept_id, supplier_id, amount) values (42, 16, 68.61);
insert into purchases (dept_id, supplier_id, amount) values (24, 19, 38.99);
insert into purchases (dept_id, supplier_id, amount) values (3, 3, 85.1);
insert into purchases (dept_id, supplier_id, amount) values (26, 12, 18.9);
insert into purchases (dept_id, supplier_id, amount) values (11, 20, 84.37);
insert into purchases (dept_id, supplier_id, amount) values (19, 11, 88.53);
insert into purchases (dept_id, supplier_id, amount) values (18, 13, 64.89);
insert into purchases (dept_id, supplier_id, amount) values (8, 18, 5.16);
insert into purchases (dept_id, supplier_id, amount) values (5, 6, 80.39);
insert into purchases (dept_id, supplier_id, amount) values (89, 13, 32.88);
insert into purchases (dept_id, supplier_id, amount) values (50, 13, 86.49);
insert into purchases (dept_id, supplier_id, amount) values (67, 14, 22.43);
insert into purchases (dept_id, supplier_id, amount) values (48, 1, 98.83);
insert into purchases (dept_id, supplier_id, amount) values (73, 2, 73.35);
insert into purchases (dept_id, supplier_id, amount) values (62, 12, 72.93);
insert into purchases (dept_id, supplier_id, amount) values (82, 18, 60.01);
insert into purchases (dept_id, supplier_id, amount) values (95, 9, 18.17);
insert into purchases (dept_id, supplier_id, amount) values (2, 6, 88.37);
insert into purchases (dept_id, supplier_id, amount) values (75, 15, 94.56);
insert into purchases (dept_id, supplier_id, amount) values (96, 6, 71.73);
insert into purchases (dept_id, supplier_id, amount) values (93, 20, 64.97);
insert into purchases (dept_id, supplier_id, amount) values (80, 19, 66.6);
insert into purchases (dept_id, supplier_id, amount) values (39, 17, 10.24);
insert into purchases (dept_id, supplier_id, amount) values (42, 4, 89.38);
insert into purchases (dept_id, supplier_id, amount) values (83, 12, 50.98);
insert into purchases (dept_id, supplier_id, amount) values (15, 9, 33.95);
insert into purchases (dept_id, supplier_id, amount) values (4, 17, 77.38);
insert into purchases (dept_id, supplier_id, amount) values (38, 5, 3.75);
insert into purchases (dept_id, supplier_id, amount) values (39, 6, 73.08);
insert into purchases (dept_id, supplier_id, amount) values (19, 17, 43.94);
insert into purchases (dept_id, supplier_id, amount) values (62, 16, 75.37);
insert into purchases (dept_id, supplier_id, amount) values (82, 16, 16.91);
insert into purchases (dept_id, supplier_id, amount) values (7, 8, 24.81);
insert into purchases (dept_id, supplier_id, amount) values (59, 9, 33.43);
insert into purchases (dept_id, supplier_id, amount) values (79, 18, 7.94);
insert into purchases (dept_id, supplier_id, amount) values (78, 16, 81.4);
insert into purchases (dept_id, supplier_id, amount) values (4, 4, 64.68);
insert into purchases (dept_id, supplier_id, amount) values (45, 18, 55.52);
insert into purchases (dept_id, supplier_id, amount) values (79, 10, 81.72);
insert into purchases (dept_id, supplier_id, amount) values (43, 15, 10.14);
insert into purchases (dept_id, supplier_id, amount) values (68, 19, 50.72);
insert into purchases (dept_id, supplier_id, amount) values (64, 16, 2.04);
insert into purchases (dept_id, supplier_id, amount) values (29, 8, 63.08);
insert into purchases (dept_id, supplier_id, amount) values (74, 6, 8.19);
insert into purchases (dept_id, supplier_id, amount) values (66, 9, 93.47);
insert into purchases (dept_id, supplier_id, amount) values (78, 6, 46.76);
insert into purchases (dept_id, supplier_id, amount) values (96, 3, 93.82);
insert into purchases (dept_id, supplier_id, amount) values (60, 5, 44.81);
insert into purchases (dept_id, supplier_id, amount) values (85, 19, 55.68);
insert into purchases (dept_id, supplier_id, amount) values (99, 12, 26.87);
insert into purchases (dept_id, supplier_id, amount) values (54, 3, 36.91);
insert into purchases (dept_id, supplier_id, amount) values (63, 9, 91.61);
insert into purchases (dept_id, supplier_id, amount) values (100, 3, 67.46);
insert into purchases (dept_id, supplier_id, amount) values (72, 1, 29.29);
insert into purchases (dept_id, supplier_id, amount) values (54, 20, 8.42);
insert into purchases (dept_id, supplier_id, amount) values (77, 18, 22.66);
insert into purchases (dept_id, supplier_id, amount) values (67, 7, 13.27);
insert into purchases (dept_id, supplier_id, amount) values (10, 10, 21.0);
insert into purchases (dept_id, supplier_id, amount) values (40, 5, 2.58);
insert into purchases (dept_id, supplier_id, amount) values (33, 17, 13.36);
insert into purchases (dept_id, supplier_id, amount) values (25, 11, 16.35);
insert into purchases (dept_id, supplier_id, amount) values (94, 6, 25.7);
insert into purchases (dept_id, supplier_id, amount) values (52, 18, 28.36);
insert into purchases (dept_id, supplier_id, amount) values (23, 1, 49.81);
insert into purchases (dept_id, supplier_id, amount) values (92, 6, 54.72);
insert into purchases (dept_id, supplier_id, amount) values (15, 1, 33.27);
insert into purchases (dept_id, supplier_id, amount) values (78, 4, 55.31);
insert into purchases (dept_id, supplier_id, amount) values (12, 9, 95.98);
insert into purchases (dept_id, supplier_id, amount) values (33, 16, 31.85);
insert into purchases (dept_id, supplier_id, amount) values (100, 1, 79.25);
insert into purchases (dept_id, supplier_id, amount) values (63, 11, 51.77);
insert into purchases (dept_id, supplier_id, amount) values (26, 14, 36.79);
insert into purchases (dept_id, supplier_id, amount) values (99, 6, 65.82);
insert into purchases (dept_id, supplier_id, amount) values (93, 19, 46.2);
insert into purchases (dept_id, supplier_id, amount) values (71, 8, 85.88);
insert into purchases (dept_id, supplier_id, amount) values (90, 17, 43.16);
insert into purchases (dept_id, supplier_id, amount) values (46, 9, 60.88);
insert into purchases (dept_id, supplier_id, amount) values (36, 15, 25.43);
insert into purchases (dept_id, supplier_id, amount) values (21, 5, 74.82);
insert into purchases (dept_id, supplier_id, amount) values (32, 8, 83.8);
insert into purchases (dept_id, supplier_id, amount) values (14, 3, 4.61);
insert into purchases (dept_id, supplier_id, amount) values (1, 19, 7.06);
insert into purchases (dept_id, supplier_id, amount) values (36, 2, 28.73);
insert into purchases (dept_id, supplier_id, amount) values (11, 4, 21.38);
insert into purchases (dept_id, supplier_id, amount) values (12, 18, 73.2);
insert into purchases (dept_id, supplier_id, amount) values (32, 8, 74.51);
insert into purchases (dept_id, supplier_id, amount) values (37, 10, 29.12);
insert into purchases (dept_id, supplier_id, amount) values (8, 18, 1.81);
insert into purchases (dept_id, supplier_id, amount) values (29, 1, 87.94);
insert into purchases (dept_id, supplier_id, amount) values (45, 15, 56.44);
insert into purchases (dept_id, supplier_id, amount) values (13, 8, 8.61);
insert into purchases (dept_id, supplier_id, amount) values (67, 3, 70.85);
insert into purchases (dept_id, supplier_id, amount) values (52, 20, 29.89);
insert into purchases (dept_id, supplier_id, amount) values (13, 18, 51.5);
insert into purchases (dept_id, supplier_id, amount) values (98, 10, 66.33);
insert into purchases (dept_id, supplier_id, amount) values (99, 18, 79.5);
insert into purchases (dept_id, supplier_id, amount) values (28, 19, 59.47);
insert into purchases (dept_id, supplier_id, amount) values (48, 13, 39.58);
insert into purchases (dept_id, supplier_id, amount) values (93, 3, 85.6);


drop view if exists star_table;
create view star_table as
	   SELECT 
    purchase_id, dept_id, dept_name, head_name, 
    buyers.company_id as buyer_id,
    buyers.company_name as buyer_name,
    buyers.sector as buyer_sector,
    suppliers.company_id as supplier_id,
    suppliers.company_name as supplier_name,
    suppliers.sector as supplier_sector,
    amount
FROM
    purchases
        JOIN
    departments USING (dept_id)
        JOIN
    companies buyers USING (company_id)
        JOIN
    companies suppliers ON suppliers.company_id = purchases.supplier_id;

drop view if exists datacube;
CREATE VIEW datacube AS
    SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY dept_name , buyer_sector , supplier_sector WITH ROLLUP 
    UNION SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY dept_name , supplier_sector , buyer_sector WITH ROLLUP 
    UNION SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY buyer_sector , dept_name , supplier_sector WITH ROLLUP 
    UNION SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY buyer_sector , supplier_sector , dept_name WITH ROLLUP 
    UNION SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY supplier_sector , dept_name , buyer_sector WITH ROLLUP 
    UNION SELECT 
        dept_name,
        buyer_sector,
        supplier_sector,
        SUM(amount) AS total_amount
    FROM
        star_table
    GROUP BY supplier_sector , buyer_sector , dept_name WITH ROLLUP
;

