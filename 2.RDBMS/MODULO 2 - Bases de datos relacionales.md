# Modulo 2: Bases de datos relacionales y SQL

* Qué es una base de datos relacional
    * Modelo visual de una base de datos
* Ejemplos de bases datos relacionales:
    * PostgreSQL
    * MySQL
    * Oracle
    * SQL Server
    * SQLite
    * DuckDB
    * ...
* Clientes para consultar bases de datos
    * Consola web/terminal
    * DBeaver
* Inicialización de una base de pruebas:
    * Crear base de datos
    * Crear tablas
    * Insertar datos
* Introducción al lenguaje de consultas estructuradas: SQL
    * SELECT * FROM tabla;
    * SELECT * FROM tabla WHERE condiciones;
    * JOIN
    * GROUP BY y funciones de agregación: COUNT, SUM, AVG, MIN, MAX, ...
    * ORDER BY
    * DISTINCT, LIMIT
    * CTE (Common Table Expressions)

## Caso de Uso: PostgreSQL con Docker

Para saber si Docker está disponible, qué contenedores existen y el estado actual:
```sh
docker ps -a
```

La primera vez, creamos un contenedor nuevo usando:
```sh
docker run --name postgres16_pruebas -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres:16
```
El nuevo contenedor se llamará `postgres16_pruebas`, la constraseña del usuario postgres será `password`, usará el puerto `5432` (predeterminado para postgres) y estará basado en la imagen oficial de PostgreSQL versión 16. La opcion `-d` indica que se debe quedar corriendo en background.

Comprobar que se ha creado el nuevo contenedor y el status es "Up"

Algunos comandos utiles para gestionar esta base de datos:
```sh
docker stop postgres16_pruebas
docker start postgres16_pruebas
docker rm postgres16_pruebas
```
En lugar de postgres16_pruebas que es el nombre que dimos al contenedor, se puede usar también el `CONTAINER ID` que le haya asignado docker

El contenedor de docker funciona como una máquina virtual, a la cual nos podemos conectar usando la linea de comandos:
```sh
# para conectarse al contenedor de postgres
docker exec -it postgres16_pruebas bash

# una vez dentro, cambiamos al usuario postgres
su postgres

# convertidos al usuario postgres, abrimos el cliente del terminal psql
psql

# dentro del cliente podemos listas las bases de datos existente con:
\l

# ó también para más información
\l+
```

Inicialmente, por defecto, existe una base de datos postgres y otras dos que sirven como plantillas para crear nuevas bases de datos.

El cliente `psql` permite administrar una base de datos postgres como cualquier otro cliente visual, mismas tareas a nivel de linea de comandos.

Probemos algunas tareas que podemos realizar:
```sql
# crear una base de datos
CREATE DATABASE northwind;

# listar bases de datos existentes
\l

# Conectarse a una base de datos
\c northwind

\dt

# eliminar base de datos
DROP DATABASE northwind;
```

Usando `psql` se puede ejecutar codigo SQL como con cualquier otro cliente, pero usaremos DBeaver para hacerlo más amigable.

