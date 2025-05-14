CREATE OR REPLACE FUNCTION codiExemplarDisponible(p_titol varchar, p_format varchar)
RETURNS varchar
AS $$
    DECLARE
        v_isbn varchar;
        v_iddocument int;
    BEGIN
        SELECT ISBN INTO STRICT v_isbn FROM llibre
        WHERE LOWER(p_titol) = LOWER(titol);

        SELECT
        IF 

        RETURN v_isbn;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 0;
    END;
$$ LANGUAGE PLPGSQL