SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT ename,sal, COcomm, (sal+COALESCE(comm,0)) FROM emp;