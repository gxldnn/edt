CREATE OR REPLACE FUNCTION existeixClient(p_cliecod)
    RETURNS varchar
    AS $$
        DECLARE
            v_bool boolean;
        BEGIN
            SELECT cliecod INTO v_bool