\c template1
DROP DATABASE IF EXISTS carreteres;
CREATE DATABASE carreteres;
\c carreteres

CREATE TABLE carretera (
    idcarretera SMALLINT,
    nom varchar(20),
    ubicacio varchar(20),
    longitut varchar(20),
    CONSTRAINT carretera_idcarretera_pk PRIMARY KEY (idcarretera)
);

CREATE TABLE area (
    idarea SMALLINT,
    nom varchar(20),
    ubicacio varchar(20),
    CONSTRAINT area_idarea_pk PRIMARY KEY (idarea)
);


CREATE TABLE termemunicipal (
    idterme SMALLINT,
    nom varchar(20),
    comarca varchar(20),
    CONSTRAINT termemunicipal_idterme_pk PRIMARY KEY (idterme)
);

CREATE TABLE tram (
    idtram SMALLINT,
    nom varchar(20),
    kilometresortida varchar(20),
    idcarretera SMALLINT,
    idarea SMALLINT,
    CONSTRAINT tram_idtram_pk PRIMARY KEY (idtram),
    CONSTRAINT tram_idcarretera_fk FOREIGN KEY (idcarretera) REFERENCES carretera(idcarretera),
    CONSTRAINT tram_idarea_fk FOREIGN KEY (idarea) REFERENCES area(idarea)
);

CREATE TABLE tramxterme (
    idtram SMALLINT,
    idterme SMALLINT,
    kmentrada varchar(40),
    kmsortida varchar(40),
    CONSTRAINT tramxterme_idtram_idterme_pk PRIMARY KEY (idtram,idterme),
    CONSTRAINT tramxterme_idtram_fk FOREIGN KEY (idtram) REFERENCES tram(idtram),
    CONSTRAINT tramxterme_idterme_fk FOREIGN KEY (idterme) REFERENCES termemunicipal(idterme)
);
INSERT INTO carretera VALUES (1, 'Carretera A', 'Barcelona', '100');
INSERT INTO carretera VALUES (2, 'Carretera B', 'Girona', '150');

INSERT INTO area VALUES (1, 'Área Norte', 'Zona Norte');
INSERT INTO area VALUES (2, 'Área Sur', 'Zona Sur');

INSERT INTO termemunicipal VALUES (1, 'Termino 1', 'Comarca A');
INSERT INTO termemunicipal VALUES (2, 'Termino 2', 'Comarca B');

INSERT INTO tram VALUES (1, 'Tramo 1', '50', 1, 1);
INSERT INTO tram VALUES (2, 'Tramo 2', '80', 2, 2);

INSERT INTO tramxterme VALUES (1, 1, 'Entrada 1', 'Salida 1');
INSERT INTO tramxterme VALUES (2, 2, 'Entrada 2', 'Salida 2');
