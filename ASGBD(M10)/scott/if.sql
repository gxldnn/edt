/*

mostrar nom, salari, salari incremental i job segobs empno
SALESMAN +10%
CLERK +20%
OTHERS +30%
*/

CREATE OR REPLACE FUNCTION mostrar(){
    RETURNS varchar
    AS $$
        DECLARE
            v_emp RECORD;
            v_sal emp.sal%type;
        BEGIN
            SELECT * INTO STRICT v_emp

}