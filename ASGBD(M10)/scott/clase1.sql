SELECT ename FROM emp WHERE LOWER(ename) LIKE '_l%';

SELECT ename,sal, COALESCE(comm::TEXT,'-'), (sal+COALESCE(comm,0)) "Sal+Com" FROM emp;