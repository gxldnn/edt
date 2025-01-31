SELECT ename,job, sal FROM emp WHERE ( job='SALESMAN' OR  job='PRESIDENT') AND sal>1500; LOS PARENTESIS HACEN QUE SE PRIORIZE ESO --)
SELECT ename, job, deptno, hiredate FROM emp ORDER BY hiredate DESC; -- DESC (Muestre valores de mayor a menor ) O ASC (Es lo que hace por defecto que es de menor a mayor)--)
SELECT ename, job, deptno, hiredate FROM emp ORDER BY deptno, ename DESC;
-Hay que pones ASC o DESC al lado del campo sino no lo coje en este caso ordenara los nombres de ultimas letras del abecedario 
SELECT empno, ename, sal*12 AS annsal FROM emp ORDER BY AS annsal;