--1. 
/*
SELECT p.codpeli, l.coddvd, p.titol, s.nom||' '||s.cognoms "Nom Soci", l.datapres
FROM lloguer l
JOIN soci s ON l.codsoci = s.codsoci
JOIN dvd d ON l.coddvd = d.coddvd
JOIN pelicula p ON d.codpeli = p.codpeli
WHERE CURRENT_DATE BETWEEN datapres AND datadev;
*/

--2.

SELECT s.codsoci "Codi Soci", s.cognoms||', '||s.nom "Soci",COUNT(s.codsoci) "Prestecs Realitzats", SUM(import) "Despesa"
FROM soci s
JOIN lloguer l ON l.codsoci = s.codsoci
GROUP BY s.codsoci
ORDER BY ;
