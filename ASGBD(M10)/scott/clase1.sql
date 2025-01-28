SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT emno,sal, comm, (sal+COALESCE(comm,0)) FROM emp;