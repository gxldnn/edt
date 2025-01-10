/*
script name: tablasScott.sql
     author: Jordi Andúgar
       date: 20/01/2022
    version: 1.0
       DBMS: PostgreSQL server
description: operations updating and deleting restricted by default
*/

\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\c scott

CREATE SEQUENCE deptno_seq
  START WITH 50
  INCREMENT BY 10;

/* Creo la seqüència empno_seq amb valor d'inici 1 i increment de un en un */
CREATE SEQUENCE empno_seq;

CREATE TABLE dept (
deptNo SMALLINT  CONSTRAINT dept_pk PRIMARY KEY,
 dName VARCHAR(50),
   loc VARCHAR(50),
CONSTRAINT emp_uk UNIQUE(dname)
);


--1.  Crear seqüencia de departament

CREATE SEQUENCE deptno_seq
  START WITH 50
  INCREMENT BY 10;

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO dept VALUES (NEXTVAL('deptno_seq'), 'CONSULTORIA', 'SANTANDER');


CREATE TABLE EMP (
   empNo SMALLINT CONSTRAINT emp_pk PRIMARY KEY,
   ename VARCHAR(100),
     job VARCHAR(100),
     mgr SMALLINT,
hiredate DATE,
     sal NUMERIC(7, 2),
    comm NUMERIC(7, 2),
  deptNO SMALLINT
);

CREATE OR REPLACE VIEW empleat AS
  	SELECT ename NomEmp, sal salari,job ofici, dname Nomdept, Loc Localitat
  	  FROM emp, dept
  	 WHERE emp.deptno = dept.deptno;

INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902, TO_DATE('17-10-1980', 'DD-MM-YYYY'),  800, NULL, 20),
        (7499, 'ALLEN',  'SALESMAN',  7698, TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600,  300, 30),
        (7521, 'WARD',   'SALESMAN',  7698, TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250,  500, 30),
        (7566, 'JONES',  'MANAGER',   8200, TO_DATE('2-04-1981', 'DD-MM-YYYY'),  2975, NULL, 20),
        (7654, 'MARTIN', 'SALESMAN',  7698, TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30),
        (7698, 'BLAKE',  'MANAGER',   8200, TO_DATE('1-05-1981', 'DD-MM-YYYY'),  2850, NULL, 30),
        (7782, 'CLARK',  'MANAGER',   8200, TO_DATE('9-06-1981', 'DD-MM-YYYY'),  2450, NULL, 10),
        (7788, 'SCOTT',  'ANALYST',   7566, TO_DATE('09-12-1982', 'DD-MM-YYYY'), 3000, NULL, 20),
        (8200, 'KING',   'PRESIDENT', NULL, TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, 10),
        (7844, 'TURNER', 'SALESMAN',  7698, TO_DATE('8-09-1981', 'DD-MM-YYYY'),  1500,    0, 30),
        (7876, 'ADAMS',  'CLERK',     7788, TO_DATE('12-01-1983', 'DD-MM-YYYY'), 1100, NULL, 20),
        (7900, 'JAMES',  'CLERK',     7698, TO_DATE('3-12-1981', 'DD-MM-YYYY'),   950, NULL, 30),
        (7902, 'FORD',   'ANALYST',   7566, TO_DATE('3-12-1981', 'DD-MM-YYYY'),  3000, NULL, 20),
        (7934, 'MILLER', 'CLERK',     7782, TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);

  /* 
     A la seqüència empno_seq li dono de valor d'inici el valor més gran que hi ha al camp empno
     El paràmetre TRUE vol dir que el valor que es generarà serà el següent al màxim
     L'increment per defecte és 1
  */

SELECT SETVAL('empno_seq', (SELECT MAX(empno) FROM emp), TRUE);

CREATE TABLE salgrade (
  grade SMALLINT,
  losal NUMERIC,
  hisal NUMERIC);

INSERT INTO salgrade VALUES
 (1,  700, 1200),
 (2, 1201, 1400),
 (3, 1401, 2000),
 (4, 2001, 3000),
 (5, 3001, 9999);

ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept;
ALTER TABLE  emp ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp;


/* Exercici 1 de Moodle

INSERT INTO emp VALUES 
  (NEXTVAL('empno_seq'), 'Pepita', NULL,     7566, TO_DATE('15-12-2023', 'DD-MM-YYYY'),  2000, NULL, 40);

UPDATE emp SET ename='PEREZ' WHERE ename='SMITH' AND deptno=20;

-- DELETE FROM emp WHERE job='CLERK';

UPDATE emp SET sal = sal + sal*0.1 WHERE job='SALESMAN';

*/

/*Exercicis DML GitLab*/

--2.
INSERT INTO emp (empNo, ename, job, deptno, mgr) VALUES (NEXTVAL('empno_seq'), 'Andreu', 'ANALYST', 30, 8200);

--3.
UPDATE emp SET hiredate = CURRENT_DATE WHERE ename = 'SCOTT';

--4.
UPDATE emp SET job = UPPER('analyst'), sal = sal+sal*0.2, deptno = 30, mgr = 7566 WHERE ename = 'MILLER' ;

--5.
UPDATE emp SET sal = sal+sal*0.06;

--6. Com no hi ha un activitat o baixa he decidit esborrar el registre
DELETE FROM emp WHERE ename = 'JAMES';

--7.
INSERT INTO emp (empno, ename, deptno, sal) VALUES (1657, 'SANZ', 30, 3000);

--8.
UPDATE emp SET deptno = 40 WHERE ename = 'SANZ';

--9.
UPDATE emp SET job = UPPER('salesman'), comm = 4000 WHERE ename = 'SANZ';

--10.
UPDATE emp SET comm = comm + sal*0.2;

--11.
UPDATE emp SET sal = sal + sal*0.35 WHERE sal < (SELECT sal FROM emp WHERE ename='SANZ');

--12.
DELETE FROM emp WHERE ename='SANZ';

--13.
DELETE FROM emp WHERE deptno = 30;

--14.

UPDATE emp SET mgr = NULL WHERE mgr = 8200;
DELETE FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'ACCOUNTING');