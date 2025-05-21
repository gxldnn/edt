\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\c scott
\i scott/scott.sql

/*
BEGIN;

DELETE FROM dept WHERE deptno = 30;


COMMIT;*/