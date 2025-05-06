CREATE OR REPLACE FUNCTION existeixClient(p_cliecod SMALLINT)
    RETURNS boolean
    AS $$
        DECLARE
            v_bool boolean;
        BEGIN
            SELECT EXISTS SELECT 1 FROM cliente WHERE cliecod = p_cliecod;
            
            
            RETURN v_bool;
        END;
    $$ LANGUAGE PLPGSQL;