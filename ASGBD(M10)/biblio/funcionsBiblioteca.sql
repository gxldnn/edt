/*
CREATE OR REPLACE FUNCTION codiExemplarDisponible(p_titol varchar, p_format varchar)
RETURNS varchar
AS $$
    DECLARE
        v_isbn varchar;
        v_iddocument int;
        v_estat record;
    BEGIN
        SELECT llibre.ISBN, llibre.idDocument INTO STRICT v_isbn, v_iddocument
        FROM llibre
        WHERE LOWER(p_titol) = LOWER(titol);    
        
        SELECT DISTINCT estat INTO STRICT v_estat FROM exemplar
        WHERE idDocument = v_iddocument;

        IF v_estat = 'Disponible' THEN
            RETURN v_isbn;
            ELSE
                RETURN 0;
        END IF;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 0;  
    END;
$$ LANGUAGE PLPGSQL
*/

DROP FUNCTION usuarioOK(p_codiusuari INT);
CREATE OR REPLACE FUNCTION usuarioOK(p_codiusuari INT)
RETURNS INT
AS $$
    DECLARE
        v_bloq usuari.bloquejat%type;
    BEGIN
        SELECT bloquejat INTO STRICT v_bloq FROM usuari
        WHERE p_codiusuari = idUsuari;

        IF NOT v_bloq THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 2;
    END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION documentsPrestats(p_usuari INT, p_format varchar)
RETURNS INT
AS $$
    DECLARE
        v_idusuari usuari.idUsuari%type;
        v_iddocument document.format%type;
        v_numdocs INT;
    BEGIN
        SELECT COUNT(idUsuari) INTO STRICT v_numdocs FROM prestec p
        JOIN document d ON 
        WHERE p_usuari = idUsuari;

        SELECT iddocument INTO STRICT v_iddocument FROM exemplar
        WHERE p_usuari = idUsuari;


        RETURN v_numdocs;

    END;

$$ LANGUAGE PLPGSQL;



