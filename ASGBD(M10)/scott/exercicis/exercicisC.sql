-- 1\. Mostrar la suma de les quotes i la suma de les vendes totals de
-- tots els representants.
/*
SELECT SUM(cuota), SUM(ventas)
FROM repventa;

*/
-- 2\. Quin és l'import total de les comandes preses per Bill Adams?

/*
SELECT ventas 
FROM repventa 
WHERE nombre = 'Bill Adams';

*/

-- 3\. Calcula el preu mitjà dels productes del fabricant “aci”.
SELECT 
