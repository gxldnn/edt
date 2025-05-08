--1. 
--SELECT * FROM producto WHERE exist BETWEEN 25 AND 40;

--2.
--SELECT DISTINCT repcod FROM pedido;

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
-- SELECT * FROM repventa WHERE TO_CHAR(fcontrato + 5000, 'YYYY') = '2003';

--10. 
--SELECT nombre, CURRENT_DATE-fcontrato FROM repventa;

