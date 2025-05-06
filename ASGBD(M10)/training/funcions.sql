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


CREATE OR REPLACE FUNCTION altaClient(p_nombre CHAR,p_repcod INT,p_limcred INT)
    RETURNS varchar
    AS $$
        DECLARE
            v_cliecod cliente.cliecod%type;
        BEGIN
            select setval('cliecod_seq', (select max(cliecod) from cliente)+1, true) INTO STRICT v_cliecod;
            INSERT INTO cliente (cliecod, nombre, repcod, limcred) VALUES (v_cliecod, p_nombre, p_repcod, p_limcred);
            RETURN format('Client %s s’ha donat d’alta correctament', v_cliecod);
        END;
    $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION stock0k(p_cant INT, p_fabcod INT, p_prodcod INT)
    RETURNS boolean
    AS $$
        DECLARE
        v_bool boolean;
        v_exist producto.exist%type
        BEGIN
            SELECT exist INTO STRICT v_exist 
            FROM producto 
            WHERE fabcod||prodcod = p_fabcod||p_prodcod;

            IF p_cant > v_exist THEN
                RETURN format('No ')  