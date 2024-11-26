DROP TABLE client; -- Esborrem una antiga possible taula anomenada Client
CREATE TABLE client ( -- Creem la taula Client
    dni varchar(9) CONSTRAINT client_dni_pk primary key, -- Establim dni com a PK de Client
    nom varchar(20),
    adreca varchar(40),
    telefon varchar(9)
);
DROP TABLE assumptes;
CREATE TABLE assumptes (
    idassumpte varchar(10) CONSTRAINT assumptes_idassumpte_pk primary key,
    datainici date,
    datarxiu date,
    estat varchar(40)
);
DROP TABLE procurador
CREATE TABLE procurador (
    dniprocurador varchar(9) CONSTRAINT dniprocurador_procurador_pk primary key,
    nom varchar(20),
    adreca varchar(40),
    telf varchar(9)
);
DROP TABLE assumptesXprocurador
CREATE TABLE assumptesXprocurador (
    idassumpte CONSTRAINT ,
    dniprocurador CONSTRAINT
);


