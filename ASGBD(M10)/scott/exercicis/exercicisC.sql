-- 1\. Mostrar la suma de les quotes i la suma de les vendes totals de
-- tots els representants.
/*
SELECT SUM(cuota), SUM(ventas)
FROM repventa;

*/
-- 2\. Quin és l'import total de les comandes preses per Bill Adams?
/*

SELECT sum(ventas) 
FROM repventa 
WHERE nombre = 'Bill Adams';



-- 3\. Calcula el preu mitjà dels productes del fabricant “aci”.

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

SELECT count(pednum)"Numero de comandes", ROUND(AVG(importe),2)"Import Mitjà", SUM(importe)
FROM pedido;