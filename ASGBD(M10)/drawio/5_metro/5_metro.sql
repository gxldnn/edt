\c template1
DROP DATABASE IF EXISTS metro;
CREATE DATABASE metro;
\c metro

CREATE TABLE linia (
    codilinia SMALLINT,
    color varchar(20),
    CONSTRAINT linia_codilinia_pk PRIMARY KEY (codilinia)
);

CREATE TABLE estacio (
    idestacio SMALLINT,
    nom varchar(20),
    ubicacio varchar(20),
    CONSTRAINT estacio_idestacio_pk PRIMARY KEY (idestacio)
);

CREATE TABLE datas (
    datainici date,
    CONSTRAINT datas_datainici_pk PRIMARY KEY (datainici)
);

CREATE TABLE accessos (
    nom varchar(20),
    ubicacio varchar(20),
    idestacio SMALLINT,
    CONSTRAINT accessos_nom_pk PRIMARY KEY (nom),
    CONSTRAINT accessos_idestacio_fk FOREIGN KEY (idestacio) REFERENCES estacio(idestacio)
);

CREATE TABLE cotxera (
    idcotxera SMALLINT,
    nom varchar(20),
    idestacio SMALLINT,
    CONSTRAINT cotxera_idcotxera_pk PRIMARY KEY (idcotxera),
    CONSTRAINT cotxera_idestacio_fk FOREIGN KEY (idestacio) REFERENCES estacio(idestacio)
);

CREATE TABLE tren (
    idtren SMALLINT,
    nomtren varchar(20),
    idcotxera SMALLINT,
    codilinia SMALLINT,
    CONSTRAINT tren_idtren_pk PRIMARY KEY (idtren),
    CONSTRAINT tren_idcotxera_fk FOREIGN KEY (idcotxera) REFERENCES cotxera(idcotxera),
    CONSTRAINT tren_codilinia_fk FOREIGN KEY (codilinia) REFERENCES linia(codilinia)

);

CREATE TABLE dataestaciolinia (
    idestacio SMALLINT,
    codilinia SMALLINT,
    datainici date,
    datafi date,
    CONSTRAINT dataestaciolinia_idestacio_codilinia_pk PRIMARY KEY (idestacio,codilinia),
    CONSTRAINT dataestaciolinia_idestacio_fk FOREIGN KEY (idestacio) REFERENCES estacio(idestacio),
    CONSTRAINT dataestaciolinia_codilinia_fk FOREIGN KEY (codilinia) REFERENCES linia(codilinia),
    CONSTRAINT dataestaciolinia_datainici_fk FOREIGN KEY (datainici) REFERENCES datas(datainici)
);
