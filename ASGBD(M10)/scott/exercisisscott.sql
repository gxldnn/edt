/*Exercicis DML GitLab*/
--1.

CREATE SEQUENCE deptno_seq
  START WITH 50
  INCREMENT BY 10;
  
INSERT INTO dept VALUES (NEXTVAL('deptno_seq'), 'CONSULTORIA', 'SANTANDER');


--2.
INSERT INTO emp VALUES (8200, 'MANAGER', 'ANALYST', 7782, TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);

INSERT INTO emp (empNo, ename, job, deptno, mgr) VALUES (NEXTVAL('empno_seq'), 'Andreu', 'ANALYST', 30, 8200);

--3.
UPDATE emp SET hiredate = CURRENT_DATE WHERE LOWER(ename) = 'scott';

--4.
UPDATE emp SET job = 'ANALYST', sal = sal+sal*0.2, deptno = 30, mgr = 7566 WHERE LOWER(ename) = 'miller' ;

--5.
UPDATE emp SET sal = sal+sal*0.06;

--6. Com no hi ha un camp activitat o baixa he decidit esborrar el registre
DELETE FROM emp WHERE LOWER(ename) = 'james';

--7.
INSERT INTO emp (empno, ename, deptno, sal) VALUES (1657, 'SANZ', 30, 3000);

--8.
UPDATE emp SET deptno = 40 WHERE LOWER(ename) = 'sanz';

--9.
UPDATE emp SET job = 'SALESMAN', comm = 4000 WHERE LOWER(ename) = 'sanz';

--10.
UPDATE emp SET comm = COALESCE(comm,0) + sal*0.2;

--11.
UPDATE emp SET sal = sal + sal*0.35 WHERE sal < (SELECT sal FROM emp WHERE LOWER(ename)='sanz');
\

--12.
DELETE FROM emp WHERE LOWER(ename)='sanz';

--13.
DELETE FROM emp WHERE deptno = 30;

--14.
UPDATE emp SET mgr = NULL WHERE mgr = 7839;
DELETE FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'ACCOUNTING');

SELECT * FROM emp;