--0. Mostrar el nom i el lloc dels que són cap (ja està fet amb self join, ara amb subconsultes)
/*
SELECT nombre, puesto
FROM repventa
WHERE repcod IN (SELECT jefe FROM repventa);
*/
--1\. Obtenir una llista dels representants les quotes dels quals són iguals o
--superiors a lobjectiu de loficina dAtlanta.
/*
SELECT nombre, cuota
FROM repventa
WHERE cuota >= ANY (SELECT objetivo FROM oficina);
*/
--2\. Obtenir una llista de tots els clients (nom) que van ser
--contactats per primera vegada per Bill Adams.
/*
SELECT nombre
FROM cliente
WHERE repcod = (SELECT repcod FROM repventa WHERE nombre = 'Bill Adams');
*/

--3\. Obtenir una llista de tots els productes del fabricant ACI les del qual
--existències superen les existències del producte 41004 del mateix
--fabricant.
/*
SELECT *
FROM producto
WHERE fabcod = 'aci' AND exist > (SELECT exist FROM producto WHERE prodcod = '41004');
*/
--4\. Obtenir una llista dels representants que treballen a les oficines
--que han aconseguit superar el seu objectiu de vendes.
/*
SELECT *
FROM repventa
WHERE ventas > ANY (SELECT objetivo FROM oficina);
*/
--5\. Obtenir una llista dels representants que no treballen a les
--oficines dirigides per Larry Fitch.
/*
SELECT *
FROM repventa
WHERE ofinum NOT IN (SELECT o.ofinum FROM oficina o JOIN repventa r ON r.repcod = o.director WHERE r.nombre = 'Larry Fitch');
*/
--6\. Obtenir una llista de tots els clients que han demanat comandes
--del fabricant ACI entre gener i juny del 2003.


--INSERT INTO pedido VALUES (113015, '2003-01-11', 2111, 105, 'aci', 41003, 35, 3745.00); INSERT PER A QUE HI HAGI UN VALOR QUE BUSCAR
/*
SELECT * 
FROM cliente
WHERE cliecod IN (SELECT cliecod FROM pedido WHERE fabcod = 'aci' AND fecha BETWEEN '2003-01-01' AND '2003-06-30');
*/
--7\. Obtenir una llista dels productes dels quals s'ha pres una comanda
--de 150 euros o més.
/*
SELECT *
FROM producto
WHERE fabcod||prodcod IN (SELECT fabcod||prodcod FROM pedido WHERE importe > 150);
*/
--8\. Obtenir una llista dels clients contactats per Sue Smith que no
--han sol·licitat comandes amb imports superiors a 18 euros.
/*
SELECT *
FROM cliente 
WHERE repcod IN 
    (SELECT repcod FROM repventa WHERE nombre = 'Sue Smith') AND 
    cliecod IN 
    (SELECT cliecod FROM pedido WHERE importe < 5000);
*/

--9\. Obtenir una llista de les oficines on hi hagi algun representant
--la quota del qual sigui més del 55% de l'objectiu de l'oficina. Per comprovar el vostre
--exercici, feu una Consulta prèvia el resultat de la qual valideu l'exercici.
/*
SELECT *
FROM oficina
WHERE ofinum IN 
    (SELECT ofinum FROM repventa WHERE cuota > ANY (SELECT 0.55 * objetivo FROM oficina o JOIN repventa r ON o.ofinum = r.ofinum));
*/

--10\. Obtenir una llista dels representants que han pres alguna comanda
--l'import del qual sigui més del 10% de la seva quota.
 /*
SELECT *
FROM repventa r
WHERE 0.1*cuota > ANY (SELECT importe FROM pedido p WHERE p.repcod = r.repcod);
*/


--11\. Obtenir una llista de les oficines on el total de vendes
--dels seus representants han aconseguit un import de vendes que supera el
--50% de lobjectiu de loficina. Mostrar també l'objectiu de cada
--oficina (suposeu que el camp vendes d'oficina no existeix).
/*
SELECT *
FROM oficina o
WHERE 0.5 * o.objetivo < ANY (SELECT SUM(ventas) FROM repventa r WHERE r.ofinum = o.ofinum);
*/
--12\. Quina és la descripció del primer producte sol·licitat en una comanda?
/*
SELECT descrip
FROM producto
WHERE prodcod||fabcod = (SELECT prodcod||fabcod FROM pedido WHERE fecha = (SELECT MIN(fecha) FROM pedido));
*/
--13\. Quin representant té el millor percentatge de vendes?
/*
SELECT repcod, nombre
FROM repventa
WHERE ventas = (SELECT MAX(ventas) FROM repventa);
*/
--14\. Quin representant té el pitjor percentatge de vendes?
/*
SELECT repcod, nombre
FROM repventa
WHERE ventas = (SELECT MIN(ventas) FROM repventa)
*/
--15. Quin producte (Descripció) té més comandes?
/*
SELECT s.descrip, MAX(var)
FROM (SELECT descrip, SUM(cant) AS var FROM pedido s1 
      JOIN producto p ON s1.prodcod||s1.fabcod = p.prodcod||p.fabcod 
      GROUP BY s1.prodcod||s1.fabcod, p.descrip) AS s
;
*/
/*
SELECT COUNT(*), fabcod||prodcod
FROM pedido p
GROUP BY fabcod||prodcod;
*/

/*
SELECT max
FROM (SELECT MAX(count) "max", prod
FROM (SELECT p.prodcod || p.fabcod "prod", COUNT(p.prodcod || p.fabcod) "count" FROM producto p GROUP BY prod) AS "sub1"
	JOIN producto p ON p.prodcod || p.fabcod = sub1.prod GROUP BY prod) AS "subf"

    -- FROM (SELECT * FROM pedido) AS "sub2" GROUP BY prodcod||fabcod)
*/




--16. Quin producte s'ha venut més?

SELECT prodcod
FROM (SELECT count(prodcod) "count" FROM pedido WHERE count = (SELECT MAX(count) FROM sub1)) AS "sub1"

