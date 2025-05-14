CREATE OR REPLACE FUNCTION codiExemplarDisponible(p_titol varchar, p_format varchar)
RETURNS varchar
AS $$
    DECLARE
        v_isbn varchar;
        v_iddocument int;
        v_estat varchar;
    BEGIN
        SELECT ISBN, idDocument INTO STRICT v_isbn, v_iddocument
        FROM llibre
        JOIN exemplar
        WHERE LOWER(p_titol) = LOWER(titol);
idDocument = v_iddocument;

        
        RETURN v_isbn;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 0;
    END;
$$ LANGUAGE PLPGSQL