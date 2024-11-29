-- Ens conectem a template 1 per a poder esborrar gabinet
\c template1
DROP DATABASE IF EXISTS gabinet; -- Afegit `IF EXISTS` per evitar errors si la taula no existeix
CREATE DATABASE gabinet;
\c gabinet
  -- Ens conectem a gabinet
-- Creem la taula Client
CREATE TABLE client (
  dniclient varchar(9),
  nom varchar(20) NOT NULL,
  adreca varchar(40),
  telefon varchar(9),
  CONSTRAINT client_dni_pk PRIMARY KEY (dniclient) -- Establim `dni` com a clau primària
);

-- Creem la taula Procurador
CREATE TABLE procurador (
  dniprocurador varchar(9),
  nom varchar(20) NOT NULL,
  adreca varchar(40),
  telf varchar(9),
  CONSTRAINT dniprocurador_procurador_pk PRIMARY KEY (dniprocurador), -- Clau primària per `dniprocurador`
  CONSTRAINT unique_procurador_nom UNIQUE (nom) -- Restricció d'unicitat per `nom`
);

-- Creem la taula Assumpte
CREATE TABLE assumpte (
  idassumpte varchar(10),
  datainici date,
  datarxiu date,
  estat varchar(40),
  dniclient varchar(9),
  CONSTRAINT assumpte_idassumpte_pk PRIMARY KEY (idassumpte), -- Clau primària per `idassumpte`
  CONSTRAINT assumpte_dni_fk FOREIGN KEY (dniclient) REFERENCES client(dniclient), -- Referència a la taula `client` per `dni`
  CONSTRAINT check_estat CHECK (estat='O' OR estat='T') -- Restricció de valors per `estat`
);

-- Creem la taula assumpteXprocurador
CREATE TABLE assumpteXprocurador (
  idassumpte varchar(20),
  dniprocurador varchar(9), -- Tipus de dada per `dniprocurador` ajustat al de la taula `procurador`
  CONSTRAINT assumpteXprocurador_pk PRIMARY KEY (idassumpte, dniprocurador), -- Clau primària composta
  CONSTRAINT assumpteXprocurador_idassumpte_fk FOREIGN KEY (idassumpte) REFERENCES assumpte(idassumpte), -- Referència a la taula `assumpte`
  CONSTRAINT assumpteXprocurador_dniprocurador_fk FOREIGN KEY (dniprocurador) REFERENCES procurador(dniprocurador) -- Referència a la taula `procurador`
);
