CREATE OR REPLACE FUNCTION mostrar(p_empno SMALLINT)
    RETURNS varchar
    AS $$
        DECLARE
            v_emp RECORD;
            v_sal emp.sal%type;
        BEGIN
            SELECT * INTO STRICT v_emp FROM emp WHERE empno = p_empno;  
            
            IF LOWER(v_emp.job) = 'salesman' THEN
                v_sal := v_emp.sal*1.1;
            ELSE
                IF LOWER(v_emp.job) = 'clerk' THEN
                    v_sal := v_emp.sal*1.2;
                ELSE v_sal := v_emp.sal*1.3;
                END IF;
            END IF;
            
sss
            RETURN v_emp.ename ||' '||v_emp.job||' '||v_emp.sal||' '||v_sal;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'No s''ha trobat cap empleat amb aquest número.';
        END;
    $$ LANGUAGE PLPGSQL;
