SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT ename,sal, COALESCE(Ocomm,0), (sal+COALESCE(comm,0)) FROM emp;