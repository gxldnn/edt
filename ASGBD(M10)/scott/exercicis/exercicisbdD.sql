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
WHERE ofinum != ALL (SELECT o.ofinum FROM oficina o JOIN repventa r ON r.repcod = o.director WHERE r.nombre = 'Larry Fitch');
*/
--6\. Obtenir una llista de tots els clients que han demanat comandes
--del fabricant ACI entre gener i juny del 2003.

SELECT * 
FROM cliente
WHERE cliecod = 

--7\. Obtenir una llista dels productes dels quals s'ha pres una comanda
--de 150 euros o més.

--8\. Obtenir una llista dels clients contactats per Sue Smith que no
--han sol·licitat comandes amb imports superiors a 18 euros.

--9\. Obtenir una llista de les oficines on hi hagi algun representant
--la quota del qual sigui més del 55% de l'objectiu de l'oficina. Per comprovar el vostre
--exercici, feu una Consulta prèvia el resultat de la qual valideu l'exercici.

--10\. Obtenir una llista dels representants que han pres alguna comanda
--l'import del qual sigui més del 10% de la seva quota.

--11\. Obtenir una llista de les oficines on el total de vendes
--dels seus representants han aconseguit un import de vendes que supera el
--50% de lobjectiu de loficina. Mostrar també l'objectiu de cada
--oficina (suposeu que el camp vendes d'oficina no existeix).

--12\. Quina és la descripció del primer producte sol·licitat en una comanda?

--13\. Quin representant té el millor percentatge de vendes?

--14\. Quin representant té el pitjor percentatge de vendes?

--15. Quin producte (Descripció) té més comandes?

--16 . Quin producte s'ha venut més?
