/* Jan Ribera Martín */
/*     a241477jr     */
\c template1
DROP DATABASE IF EXISTS clubnautic;
CREATE DATABASE clubnautic;
\c clubnautic

CREATE SEQUENCE numsoci_seq;

CREATE TABLE usuari (
    dni VARCHAR(10),
    nom VARCHAR(20),
    telefon VARCHAR(13), -- Poso varchar es cas de voler posar un prefix tipus, +34 666 666 666
    email VARCHAR(40),
    tipus VARCHAR(1),
    dataAlta DATE,
    numSoci SMALLINT,
    ciutat VARCHAR(40),
    CONSTRAINT usuari_dni_pk PRIMARY KEY (dni),
    CONSTRAINT usuari_tipus_ck CHECK (tipus IN ('A', 'B', 'C'))
);


CREATE TABLE vaixell (
    matricula SMALLINT,
    soci VARCHAR(10),
    nomVaixell VARCHAR(30),
    numAmarre SMALLINT,
    quota MONEY, -- Ho posa en USD $ per la configuracio de PSQL default
    CONSTRAINT vaixell_matricula_pk PRIMARY KEY (matricula),
    CONSTRAINT vaixell_nomvaixell_uq UNIQUE (nomVaixell),
    CONSTRAINT vaixell_soci_fk FOREIGN KEY (soci) REFERENCES usuari(dni) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE sortida (
    dataSortida TIMESTAMP,
    vaixell SMALLINT,
    patro VARCHAR(10),
    dataRetorn TIMESTAMP,
    destinacio VARCHAR(40),
    CONSTRAINT sortida_dataS_vaixell_pk PRIMARY KEY (dataSortida,vaixell),
    CONSTRAINT sortida_dates_ck CHECK (dataSortida < dataRetorn),
    CONSTRAINT sortida_vaixell_fk FOREIGN KEY (vaixell) REFERENCES vaixell(matricula) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT sortida_patro_fk FOREIGN KEY (patro) REFERENCES usuari(dni) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Inserts necesaris per a fer proves

INSERT INTO usuari VALUES ('454129406W', 'Jan', '+34 666666666', 'correu@correu.es', 'A', CURRENT_DATE , NEXTVAL('numsoci_seq'), 'Barcelona');
INSERT INTO usuari VALUES ('454559406W', 'Pepe', '+34 666666666', 'correu@correu.es', 'B', CURRENT_DATE, NEXTVAL('numsoci_seq'), 'Barcelona');
INSERT INTO usuari VALUES ('454556406W', 'Juansito', '+34 666666666', 'correu@correu.es', 'C', CURRENT_DATE, NEXTVAL('numsoci_seq'), 'Barcelona');


INSERT INTO vaixell VALUES (5555, '454129406W', 'Margarita', 21, 3200);
INSERT INTO vaixell VALUES (4444, '454559406W', 'PepeBarco', 22, 380);

-- A.
INSERT INTO sortida VALUES (TO_DATE('14/4/2024', 'DD/MM/YYY'), 5555, '454129406W', TO_DATE('15/5/2024', 'DD/MM/YYY'), 'Baleares');

-- B.
DELETE FROM usuari WHERE tipus = 'A' OR tipus = 'C' AND LOWER(ciutat) = 'barcelona';

-- C.
UPDATE vaixell SET quota = quota * 1.2 WHERE quota < '400' -- Ho poso entre '' perque el MONEY no funciona com a INTEGER    