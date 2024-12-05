\c template1
DROP DATABASE IF EXISTS cinefil;
CREATE DATABASE cinefil;
\c cinefil

CREATE TABLE tema(
    idtema SMALLINT,
    nomtema varchar(20),
    CONSTRAINT tema_idtema_pk PRIMARY KEY (idtema)
);

CREATE TABLE companyia(
    idcompanyia SMALLINT,
    nomcompanyia varchar(40),
    CONSTRAINT companyia_idcompanyia_pk PRIMARY KEY (idcompanyia)
);

CREATE TABLE ciutat(
    idciutat SMALLINT,
    nomcompanyia varchar(20),
    CONSTRAINT ciutat_idciutat_pk PRIMARY KEY (idciutat)
);

CREATE TABLE paper(
    idpaper SMALLINT,
    nom varchar(20),
    CONSTRAINT paper_idpaper_pk PRIMARY KEY (idpaper)
);

CREATE TABLE data(
    datainici date,
    CONSTRAINT data_datainici_pk PRIMARY KEY (datainici)
);

CREATE TABLE datarodatje(
    datainicirodatje date,
    CONSTRAINT datarodatje_datainicirodatje_pk PRIMARY KEY (datainicirodatje)
);

CREATE TABLE pelicula(
    idpeli SMALLINT,
    titol varchar(30),
    estreno date,
    pressupost varchar(30),
    director varchar(30),
    idcompanyia SMALLINT,
    idtema SMALLINT,
    CONSTRAINT peli_idpeli_pk PRIMARY KEY (idpeli),
    CONSTRAINT peli_idcompanyia_fk FOREIGN KEY (idcompanyia) REFERENCES companyia(idcompanyia),
    CONSTRAINT peli_idtema_fk FOREIGN KEY (idtema) REFERENCES tema(idtema)
);

CREATE TABLE actor(
    idactor SMALLINT,
    nom varchar(50),
    datanaixement date,
    CONSTRAINT actor_idactor_pk PRIMARY KEY (idactor)
);

CREATE TABLE actorxtema(
    idactor SMALLINT,
    idtema SMALLINT,
    habilitat SMALLINT,
    CONSTRAINT actorxtema_idactoridtema_pkc PRIMARY KEY (idactor,idtema),
    CONSTRAINT actorxtema_idactor_fk FOREIGN KEY (idactor) REFERENCES actor(idactor),
    CONSTRAINT actorxtema_idtema_fk FOREIGN KEY (idtema) REFERENCES tema(idtema),
    CONSTRAINT actorxtema_check_habilitat CHECK (habilitat BETWEEN 1 AND 10)
);

CREATE TABLE ciutatxcompanyia(
    idciutat SMALLINT,
    idcompanyia SMALLINT,
    adreca varchar(50),
    CONSTRAINT ciutatxcompanyia_idciutatidcompanyia_pkc PRIMARY KEY (idciutat,idcompanyia),
    CONSTRAINT ciutatxcompanyia_idciutat_fk FOREIGN KEY (idciutat) REFERENCES ciutat(idciutat),
    CONSTRAINT ciutatxcompanyia_idcompanyia_fk FOREIGN KEY (idcompanyia) REFERENCES companyia(idcompanyia)
);

CREATE TABLE actorxsubstitucio(
    idactor1 SMALLINT,
    idactor2 SMALLINT,
    grausubstitucio SMALLINT,
    CONSTRAINT actorxsubstitucio_idactor1idactor2_pkc PRIMARY KEY (idactor1,idactor2),
    CONSTRAINT actorxsubstitucio_idactor1_fk FOREIGN KEY (idactor1) REFERENCES actor(idactor),
    CONSTRAINT actorxsubstitucio_idactor2_fk FOREIGN KEY (idactor2) REFERENCES actor(idactor),
    CONSTRAINT actorxsubstitucio_grausubstitucio_check CHECK (grausubstitucio BETWEEN 1 AND 10)
);

CREATE TABLE actorxcompatibilitat(
    idactor1 SMALLINT,
    idactor2 SMALLINT,
    compatibilitat BOOLEAN,
    CONSTRAINT actorxcompatibilitat_idactor1idactor2_pkc PRIMARY KEY (idactor1,idactor2),
    CONSTRAINT actorxcompatibilitat_idactor1_fk FOREIGN KEY (idactor1) REFERENCES actor(idactor),
    CONSTRAINT actorxcompatibilitat_idactor2_fk FOREIGN KEY (idactor2) REFERENCES actor(idactor)
);

CREATE TABLE actorxcompanyiaxdata(
    idactor SMALLINT,
    datainici date,
    idcompanyia SMALLINT,
    datafi date,
    CONSTRAINT actorxcompanyiaxdata_idactordatainici_pk PRIMARY KEY (idactor,datainici),
    CONSTRAINT actorxcompanyiaxdata_idactor_fk FOREIGN KEY (idactor) REFERENCES actor(idactor),
    CONSTRAINT actorxcompanyiaxdata_datainici_fk FOREIGN KEY (datainici) REFERENCES data(datainici),
    CONSTRAINT actorxcompanyiaxdata_idcompanyia_fk FOREIGN KEY (idcompanyia) REFERENCES companyia(idcompanyia)
);

CREATE TABLE actorxpaperxpeli(
    idactor SMALLINT,
    idpeli SMALLINT,
    idpaper SMALLINT,
    premi varchar(30),
    CONSTRAINT actorxpaperxpeli_idactoridpeli_pkc PRIMARY KEY (idactor,idpaper),
    CONSTRAINT actorxpaperxpeli_idactor_fk FOREIGN KEY (idactor) REFERENCES actor(idactor),
    CONSTRAINT actorxpaperxpeli_idpeli_fk FOREIGN KEY (idpeli) REFERENCES pelicula(idpeli),
    CONSTRAINT actorxpaperxpeli_idpaper_fk FOREIGN KEY (idpaper) REFERENCES paper(idpaper)
);

CREATE TABLE faserodatje(
    idpeli SMALLINT,
    idciutat SMALLINT,
    datainicirodatje date,
    faserodatje date,
    datafirodatje date,
    CONSTRAINT faserodatje_idpeliidciutatdatainicirodatje_pkc PRIMARY KEY (idpeli,idciutat,datainicirodatje),
    CONSTRAINT faserodatje_idpeli_fk FOREIGN KEY (idpeli) REFERENCES pelicula(idpeli),
    CONSTRAINT faserodatje_idciutat_fk FOREIGN KEY (idciutat) REFERENCES ciutat(idciutat),
    CONSTRAINT faserodatje_datainicirodatje_fk FOREIGN KEY (datainicirodatje) REFERENCES datarodatje(datainicirodatje)
);
