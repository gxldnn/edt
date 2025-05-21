\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\i scort
\c scott

BEGIN;

DELETE FROM dept WHERE deptno = 30;


COMMIT;