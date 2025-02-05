--1.
SELECT nombre, ciudad, region FROM repventa JOIN oficina ON repventa.ofinum = oficina.ofinum

--2. 
SELECT *, nombre FROM pedido JOIN cliente ON pedido.cliecod = cliente.cl