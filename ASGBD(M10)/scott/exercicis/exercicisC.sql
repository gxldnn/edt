-- 1\. Mostrar la suma de les quotes i la suma de les vendes totals de
-- tots els representants.

SELECT SUM(cuota), SUM(ventas) FROM repventa;

-- 2\. Quin és l'import total de les comandes preses per Bill Adams
/*
SELECT sum(ventas) 
FROM repventa 
WHERE nombre = 'Bill Adams';
*/
-- 3\. Calcula el preu mitjà dels productes del fabricant “aci”.
/*
SELECT ROUND(AVG(precio),2) AS "ACI PREU"
FROM producto
WHERE LOWER(fabcod) = 'aci';
*/
--4\. Quin és l'import mitjà de la comanda sol·licitada pel client
--"acme mfg."
/*
SELECT AVG(p.importe), c.nombre "Client"
FROM pedido p
JOIN cliente c ON c.cliecod = p.cliecod
WHERE LOWER(c.nombre) = 'acme mfg.'
GROUP BY c.nombre;
*/
--5\. Mostrar la quota màxima i la quota mínima de les quotes dels
--representants.
/*
SELECT MIN(coalesce(cuota,0)), MAX(coalesce(cuota,0)), nombre "Nom Representant"
FROM repventa
GROUP BY nombre;
*/
--6\. Quina és la data de la comanda més antiga que es té registrada?
/*
SELECT MIN(fecha) "Data mes antiga"
FROM pedido;
*/
--7\. Quin és el millor rendiment de vendes de tots els representants?
--(considerar-ho com el percentatge de vendes sobre la quota).
/*
SELECT MAX(ventas) "Millor Rendiment"
FROM repventa;
*/
--8\. Quants clients té lempresa?
/*
SELECT count(cliecod)
FROM cliente;
*/
--9\. Quants representants han obtingut un import de vendes superior a
--la seva pròpia quota?
/*
SELECT count(repcod)
FROM repventa
WHERE ventas > cuota;
*/
--10\. Quantes comandes s'han pres de més de 150 euros?
/*
SELECT count(pednum)
FROM pedido
WHERE importe > 150;
*/
--11\. Troba el nombre total de comandes, l'import mitjà, l'import total
--dels mateixos.
/*
SELECT count(pednum)"Numero de comandes", ROUND(AVG(importe),2)"Import Mitjà", SUM(importe) "Total de imports"
FROM pedido;
*/
--12\. Quants llocs de treball diferents hi ha a l'empresa?
/*
SELECT count(DISTINCT puesto)
FROM repventa;
*/
--13\. Quantes oficines tenen representants que superen les seves
--pròpies quotes?
/*
SELECT count(ofinum)
FROM repventa
WHERE ventas > cuota;
*/
--14\. Quin és l'import mitjà de les comandes preses per cada
--representant?
/*
SELECT r.repcod "Codi representant", AVG(p.importe)"Import Mitja" 
FROM repventa r 
JOIN pedido p ON p.repcod = r.repcod
GROUP BY r.repcod
ORDER BY r.repcod;
*/
--15\. Quin és el rang de les quotes dels representants assignats a
-- cada oficina (mínim i màxim)?
/*
SELECT ofinum, MIN(cuota)"Cuota Minima", MAX(cuota) "Cuota Maxima"
FROM repventa
GROUP BY ofinum
ORDER BY ofinum;
*/
--16\. Quants representants hi ha assignats a cada oficina? Mostra Ciutat
--i nombre de representants.
/*
SELECT count(r.repcod)"Nombre representants", o.ciudad "Ciutat"
FROM repventa r
JOIN oficina o ON r.ofinum = o.ofinum
GROUP BY o.ofinum;
*/
--17\. Quants clients ha contactat per primer cop cada representant?
--Mostra el codi de representant, nom i número de clients.
/*
SELECT r.repcod, r.nombre, count(c.cliecod)
FROM repventa r
JOIN cliente c ON r.repcod = c.repcod
GROUP BY r.repcod;
*/
-- 8\. Calcula el total de l'import de les comandes sol·licitades per cada
--client a cada representant.
/*
SELECT SUM(p.importe), c.nombre, r.nombre
FROM pedido p 
JOIN repventa r ON p.repcod = r.repcod
JOIN cliente c ON r.repcod = c.repcod
GROUP BY c.cliecod, r.repcod
ORDER BY c.cliecod;
*/
--19\. Llista l'import total de les comandes preses per cada
--representant.
/*
SELECT r.repcod, SUM(importe)
FROM pedido p 
JOIN repventa r ON p.repcod = r.repcod
GROUP BY r.repcod
ORDER BY r.repcod;
*/
--20\. Per a cada oficina amb dos o més representants, calculeu el total de
--les quotes i el total de les vendes de tots els representants.
/*
SELECT ofinum, count(repcod), SUM(cuota), SUM(ventas)
FROM repventa
GROUP BY ofinum
HAVING COUNT(repcod) > 1;
*/
--21\. Mostra el nombre de comandes que superen el 75% de les existències.
/*
SELECT COUNT(pednum)
FROM pedido p
JOIN producto pr ON pr.prodcod||pr.fabcod = p.prodcod||p.fabcod
WHERE cant > exist * 0.75
*/
