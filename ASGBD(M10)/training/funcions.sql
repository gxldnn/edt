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
        v_pednum pedido.pednum%type;
        v_importe pedido.importe%type;
    BEGIN
        SELECT CURRENT_DATE INTO v_data;

        -- Assignar el següent valor de la seqüència
        SELECT setval('pednum_seq', (SELECT max(pednum) FROM pedido) + 1, true) INTO v_pednum;

        -- Comprovar si el client existeix
        IF NOT existeixClient(p_cliecod::SMALLINT) THEN
            RETURN format('Client %s no existeix, no es pot fer la comanda', p_cliecod::text);
        END IF;

        -- Comprovar si hi ha estoc disponible
        IF NOT stock0k(p_cant, p_fabcod, p_prodcod) THEN
            RETURN format('No hi han existències suficients del producte %s', (p_fabcod || p_prodcod)::text);
        END IF;

        -- Calcular l'import de la comanda
        SELECT precio * p_cant INTO v_importe
        FROM producto
        WHERE fabcod || prodcod = p_fabcod || p_prodcod;
        
        -- Comprovar si el producte existeix i si l'import és vàlid
        IF NOT FOUND OR v_importe IS NULL THEN
            RETURN format('No s’ha pogut calcular l’import: producte %s no trobat o preu nul', (p_fabcod || p_prodcod)::text);
        END IF;
        
        -- Inserir la comanda a la taula "pedido"
        INSERT INTO pedido
        VALUES (v_pednum, v_data, p_cliecod, NULL, p_fabcod, p_prodcod, p_cant, v_importe);

        -- Retornar el missatge de confirmació
        RETURN format('Una quantitat de %s del producte %s amb un import de %s € s’ha afegit a pedidos pel client %s',
            p_cant::text,
            (p_prodcod || p_fabcod)::text,
            v_importe::text,
            p_cliecod::text
        );
    END;
$$ LANGUAGE plpgsql;
