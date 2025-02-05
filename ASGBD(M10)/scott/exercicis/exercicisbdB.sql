--1.
--SELECT nombre, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum

--2. 
--SELECT *, nombre, limcred FROM pedido JOIN cliente ON pedido.cliecod = cliente.cliecod

--3.
--SELECT nombre, repcod, repventa.ofinum, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum ORDER BY 1;

--4. 
SELECT ciudad FROM oficina WHERE objetivo > 360