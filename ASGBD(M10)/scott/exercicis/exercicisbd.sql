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
--SELECT * FROM producto WHERE exist IN (0, NULL) --per en el cas de que fos null, no faria falta

--9.
SELECT 