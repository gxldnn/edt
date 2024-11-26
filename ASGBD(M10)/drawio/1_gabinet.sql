DROP TABLE Client -- Esborrem una antiga possible taula anomenada Client
CREATE TABLE Client ( -- Creem la taula Client
    dni varchar(9) CONSTRAINT client_dni_pk primary key, -- Establim dni com a PK de Client
    nom varchar(20),
    adreca varchar(40),  
    telefon varchar(9)
);

