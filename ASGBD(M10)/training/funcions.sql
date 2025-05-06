CREATE OR REPLACE FUNCTION existeixClient(p_cliecod SMALLINT)
    RETURNS boolean
    AS $$
        DECLARE
            v_bool boolean;
        BEGIN
            SELECT Ecliecod INTO STRICT v_bool FROM cliente WHERE cliecod = p_cliecod;
            
            
            RETURN v_bool;
        END;
    $$ LANGUAGE PLPGSQL;