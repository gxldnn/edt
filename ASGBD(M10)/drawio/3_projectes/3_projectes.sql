\c template1
DROP DATABASE IF EXISTS projectes;
CREATE DATABASE projectes;
\c projectes

CREATE TABLE departament (
    iddepartament SMALLINT,
    nomdepartament varchar(20),
    CONSTRAINT departament_iddepartament_pk PRIMARY KEY (iddepartament)
);

CREATE TABLE empleat (
    dni varchar(9),
    nom varchar(20),
    adreca varchar(40),
    telf varchar(20),
    codcap varchar(9),
    idprojecte SMALLINT,
    iddepartament SMALLINT,
    CONSTRAINT empleat_dni_pk PRIMARY KEY (dni),
    CONSTRAINT empleat_codcap_r_fk FOREIGN KEY (codcap) REFERENCES empleat(dni) 
);

CREATE TABLE projecte (
    idprojecte SMALLINT,
    titol varchar(40),
    duradaest date,
    pressupost varchar(20),
    dni varchar(9),
    CONSTRAINT projecte_idprojecte_pk PRIMARY KEY (idprojecte)
);

ALTER TABLE empleat
    ADD CONSTRAINT empleat_idprojecte_fk FOREIGN KEY (idprojecte) REFERENCES projecte(idprojecte);

ALTER TABLE projecte
    ADD CONSTRAINT projecte_dni_fk FOREIGN KEY (dni) REFERENCES empleat(dni);



INSERT INTO departament VALUES (1, 'IT');
INSERT INTO departament VALUES (2, 'Direccio');

INSERT INTO projecte VALUES (1, 'Marketing Digital', '2024-05-01', '15000', NULL);
INSERT INTO projecte VALUES (2, 'Amplificacio de la oficina', '2025-06-15', '30000', NULL);

INSERT INTO empleat VALUES ('12345678A', 'Jan Ribera', 'Carrer Ferrero Roscher 6969', '620275300', '12345678A', 1, 1);
INSERT INTO empleat VALUES ('98765432B', 'Ribera Jan', 'Carrer Nutella 69', '638775816', '12345678A', 2, 2);