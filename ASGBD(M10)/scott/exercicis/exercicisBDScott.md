# ­Exercicis d'SQL. Base de dades Scott
### Professor: Jordi Andúgar
### Mòdul: M02-Bases de dades
La base de dades està composta per les següents taules:

DEPT (<ins>deptno</ins>, dname, loc)
Cada fila representa un departament, amb el seu número de departament, el seu nom i la ciutat on està localitzat.

EMP (<ins>empno</ins>, ename, job, mgr, hiredate, sal, comm, deptno)
Cada fila representa un empleat. Les seves columnes són: nombre d'empleat, nom de l'empleat, ocupació, nombre de l'empleat que és el seu cap, data de contractació, salari, comissió i nombre de departament a què està assignat.

SALGRADE (<ins>grade</ins>, losal, hisal)
Cada fila representa un tram de salaris, amb el salari mínim i el màxim, per a aquest tram.

Recordeu que `null` significa absència de valor.

__IMPORTANT__: Utilitzeu la funció lower per comparar cadenes de caràcters.

Ús:
  LOWER(camp) = cadena de caràcters  en minúscules
Exemple:
```
 SELECT *
 FROM emp
 WHERE LOWER(job)='salesman';
```
Existeix un tipus d'objecte que genera automàticament valors únics que es fan servir el camps clau primària. Aquest objecte es diu `SEQUENCE`.
Per crear la seqüència segueix la següent sintaxi:
```
CREATE SEQUENCE nomCamp_seq
START WITH i
INCREMENT BY j;
```
On i serà el valor d'inici de la seqüència i j serà l'increment. El nom de la seqüència acostuma a ser el nom del camp que rebrà el valor amb el sufixe `_seq`. Les seqüències es fan servir per l'ordre INSERT, de manera que en lloc de posar un valor literal s'utilitza la funció NEXTVAL('seqüència'). Quedaria de la següent manera:

INSERT INTO taula
VALUES (..., NEXTVAL('seqüència'), ...);

Més informació a [tutorial](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-sequences/)

#### Diagrama referencial

Taula referencial | Clau aliena | Taula referenciada
:-:|:-:|:-:
emp|deptno|dept
emp|mgr 	| emp

# EXERCICIS
# Consideracions
* L'script literalment es dirà `exercicisBDScott.sql` i a dintre hi haurà el vostre nom, cognoms i el vostre codi.
* L'enunciat dels exercicis es posarà com a comentari
* L'script no ha de tenir errors sintàctics (comproveu-lo des de fora amb psql ...)

## DML
Els exercicis marcats amb un `*` significa que seran per més endavant.

1. Inserir en la taula DEPT la informació corresponent a un nou departament de
consultoria, de codi 50 i que estigui ubicat a SANTANDER. Per a l'ocasió creeu
la seqüència `deptno_seq` (la qual començarà en 50 i s'incrementarà de 10 en 10)
 i la utilitzeu per la sentència SQL.
2. Donar d'alta a un nou empleat de nom Andreu, que exercirà el lloc de analyst
en el departament 30 i el seu cap serà l'empleat 8200. De moment es desconeixen
els altres valors dels camps.
3. Canviar la data de l'empleat SCOTT per la d'avui.
4. L'empleat MILLER, a causa de els seus èxits és ascendit al lloc de analyst, augmentant-seu salari en un 20%, se li canvia al departament 30 i el seu nou cap serà l'empleat 7566.
7. Arran de la signatura d'el conveni anual de l'empresa, s'ha determinat incrementar el salari de tots els empleats en un 6%.
8. L'empleat JAMES causa baixa a l'empresa.
9. Es contracta a SANZ, amb número 1657, per al departament 30 i amb sou 3000.
10. SANZ canvia al departament 40.
11. SANZ treballa de salesman, amb una comissió de 4000.
12. Es decideix augmentar les comissions. Augmenten totes les comissions en un 20% de l'salari.
10.B. Es decideix augmentar les comissions. Augmenten totes les comissions en un 20% de l'salari.
13. Es decideix augmentar un 35% el salari als empleats que guanyin menys que SANZ (\*).
14. S'acomiada a SANZ.
15. El departament 30 desapareix. S'han d'acomiadar a tots els treballadors que hi treballen. Escriviu les sentències SQL necessàries per portar-lo a terme.
23. L'empresa està en crisi i ha d'acomiadar a tots els que treballen al departament ACCOUNTING. (*)


## Consultes bàsiques


15. Mostreu el codi d'empleat, salari, comissió, nº de departament i data de la taula EMP.
15. Mostra tota la informació de la taula departaments.
18. Mostreu el nom i l'ocupació d'aquells que siguin salesman.
19. Mostreu el nom i el codi de departament d'aquells empleats que no treballen en el departament 30.
20. Mostreu els empleats que treballen en els departaments 10 y 20 (es vol les dues solucions).
21. Mostreu el nom i salari d'aquells empleats que guanyin més de 2000.
22. Mostreu el nom i la data de contractació d'aquells empleats que hagin entrat abans de l'1/1/82.
23. Mostreu el nom dels salesmans que guanyin més de 1500.
24. Mostreu el nom d'aquells que siguin 'Clerk' o treballin en el departament 30.
25. Mostreu aquells que es diguin 'SMITH', 'ALLEN' o 'SCOTT'.
26. Mostreu aquells que no es diguin 'SMITH', 'ALLEN' o 'SCOTT'.
27. Mostreu aquells el salari estigui entre 2000 i 3000.
28. Mostreu aquells empleats que treballin en el departament 10 o 20.
29. Mostreu aquells empleats el nom comenci per 'A'.
30. Mostreu aquells empleats el nom tingui com a segona lletra una "D".
31. Mostreu els diferents departaments que hi ha a la taula EMP.
32. Mostreu el departament i el treball dels empleats (evitant repeticions).
33. Mostreu aquells empleats que hagin entrat el 1981.
34. Mostreu aquells empleats que tenen comissió, mostrant nom i comissió.
35. Mostreu aquells empleats que guanyin més de 1500, ordenats per ocupació.
36. Calcular el salari anual a percebre per cada empleat (tingueu en compte 14 pagues).
37. Mostreu el nom de l'empleat, el salari i l'increment de l'15% de l'salari.
38. Mostreu el nom de l'empleat, el salari, l'increment de l'15% de l'salari i el salari augmentat un 15%.

## Consultes multitaula

38. Mostreu el nom i la localitat dels empleats que treballin a 'CHICAGO'.
40. Nom dels empleats, ocupació, departament i localitat.
41. Mostra codi d'empleat, el seu nom, el codi del seu cap i el nom del seu cap.

## Funcions de grup

41. Calcular el salari total mensual.
27. Calcular el nombre d'empleats que tenen comissió i la mitjana. Volem Mostreu tots els empleats, de manera que pretén en compte que el camp comm pot tenir nuls
28. Mostreu el salari, mínim i màxim dels empleats, agrupats per ocupació.
29. Seguint el que s'ha explicat en l'ex. 27, Mostreu per cada departament, el nombre d'empleats que tenen comissió, la suma i la mitjana.
30. Idem que el 4, però mostrant a més el nom de departament.
31. Mostreu el salari mínim, màxim i mig dels empleats agrupats per feina, però només d'aquells la mitjana sigui superior a 4000.
32. Vegeu el nombre i el nom dels departaments que tinguin més de tres empleats assignats.

## Avançats

48. Mostreu els empleats que treballen en el mateix departament que Clark.
34. Calcular el nombre d'empleats per departament que tenen un salari superior a la mitjana.
35. Mostreu els empleats el salari sigui superior al d'Adams.
36. Mostreu el nom i data d'ingrés de l'empleat que porta menys temps.
37. Mostreu el nom dels empleats que guanyin més que qualsevol salesman (es a dir, que guanyi més que tots els salesman).
38. Mostreu els empleats que guanyin més que algun dels que treballen de salesman.

## Més exercicis

54. Mostreu el treball, el nom i el salari dels empleats ordenats pel tipus de treball i per salari descendent.
40. Mostreu el nom de cada empleat, i el nombre i nom del seu cap.
41. Mostreu el nom de l'empleat i la seva data d'alta en l'empresa dels empleats que són analyst.
42. Mostreu el nom de l'empleat i una columna que contingui el salari multiplicat per la comissió la capçalera sigui 'BO'.
43. Trobeu el salari mitjà d'aquells empleats el treball sigui el d'analista (analyst).
44. Trobeu el salari més alt, el més baix i la diferència entre tots dos.
45. Trobeu el nombre de treballs diferents que hi ha al departament 30.
46. Mostreu el nom de l'empleat, el seu treball, el nom i el codi de l'departament en el qual treballa.
47. Mostreu el nom, el treball i el salari de tots els empleats que tenen un salari superior a el salari més baix de el departament 30.
48. Trobeu als empleats el cap és 'BLAKE'.
49. Trobeu el nombre de treballadors diferents en el departament 30 per a aquells empleats el salari pertanyi a l'interval [1000, 1800].
50. Trobeu el Ename, dname, job i sal dels empleats que treballin en el mateix departament que 'TURNER' i el seu salari sigui més gran que la mitjana de l'salari de el departament 10.
51. Indiqueu si les següents sentències són correctes, si no ho són, indiqueu en què consisteix l'error:  
A.
```
SELECT *  
FROM EMP  
WHERE MGR = NULL;  
```
B.
```
SELECT *  
FROM DEPT  
WHERE DEPTNO = 20 OR WHERE DEPTNO = 30;  
```
C.
```
SELECT *  
FROM EMP  
WHERE NOT ename LIKE 'R%' AND sal BETWEEN 3000 AND 5000;  
```
D.
```
SELECT *  
FROM EMP  
WHERE sal < 4000 AND job NOT = 'ANALYST';  
```
E.
```
SELECT *  
FROM DEPT  
WHERE loc = 'DALLAS' OR 'CHICAGO';  
```
52. El salari mitjà i mínim de cada lloc, mostrant en el resultat aquells el salari mitjà estigui per sobre de 1500.  
53. Què empleats treballen a 'DALLAS'?  
54. Quants emprat treballen a 'CHICAGO'?  
55. Llistar el nom dels empleats que guanyen menys que els seus supervisors.  
56. Llistar el nom, treball, departament, localitat i salari d'aquells empleats que tinguin un salari major de 2000 i treballin a 'DALLAS' o 'NEW YORK'.

## VISTES

Crear una vista que mostri en una fila quants empleats hi ha de cada treball,
segons es mostra a continuació:  

Clerk|Salesman|Analyst|Manager|President  
-|-|-|-|-
4|4|2|3|1

Primer feu-lo com a consulta. Quan us funcioni, creeu la vista.

## TRIGGERS (fitxer triggersScott.sql)

1. Creeu el trigger *t_auditoria* el qual anotarà a la taula *control* (l'hem de crear), qui fa una operació DML sobre la taula EMP (bd scott) i quan la realitza. L'estructura de la taula control ha de ser la següent: id (tipus serial), fecha (tipus timestamp), opDML (tipus text, longitud 1, ha de tenir un dels 3 valores: I(nsert),U(pdate) o D(elete)) i el camp usuari (tipo varchar(50)). La funció del trigger s'ha de dir *autoditoria*.

Per saber de quina operació es tracta, podem consultar aquest [enllaç](https://www.postgresql.org/docs/12/plpgsql-trigger.html). A dintre d'una funció de trigger hi tenim accés a unes variables especials. Busqueu a la llista de quina es tracta.

Què codi hem d'executar per donar per bó el trigger que hem implementat?

2. Creeu el trigger _tEmpleat_ el qual ha de permetre inserir dades en la vista complexa `empleat`. Si el departament no existeix, el crearà.

```
scott=> \d empleat
             View "public.empleat"
  Column   |         Type          | Modifiers
-----------+-----------------------+-----------
 nomemp    | character varying(10) |
 salari    | numeric(7,2)          |
 ofici     | character varying(9)  |
 nomdept   | character varying(14) |
 localitat | character varying(13) |
```
