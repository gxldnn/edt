CREATE OR REPLACE FUNCTION mostrar(p_empno SMALLINT){
    RETURNS varchar
    AS $$
        DECLARE
            v_emp RECORD;
            v_sal emp.sal%type;
        BEGIN
            SELECT * INTO STRICT v_emp FROM emp WHERE empno = p_empno;  
            
            
        EXCEPTION
                WHEN NO DATA FOUND THEN
                 RETURN 'No s''ha trobat cap empleat amb aquest número.';
        END;
    $$ LANGUAGE PLPGSQL;
}