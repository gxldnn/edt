--() { :; }; exec psql template1 -f "$0"

-- Script:      biblioteca.sql
-- Descripció:  Biblioteca pública on els usuaris poden agafar en prèstec
--              diferents tipus de documents (libres, CDs de musica, pel·lícules
--              i revistes.
-- Autor:       Jordi Andúgar
-- Data creació:20/04/2019
-- Darrera rev.:12/05/2020
-- Versió:      0.3

drop database  if exists biblioteca;
create database biblioteca;
\c biblioteca

/*
La taula Document representarà el supertipus del qual heretaran 4 subtipus de
documents que es poden prestar:
- llibre
- musica
- pel·lícula
- revista
*/
create table document(
	idDocument serial primary key ,
	titol varchar(200),
	descripcio varchar(200),
	format varchar(100),
	CONSTRAINT document_format_ck check (format in ('llibre','revista','CD','DVD'))
);

/* Estructura taula LLIBRE
  -- heretats
idDocument serial primary key ,
titol varchar(200),
descripcio varchar(200),
format varchar(100),
  --- propis
ISBN varchar(100),
edicio varchar(50),
signatura varchar(10),
revTecnica varchar(200)
*/
create table llibre(
	ISBN varchar(100),
	edicio varchar(50),
	signatura varchar(10),
	revTecnica varchar(200)
)  inherits (document);

/* Estructura taula MUSICA
-- heretats
idDocument serial primary key ,
titol varchar(200),
descripcio varchar(200),
format varchar(100),
--- propis
numSegell varchar(100),
publicacio varchar(100),
edicio varchar(50),
signatura varchar(10),
contingut varchar(200),
tema int
*/

create table musica(
	numSegell varchar(100),
	publicacio varchar(100),
	edicio varchar(50),
	signatura varchar(50),
	contingut varchar(200),
	tema int
) inherits (document);

/* Estructura taula PELICULA
-- heretats
idDocument serial primary key ,
titol varchar(200),
descripcio varchar(200),
format varchar(100),
--- propis
publicacio varchar(100),
durada smallint,
anyRealitzacio smallint,
classificacio varchar(100),
nota varchar(200),
sinopsi varchar(1000)
*/
create table pelicula (
	publicacio varchar(100),
	durada smallint,
	anyRealitzacio smallint,
	classificacio varchar(100),
	nota varchar(200),
	sinopsi varchar(1000)
) inherits (document);

/* Estructura taula REVISTA
-- heretats
idDocument serial primary key ,
titol varchar(200),
descripcio varchar(200),
format varchar(100),
--- propis
ISSN varchar(100),
signatura varchar(10),
publicacio  varchar(200),
periodicitat varchar(50)
*/
create table revista(
	ISSN varchar(100),
	signatura varchar(10),
	publicacio  varchar(200),
	periodicitat varchar(50)
)  inherits (document);

-- La taula autor valdrà per escriptors, musics i directors de pelicula
create table autor (
	idAutor serial primary key,
	nom varchar(200) constraint autor_nom_uk unique
);

insert into autor
values (default,'Silberschatz, Abraham'),(default,'Korth, Henry F.'), (default,'Sudarshan, S.'),
		(default,'AC/DC'), 	(default, 'Chazelle, Damien')
;
create table actor (
	idActor serial primary key,
	nom varchar(200) constraint actor_nom_uk unique
);

create table repartiment(
	idActor int,
  idDocument int,
	constraint repartiment_pk primary key (idActor, idDocument),
	constraint repartiment_idActor_fk foreign key (idActor)
									references actor(idActor)
);

insert into actor
values
		(default, 'Gosling, Ryan'),
		(default, 'Stone, Emma'),
		(default, 'DeWitt, Rosemarie')
;

-- Fixeu-vos que no peta perquè no tenim idDocument com a CA,
-- donat que no es pot establir degut a l'herència
insert into repartiment
values  (1,3), (2,3),(3,3);

insert into llibre
values (
 default,
 'Fundamentos de bases de datos',
 'XVII, 653 p. : il. ; 28 cm',
 'llibre',
 '9788448190330',
 '6ª ed.',
 '681.3 Sil',
 'Jesús Sánchez Allende');

 insert into musica
values (
 default,
 'Highway to hell',
 '1 disc (CD) (42 min) : estèreo + 1 fullet (15 p.)',
 'CD',
 '510764 2 EPIC',
 '[S.l.] : Albert Son, cop. 2003',
 'Digitally Remastered',
 'CD 2.AC/D 40',
 'Inclou accés exclusiu a la web www.acdcrocks.com a través de ConnecteD, inclòs al propi CD',
 3
);

insert into pelicula
values (
 default,
 'La La Land',
 '1 disc òptic (BD) : col., so.',
 'DVD',
 'Madrid : Universal, DL 2017',
 128, -- en minuts
 2016,
 'Per a tots els públics',
 'Opcions de so i subtítols en castellà i anglès',
 'Mia (Emma Stone) és una de les moltes aspirants a actriu que viuen a Los Angeles a la recerca del somni hollywoodià, es guanya la vida com a cambrera mentre es presenta a munts de proves de càsting. Sebastian (Ryan Gosling) és un pianista que viu de les actuacions de segona que li surten, i el seu somni és regentar el seu propi club on retre tribut al jazz més pur.
Les destinacions de Mia i Sebastian es creuaran i la parella descobrirà l''amor, un vincle que farà florir i després posar en escac les aspiracions de tots dos. En una competició constant per buscar un lloc en el món de l''espectacle, la parella descobrirà que l''equilibri entre l''amor i l''art pot ser el major obstacle de tots.'
);

insert into revista
values (
 default,
 'Lonely Planet traveller',
 'Il. ; 27 cm',
 'revista',
 '1888-0479',
 'R 91 Lon',
 'Barcelona : Sàpiens : GeoPlaneta, 2007-2018',
 'Mensual'
);

create table premi(
 idPremi serial constraint premi_pk primary key,
 guardo varchar(200)
);

insert into premi
values (default,'Oscar'), (default,'Globus d''or'), (default,'BAFTA'), (default,'Festival de Venècia'),  (default,'Goya');

create table premiPelicula (
 idPremi int,
 idDocument int,
 quantitat smallint,
 constraint premiPelicula_pk primary key (idPremi,idDocument),
 constraint premiPelicula_idPremi_fk foreign key (idPremi) references premi(idPremi)
);

insert into premiPelicula
values (1,3,6) ,(2,3,7), (3,3,5), (4,3,1);

/*
Si executem la següent sentència
  select *
  from document;
Sortiran 4 files, però en el fons no hi ha cap fila a aquesta taula,
perquè representa la taula supertipus (les dades realment s'emmagatzemaran
a les taules subtipus)
Per fer la comprovació del que acabo de dir executem:
  select *
	from only document;
Aquesta consulta no retornarà res. Per més informació, consulteu l'enllaç
https://www.mycodesmells.com/post/bonus---inheritance-in-postgresql

No es pot posar idDocument com a CA, no funciona perquè realment no existeix
la fila en la taula document
*/
create table exemplar(
	idExemplar int constraint exemplar_idExemplar_pk primary key,
	idDocument int,  -- no funciona: references document(idDocument),
	estat varchar(100) default 'Disponible',
	descripcio varchar(200),
	constraint exemplar_idExemplar_ck check (estat in ('Disponible','Reservat','Exclòs de prèstec','En exposició'))
);

insert into exemplar(idExemplar,idDocument)
values (1,1), (2,1), (3,1),
			(4,2), (5,2),
			(6,3),(7,3), (8,3),
			(9,4)
;
-- El segon exemplar del llibre Fundamentos de bases de datos està "En exposició"
--El segon exemplar de la peli La la land està Exclòs de prèstec
insert into exemplar
values(2,1,'En exposició',null),
	 		(7,3, 'Exclòs de prèstec','Exemplar d''ús exlusiu al centre bibliotecari');

create table autorDocument(
	autor int,
	document int,
	primary key(autor, document)
);

-- Taula que recull qui escriu un llibre, el grup musical o autor d'un àlbum
-- musical o directors de pel·lícula
insert into autorDocument
values (1,1), (2,1), (3,1),  --llibre de BD
				(4,2),(5,2),		-- CD
			(6,3), (7,3)		-- DVD
;

-- tema valdrà tant per tema d'un llibre com pel gènere o gèneres de música o
-- pel·lícules

create table tema(
	idTema serial primary key,
	tema varchar(200)
);
insert into tema
values (default, 'Bases de dades'), 		(default, 'Informàtica'),
		(default, 'Hard rock (Música)'), (default, 'Musical'),
		(default, 'Viatges'), (default, 'Turisme')
		;

create table temaDocument(
	tema int,
	document int,
	constraint temaDocument_pk primary key(tema, document),
	constraint temaDocument_fk foreign key (tema) references tema(idTema)
);

insert into temaDocument
values (1,1), (2,1), (3,2), (4,3), (5,4);

CREATE TABLE Usuari
       (idUsuari serial CONSTRAINT SOCI_CODSOCI_PK PRIMARY KEY ,
        login    VARCHAR(15),
        passwd character varying(32),
        dni varchar(9) ,
        nom   varchar(15) CONSTRAINT SOCI_NOMSOCI_NN NOT NULL,
        cognoms varchar(30) CONSTRAINT SOCI_COGNOMS_NN NOT NULL,
    		dataNaixement DATE,
        adreca varchar(50) CONSTRAINT SOCI_DIRSOCI_NN NOT NULL,
        telefon varchar(9) CONSTRAINT SOCI_TELFSOCI_NN NOT NULL,
				sexe varchar(1),
				bloquejat BOOLEAN,
				dataDesbloqueig DATE,
				punts INT
			);

-- L'usuari Arnau té bloquejat el carnet, de manera que no podrà agafar cap prèstec
INSERT INTO Usuari
VALUES
(1, 'mcapdevila',md5('manel'),'12345678Z','Manel','Capdevila',null,'SARDENYA 12-20','932982824','H',false,null,40),
(2,'arobles',md5('anna'),null,'Anna','Robles',null,'GRAN VIA 300','933102376','D',false,null,0),
(3,'jandreu',md5('julia'),null,'Julia','Andreu',null,'DIAGONAL 450','933457698','H',false,null,0),
(4,'aboixaderas',md5('arnau'),null,'Arnau','boixaderas',null,'VIA LAIETANA 123','933452200','H',true,current_timestamp + interval '20 days', 0),
(5,'afernandez',md5('alexia'),null,'Alèxia','fernandez',null,'MARINA 233','933152304','D',false,null,0);

create table prestec (
	idExemplar int,
	dataPres timestamp,
	dataDev timestamp,
	idUsuari int,
	vegadesRenovat smallint,
	constraint prestec_pk primary key(idExemplar,dataPres),
	constraint prestec_exemplar_fk_ foreign key(idExemplar) references exemplar(idExemplar),
	constraint prestec_usuari_fk foreign key(idUsuari) references usuari(idUsuari)
);

insert into prestec
values  (1, current_timestamp - interval '83 days',null,1,0),
		-- Quan l'usuari 1 retorni aquest exemplar de document,
		-- tindrà una penalització
	(4, current_timestamp - interval '10 days',null,3,0),
	(6, current_timestamp - interval '25 days',null,2,0),
	(9, current_timestamp - interval '12 days',null,3,0),
	--prestecs retornats
	(5, current_timestamp - interval '20 days', current_timestamp - interval '10 days',4, 0 )
;

create table penalitzacio (
  idUsuari int,
	idExemplar int,
	data date,
	demerit int,
	CONSTRAINT penalitzacio_pk PRIMARY KEY (idExemplar, Data)
);

create table reserva(
	idExemplar int,
	idUsuari int,
	dataReserva timestamp,
	dataAvis timestamp,
	CONSTRAINT reserva_pk PRIMARY KEY (idExemplar, dataReserva),
	CONSTRAINT reserva_idExemplar_fk FOREIGN KEY (idExemplar)
			REFERENCES exemplar (idExemplar),
	CONSTRAINT reserva_idUsuari_fk FOREIGN KEY (idUsuari)
					REFERENCES usuari (idUsuari)
);

-- Reserva per la revista Lonely Planet traveller per l'usuari
insert into reserva
values (8,5,current_timestamp - interval '10 days', null);
