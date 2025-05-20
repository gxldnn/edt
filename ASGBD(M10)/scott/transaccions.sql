\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\c scott

BEGIN;
emp WHERE deptno = 30;
DELETE FROM dept WHERE deptno = 30;
COMMIT;