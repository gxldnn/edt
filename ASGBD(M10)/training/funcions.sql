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
          
CREATE OR REPLACE FUNCTION crear_comanda(
    p_cliecod varchar,
    p_fabcod varchar,
    p_prodcod varchar,
    p_cant integer
)
RETURNS varchar AS $$
DECLARE
    v_data pedido.fecha%type;
    v_pednum pedido.pednum%type;
    v_importe pedido.importe%type;
BEGIN
    -- Obtener la fecha actual
    SELECT CURRENT_DATE INTO v_data;

    SELECT setval('pednum_seq', (SELECT max(pednum) FROM pedido) + 1, true) INTO v_pednum;

    IF NOT existeixClient(p_cliecod) THEN
        RETURN format('Client %s no existeix, no es pot fer la comanda', p_cliecod);
    END IF;

    IF NOT stock0k(p_cant, p_fabcod, p_prodcod) THEN
        RETURN format('No hi han existències suficients del producte %s', p_fabcod || p_prodcod);
    END IF;

    SELECT precio * p_cant INTO v_importe
    FROM producto
    WHERE fabcod || prodcod = p_fabcod || p_prodcod;

    INSERT INTO pedido (pednum, fecha, cliecod, otrocampo, fabcod, prodcod, cantidad, importe)
    VALUES (v_pednum, v_data, p_cliecod, NULL, p_fabcod, p_prodcod, p_cant, v_importe);

    RETURN format(
        'Una quantitat de %s del producte %s amb un import de %.2f € s’ha afegit a pedidos pel client %s',
        p_cant,
        p_prodcod,
        v_importe,
        p_cliecod
    );
END;
$$ LANGUAGE plpgsql;
