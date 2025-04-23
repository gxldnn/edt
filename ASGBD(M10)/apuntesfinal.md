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
        v_ename varchar(100);
    BEGIN
        SELECT ename INTO v_ename FROM emp WHERE empno = p_empno;
        RETURN v_ename;
    END;
$$ LANGUAGE PLPGSQL;
```
En aquest cas hem de tindre compte ja que `p_empno` ha de ser un SMALLINT pero a la hora de cridar a la funcio i posar un numero, exemple: `SELECT mostraempleat(7499)`, donç hem de cambiar el valor de el "input" amb un cast de la següent forma, `SELECT mostraempleat(7499::SMALLINT)`
```sql
SELECT mostraempleat(7499::SMALLINT); -- FORMA CORRECTE
```
```diff
  mostraempleat 
 ---------------
  ALLEN
 (1 row)
```
Si ho posem de forma incorrecta ens surtira un error aixi, que nombra el error de casting

```sql
SELECT mostraempleat(7499); -- FOMRA INCORRECTA
```
```diff 
HINT: No function matches the given name and argument types. You might need to add explicit type casts.
```

