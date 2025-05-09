\c template1
DROP DATABASE training;
\i training/training.sql

DROP FUNCTION existeixClient(p_cliecod SMALLINT);
DROP FUNCTION altaClient(p_nombre CHAR,p_repcod INT,p_limcred INT);
DROP FUNCTION stock0k(p_cant INT, p_fabcod varchar, p_prodcod varchar);
DROP FUNCTION altaComanda(p_cliecod int, p_fabcod varchar, p_prodcod varchar, p_cant int);

CREATE sequence cliecod_seq;
CREATE sequence pednum_seq;
select setval('cliecod_seq', (SELECT max(cliecod) FROM cliente)+1, true);
SELECT setval('pednum_seq', (SELECT max(pednum) FROM pedido), true);

CREATE OR REPLACE FUNCTION existeixClient(p_cliecod INT)
    RETURNS boolean
    AS $$
        DECLARE
            v_cliecod int;
        BEGIN
            SELECT cliecod INTO STRICT v_cliecod FROM cliente WHERE cliecod = p_cliecod;
            RETURN TRUE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN FALSE;
        END;
    $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION altaClient(p_nombre CHAR,p_repcod INT,p_limcred INT)
    RETURNS varchar
    AS $$
        DECLARE
            v_repcod repventa.repcod%type;
        BEGIN
            SELECT repcod INTO STRICT v_repcod
            FROM repventa
            WHERE repcod = p_repcod;

            INSERT INTO cliente
            VALUES (NEXTVAL('cliecod_seq'), p_nombre, p_repcod, p_limcred);
            
            RETURN 'El client '||p_nombre||' s’ha donat d’alta correctament';
        
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 'El representant'|| p_repcod ||'no existeix.';
        END;
    $$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION stockOk(p_cant INT, p_fabcod varchar, p_prodcod varchar)
    RETURNS boolean
    AS $$
        DECLARE
        v_exist producto.exist%type;
        BEGIN
            SELECT exist INTO STRICT v_exist 
            FROM producto 
            WHERE fabcod||prodcod = p_fabcod||p_prodcod AND p_cant <= (SELECT exist FROM producto WHERE fabcod||prodcod = p_fabcod||p_prodcod);
/*
            IF p_cant > v_exist THEN
                RETURN FALSE;
            ELSE
                RETURN TRUE;
            END IF;*/
            /*
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN FALSE;
                    */
        END; 
    $$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION altaComanda(p_cliecod int, p_fabcod char, p_prodcod char, p_cant int)
RETURNS varchar 
AS $$
    DECLARE
        v_importe pedido.importe%type;
    BEGIN

        IF NOT existeixClient(p_cliecod::SMALLINT) THEN
            RETURN 'Client '||p_cliecod||' no existeix, no es pot fer la comanda';
        END IF;

        IF NOT stockOk(p_cant, p_fabcod, p_prodcod) THEN
            RETURN 'No hi han existències suficients del producte '||p_fabcod||p_prodcod||'';
        END IF;

        SELECT precio * p_cant INTO v_importe
        FROM producto
        WHERE fabcod||prodcod = p_fabcod||p_prodcod;
        
        INSERT INTO pedido
        VALUES (NEXTVAL('pednum_seq'), CURRENT_DATE, p_cliecod, NULL, p_fabcod, p_prodcod, p_cant, v_importe);
        RETURN 'Una quantitat de '||p_cant||' del producte '||p_fabcod||'-'||p_prodcod||' amb un import de '||v_importe||' € sha afegit a pedidos pel client '||p_cliecod||'';
        
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION preuSenseIVA(p_precio int)
RETURNS numeric(9,2)
AS $$
    DECLARE
        v_iva numeric(9,2);
    BEGIN
        SELECT p_precio * 0.21 INTO STRICT v_iva;
        RETURN v_iva;
    END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION preuAmbIVA(p_precio int)
RETURNS numeric(9,2)
AS $$
    DECLARE
        v_iva numeric(9,2);
    BEGIN
        SELECT p_precio * 1.21 INTO STRICT v_iva;
        RETURN v_iva;
    END;
$$ LANGUAGE PLPGSQL;





SELECT existeixClient(2111);
SELECT altaClient('Jose', 107, 4000);
SELECT stockOk(40, 'rei'::varchar, '2a45c'::varchar);
SELECT altaComanda(2111, 'rei'::varchar, '2a45c'::varchar, 20);
SELECT preuSenseIVA(56);
SELECT preuAmbIVA(56);

