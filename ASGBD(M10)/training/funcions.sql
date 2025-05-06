CREATE sequence cliecod_seq;
CREATE sequence pednum_seq;
select setval('cliecod_seq', (select max(cliecod) from cliente), true);
SELECT setval('pednum_seq', (SELECT max(pednum) FROM pedido), true);

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
            INSERT INTO cliente (cliecod, nombre, repcod, limcred) VALUES (v_cliecod, p_nombre, p_repcod, p_limcred);
            RETURN ('Client %s s’ha donat d’alta correctament', v_cliecod);
        END;
    $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION stock0k(p_cant INT, p_fabcod char, p_prodcod char)
    RETURNS boolean
    AS $$
        DECLARE
        v_exist producto.exist%type;
        BEGIN
            SELECT exist INTO v_exist 
            FROM producto 
            WHERE fabcod||prodcod = p_fabcod||p_prodcod;

            IF p_cant > v_exist THEN
                RETURN FALSE;
            ELSE 
                RETURN TRUE;
            END IF;
        END; 
    $$ LANGUAGE PLPGSQL;
        
      
CREATE OR REPLACE FUNCTION altaComanda(p_cliecod int, p_fabcod char, p_prodcod char, p_cant int)
RETURNS varchar 
AS $$
    DECLARE
        v_data pedido.fecha%type;
            v_importe pedido.importe%type;
    BEGIN
        SELECT CURRENT_DATE INTO v_data;


        IF NOT existeixClient(p_cliecod::SMALLINT) THEN
            RETURN format('Client %s no existeix, no es pot fer la comanda', p_cliecod);
        END IF;

        IF NOT stock0k(p_cant, p_fabcod, p_prodcod) THEN
            RETURN format('No hi han existències suficients del producte %s', p_fabcod||p_prodcod);
        END IF;

        SELECT precio * p_cant INTO v_importe
        FROM producto
        WHERE fabcod||prodcod = p_fabcod||p_prodcod;
        /**
        IF NOT FOUND OR v_importe IS NULL THEN
            RETURN format('No sha pogut calcular limport producte %s no trobat o preu nul', p_fabcod||p_prodcod);
        END IF;
        */
        
        INSERT INTO pedido
        VALUES (v_pednum, v_data, p_cliecod, NULL, p_fabcod, p_prodcod, p_cant, v_importe);
        RETURN format('Una quantitat de %s del producte %s amb un import de %s € sha afegit a pedidos pel client %s',
            p_cant,
            p_prodcod || p_fabcod,
            v_importe,
            p_cliecod
        );
        
    END;
$$ LANGUAGE plpgsql;