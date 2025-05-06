CREATE OR REPLACE FUNCTION existeixClient(p_cliecod SMALLINT)
    RETURNS boolean
    AS $$
        DECLARE
            v_bool boolean;
        BEGIN
            SELECT EXISTS (SELECT 1 FROM cliente WHERE cliecod = p_cliecod) INTO v_bool;
            RETURN v_bool;
        END;
    $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION altaClient(p_nombre::CHAR,p_repcod::INT,p_limcred::INT)
    RETURNS varchar
    AS $$
        BEGIN
        