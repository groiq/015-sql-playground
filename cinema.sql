-- Cinema database

drop database if exists cinema190812;
create database if not exists cinema190812;
use cinema190812;

drop table if exists saal;
CREATE TABLE saal (
    saalnummer INT PRIMARY KEY,
    saalname VARCHAR(32)
);

drop table if exists film;
CREATE TABLE film (
    film_code INT PRIMARY KEY,
    filmtitel VARCHAR(32),
    dauer TIME
);

drop table if exists sitz;
CREATE TABLE sitz (
    sitz_id INT PRIMARY KEY,
    saalnummer INT NOT NULL,
    reihe INT NOT NULL,
    platznummer INT NOT NULL,
    preis INT,
    FOREIGN KEY (saalnummer)
        REFERENCES saal (saalnummer),
    UNIQUE (saalnummer , reihe , platznummer)
);

drop table if exists vorfuehrung;
CREATE TABLE vorfuehrung (
    vorfuehrung_id INT PRIMARY KEY,
    saalnummer INT,
    film_code INT NOT NULL,
    zeit DATETIME NOT NULL,
    ende DATETIME,
    FOREIGN KEY (film_code)
        REFERENCES film (film_code),
    FOREIGN KEY (saalnummer)
        REFERENCES saal (saalnummer),
    UNIQUE (film_code , zeit)
);

drop table if exists angestellte;
CREATE TABLE angestellte (
    personalnummer INT PRIMARY KEY,
    svnr INT,
    name VARCHAR(32),
    UNIQUE (svnr)
);

drop table if exists reservierung;
CREATE TABLE reservierung (
    reservierungsnummer INT PRIMARY KEY,
    kundenname VARCHAR(32),
    personalnummer INT,
    FOREIGN KEY (personalnummer)
        REFERENCES angestellte (personalnummer)
);

drop table if exists verkauf;
CREATE TABLE verkauf (
    verkaufsnummer INT PRIMARY KEY,
    kundenname VARCHAR(32),
    personalnummer INT,
    FOREIGN KEY (personalnummer)
        REFERENCES angestellte (personalnummer)
);

drop table if exists ticket;
CREATE TABLE ticket (
    ticket_id INT PRIMARY KEY,
    vorfuehrung_id INT NOT NULL,
    sitz_id INT NOT NULL,
    reservierungsnummer INT,
    verkaufsnummer INT,
    FOREIGN KEY (sitz_id)
        REFERENCES sitz (sitz_id),
    FOREIGN KEY (vorfuehrung_id)
        REFERENCES vorfuehrung (vorfuehrung_id),
    FOREIGN KEY (reservierungsnummer)
        REFERENCES reservierung (reservierungsnummer),
    FOREIGN KEY (verkaufsnummer)
        REFERENCES verkauf (verkaufsnummer),
    UNIQUE (vorfuehrung_id , sitz_id)
);

drop table if exists gutschein;
CREATE TABLE gutschein (
    gutscheinnummer INT PRIMARY KEY,
    betrag INT,
    verfallsdatum DATE,
    personalnummer INT,
    FOREIGN KEY (personalnummer)
        REFERENCES angestellte (personalnummer)
);

drop table if exists gutschein_transaktion;
CREATE TABLE gutschein_transaktion (
    gutschein_transaktion_id INT PRIMARY KEY,
    verkaufsnummer INT NOT NULL,
    gutscheinnummer INT NOT NULL,
    betrag INT,
    FOREIGN KEY (gutscheinnummer)
        REFERENCES gutschein (gutscheinnummer),
    FOREIGN KEY (verkaufsnummer)
        REFERENCES verkauf (verkaufsnummer),
    UNIQUE (gutscheinnummer , verkaufsnummer)
);

drop table if exists ticketdienst;
CREATE TABLE ticketdienst (
    ticketdienst_id INT PRIMARY KEY,
    vorfuehrung_id INT NOT NULL,
    personalnummer INT NOT NULL,
    FOREIGN KEY (personalnummer)
        REFERENCES angestellte (personalnummer),
    FOREIGN KEY (vorfuehrung_id)
        REFERENCES vorfuehrung (vorfuehrung_id),
    UNIQUE (personalnummer , vorfuehrung_id)
);

