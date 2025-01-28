SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';


SELECT ename,sal, COALESCE(TO_CAHR(comm),''), (sal+COALESCE(comm,0)) FROM emp;