-- 1\. Mostrar la suma de les quotes i la suma de les vendes totals de
-- tots els representants.
/*
SELECT SUM(cuota), SUM(ventas)
FROM repventa;

*/
-- 2\. Quin és l'import total de les comandes preses per Bill Adams?


SELECT sum(ventas) 
FROM repventa 
WHERE nombre = 'Bill Adams';



-- 3\. Calcula el preu mitjà dels productes del fabricant “aci”.

SELECT ROUND(AVG(precio),2) AS "ACI PREU"
FROM producto
WHERE LOWER(fabcod) = 'aci'

--4\. Quin és l'import mitjà de la comanda sol·licitada pel client
--"acme mfg."

SELECT AVG(pr.precio)
FROM pedido p
JOIN producto pr ON pr.fabcod||pr.prodcod = p.fabcod||p.prodcod
WHERE LOWER(p.cliecod
