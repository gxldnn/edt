\c template1
drop database if exists hotel;
create database hotel;
\c hotel

create sequence seq_codclient
start with 1
increment by 1;

create sequence seq_numfra
start with 1
increment by 1;

create sequence seq_numreserva
start with 1
increment by 1;

CREATE TABLE TipusHab (
  CodTipus smallint,
  Descripcio VARCHAR(100),
  Preu numeric(5,2)  ,
  PRIMARY KEY(CodTipus)
);

insert into tipushab values (1, 'Simple',30);
insert into tipushab values (2, 'Doble estandar',50);
insert into tipushab values (3, 'Triple estandar',65);

CREATE TABLE Habitacio (
  NumHab smallint,
  CodTipus smallint,
  PRIMARY KEY(NumHab),
  FOREIGN KEY(CodTipus)   REFERENCES TipusHab(CodTipus)     
);

insert into habitacio values (101,1);
insert into habitacio values (102,2);
insert into habitacio values (103,3);


CREATE TABLE TipusEstada (
  CodEstada VARCHAR(2),
  Descripcio VARCHAR(150) ,
  Preu numeric(5,2)  ,
  PRIMARY KEY(CodEstada)
);

insert into TipusEstada values ('SA','Solo alojamiento',0);
insert into TipusEstada values ('AD','Alojamiento y desayuno',5.50);
insert into TipusEstada values ('MP','Media pension',18);
insert into TipusEstada values ('PC','Pension completa',25);

CREATE TABLE Client (
  CodClient smallint ,
  DNI VARCHAR(9) ,
  Nom VARCHAR(40) ,
  Cognom1 VARCHAR(50) ,
  Cognom2 VARCHAR(50) ,
  Adreca VARCHAR(100) ,
  Ciutat VARCHAR(100) ,
  Telefon VARCHAR(9) ,
  Nacionalitat VARCHAR(20) ,
  Sexe VARCHAR(1) ,
  PRIMARY KEY(CodClient)
);

insert into Client values (nextval('seq_codclient'),'12345678Z','Alex','Perarnau', 'Tusquets','Carrer Provença 340, 5e 4a','Barcelona','688123456','Espanyola','H');
insert into Client values (nextval('seq_codclient'),'87654321X','Anna','Garcia', 'Raventós','Plaça Paisos Catalans 12,1r 2a','Badalona','664323437','Espanyola','D');

CREATE TABLE Reserva (
  NumReserva smallint PRIMARY KEY,
  CodClient smallint  not null ,
  DataReserva DATE ,
  DataArribada DATE not null ,
  DataSortida DATE ,
  NumHab smallint  not null ,
  CodEstada VARCHAR(2) not null , 
  Ocupada VARCHAR(1) ,
  Facturada VARCHAR(1) ,
  FOREIGN KEY(NumHab)     REFERENCES Habitacio(NumHab),
  FOREIGN KEY(CodClient)     REFERENCES Client(CodClient),
  FOREIGN KEY(CodEstada)     REFERENCES TipusEstada(CodEstada),
  CHECK (Ocupada in ('S','N')),
  CHECK (Facturada in ('S','N'))
);

insert into reserva values (nextval('seq_numreserva'), 1, null, current_date-20, current_date-18,102,'SA','S','S');
insert into reserva values (nextval('seq_numreserva'), 1, current_date-10, current_date-5, current_date-2,102,'MP','S','S');
insert into reserva values (nextval('seq_numreserva'), 2, current_date-8, current_date-2, current_date+2,102,'MP','S','N');
insert into reserva values (nextval('seq_numreserva'), 1, null, current_date, current_date+2,101,'MP','S','N');
insert into reserva values (nextval('seq_numreserva'), 2, current_date, current_date+2, current_date+3,101,'AD','N','N');

CREATE TABLE Factura (
  NumFra smallint PRIMARY KEY,
  numreserva smallint,
  DataFacturacio DATE ,
  Import smallint  ,
  FOREIGN KEY(numreserva)  REFERENCES Reserva(numreserva) 
);

CREATE TABLE Servei (
  IdServei smallint,
  Descripcio VARCHAR(150) ,
  Preu numeric(5,3)  ,
  PRIMARY KEY(IdServei)
);
insert into servei values (1,'massatge', 40);
insert into servei values (2,'spa', 12);
insert into servei values (3,'parking', 15);  
insert into servei values (4,'dinar', 16);  
insert into servei values (5,'sopar', 20);  

CREATE TABLE ServeiHabitacio (
  NumHab smallint  not null ,
  IdServei smallint  not null ,
  Data timestamp  not null ,
  Quantitat smallint not null,
  PRIMARY KEY(NumHab, Data),
  FOREIGN KEY(NumHab)     REFERENCES Habitacio (NumHab) ,
  FOREIGN KEY(IdServei)     REFERENCES Servei(IdServei)
);

-- Serveis de l'habitació 102
insert into serveihabitacio values (102,1, current_date-18 + time '10:05',2);
-- Serveis de l'habitació 102
insert into serveihabitacio values (102,2, current_date-4 + time '20:30',1);
insert into serveihabitacio values (102,5, current_date-3 + time '22:13',2);
-- Serveis de l'habitació 102 Actual: 2 massatges i un spa
insert into serveihabitacio values (102,1, current_timestamp- interval '1 day 3 hours',2);
insert into serveihabitacio values (102,2, current_timestamp,1);
-- Serveis de l'habitació 101 Actual: parking
insert into serveihabitacio values (101,3, current_timestamp + interval '5 hours',1);

