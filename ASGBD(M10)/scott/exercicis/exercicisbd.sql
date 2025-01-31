--1. 
--SELECT * FROM producto WHERE exist BETWEEN 25 AND 40;

--2.
--SELECT repcod FROM repventa ORDER BY 1;

--3.
--SELECT * FROM pedido WHERE cliecod = 2111;

--4.
--SELECT * FROM pedido WHERE cliecod = 2111 AND repcod = 103;

--5.
--SELECT * FROM pedido WHERE cliecod = 2111 AND repcod = 103 AND LOWER(fabcod) = 'aci';

--6. 
--SELECT * FROM pedido ORDER BY cliecod, fecha;

--7. 
--SELECT * FROM repventa WHERE ofinum IN (12, 13);

--8.
--SELECT * FROM producto WHERE exist IN (0, NULL); --per en el cas de que fos null, no faria falta

--9.
SELECT * FROM repventa WHERE fcontrato = 'CREATE TABLE repventa (
    repcod smallint CONSTRAINT PK_REPVENTA_REPCOD PRIMARY KEY,
    nombre character varying(30) NOT NULL,
    edad smallint,
    ofinum smallint,
    puesto character varying(20),
    fcontrato date NOT NULL,
    jefe smallint,
    cuota numeric(8,2),
    ventas numeric(8,2),
    CONSTRAINT CK_REPVENTA_NOMBRE CHECK(NOMBRE = INITCAP(NOMBRE)),
	CONSTRAINT CK_REPVENTA_EDAD CHECK(EDAD>0),
	CONSTRAINT CK_REPVENTA_VENTAS CHECK(VENTAS>0),
	CONSTRAINT CK_REPVENTA_CUOTA CHECK(CUOTA>0),
	CONSTRAINT FK_REPVENTA_OFINUM FOREIGN KEY(OFINUM) REFERENCES OFICINA(OFINUM)
);';