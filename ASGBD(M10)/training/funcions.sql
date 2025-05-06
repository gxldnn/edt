CREATE OR REPLACE FUNCTION existeixClient(p_cliecod)
    RETURNS varchar
    AS $$
        DECLARE
            v_bool boo
        BEGIN
            SELECT