
/*    ---- -       OPCIONAL
\c template1
DROP DATABASE IF EXISTS hotel;
CREATE DATABASE hotel;
\c hotel
\i hotel.sql
DROP FUNCTION IF EXISTS afegirServei(p_codiservei INT, p_quantitat INT, p_hab INT);
*/



CREATE OR REPLACE FUNCTION afegirServei(p_codiservei INT, p_quantitat INT, p_hab INT )
RETURNS varchar
AS $$
    DECLARE
        v_preu INT;
        v_nom varchar;
        v_desc varchar;

    BEGIN
    

    INSERT INTO serveihabitacio (NumHab, IdServei, Data, Quantitat)
    VALUES (p_hab, p_codiservei, CURRENT_DATE, p_quantitat);
    
    SELECT nom INTO STRICT v_nom FROM client c
    JOIN reserva r ON c.codclient = r.codclient
    WHERE r.NumHab = p_hab AND Facturada = 'N'; 
    
    SELECT preu * p_quantitat, Descripcio INTO STRICT v_preu, v_desc
    FROM servei
    WHERE p_codiservei = IdServei; 
    
    RETURN 'El client'||v_nom||'amb habitacio'||p_hab||' ha afegit el servei '||v_desc||' amb un preu unitari '||v_preu/p_quantitat||' de  de '||v_preu||'€';


    END;
$$ LANGUAGE PLPGSQL;

/*
CREATE OR REPLACE FUNCTION checkIn(p_dni varchar)
RETURNS varchar
AS $$
    DECLARE
        v_hab INT;
        v_nom varchar;
        v_codclient SMALLINT;
        v_reserva SMALLINT;
    BEGIN
        SELECT nom, codclient INTO STRICT v_nom, v_codclient
        FROM client c
        WHERE dni = p_dni;

        SELECT NumHab, numreserva INTO STRICT v_hab, v_reserva
        FROM reserva
        WHERE codclient = v_codclient AND Facturada = 'N';

        UPDATE reserva SET Ocupada = 'S'
        WHERE codclient = v_codclient AND Facturada = 'N';

        -- EM FALTA EL CALCUL DEL PREU DE LA FACTURA

        INSERT INTO Factura (NEXTVAL('seq_numfra'), v_reserva, CURRENT_DATE, v_import);

        RETURN 'El client '||v_nom||' ha fet check-in a la habitacio '||v_hab||'';
        
    END;

$$ LANGUAGE PLPGSQL;

SELECT checkIn('12345678Z');
*/