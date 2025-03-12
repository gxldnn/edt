-- 41. Calcular el salari total mensual.
--SELECT SUM(sal) FROM emp;

-- 42. Calcular el nombre d'empleats que tenen comissió i la mitjana. Volem Mostreu tots els empleats, de manera que pretén en compte que el camp comm pot tenir nuls
--SELECT count(comm), ROUND(AVG(COALESCE(comm,0)),2) FROM emp; 

-- 43. Mostreu el salari, mínim i màxim dels empleats, agrupats per ocupació.
/*
SELECT job, MIN(sal), MAX(sal) FROM emp
GROUP BY job;
*/

-- 44. Seguint el que s'ha explicat en l'ex. 27, Mostreu per cada departament, el nombre d'empleats que tenen comissió, la suma i la mitjana.
/*
SELECT deptno, count(empno), sum(comm), ROUND(AVG(COALESCE(comm,0)),2)
FROM emp
GROUP BY deptno;

*/
-- 45. Idem que el 44, però mostrant a més el nom de departament.
/*
SELECT e.empno, e.ename, e.job, e.sal, e.deptno, d.dname "Dept Dname"
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.empno= 7934;
*/

---------------------------------------------------------------------------------------------------------------------

/*
SELECT job, deptno, sum(sal)
FROM emp
GROUP BY job, deptno;
*/

/*
SELECT deptno, count(ename)
from emp
GROUP BY deptno;
*/

/*
SELECT ename, sal
FROM emp
ORDER BY sal DESC LIMIT 5;
*/
/*
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING AVG(sal) > 2000;
*/






--27. Mostreu aquells el salari estigui entre 2000 i 3000.
/*
SELECT SAL FROM EMP WHERE SAL >=2000 AND SAL <=3000;



--31. Mostreu el salari mínim, màxim i mig dels empleats agrupats per feina, però només d'aquells la mitjana sigui superior a 4000.


select min(sal), max(sal), avg(sal)
from emp group by job having avg(sal) >= 4000;

*/

--32. Vegeu el nombre i el nom dels departaments que tinguin més de tres empleats assignats.
/*
SELECT d.deptno "Numero DEpt", e.deptno"Numero DEPT emp", d.dname
FROM dept d
JOIN emp e ON e.deptno = d.deptno
GROUP BY d.deptno, e.deptno, d.dname
HAVING count(empno) > 3;
*/





