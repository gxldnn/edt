
# 1. Zoos

Es vol dissenyar una base de dades relacional per emmagatzemar informació relativa als zoos existents en el món, així com les espècies i animals que aquests alberguen.

De cada zoo es vol emmagatzemar el seu codi, nom, la ciutat i país on es troba, mida (m2) i pressupost anual.
Cada zoo codifica els seus animals amb un codi propi, de manera que entre zoos es pot donar el cas que es repeteixi.
De cada espècie animal s'emmagatzema un codi d'espècie, el nom vulgar, el nom científic, família a la qual pertany i si es troba en perill d'extinció.
A més, s'ha de guardar informació sobre cada animal que els zoos tenen, com el seu número d'identificació, espècie, sexe, any de naixement, país d'origen i continent.

# 2. Model conceptual
## 2.1. Enllaç públic a l'esquema
[Esquema drawio -- ZOOS](https://drive.google.com/file/d/1Ab4533XcrnR1XXVZW0GN_wVuAtzxP7rB/view?usp=sharing)
## 2.2. Esquema conceptual (EC ó ER)
  ![Esquema drawio -- ZOOS](./2_zoo.png)
# 3. Model lògic relacional
## 3.1. Esquema lògic
  Zoo(<ins>IdZoo</ins>, Nom, Ciutat, Pais, Mida, Pressupost)\
  Animal(<ins>IdAnimal,IdZoo</ins>, Sexe, DataNaixement, PaisOrigen, Continent, *IdEspecie*)\
  Especie(<ins>IdEspecie</ins>, NomVulgar, NomCientific, Familia, Extincio)

## 3.2. Diagrama referencial

* El diagrama referencial em serveix per indicar quines claus alienes hi ha a l'esquema lògic  
* La relació referencial és aquella que conté la clau aliena  
* La relació referida és l'origen de la informació. És la part 1, tal com s'ha explicat a classe.

Relació referencial|Clau aliena|Relació referida
-|:-:|-
Animal|IdZoo|Zoo
Animal|IdEspecie|Especie


# 4. Model físic
## 4.1 Enllaç a l'esquema físic

[NONE](./)
