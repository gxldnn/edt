CREATE OR REPLACE FUNCTION codiExemplarDisponible(p_titol varchar, p_format varchar)
RETURNS varchar
AS $$
    DECLARE
        v_isbn varchar;
        v_iddocument int;
        v_estat varchar;
    BEGIN
        SELECT ISBN INTO STRICT v_isbn
        FROM llibre
        WHERE LOWER(p_titol) = LOWER(titol);        
        
        SELECT idDocument INTO STRICT v_iddocument
        FROM llibre
        WHERE LOWER(p_titol) = LOWER(titol);
        
        SELECT estat INTO STRICT v_estat FROM exemplar
        WHERE idDocument = v_iddocument;

        
        IF estat = 'Discponible' THEN
            RETURN v_isbn;
            ELSE
                RETURN 0;
        END IF;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 0;
    END;
$$ LANGUAGE PLPGSQL