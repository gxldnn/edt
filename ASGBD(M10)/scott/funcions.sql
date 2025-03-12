-- 41. Calcular el salari total mensual.
--SELECT SUM(sal) FROM emp;

-- 42. Calcular el nombre d'empleats que tenen comissió i la mitjana. Volem Mostreu tots els empleats, de manera que pretén en compte que el camp comm pot tenir nuls
--SELECT count(comm), ROUND(AVG(COALESCE(comm,0)),2) FROM emp; 

-- 43. Mostreu el salari, mínim i màxim dels empleats, agrupats per ocupació.
/*
SELECT MIN(sal), MAX(sal) FROM emp
GROUP BY job;
*/

-- 44. Seguint el que s'ha explicat en l'ex. 27, Mostreu per cada departament, el nombre d'empleats que tenen comissió, la suma i la mitjana.

SELECT deptno, count(empno), sum(comm), ROUND(AVG(COALESCE(comm,0)),2)
FROM emp
WHERE comm IS NOT NULL
GROUP BY deptno;


-- 45. Idem que el 44, però mostrant a més el nom de departament.
--SELECT d.dname, count(comm), sum(comm), ROUND(AVG(COALESCE(comm,0)),2) FROM emp e
--JOIN dept d ON e.deptno = d.deptno;


