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
ON repventa.ofinum = oficina.ofinum
WHERE oficina.objetivo > 360000*;
*/

--5. Obtenir una llista de totes les comandes mostrant el seu número, el import i la descripció dels productes sol·licitats.
/*
SELECT pednum, importe, producto.descrip
FROM pedido JOIN producto
ON producto.prodcod = pedido.prodcod;
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

SELECT pednum, importe, clien
FROM pedido JOIN cliente
ON cliente.cliecod =  pedido.cliecod
