# BASE DE DADES 1

**SGBD = Motor BD**

**PostgreSQL = Open Source**

**magatzem de dades en un suport secundari de forma estructurada i relacionada**

**Taula**= Magatzem de dades que es recull d’una persona, ens o esdeviniment, conjunt d’items que ens intersa magatzemar per desriure una persona un ens o esdeveniment

**TAULA ALUMNE**

| **Nombre del Alumno** | **DNI** | **Grupo** | **Edad** |
| --- | --- | --- | --- |
| María García López | 48765432A | 1hisx | 19 |
| Juan Rodríguez Martínez | 39876543B | 1hiaw | 17 |
| Ana Fernández Sánchez | 50987654C | 1hisx | 18 |
| Carlos Pérez Gómez | 41098765D | 1hisx | 21 |
| Laura Martín Ruiz | 52109876E | 1hiaw | 19 |

```sql
WHERE lower (Grupo) = ‘1hisx’
```

**TAULA MODUL**

| **Módulo** | **Ciclo Formativo** | **Horas** | **Curso** |
| --- | --- | --- | --- |
| Sistemas Operativos en Red | ASIX | 180 | 2º |
| Desarrollo de Interfaces | DAM | 120 | 2º |
| Despliegue de Aplicaciones Web | DAW | 100 | 2º |
| Administración de Sistemas Gestores de Bases de Datos | ASIX | 60 | 2º |
| Programación Multimedia y Dispositivos Móviles | DAM | 100 | 2º |

**TAULA RELACIONAL**

| **DNI Alumno** | **Nombre Alumno** | **Módulo** | **Ciclo Formativo** |
| --- | --- | --- | --- |
| 48765432A | María García López | Sistemas Operativos en Red | ASIX |
| 39876543B | Juan Rodríguez Martínez | Desarrollo de Interfaces | DAM |
| 50987654C | Ana Fernández Sánchez | Despliegue de Aplicaciones Web | DAW |
| 41098765D | Carlos Pérez Gómez | Administración de Sistemas Gestores de Bases de Datos | ASIX |
| 52109876E | Laura Martín Ruiz | Programación Multimedia y Dispositivos Móviles | DAM |

```sql
WHERE lower(Grupo) = '1hisx'
AND
curs_academic = '2024/25'
```

DADES = 3000 alumnes → **Ha pasat per un filtre** → Informació = 20 alumnes

Càlcul de el compte correu del profesor: 

```sql
SELECT nom,cognom1,cognom2,
	SUBSTR(nom,1,1) || SUBSTR(cognom1,1,7) usuari
FROM professor;
```

Pregunta: depen de la quantitat de informacio el consum de recursos serà diferent vol dir que usar un metode diferent de recaudacio de dades.

Per creauar Informacio (**JOIN**).
