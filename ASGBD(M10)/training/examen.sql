-- Script: 			taules_pg_videoclub_v2.sql
-- Descripció: 		Base de dades videoclub en català
-- Autor: 			Jordi Andúgar
-- Darrera revisió:	29/03/2023
-- Versió:			0.2
-- Característiques:
-- Peli que té un director que participa en la peli

\c template1
DROP DATABASE IF EXISTS videoclub;
CREATE DATABASE videoclub;
\c videoclub

CREATE TABLE SOCI
       (CODSOCI SMALLINT CONSTRAINT SOCI_CODSOCI_PK PRIMARY KEY ,
        LOGIN    VARCHAR(15),
        PASSWORD character varying(32),
        DNI varchar(9) ,
        NOM   varchar(15) CONSTRAINT SOCI_NOMSOCI_NN NOT NULL,
        COGNOMS varchar(30) CONSTRAINT SOCI_COGNOMS_NN NOT NULL,
    	  DATA_NAIXEMENT DATE,
        ADRECA varchar(50) CONSTRAINT SOCI_DIRSOCI_NN NOT NULL,
        TELEFON varchar(9) CONSTRAINT SOCI_TELFSOCI_NN NOT NULL,
		    SEXE varchar(1)
);


CREATE TABLE DIRECTOR
       (CODDIR   SMALLINT CONSTRAINT DIRECTOR_CODDIREC_PK PRIMARY KEY,
        NOM   varchar(15) CONSTRAINT DIRECTOR_NOM_NN NOT NULL,
        COGNOMS varchar(20) CONSTRAINT DIRECTOR_COGNOMS_NN NOT NULL,
        Nacionalitat varchar(23)
       );

CREATE TABLE GENERE
       (CODGEN   SMALLINT CONSTRAINT GENERE_CODGENERE_PK PRIMARY KEY,
        GENERE   varchar(15) CONSTRAINT GENERE_GENERE_NN NOT NULL
         );

CREATE TABLE ACTOR
       (CODACTOR SMALLINT CONSTRAINT ACTOR_CODACTOR_PK PRIMARY KEY,
        NOM   varchar(15) CONSTRAINT ACTOR_NOM_NN NOT NULL,
        COGNOMS varchar(20) CONSTRAINT ACTOR_COGNOMS_NN NOT NULL
        );

CREATE TABLE PELICULA
    (CODPELI  SMALLINT CONSTRAINT PELICULA_CODPELI_PK PRIMARY KEY,
    TITOL   varchar(40) CONSTRAINT PELICULA_TITULO_NN NOT NULL,
    CODGEN   SMALLINT CONSTRAINT PELICULA_GENERE_NN NOT NULL,
    CODDIR   SMALLINT CONSTRAINT PELICULA_DIRECTOR_NN NOT NULL,
	PREU   NUMERIC(3,2),
	SINOPSI varchar(1000),
	DATAESTRENA  date,
    FOTO varchar(200),
	CONSTRAINT PELICULA_GENERE_FK FOREIGN KEY (CODGEN)
                        REFERENCES GENERE (CODGEN),
    CONSTRAINT PELICULA_DIRECTOR_FK FOREIGN KEY (CODDIR)
                        REFERENCES DIRECTOR (CODDIR)
    );
CREATE TABLE DVD
    (CODDVD SMALLINT CONSTRAINT DVD_CODDVD_PK PRIMARY KEY,
    DESCRIP  varchar(25),
    CODPELI  SMALLINT CONSTRAINT DVD_CODPELI_NN NOT NULL,
	RESERVAT	 varchar(1) DEFAULT 'N',
    CONSTRAINT DVD_RESERVAT_CK  CHECK (RESERVAT IN ('N','S','n','s') ),
    CONSTRAINT DVD_CODPELI_FK FOREIGN KEY (CODPELI) REFERENCES PELICULA (CODPELI)
    );

CREATE TABLE LLOGUER
    (CODSOCI SMALLINT,
    CODDVD SMALLINT,
    DATAPRES TIMESTAMP,
    DATADEV TIMESTAMP,
    IMPORT NUMERIC(5,2),
    CONSTRAINT PRESTEC_CODSOCI_FK FOREIGN KEY (CODSOCI)
            REFERENCES SOCI (CODSOCI),
    CONSTRAINT PRESTEC_CODDVD_FK FOREIGN KEY (CODDVD)
            REFERENCES DVD (CODDVD),
    CONSTRAINT PRESTEC_SOCOFEP_PK
            PRIMARY KEY (CODSOCI, CODDVD, DATAPRES));

CREATE TABLE LLISTAESPERA
    (CODSOCI SMALLINT,
    CODPELI  SMALLINT,
	DATA_RES    TIMESTAMP,
    DATA_AVIS   TIMESTAMP,
    CODDVD SMALLINT,
    CONSTRAINT LLISTAESPERA_CODSOCI_FK FOREIGN KEY (CODSOCI)
            REFERENCES SOCI (CODSOCI),
    CONSTRAINT LLISTAESPERA_CODPELI_FK FOREIGN KEY (CODPELI)
            REFERENCES PELICULA (CODPELI),
    CONSTRAINT LLISTAESPERA__PK PRIMARY KEY (CODSOCI, CODPELI));

CREATE TABLE REPARTIMENT
    (CODPELI  SMALLINT,
    CODACTOR SMALLINT,
    CONSTRAINT REPARTIMENT_CODPELI_FK FOREIGN KEY (CODPELI)
            REFERENCES PELICULA (CODPELI),
    CONSTRAINT REPARTIMENT_CODACTOR_FK FOREIGN KEY (CODACTOR)
            REFERENCES ACTOR (CODACTOR),
    CONSTRAINT REPARTIMENT_PEAC_PK PRIMARY KEY (CODPELI,CODACTOR)
  );

CREATE TABLE GENERESFAV
     (CODSOCI SMALLINT,
      CODGEN   SMALLINT,
      CONSTRAINT GUSGEN_CODSOCI_FK FOREIGN KEY (CODSOCI)
                REFERENCES SOCI (CODSOCI),
      CONSTRAINT GUSGEN_CODGENERE_FK FOREIGN KEY (CODGEN)
                REFERENCES GENERE (CODGEN),
      CONSTRAINT GUSGEN_SOGE_PK PRIMARY KEY (CODSOCI, CODGEN)
    );

CREATE TABLE ACTORSFAV
       (CODSOCI SMALLINT,
        CODACTOR SMALLINT,
        CONSTRAINT GUSACT_CODSOCI_FK FOREIGN KEY (CODSOCI)
                        REFERENCES SOCI (CODSOCI),
        CONSTRAINT GUSACT_CODACTOR_FK FOREIGN KEY (CODACTOR)
                        REFERENCES ACTOR (CODACTOR),
        CONSTRAINT GUSACT_SOAC_PK PRIMARY KEY (CODSOCI, CODACTOR));

CREATE TABLE DIRECTORSFAV
       (CODSOCI SMALLINT,
        CODDIR   SMALLINT,
        CONSTRAINT GUSDIR_CODSOCI_FK FOREIGN KEY (CODSOCI)
                        REFERENCES SOCI (CODSOCI),
        CONSTRAINT GUSDIR_CODDIREC_FK FOREIGN KEY (CODDIR)
                        REFERENCES DIRECTOR (CODDIR),
        CONSTRAINT GUSDIR_SODI_PK PRIMARY KEY (CODSOCI, CODDIR));

CREATE TABLE RECARREC  (
	CODSOCI 	SMALLINT,
	CODDVD 		SMALLINT,
	DATA   		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	RECARREC	NUMERIC(5,2),
       	CONSTRAINT recargo_codSOCI_FK FOREIGN KEY (CODSOCI)
                        REFERENCES SOCI (CODSOCI),
        CONSTRAINT recargo_CODDVD_FK FOREIGN KEY (CODDVD)
                        REFERENCES DVD (CODDVD),
        CONSTRAINT recargo_PK PRIMARY KEY (CODDVD, DATA));


-- CARREGA DE DADES


/* ******** 	S O C I O S ************** */

INSERT INTO SOCI VALUES (1, 'mcapdevila',md5('manel'),'12345678Z','Manel','CAPDEVILA',null,'SARDENYA 12-20','932982824','H');
INSERT INTO SOCI VALUES (2,'arobles',md5('anna'),null,'Marina','Robles',null,'GRAN VIA 300','933102376','D');
INSERT INTO SOCI VALUES (3,'aandreu',md5('ariadna'),null,'Alexia','Andreu',null,'DIAGONAL 450','933457698','H');
INSERT INTO SOCI VALUES (4,'nboixaderas',md5('nil'),null,'nil','boixaderas',null,'VIA LAIETANA 123','933452200','H');
INSERT INTO SOCI VALUES (5,'vfernandez',md5('valeria'),null,'victoria','fernandez',null,'MARINA 233','933152304','D');

/*  ******** D I R E C T O R E S ************** */

INSERT INTO DIRECTOR VALUES (1,'VICENTE','ARANDA','espanyola');
INSERT INTO DIRECTOR VALUES (2,'ITZIAR','BOLLAIN','Espanyola');
INSERT INTO DIRECTOR VALUES (3,'RICARDO','FRANCO','Espanyola');
INSERT INTO DIRECTOR VALUES (4,'ALEJANDRO','AMENABAR','Espanyola');
INSERT INTO DIRECTOR VALUES (5,'ALEX','DE LA IGLESIA','espanyola');
INSERT INTO DIRECTOR VALUES (6,'JULIO','MEDEM','Espanyola');
INSERT INTO DIRECTOR VALUES (7,'STANDLEY','KUBRICK', 'estatunidenca');
INSERT INTO DIRECTOR VALUES (8,'WEST','CRAVEN', 'estatunidenca');
INSERT INTO DIRECTOR VALUES (0,'M. ANGEL','LAMATA','Espanyola');
INSERT INTO DIRECTOR VALUES (9,'RIDLEY','SCOTT','anglesa');
INSERT INTO DIRECTOR VALUES (10,'Boby y Peter', 'Farrelly','estatunidenca');
INSERT INTO DIRECTOR VALUES (11,'Steven', 'Spielberg', 'estatunidenca');
INSERT INTO DIRECTOR VALUES (12,'Byron','Haskin','estatunidenca');
INSERT INTO DIRECTOR VALUES (13,'Clint','Eastwood','estatunidenca');


/*  ******** G E N E R O S ************** */

INSERT INTO GENERE VALUES(0,'HISTORICA');
INSERT INTO GENERE VALUES(1,'COMEDIA');
INSERT INTO GENERE VALUES(2,'DRAMA');
INSERT INTO GENERE VALUES(3,'ACCIO');
INSERT INTO GENERE VALUES(4,'SUSPENSE');
INSERT INTO GENERE VALUES(5,'TERROR');
INSERT INTO GENERE VALUES(6,'THRILLER');
INSERT INTO GENERE VALUES(7,'INFANTIL');
INSERT INTO GENERE VALUES(8,'CIENCIA FICCIO');


/*  ******** A C T O R E S ************** */

INSERT INTO ACTOR VALUES(1,'ARIADNA','GIL');
INSERT INTO ACTOR VALUES(2,'PILAR','LOPEZ DE AYALA');
INSERT INTO ACTOR VALUES(3,'EDUARDO','NORIEGA');
INSERT INTO ACTOR VALUES(4,'ANA','TORRENT');
INSERT INTO ACTOR VALUES(5,'FELE','MARTINEZ');
INSERT INTO ACTOR VALUES(6,'PENE','CRUZ');
INSERT INTO ACTOR VALUES(7,'NAJWA','NIMRI');
INSERT INTO ACTOR VALUES(8,'NICOLE','KIDMAN');
INSERT INTO ACTOR VALUES(9,'PAZ','VEGA');
INSERT INTO ACTOR VALUES(10,'TOM','CRUISE');
INSERT INTO ACTOR VALUES(11,'PEPE','SANCHO');
INSERT INTO ACTOR VALUES(12,'ESTE','OTRO');
INSERT INTO ACTOR VALUES(13,'NACHO','NOVO');
INSERT INTO ACTOR VALUES(14,'CLINT','Eastwood');
INSERT INTO ACTOR VALUES(15,'Hilary','Swank');



/*  ******** P E L I C U L A S (Codpeli, Titul, Codgen, Coddir,PREU) ************** */



INSERT INTO PELICULA VALUES (1,'JUANA LA LOCA',0,1,1.5,'Laredo, 22 de agosto de 1496. Una flota parte con destino a Flandes. Su objetivo es conducir a la infanta Juana a la corte de Bruselas, donde contraerá matrimonio con el que más tarde será conocido como Felipe el Hermoso. El encuentro es fulgurante. Apenas mirarse, nace entre ellos un deseo y una atracción incontrolable. Se olvidan de sus obligaciones políticas y se abandonan a los sentimientos. Sin embargo, el destino tiene otros planes para ellos. Las muertes de sus hermanos mayores y de su madre Isabel la Católica, convierten a la infanta Juana en reina de Castilla y heredera de la corona de Aragón. Estos acontecimientos desembocarán en dos batallas: una política, entre la nobleza flamenca y la castellana, la otra, mucho más dolorosa, será la que libre Juana en el lecho conyugal.',to_date('02-03-1920','dd-mm-yyyy'),'juana_la_loca.jpg');
INSERT INTO PELICULA VALUES (2,'ABRE LOS OJOS',2,4,1.5,'César es un atractivo y apuesto huérfano que ha heredado una gran fortuna de sus padres. Vive en una lujosa casa de su propiedad en la que organiza lujosas fiestas. Una noche su amigo Pelayo le presenta a su bella amiga Sof  a, pero su anterior amante, Nuria, siente celos de ella. Al día siguiente intenta suicidarse junto a César en su coche. Cuando César se despierta en el hospital, su rostro se encuentra horriblemente desfigurado.',to_date('02-03-1920','dd-mm-yyyy'),'abre_los_ojos.jpg');
INSERT INTO PELICULA VALUES (3,'LOS OTROS',2,4,2,'Isla de Jersey, en el Canal de La Mancha, en 1945. La II Guerra Mundial ha terminado pero el marido de Grace no vuelve. Sola en un aislado caserón victoriano, educa a sus hijos dentro de estrictas normas religiosas. Los niños sufren una extraña enfermedad: no pueden recibir directamente la luz del día. Los tres nuevos sirvientes que se incorporan a la vida familiar deben aprender una regla vital: la casa estará siempre en penumbra; nunca se abrirá una puerta si no se ha cerrado la anterior. El estricto orden que Grace ha impuesto hasta entonces será desafiado. Grace, los niños y quienes les rodean darán un paso inesperado y definitivo.',to_date('02-03-1920','dd-mm-yyyy'),'los_otros.jpg');
INSERT INTO PELICULA VALUES (4,'TESIS',6,5,2,'Ángela, estudiante de Imagen, está preparando una tesis sobre la violencia audiovisual. Como complemento a su trabajo, su director de tesis se compromete a buscar en la videoteca de la facultad material para ella, pero al d  a siguiente aparece asesinado en su despacho. Ángela conoce a Chema, un compañero experto en cine gore y pornográfico, y a Bosco, un extraño chico, amigo íntimo de una joven asesinada en una snuff movie. Crimen',to_date('02-03-1920','dd-mm-yyyy'),'tesis.jpg');
INSERT INTO PELICULA VALUES (5,'LOS AMANTES DEL CIRCULO POLAR',2,6,1.25,'Una historia de amor apasionada y secreta, contada por cada uno de sus protagonistas, Ana y Otto, desde que tienen ocho años hasta los veinticinco. Todo comienza en 1980, a la salida de un colegio, cuando dos niños echan a correr por distintos motivos. Desde esa tarde en la que se les escapa el mundo, las vidas de Ana y Otto se trenzarán en un mísmo círculo, que comenzará a cerrarse diecisiete años más tarde, en Finlandia, en el mismo borde del Círculo Polar.',to_date('02-03-1920','dd-mm-yyyy'),'los_amantes_del_circulo_polar.jpg');
INSERT INTO PELICULA VALUES (6,'LUCIA Y EL SEXO',2,6,1.75,'Lucía es una joven que trabaja como camarera en el centro de Madrid. Tras la misteriosa desaparición de su novio, un escritor, decide marcharse a una tranquila isla mediterránea. La libertad que siente allí le hace enfrentarse a los rincones más oscuros de su pasada relación con el escritor, como si se tratara de una novela.',to_date('02-03-1920','dd-mm-yyyy'),'lucia_y_el_sexo.jpg');
INSERT INTO PELICULA VALUES (7,'EYES WIDE SHUT',2,7,2,'William Harford es un médico respetable de Nueva York cuya vida parece ir sobre ruedas. Tiene una mujer preciosa con la que lleva 9 años casdado, una hija y un trabajo que le gusta. Pero una noche, al día siguiente de asistir a una fiesta, su esposa Alice le cuenta unas fantasías eróticas y cómo estuvo a punto de dejarle por un hombre que ni siquiera conocía. Abrumado por esta confesión, sale a la calle a visitar a un paciente. De vuelta a casa paseando, entra en un local donde un antiguo compañero le cuenta una misteriosa historia. A partir de entonces, un mundo de sexo y fantasías se abre ante él, uniéndose a una congregación secreta dedicada al hedonismo y al placer sin límites...',to_date('02-03-1920','dd-mm-yyyy'),'eyes_wide_shut.jpg.gif');
INSERT INTO PELICULA VALUES (8,'PESADILLA EN ELM STREET',5,8,1.25,'Un grupo de jóvenes sueña con un individuo con el rostro quemado y cuchillas en los dedos que va asesinándolos a medida que entran en su mundo, a todos excepto a una joven que le podrá hacer frente. Todo un clásico del cine de terror.',to_date('02-03-1920','dd-mm-yyyy'),'pesadilla_en_elm_street.jpg');
INSERT INTO PELICULA VALUES (9,'FLORES DE OTRO MUNDO',2,2,1.55,'Patricia, dominicana, busca un hogar y una seguridad económica que su situación ilegal en Madrid no le permite alcanzar. Milady, nacida en La Habana, tiene 20 años y el mundo entero por recorrer. Marirrosi, de Bilbao, tiene trabajo, casa y la más completa soledad. Como la soledad que comparte Alfonso, Damian y Carmelo, hombres de Santa Eulalia, pueblo sin mujeres casaderas ni futuro. Una fiesta de solteros fuerza el encuentro de unas con otros y el inicio de esta historia agridulce de convivencias a veces imposibles.',to_date('02-03-1920','dd-mm-yyyy'),null);
INSERT INTO PELICULA VALUES (10,'BLADE RUNNER',2,9,1.55,'A principios del siglo XXI, la poderosa Tyrell Corporation desarrolló un nuevo tipo de robot llamado Nexus, un ser virtualmente idéntico al hombre y conocido como Replicante. Los Replicantes Nexus-6 eran superiores en fuerza y agilidad, y al menos iguales en inteligencia, a los ingenieros de genética que los crearon. En el espacio exterior, los Replicantes fueron usados como trabajadores esclavos en la arriesgada exploración y colonización de otros planetas. Después de la sangrienta rebelión de un equipo de combate de Nexus-6 en una colonia sideral, los Replicantes fueron declarados proscritos en la Tierra bajo pena de muerte. Brigadas de policías especiales, con el nombre de Unidades de Blade Runners, tenían órdenes de tirar a matar al ver a cualquier Replicante invasor. A esto no se le llamaba ejecución, se le llamaba retiro.',to_date('02-03-1920','dd-mm-yyyy'),'blade_runner.jpg');
INSERT INTO PELICULA VALUES (11,'ALGO PASA CON MARY',1,10,1.55,'Ted Strohehmann ha vivido angustiado durante 14 años de su vida. La razón de su desgracia no es otra que la famosa Mary Jensen, la chica a la que todos desean y con la que por fin consigue tener una cita en la fiesta de graduación. Pero un desgraciado accidente con la c/* allera del pantalón arruinó este momento tan deseado. Ahora parece que tendrá otra oportunidad.',to_date('02-03-1920','dd-mm-yyyy'),'algo_pasa_con_mary.jpg');
INSERT INTO PELICULA VALUES (12,'UNA DE ZOMBIS',5,0,1,'Los buenos de la película son Aijón y Caspas. Dos taradetes de veintipocos que quieren ser directores de cine a pesar de no tener talento, dinero, contactos... ni siquiera una historia que contar. La tensión sexual la pondrá Carla, una atractiva mujer de negocios que, vaya usted a saber por qué, quiere ayudarles. Y la ensalada de plomo la servirá el Duende: héroe, vengador, porrero... Ah, ¿que por qué la ensalada de plomo? Muy sencillo: si Aijón y Caspas quieren estrenar su película, primero tendrán que acabar con Los Anticristos, una mafia satánica de gángsters psicópatas que no sólo han vuelto de la tumba para sembrar el terror y conquistar el mundo, sino que además cuentan chistes malos de cojones. Entonces, ¿qué es esta peli? ¿Una de risa? ¿Una de amor? ¿Una de acción? Pues sí, todo eso y, además, "Una de zombis". Pero no otra de zombis...',to_date('02-03-1920','dd-mm-yyyy'),'una_de_zombis.jpg');
INSERT INTO PELICULA VALUES (13,'La guerra de los mundos',8,11,1.5,'Ray Ferrier es un trabajador portuario divorciado de Nueva Jersey que recibe, un fin de semana, la visita de sus dos hijos: la pequeña Rachel y el adolescente Robbie. Lo que no imagina es que, precisamente ese fin de semana, unos extraterrestres van a atacar la Tierra y que ahora sus vidas corren peligro.',to_date('29-06-2005','dd-mm-yyyy'),'la_guerra_de_los_mundos_2.jpg');
INSERT INTO PELICULA VALUES (14,'La guerra de los mundos',8,12,1.5,'Ray Ferrier es un trabajador portuario divorciado de Nueva Jersey que recibe, un fin de semana, la visita de sus dos hijos: la pequeña Rachel y el adolescente Robbie. Lo que no imagina es que, precisamente ese fin de semana, unos extraterrestres van a atacar la Tierra y que ahora sus vidas corren peligro.',to_date('02-03-1953','dd-mm-yyyy'),'la_guerra_de_los_mundos.jpg');
INSERT INTO PELICULA VALUES (15,'Million dollar baby',2,13,1.5, 'Después de haber entrenado y representado a los mejores púgiles, Frankie Dunn (Eastwood) regenta un gimnasio con la ayuda de Scrap (Freeman), un ex-boxeador que es además su único amigo. Frankie es un hombre solitario y adusto que se refugia desde hace años en la religión buscando una redención que no llega. Un día, entra en su gimnasio Maggie Fitzgerald (Swank), una voluntariosa chica que quiere boxear y que está dispuesta a luchar denodadamente para conseguirlo. Frankie la rechaza alegando que él no entrena chicas y que, además, es demasiado mayor. Pero Maggie no se rinde y se machaca cada día en el gimnasio, con el único apoyo de Scrap.', TO_DATE('02-03-2004','dd-mm-yyyy'),'million_dollar_baby.jpg');

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (1,NULL,1);
INSERT INTO DVD(Coddvd, Descrip, Codpeli,Reservat) VALUES (2,NULL,1,'S');
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (3,NULL,1);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (4,NULL,2);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (5,NULL,2);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (6,NULL,3);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (7,NULL,3);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (8,NULL,4);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (9,NULL,4);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (10,NULL,5);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (11,NULL,5);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (12,NULL,6);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (13,NULL,6);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (14,NULL,7);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (15,NULL,7);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (16,NULL,8);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (17,NULL,9);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (18,NULL,9);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (19,NULL,10);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (20,NULL,10);
INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (21,NULL,10);

INSERT INTO DVD(Coddvd, Descrip, Codpeli) VALUES (22,NULL,11);

/* La peli 12 no té còpies */

INSERT INTO LLOGUER(Codsoci, coddvd,datapres, datadev, import)
VALUES
(1,1, CURRENT_TIMESTAMP::TIMESTAMP - interval '24 hours', null,
  (select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=1)),
(2,5, CURRENT_TIMESTAMP::TIMESTAMP - interval '28 hours', CURRENT_TIMESTAMP,
		(select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=5)),
(3,9, CURRENT_TIMESTAMP::TIMESTAMP - interval '56 hours', CURRENT_TIMESTAMP,
		(select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=9)),
(2,12, CURRENT_TIMESTAMP, null,
  (select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=12)),
(2,2, CURRENT_TIMESTAMP, null,(select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=2)),
(4,3, CURRENT_TIMESTAMP::TIMESTAMP - interval '48 hours', CURRENT_TIMESTAMP::TIMESTAMP - interval '26 hours',
    (select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=3)),
(1,21, CURRENT_TIMESTAMP, null,  (select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=21)),
(1,2, CURRENT_TIMESTAMP - interval '1 year', CURRENT_TIMESTAMP - interval '340 days',
  (select preu from pelicula p, dvd d where p.codpeli=d.codpeli and d.coddvd=2))
;

/*  ******** R E P A R T O (Pelicula, Actor) ************** */

INSERT INTO REPARTIMENT(CODPELI,CODACTOR)
VALUES 	(1,2),
	(2,3),
	(2,6),
	(2,7),
	(3,8),
	(4,3),
	(4,4),
	(4,5),
	(5,5),
	(5,7),
	(6,9),
	(6,7),
	(7,8),
	(7,10),
  (15,14), (15, 15)
  ;

/*  ******** D V D S (Coddvd, Descrip, Codpeli) ************** */

/*  ****** G E N E R O S F A V (CodSOCI, Codgen) */

INSERT INTO GENERESFAV VALUES (1,4);
INSERT INTO GENERESFAV VALUES (2,3);


/*  ****** A C T O R E S F A V (CodSOCI, Codactor) */

INSERT INTO ACTORSFAV VALUES (3,1);
INSERT INTO ACTORSFAV VALUES (1,1);


/*  ****** D I R E C T O R E S F A V (Codsoci, Coddir) */

INSERT INTO DIRECTORSFAV VALUES (1,1);
INSERT INTO DIRECTORSFAV VALUES (2,4);
INSERT INTO DIRECTORSFAV VALUES (3,1);
INSERT INTO DIRECTORSFAV VALUES (3,2);


INSERT INTO DIRECTORSFAV VALUES (4,7);
INSERT INTO DIRECTORSFAV VALUES (4,1);


INSERT INTO LLISTAESPERA(CODSOCI, CODPELI,DATA_RES)
VALUES (5,1,CURRENT_TIMESTAMP::TIMESTAMP - interval '49 hours'),
		(3,1,CURRENT_TIMESTAMP::TIMESTAMP - interval '21 hours'),
		(2,8,CURRENT_TIMESTAMP::TIMESTAMP - interval '6 hours'),
		(1,4,CURRENT_TIMESTAMP::TIMESTAMP - interval '50 hours');


