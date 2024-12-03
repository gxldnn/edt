\c template1
DROP DATABASE IF EXISTS museu;
CREATE DATABASE museu;
\c museu

CREATE TABLE museu (
    idmuseu SMALLINT,
    nom varchar(20),
    nomcarrer varchar(20),
    ciutat varchar(20),
    pais varchar(20),
    CONSTRAINT museu_idmuseu_pk PRIMARY KEY (idmuseu),
);

CREATE TABLE sala (
    idsala SMALLINT,
    idmuseu SMALLINT,
    nom varchar(20),
    CONSTRAINT sala_idmuseu_idsala_pk PRIMARY KEY (idsala,idmuseu),
    CONSTRAINT sala_idmuseu_fk FOREIGN KEY (idmuseu) REFERENCES museu(idmuseu)
);

CREATE TABLE autor (
    idautor SMALLINT,
    nom varchar(20),
    nacionalitat varchar(20),
    CONSTRAINT autor_idautor_pk PRIMARY KEY (idautor)
);

CREATE TABLE exposicio (
    idexposicio SMALLINT,
    titol varchar(20),
    CONSTRAINT exposicio_idexposicio_pk PRIMARY KEY (idexposicio)
);

CREATE TABLE obra (
    idobra SMALLINT,
    tipus
);