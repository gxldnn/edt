CREATE sequence cliecod_seq;
CREATE sequence pednum_seq;

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


CREATE OR REPLACE FUNCTION stock0k(p_cant INT, p_fabcod char, p_prodcod char)
    RETURNS boolean
    AS $$
        DECLARE
        v_exist producto.exist%type;
        BEGIN
            SELECT exist INTO STRICT v_exist 
            FROM producto 
            WHERE fabcod||prodcod = p_fabcod||p_prodcod;

            IF p_cant > v_exist THEN
                RETURN FALSE;
            ELSE 
                RETURN TRUE;
            END IF;
        END; 
    $$ LANGUAGE PLPGSQL;
          
CREATE OR REPLACE FUNCTION altaComanda(p_cliecod INT, p_cant INT, p_fabcod varchar,p_prodcod varchar)
    RETURNS varchar
    AS $$
        DECLARE
            v_data pedido.fecha
        BEGIN
            IF existeixClient(p_cliecod) == false THEN
                RETURN format('Client %s no existeix, no es pot fer la comanda',p_cliecod);
            END IF;

            IF stock0k(p_cant, p_fabcod, p_prodcod) == false THEN
                RETURN format('No hi han existencies suficients del producte $s', p_fabcod||p_prodcod );
            END IF;

            INSERT INTO pedido ()
        END;
    $$ LANGUAGE PLPGSQL;
