# FUNCIONS

## Sintaxis e informacio de funcions

Hem de tindre en compte que el REPLACE es opcional  
```sql
"CREATE [OR REPLACE] FUNCTION name (parameters)"
```

La funcio retorna un resultat sobre el nom de RETURN, en aquest especificarem quin tipus de dades volem (char/varchar, int/smallint/bigint, numeric, date, timestamp, boolean)


## Exemple de una funcio sense variables locals ni parametres

```sql
CREATE OR REPLACE FUNCTION helloworld()
RETURNS varchar
AS $$
    DECLARE
    BEGIN
        RETURN 'Hello World!';
    END;
$$ LANGUAGE PLPGSQL;
```
Per a cridar a la funcio hem de fer un SELECT com si fos una variable del sistema
```sql
SELECT helloworld();
```

## Exercicis de prova

Crea una funcio que selecciona el nom de un empleat segons el codi que li donem com parametre

```sql
CREATE OR REPLACE FUNCTION mostraempleat(p_empno SMALLINT)
RETURNS varchar
AS $$
    DECLARE 
    
    BEGIN
        SELECT ename FROM emp WHERE empno = p_empno
    END;
$$ LANGUAGE PGPLSQL;
```

