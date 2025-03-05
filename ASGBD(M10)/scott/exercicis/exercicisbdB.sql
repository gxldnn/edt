--1. Mostra dels representants el seu nom, la ciutat de la seva oficina, així com la seva regió.
/*
SELECT nombre, ciudad, region
FROM repventa JOIN oficina
ON repventa.ofinum = oficina.ofinum;
*/

--2. Obtenir una llista de totes les comandes, mostrant el número de comanda, el seu import, el nom del client que el va fer i el límit de crèdit del client.
/*
SELECT pednum, importe, nombre, limcred
FROM pedido JOIN cliente 
ON pedido.cliecod = cliente.cliecod;
*/

--3. Obtenir una llista de representants ordenada alfabèticament, en què es mostri el nom del representant, codi de la oficina on treballa, ciutat i la regió on ven.
/*
SELECT nombre, repcod, repventa.ofinum, ciudad, region
FROM repventa JOIN oficina
ON repventa.ofinum = oficina.ofinum ORDER BY 1;
*/

--4. Obtenir una llista de les oficines (ciutats, no codis) que tenen un objectiu superior a 360.000 euros. Per a cada oficina mostrar la ciutat, el seu objectiu, el nom del director i lloc del mateix.
/*
SELECT ciudad, oficina.director, repventa.puesto, objetivo
FROM oficina JOIN repventa
ON repventa.repcod  = oficina.director
WHERE oficina.objetivo > 360000;
*/

--5. Obtenir una llista de totes les comandes mostrant el seu número, el import i la descripció dels productes sol·licitats.
/*
SELECT pednum, importe, producto.descrip
FROM pedido JOIN producto
ON producto.prodcod = pedido.prodcod
AND producto.fabcod = pedido.fabcod
ORDER BY 1;
*/

--6. Obtenir una llista de les comandes amb imports superiors a 4000. Mostrar el nom del client que va sol·licitar la comanda, número de la comanda, import de la mateixa
--la descripció del producte sol·licitat i el nom del representant que el va prendre. Ordeneu la llista per client alfabèticament i després per import de més gran a més petit.
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

--7. Obtenir una llista de les comandes amb imports superiors  a 2000 euros, mostrant el número de comanda, import, nom del
--client que ho va sol·licitar i el nom del representant que va contactar amb el client per primera vegada.
/*
SELECT p.pednum, p.importe, c.nombre, r.nombre
FROM pedido p
JOIN cliente c ON c.cliecod = p.cliecod
JOIN repventa r ON c.repcod = r.repcod
WHERE importe >2000 ORDER BY 3;
*/

--8. Obtenir una llista de les comandes amb imports superiors a 150 euros, mostrant el codi 
--de la comanda, l'import, el nom del client que ho va sol·licitar, 
--el nom del representant que va contactar amb ell per primera vegada i la ciutat de loficina on el 
--representant treballa.

/*
SELECT p.pednum, p.importe, c.nombre, r.nombre, o.ciudad
FROM pedido p 
JOIN cliente c ON p.cliecod = c.cliecod
JOIN repventa r ON r.repcod = c.repcod
JOIN oficina o ON r.ofinum = o.ofinum
WHERE importe > 150 ORDER BY 3;
*/

--9. 
/*
SELECT p.pednum, p.importe, c.nombre, p.fecha, pr.descrip
FROM pedido p
JOIN cliente c  ON p.cliecod = c.cliecod
JOIN producto pr ON p.fabcod = pr.fabcod AND p.prodcod = pr.prodcod
WHERE p.fecha BETWEEN '2003-10-01' AND '2003-10-31';
*/


--10.
/*
SELECT pednum, r.nombre, pr.descrip
FROM pedido p
JOIN repventa r ON p.repcod = r.repcod
JOIN oficina o ON r.ofinum = o.ofinum
JOIN producto pr ON p.fabcod = pr.fabcod AND p.prodcod = pr.prodcod
WHERE LOWER(o.region) = 'este';
*/


--11.
/*
SELECT pednum, importe, fecha, p.repcod, fcontrato, r.repcod
FROM pedido p
CROSS JOIN repventa r
WHERE r.fcontrato = p.fecha;
*/


--12.
/*
SELECT r.nombre, r.cuota, o.ciudad, o.objetivo
FROM repventa r
CROSS JOIN oficina o
WHERE r.cuota >= o.objetivo;
*/


--13. 
/*
SELECT r.nombre, r.ventas, o.ciudad
FROM repventa r
LEFT JOIN oficina o ON r.ofinum = o.ofinum;
*/

--14.
/*
SELECT pr.descrip 
FROM producto pr
JOIN pedido p ON p.fabcod||p.prodcod = pr.fabcod||pr.prodcod 
WHERE p.cant > pr.exist
*/

--15.
/*
SELECT r.nombre,r.cuota, rdir.nombre, rdir.cuota
FROM repventa r
JOIN oficina o ON o.ofinum = r.ofinum
JOIN repventa rdir ON o.director = rdir.repcod
WHERE r.cuota > rdir.cuota;
*/
--16.
/*
SELECT r.nombre"Nom Representant", r.ofinum"Ofinum Representant", rdir.nombre"Nom Director", rdir.ofinum"Ofinum Director"
FROM repventa r
JOIN oficina o ON o.ofinum = r.ofinum
JOIN repventa rdir ON o.director = rdir.repcod
WHERE r.ofinum != rdir.ofinum
*/



--17.
/*
SELECT r.nombre, o.ciudad, rdir.nombre, odir.ciudad
FROM repventa r
JOIN oficina o ON o.ofinum = r.ofinum
JOIN repventa rdir ON o.director = rdir.repcod
JOIN oficina odir ON rdir.repcod = odir.director
WHERE r.ofinum != rdir.ofinum;
*/

--18.
/*
<<<<<<< HEAD
SELECT rdir.nombre FROM repventa r
JOIN repventa rdir ON r.repcod = rdir.nombre
*/

------EXTRA
--Per a cada representant mostrar el nom i le seva oficina, numero de comanda i l'import

/*
SELECT r.nombre "Nom Repv", COALESCE(o.ciudad,'No te Ciutat') "Ciutat", p.pednum"Numero de comanda", p.importe "Import" , pr.descrip "Producto", c.nombre "Nom del Client"
FROM repventa r
LEFT JOIN oficina o ON r.ofinum = o.ofinum
LEFT JOIN pedido p ON r.repcod = p.repcod
LEFT JOIN producto pr ON p.fabcod||p.prodcod = pr.fabcod||pr.prodcod
LEFT JOIN cliente c ON p.cliecod = c.cliecod
ORDER BY 1;
*/
SELECT count(*)
FROM repventa;

=======
SELECT DISTINCT rdir.nombre, rdir.puesto
FROM repventa r
JOIN repventa rdir ON r.jefe = rdir.repcod;
<<<<<<< HEAD
*/

-- Numero  de departaments asignats
-- SELECT count(DISTINCT deptno) FROM emp;
-- Numero de caps que hi ha
-- SELECT count(DISTINCT mgr) FROM emp;
-- Numero de treballs diferents
-- SELECT count(DISTINCT job) FROM emp;
=======
/*
>>>>>>> 6a05be04ed5ee66312d0b617c64bd2791a63d273
>>>>>>> 3ef14591ece17438bfdc0eca0cdea592f969af5a
