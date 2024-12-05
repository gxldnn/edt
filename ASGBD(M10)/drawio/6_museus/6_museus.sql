\c template1
DROP DATABASE IF EXISTS museu;
CREATE DATABASE museu;
\c museu

-- Jerarquia
CREATE TABLE format (
    idformat SMALLINT,
    descripcio VARCHAR(255) NOT NULL,
    CONSTRAINT format_idformat_pk PRIMARY KEY (idformat)
);

CREATE TABLE tipuspintura (
    idtipuspintura SMALLINT,
    descripcio VARCHAR(255) NOT NULL,
    CONSTRAINT tipuspintura_idtipuspintura_pk PRIMARY KEY (idtipuspintura)
);

CREATE TABLE material (
    idmaterial SMALLINT,
    descripcio VARCHAR(255) NOT NULL,
    CONSTRAINT material_idmaterial_pk PRIMARY KEY (idmaterial)
);

CREATE TABLE estil (
    idestil SMALLINT,
    descripcio VARCHAR(255) NOT NULL,
    CONSTRAINT estil_idestil_pk PRIMARY KEY (idestil)
);

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
    tipus SMALLINT,
    idformat SMALLINT,
    idtipuspintura SMALLINT,
    idmaterial SMALLINT,
    idestil SMALLINT,
    idmuseu SMALLINT,
    idsala SMALLINT,
    CONSTRAINT obra_idobra_pk PRIMARY KEY,
    CONSTRAINT obra_idmuseuidsala_fkc FOREIGN KEY (idsala,idmuseu) REFERENCES sala(idsala,idmuseu) -- FK composta
    CONSTRAINT obra_idformat_fk FOREIGN KEY (idformat) REFERENCES format(idformat),
    CONSTRAINT obra_idtipuspintura_fk FOREIGN KEY (idtipuspintura) REFERENCES TipusPintura(idtipuspintura),
    CONSTRAINT obra_idmaterial_fk FOREIGN KEY (idmaterial) REFERENCES Material(idmaterial),
    CONSTRAINT obra_idestil_fk FOREIGN KEY (idestil) REFERENCES Estil(idestil)
);

CREATE TABLE autorxobra (
    idobra SMALLINT,
    idautor SMALLINT,
    CONSTRAINT autorxobra PRIMARY KEY (idobra,idautor),
    CONSTRAINT autorxobra FOREIGN KEY (idobra) REFERENCES obra(idobra),
    CONSTRAINT autorxobra FOREIGN KEY (idautor) REFERENCES autor(idautor)
);

CREATE TABLE expoxmuseu (
    idobra SMALLINT,
    idmuseu SMALLINT,
    
);