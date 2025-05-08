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
    CONSTRAINT museu_idmuseu_pk PRIMARY KEY (idmuseu)
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
    CONSTRAINT obra_idobra_pk PRIMARY KEY (idobra),
    CONSTRAINT obra_idmuseuidsala_fkc FOREIGN KEY (idsala,idmuseu) REFERENCES sala(idsala,idmuseu), -- FK composta
    CONSTRAINT obra_idformat_fk FOREIGN KEY (idformat) REFERENCES format(idformat),
    CONSTRAINT obra_idtipuspintura_fk FOREIGN KEY (idtipuspintura) REFERENCES TipusPintura(idtipuspintura),
    CONSTRAINT obra_idmaterial_fk FOREIGN KEY (idmaterial) REFERENCES Material(idmaterial),
    CONSTRAINT obra_idestil_fk FOREIGN KEY (idestil) REFERENCES Estil(idestil)
);

CREATE TABLE expoxmuseu (
    idobra SMALLINT,
    idmuseu SMALLINT,
    idexposicio SMALLINT,
    datainici date,
    datafi date,
    CONSTRAINT expoxmuseu_idobraidmuseu_pk PRIMARY KEY (idobra,idmuseu),
    CONSTRAINT expoxmuseu_idmuseu_fk FOREIGN KEY (idobra) REFERENCES obra(idobra),
    CONSTRAINT expoxmuseu_idobra_fk FOREIGN KEY (idmuseu) REFERENCES museu(idmuseu),
    CONSTRAINT expoxmuseu_idexposicio_fk FOREIGN KEY (idexposicio) REFERENCES exposicio(idexposicio)
);

CREATE TABLE autorxobra (
    idobra SMALLINT,
    idautor SMALLINT,
    CONSTRAINT autorxobra_idobraidautor_pk PRIMARY KEY (idobra,idautor),
    CONSTRAINT autorxobra_idobra_fk FOREIGN KEY (idobra) REFERENCES obra(idobra),
    CONSTRAINT autorxobra_idautor_fk FOREIGN KEY (idautor) REFERENCES autor(idautor)
);

INSERT INTO format VALUES (1, 'Pintura al óleo sobre lienzo');
INSERT INTO format VALUES (2, 'Escultura de mármol');

INSERT INTO tipuspintura VALUES (1, 'Óleo');
INSERT INTO tipuspintura VALUES (2, 'Acrílico');

INSERT INTO material VALUES (1, 'Lienzo');
INSERT INTO material VALUES (2, 'Mármol');

INSERT INTO estil VALUES (1, 'Impresionismo');
INSERT INTO estil VALUES (2, 'Renacimiento');

INSERT INTO museu VALUES (1, 'Museu del Prado', 'Calle Ruiz', 'Madrid', 'España');
INSERT INTO museu VALUES (2, 'Museu Picasso', 'Calle Montcada', 'Barcelona', 'España');

INSERT INTO sala VALUES (1, 1, 'Sala Goya');
INSERT INTO sala VALUES (2, 2, 'Sala Cubismo');

INSERT INTO autor VALUES (1, 'Pablo Picasso', 'Española');
INSERT INTO autor VALUES (2, 'Leonardo da Vinci', 'Italiana');

INSERT INTO exposicio VALUES (1, 'Grandes Maestros');
INSERT INTO exposicio VALUES (2, 'Vanguardias');

INSERT INTO obra VALUES (1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO obra VALUES (2, 2, 2, 2, 2, 2, 2, 2);

INSERT INTO expoxmuseu VALUES (1, 1, 1, '2024-01-01', '2024-12-31');
INSERT INTO expoxmuseu VALUES (2, 2, 2, '2024-06-01', NULL);

INSERT INTO autorxobra VALUES (1, 1);
INSERT INTO autorxobra VALUES (2, 2);
