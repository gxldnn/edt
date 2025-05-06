CREATE OR REPLACE FUNCTION existeixClient(p_cliecod)
    RETURNS 
    AS $$
        DECLARE
            v_bool boolean;
        BEGIN
            SELECT cliecod INTO STRICT v_bool FROM cliente WHERE cliecod = p_cliecod
            RETURNS 