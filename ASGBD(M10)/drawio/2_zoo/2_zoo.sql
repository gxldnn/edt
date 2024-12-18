\c template1
DROP DATABASE IF EXISTS zoo;
CREATE DATABASE zoo;
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
    extincio BOOLEAN,
    CONSTRAINT especie_idespecie_pk PRIMARY KEY (idespecie)
);

CREATE TABLE animal (
    idanimal SMALLINT,
    idzoo SMALLINT,   --FK from zoo
    sexo VARCHAR(20) NOT NULL,
    datanaixement date,
    paisorigen varchar(20),
    continent varchar(20),
    idespecie SMALLINT,
    CONSTRAINT animal_idan_idzoo_pk PRIMARY KEY (idanimal,idzoo),
    CONSTRAINT animal_idzoo_fk FOREIGN KEY (idzoo) REFERENCES zoo(idzoo),
    CONSTRAINT animal_idespecie_fk FOREIGN KEY (idespecie) REFERENCES especie(idespecie),
    CONSTRAINT animal_check_sexo CHECK (sexo IN ('femenino', 'masculino', 'sin', 'hermafrodita'))
);

INSERT INTO zoo VALUES (1, 'Zoo Barcelona', 'Barcelona', 'Espanya', 'Gran', '1000000');
INSERT INTO zoo VALUES (2, 'Zoo Madrid', 'Madrid', 'Espanya', 'Mitjana', '750000');

INSERT INTO especie VALUES (1, 'Tigre', 'Panthera tigris', 'Felidae', FALSE);
INSERT INTO especie VALUES (2, 'Dodo', 'Raphus cucullatus', 'Columbidae', TRUE);

INSERT INTO animal VALUES (1, 1, 'masculino', '2015-06-15', 'India', 'Asia', 1);
INSERT INTO animal VALUES (1, 2, 'femenino', '2020-03-22', 'Maurici', 'África', 2);