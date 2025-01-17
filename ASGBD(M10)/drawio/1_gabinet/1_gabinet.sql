-- Ens conectem a template 1 per a poder esborrar gabinet
\c template1
DROP DATABASE IF EXISTS gabinet; -- Afegit `IF EXISTS` per evitar errors si la taula no existeix
CREATE DATABASE gabinet;
\c gabinet
  -- Ens conectem a gabinet
-- Creem la taula Client
CREATE TABLE client (
  dniclient VARCHAR(9),
  nom VARCHAR(20) NOT NULL,
  adreca VARCHAR(40),
  telefon VARCHAR(9),
  CONSTRAINT client_dni_pk PRIMARY KEY (dniclient) -- Establim `dni` com a clau primària
);

-- Creem la taula Procurador
CREATE TABLE procurador (
  dniprocurador VARCHAR(9),
  nom VARCHAR(20) NOT NULL,
  adreca VARCHAR(40),
  telf VARCHAR(9),
  CONSTRAINT dniprocurador_procurador_pk PRIMARY KEY (dniprocurador), -- Clau primària per `dniprocurador`
  CONSTRAINT unique_procurador_nom UNIQUE (nom) -- Restricció d'unicitat per `nom`
);

-- Creem la taula Assumpte
CREATE TABLE assumpte (
  idassumpte SMALLINT,
  datainici DATE,
  datarxiu DATE,
  estat VARCHAR(1),
  dniclient VARCHAR(9),
  CONSTRAINT assumpte_idassumpte_pk PRIMARY KEY (idassumpte), -- Clau primària per `idassumpte`
  CONSTRAINT assumpte_dni_fk FOREIGN KEY (dniclient) REFERENCES client(dniclient) ON DELETE SET NULL ON UPDATE CASCADE, -- Referència a la taula `client` per `dni`
  CONSTRAINT check_estat CHECK (estat='O' OR estat='T') -- Restricció de valors per `estat`
);

-- Creem la taula assumpteXprocurador
CREATE TABLE assumpteXprocurador (
  idassumpte SMALLINT,
  dniprocurador VARCHAR(9), -- Tipus de dada per `dniprocurador` ajustat al de la taula `procurador`
  CONSTRAINT assumpteXprocurador_pk PRIMARY KEY (idassumpte, dniprocurador), -- Clau primària composta
  CONSTRAINT assumpteXprocurador_idassumpte_fk FOREIGN KEY (idassumpte) REFERENCES assumpte(idassumpte) ON DELETE CASCADE ON UPDATE CASCADE, -- Referència a la taula `assumpte`
  CONSTRAINT assumpteXprocurador_dniprocurador_fk FOREIGN KEY (dniprocurador) REFERENCES procurador(dniprocurador) ON DELETE CASCADE ON UPDATE CASCADE -- Referència a la taula `procurador`
);

INSERT INTO client VALUES ('98765432Q', 'Anna Pérez', 'Carrer de les Flors, 22', '666555444');
INSERT INTO client VALUES ('34567890W', 'Marc Martí', 'Carrer Gran, 10', '633222111');
INSERT INTO procurador VALUES ('11122233X', 'Laura Soler', 'Avinguda Catalunya, 50', '654987123');
INSERT INTO procurador VALUES ('99988877C', 'David Ruiz', 'Passeig Marítim, 12', '612345678');
INSERT INTO assumpte VALUES ('001', '2024-01-10', NULL, 'O', '98765432Q'); 
INSERT INTO assumpte VALUES ('002', '2023-09-15', '2024-02-01', 'T', '34567890W'); 
INSERT INTO assumpteXprocurador VALUES ('001', '11122233X');
INSERT INTO assumpteXprocurador VALUES ('002', '99988877C');