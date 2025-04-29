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
Si ho posem de forma incorrecta ens surtira un error aixi, que nombra el error de casting\
CASTING (::TEXT/SMALLINT/(datatypes))

```sql
SELECT mostraempleat(7499); -- FOMRA INCORRECTA
```
```diff 
HINT: No function matches the given name and argument types. You might need to add explicit type casts.
```

## Exercici SQL Funcions
Exercici que demana:
Segons el numero de empleat rebut com a parametre, donam: el nom de l'empleat, el seu salari y el seu salari augmentat; si es `SALESMAN (10%)`,  `CLERK (20%)`, `ALTRES (30%)`

```sql

CREATE OR REPLACE FUNCTION mostrar(p_empno SMALLINT)
    RETURNS varchar
    AS $$
        DECLARE
            v_emp RECORD;
            v_sal emp.sal%type;
        BEGIN
            SELECT * INTO STRICT v_emp FROM emp WHERE empno = p_empno;  
            
            IF LOWER(v_emp.job) = 'salesman' THEN
                v_sal := v_emp.sal*1.1;
            ELSE
                IF LOWER(v_emp.job) = 'clerk' THEN
                    v_sal := v_emp.sal*1.2;
                ELSE v_sal := v_emp.sal*1.3;
                END IF;
            END IF;
            

            RETURN v_emp.ename ||' '||v_emp.job||' '||v_emp.sal||' '||v_sal;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'No s''ha trobat cap empleat amb aquest número.';
        END;
    $$ LANGUAGE PLPGSQL;