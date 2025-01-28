SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT emnosal, comm, (sal+COALESCE(comm,0)) FROM emp;