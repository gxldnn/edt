SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT ename,sal, comm, (sal+COALESCE(comm,0)) FROM emp;