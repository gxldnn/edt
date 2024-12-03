\c template1
DROP DATABASE IF EXISTS zoo
CREATE DATABASE zoo
\c zoo

CREATE TABLE zoo (
    idzoo SMALLINT,
    nom varchar(40),
    ciutat varchar(20),
    pais varchar(20),
    mida varchar(20),
    pressupost varchar(20),
    CONSTRAINT zoo_idzoo_pk PRIMARY KEY (idzoo) 
);

CREATE TABLE especie (
    idespecie SMALLINT,
    nomvulgar varchar(20),
    nomcientific varchar(20),
    familia varchar(20),
    extincio date,
    CONSTRAINT especie_idespecie_pk PRIMARY KEY (idespecie)
);

CREATE TABLE animal (
    idanimal SMALLINT,
    idzoo SMALLINT,   --FK from zoo
    sexe varchar(20),
    datanaixement date,
    paisorigen varchar(20),
    continent varchar(20),
    idespecie SMALLINT,
    CONSTRAINT animal_idzoo_fk FOREIGN KEY idzoo REFERENCES zoo(idzoo),
    CONSTRAINT animal_idespecie_fk FOREIGN KEY idespecie REFERENCES especie(idespecie),
    CONSTRAINT animal_idan-idzoo_pk PRIMARY KEY (idanimal,idzoo)
);
