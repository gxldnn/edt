--1. 

SELECT l.codpeli, coddvd, p.titol, nom||' '||cognoms "Nom Soci", datapres
FROM lloguer l




WHERE CURRENT_DATE BETWEEN datapres AND datadev;


