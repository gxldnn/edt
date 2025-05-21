# Funcions de transaccions (MONOUSUARI)

Creeu una base de dades anomenada __transaccions__, amb una única taula anomenada __punts__, amb la següent estructura: id de tipus INT (CP) i valor de tipus SMALLINT.

1. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.  

```
INSERT INTO punts (id, valor) VALUES (10,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 10;
ROLLBACK;
SELECT valor FROM punts WHERE id = 10;

////////

Ens surtira el valor 10 ja que a la hora de fer el rollback estem "desfent" el UPDATE que el cambia a 4.
```

2. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.  
```
INSERT INTO punts (id, valor) VALUES (20,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 20;
COMMIT;
SELECT valor FROM punts WHERE id = 20;

////////

Primerament inserim un registre amb `ID = 20, valor = 5`, començem la transacció, es canvia el camp valor per `4` on el ID = 20, es fa un COMMIT, es a dir, es guarden els canvis, despres es fa un select, que donarà 4
```


3. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
INSERT INTO punts (id, valor) VALUES (30,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 30;
SAVEPOINT a;
INSERT INTO punts (id, valor) VALUES (31,7);
ROLLBACK;
SELECT valor FROM punts WHERE id = 30;

////////

Primerament inserim un registre amb `ID = 30, valor = 5`, començem la transacció, es canvia el camp valor per `4` on el ID = 30, es fa un SAVEPOINT amb identificador A,
s'insereix un altre registre amb `ID = 31, valor = 7`, despres es fa un ROLLBACK per tant no es guarda ningun cambi fet nomes el INSERT d'abans de la transacció, per tant el SELECT retornarà 5
```

4. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.
```
DELETE FROM punts;
INSERT INTO punts (id, valor) VALUES (40,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 40;
SAVEPOINT a;
INSERT INTO punts (id, valor) VALUES (41,7);
ROLLBACK TO a;
SELECT COUNT(*) FROM punts;

////////

Veiem com s'esborra la informacio sencera de la taula punts, despres com inserim un registre amb `ID = 40, valor = 5`, seguidament comença la transacció, cambiem el valor del registre anterior a `4`, es fa un SAVEPOINT amb identificador A, s'insereix un altre registre amb `ID = 41, valor = 7`, es fa un ROLLBACK al SAVEPOINT A, per tant el select nomes tro
```
5. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.
```
INSERT INTO punts (id, valor) VALUES (50,5);
BEGIN;
SELECT id, valor WHERE punts;
UPDATE punts SET valor = 4 WHERE id = 50;
COMMIT;
SELECT valor FROM punts WHERE id = 50;

////////

```
6. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.
```
DELETE FROM punts;
INSERT INTO punts (id, valor) VALUES (60,5);
BEGIN;
UPDATE punts SET valor = 4 WHERE id = 60;
SAVEPOINT a;
INSERT INTO punts (id, valor) VALUES (61,8);
SAVEPOINT b;
INSERT INTO punts (id, valor) VALUES (61,9);
ROLLBACK TO b;
COMMIT;
SELECT SUM(valor) FROM punts;

////////

```