--1.
--SELECT nombre, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum

--2. 
--SELECT pednum, importe, nombre, limcred FROM pedido JOIN cliente ON pedido.cliecod = cliente.cliecod

--3.
--SELECT nombre, repcod, repventa.ofinum, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum ORDER BY 1;



--4. 
/*
SELECT ciudad, oficina.director, repventa.puesto, objetivo 
FROM oficina JOIN repventa 
ON repventa.ofinum = oficina.ofinum 
WHERE oficina.objetivo > 360000*/

--5.
/*
SELECT pednum, importe, producto.descrip
FROM pedido JOIN producto 
ON producto.prodcod = pedido.prodcod;
*/
--6. 
/*
SELECT pednum, importe, cliente.nombre "Nom Client", producto.descrip, repventa.nombre "Nom Representant"
FROM pedido JOIN cliente
ON cliente.cliecod = pedido.cliecod
JOIN producto
ON cliente.cliecod = pedido.cliecod
JOIN repventa
ON repventa.repcod = pedido.repcod
WHERE importe > 400 ORDER BY 3, 2 DESC;
*/

--7. 
