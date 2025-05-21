\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\i scott
\c scooscott

BEGIN;

DELETE FROM dept WHERE deptno = 30;


COMMIT;