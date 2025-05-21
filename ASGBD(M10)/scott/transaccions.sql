\c template1
DROP DATABASE IF EXISTS scott;
CREATE DATABASE scott;
\i scott/scott.sql
\c scott

INSERT INTO punts (id, valor) VALUES (10,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 10;
ROLLBACK;
SELECT valor FROM punts WHERE id = 10;