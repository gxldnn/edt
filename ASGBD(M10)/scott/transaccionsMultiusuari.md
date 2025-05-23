# Funcions de transaccions (MONOUSUARI) | Jan Ribera

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

Veiem com s'esborra la informacio sencera de la taula punts, despres com inserim un registre amb `ID = 40, valor = 5`, seguidament comença la transacció, cambiem el valor del registre anterior a `4`, es fa un SAVEPOINT amb identificador A, s'insereix un altre registre amb `ID = 41, valor = 7`, es fa un ROLLBACK al SAVEPOINT A, per tant el select nomes trobara un registre i el count retornarà 1
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

Primerament s'insereix un registre amb `ID = 50, valor = 5`, es comença la transacció, el select te un error de sintaxis, per tant la transacció fallarà independentment delq ue es fagi, per tant el select retornarà 5
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

S'esborra el contingut de punts e inserimb un registre amb `ID = 60, valor = 5`, comença la transacció, actualitzem el valor del registre anterior a `4` i es fa un SAVEPOINT amb identificador A, s'insereix un altre registre amb `ID = 61, valor = 8` i es fa un altre SAVEPOINT amb identificador B, s'insereix un altre registre amb `ID = 61, valor = 9`, que fallarà ja que el ID es clau primaria, per tant es duplica, es fa un ROLLBACK al identificador B, per tant solucionem el problema i es fa un COMMIT exitós, per tant nomes s'an inserit dos registres (`ID = 60, valor = 4`, `ID = 61, valor = 8`), donçs el select tornarà 4+8 = 12.
```

# Transacciones (Multiusuari)

7. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor) VALUES (70,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

SELECT COUNT(*) FROM punts; -- Connexió 2

////////

Primeraments s'esborra tot el contingut de punts i s'insereix un registre amb `ID = 70, valor = 5`, seguidament desde un altre client començem una transaccio en la qual esborrem el registre que hem inserit abans i sense acabar la transaccio, anem a un tercer client i fem un select del numero de registres de la taula punts, que retorna 1, ja que no s'ha acabat la transaccio que esborra el registre
```
Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:



8. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor) VALUES (80,5); -- Connexió 0
INSERT INTO punts (id, valor) VALUES (81,9); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts SET valor = 4 WHERE id = 80; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts SET valor = 8 WHERE id = 81; -- Connexió 2

UPDATE punts SET valor = 10 WHERE id = 81; -- Connexió 1

UPDATE punts SET valor = 6 WHERE id = 80; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts WHERE id = 80; -- Connexió 0

////////

Primerament inserim dos registres desde el client 0 en el cual s'especifican amb valors:(`ID = 80, valor = 5`, `ID = 81, valor = 9`), despres desde un altre client 1 es comença una transacció i es modifica el registre amb id 80, i desde el client 2 també pero es modifica el que te id 81, despres el client 1 modificarà el que te id 81, aixo generarà un colaps, i el client 2 modifica el 80, per tant es fara un deadlock que l'ha provocat el client 2, per tant la transaccio el client 2 no es realitzara a la hora de fer el commit, pero el del client 1 si, en el select podrem veure el valor 4, ja que el update a valor 6 estaba dins de la transaccio fallida.
```

Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:
1|Blocat|Modifica un valor que esta sent modificat per usuari 2
2|Blocat|Modifica un valor que esta sent modificat per ususari 1
1/2|DeadLock| El usuari 2 provoca un deadlock
1|Desblocat| El usuari 1 es debloqueja perque la transaccio d'usuari 2 ara es invalida

9. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor) VALUES (90,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

BEGIN; -- Connexió 2
INSERT INTO punts (id, valor) VALUES (91,9); -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts WHERE id = 91; -- Connexió 0

////////

Primerament s'insereix un registre amb `ID = 90, valor = 5` desde un primer client, un segon client comença una transaccio i esborra el registre, un trecer comença una transacció e insereix un registre amb `ID = 91, valor = 9` i la tanca, despres el segon client tanca la transacció, el segon client quan ha esborrat els registres no tenien present el insert del tercer client perque encara no existia, per tant el registre no s'esborra i el select retorna '9'
```
Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:
2|Blocat|Modifica un valor que esta en us per ususari 1
2|Desblocat|Usuari 1 deixa el us de la taula i el usuari 2 es desbloca

10. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor) VALUES (100,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts SET valor = 6 WHERE id = 100; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts SET valor = 7 WHERE id = 100; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts WHERE id = 100; -- Connexió 0

////////

Primerament s'insereix un registre amb `ID = 100, valor = 5`, despres un segon client inicia una transacció i modifica el registre posant el valor 6, despres un tercer client obre una transaccio i modifica el valor del registre per 7, aixo farà que es bloqui la seva operació, Fa un commit que no es realitzara fins que el segon client acabi la seva transacció, el valor del SELECT sera 7 ja que la ultima transacció tancada sera del tercer client
```

Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:
2|Blocat|Modifica un valor que esta sent modificat per usuari 1
2|Desblocat|Usuari 1 deixa el us de la taula i el usuari 2 es desbloca


11. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor) VALUES (110,5); -- Connexió 0
INSERT INTO punts (id, valor) VALUES (111,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts SET valor = 6 WHERE id = 110; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts SET valor = 7 WHERE id = 110; -- Connexió 2
UPDATE punts SET valor = 7 WHERE id = 111; -- Connexió 2
SAVEPOINT a; -- Connexió 2
UPDATE punts SET valor = 8 WHERE id = 110; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts WHERE id = 111; -- Connexió 0

////////

Primerament s'insereixen dos registres amb `ID = 110, valor = 5` i `ID = 111, valor = 5`, despres uns segon client comença una transaccio en al que modifica el valotr a 6 on l'id es 110, despres un trecer client inicia una altre transacció en la que modifica el valor a 7 on l'id es 110, aixo provoca un bloqueij al tercer client ja que esta accedint a una modificacio del segon client, despres modicia el valor a 7 on l'id es 111, operacio que no es realitzara ja que esta blocat, el mateix client fa un savepoint amb id "a", i fa un cambi de valor a 8 on l'id es 110 seguiament fa un rollback al id "a", per tant aquesta operacio no es realitzarà, ara aquest tanca la transaccio, pero aquesta no es tancara fins que el segon client tanqui la seva, un cop tancada es realitza la transaccio del tercer client, el select retorna 7 
```
Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:
2|Blocat|Modifica un valor que esta sent modificat per usuari 1
2|Desblocat|Usuari 1 deixa el us de la taula i el usuari 2 es desbloca


12. Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor) VALUES (120,5); -- Connexió 0
INSERT INTO punts (id, valor) VALUES (121,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts SET valor = 6 WHERE id = 121; -- Connexió 1
SAVEPOINT a;
UPDATE punts SET valor = 9 WHERE id = 120; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts SET valor = 7 WHERE id = 120; -- Connexió 2

ROLLBACK TO a; -- Connexió 1

SAVEPOINT a; -- Connexió 2
UPDATE punts SET valor = 8 WHERE id = 120; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts WHERE id = 121; -- Connexió 0

////////

Primerament s'insereixen dos registres amb `ID = 120, valor = 5` i `ID = 121, valor = 5`, desde un segon client s'inicia una transacció en la que modifica el valor a 6 on l'id es 121, crea un savepoint amb id "a" i modifica el valor a 9 on l'id es 120 sense tancar la transaccio, desde un trercer client es comença una transacció on es modifica el valor a 7 on l'id es 120, aixo provoca que aquest tercer es quedi blocat, pero el segon client fa un ROLLBACK a "a" i desfa el seu update al id 120, per tant encara que la transacció no hagi finalitzat el tercer client es desblocara, despres el tercer client fa un SAVEPOINT amb  id "a" i fa un altre update d valor  a8 on l'id 120 pero retorna amb ROLLBACK al savepoint amb id "a", els dos clients fan COMMIT, per tant el valor que retorna el SELECT es de 6
```

Usuari | Blocat/Desblocat | Motiu
:-:|:-:|:-:
2|Blocat|Modifica un valor que esta sent modificat per usuari 1
2|Desblocat|Usuari 1 fa rollback i allibera a usuari 2
