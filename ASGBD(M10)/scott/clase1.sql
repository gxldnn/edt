SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT sal, comm, (sal+COALESCE(comm,0)) FROM emp;