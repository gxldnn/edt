/*

mostrar nom, salari, salari incremental i job
SALESMAN +10%
CLERK +20%
OTHERS +30%
*/

CREATE OR REPLACE FUNCTION mostrar(ename){
    RETURNS en
    DECLARE
        v_ename varchar(100);
        sal_sales SMALLINT
        sal_clerk SMALLINT
        sal_
    BEGIN
        SELECT ename INTO v_ename FROM emp;
        SELECT sal * 1.1 INTO sal_sales FROM emp WHERE job = 'SALESMAN';
        SELECT sal * 1.2 INTO sal_clerk FROM emp WHERE job = 'CLERK';
        SELECT sal * 1.3 INTO sal_others FROM emp WHERE job != 'SALESMAN' OR job != 'CLERK';




}
