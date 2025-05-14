CREATE OR REPLACE FUNCTION codiExemplarDisponible(p_titol varchar, p_format varchar)
RETURNS varchar
AS $$
    DECLARE
        v_isbn varchar;
        v_iddocument int;
        v_estat varchar;
    BEGIN
        SELECT llibre.ISBN, llibre.idDocument INTO STRICT v_isbn, v_iddocument
        FROM llibre
        WHERE LOWER(p_titol) = LOWER(titol);    
        
        SELECT DISTINCT estat INTO STRICT v_estat FROM exemplar
        WHERE idDocument = v_iddocument
        GROUP BY estat;


        RETURN v_isbn, v_iddocument, v_estat;
        /*
        IF v_estat = 'Disponible' THEN
            RETURN v_isbn;
            ELSE
                RETURN 0;
        END IF;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 0;
                */
    END;
$$ LANGUAGE PLPGSQL