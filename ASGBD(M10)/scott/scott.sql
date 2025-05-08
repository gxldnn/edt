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
CREATE SCHEMA ribee;
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

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

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
        (7566, 'JONES',  'MANAGER',   7839, TO_DATE('2-04-1981', 'DD-MM-YYYY'),  2975, NULL, 20),
        (7654, 'MARTIN', 'SALESMAN',  7698, TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30),
        (7698, 'BLAKE',  'MANAGER',   7839, TO_DATE('1-05-1981', 'DD-MM-YYYY'),  2850, NULL, 30),
        (7782, 'CLARK',  'MANAGER',   7839, TO_DATE('9-06-1981', 'DD-MM-YYYY'),  2450, NULL, 10),
        (7788, 'SCOTT',  'ANALYST',   7566, TO_DATE('09-12-1982', 'DD-MM-YYYY'), 3000, NULL, 20),
        (7839, 'KING',   'PRESIDENT', NULL, TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, 10),
        (7844, 'TURNER', 'SALESMAN',  7698, TO_DATE('8-09-1981', 'DD-MM-YYYY'),  1500,    0, 30),
        (7876, 'ADAMS',  'CLERK',     7788, TO_DATE('12-01-1983', 'DD-MM-YYYY'), 1100, NULL, 20),
        (7900, 'JAMES',  'CLERK',     7698, TO_DATE('3-12-1981', 'DD-MM-YYYY'),   950, NULL, 30),
        (7902, 'FORD',   'ANALYST',   7566, TO_DATE('3-12-1981', 'DD-MM-YYYY'),  3000, NULL, 20),
        (7934, 'MILLER', 'CLERK',     7782, TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);

  /* A la seqüència empno_seq li dono de valor d'inici el valor més gran que hi ha al camp empno
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

--ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept;

--ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept --ON DELETE CASCADE;
--ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept --ON DELETE SET NULL;

ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept ON UPDATE CASCADE;
--ALTER TABLE  emp ADD CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept ON UPDATE SET NULL;
  
ALTER TABLE  emp ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp;