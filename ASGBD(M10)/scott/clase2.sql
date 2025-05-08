SELECT ename,job, sal FROM emp WHERE ( job='SALESMAN' OR  job='PRESIDENT') AND sal>1500;

SELECT ename, job, deptno, hiredate FROM emp ORDER BY hiredate DESC;

SELECT ename, job, deptno, hiredate FROM emp ORDER BY deptno, ename DESC;

SELECT empno, ename, sal*12 AS "Salari Anual" FROM emp ORDER BY 3;

-- Mostrar nom del empleat el salari, el salari incrementat 20% , de qui mes cobra a menys
SELECT ename, sal, sal*1.20 AS "Salari Incrementat" FROM emp ORDER BY 3 DESC, ename DESC;

