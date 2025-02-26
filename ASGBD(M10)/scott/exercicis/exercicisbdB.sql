


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
JOIN oficina o ON r.ofinum = o.ofinum;

*/

--14.
/*
SELECT pr.descrip 
FROM producto pr
JOIN pedido p ON p.fabcod = pr.fabcod AND p.prodcod = pr.prodcod
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
SELECT r.nombre, r.ofinum, rdir.nombre, rdir.ofinum
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
SELECT rdir.nombre FROM repventa r
JOIN repventa rdir ON r.repcod = rdir.nombre
*/
