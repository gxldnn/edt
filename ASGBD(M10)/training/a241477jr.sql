--1. 

SELECT p.codpeli, l.coddvd, p.titol, s.nom||' '||s.cognoms "Nom Soci", l.datapres
FROM lloguer l
JOIN soci s ON l.codsoci = s.codsoci
JOIN dvd d ON l.coddvd = d.coddvd
JOIN pelicula p ON d.codpeli = p.codpeli
WHERE CURRENT_DATE BETWEEN datapres AND datadev;


--2.

SELECT s.codsoci "Codi Soci", s.cognoms||', '||s.nom "Soci",COUNT(s.codsoci) "Prestecs Realitzats", SUM(import) "Despesa"
FROM soci s
JOIN lloguer l ON l.codsoci = s.codsoci
GROUP BY s.codsoci
ORDER BY 4 DESC, 3,2;


--3.

SELECT DISTINCT genere
FROM genere g
JOIN pelicula p ON p.codgen = g.codgen
WHERE p.codpeli NOT IN (SELECT p.codpeli
    FROM genere g
    JOIN pelicula p ON g.codgen = p.codgen 
    JOIN dvd d ON d.codpeli = p.codpeli
    JOIN lloguer l ON l.coddvd = d.coddvd)
ORDER BY 1;
