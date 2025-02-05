--1.
--SELECT nombre, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum

--2. 
SELECT pednum, importe, nombre, limcred FROM pedido JOIN cliente ON pedido.cliecod = cliente.cliecod

--3.
--SELECT nombre, repcod, repventa.ofinum, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum ORDER BY 1;
/*


--4. 
/*
SELECT ciudad, region, repventa.nombre, objetivo 
FROM oficina JOIN repventa ON repventa.ofinum = oficina.ofinum  
WHERE objetivo > 360000;
 