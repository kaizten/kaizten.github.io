# PostgreSQL mediante Docker

- [PostgreSQL mediante Docker](#postgresql-mediante-docker)
  - [Conectar al contenedor](#conectar-al-contenedor)
  - [Conectar a `psql`](#conectar-a-psql)

Crea un archivo `docker-compose.yml` como el siguiente:

```yaml
services:

  db:
    image: postgres:latest
    container_name: postgres
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydb
    ports:
      - 5432:5432
    volumes:
      - pg_data:/var/lib/postgresql/data

volumes:
  pg_data:
```

Para iniciar el contenedor con Docker Compose, ejecuta:

```shell
$ docker-compose up
```

Este comando creará un contenedor de la última versión de PostgreSQL, tal como se muestra a continuación:
```
[+] Running 1/0
 ✔ Container postgres  Created                                                                                                                                                                         0.0s 
Attaching to postgres
postgres  | 
postgres  | PostgreSQL Database directory appears to contain a database; Skipping initialization
postgres  | 
postgres  | 2024-11-29 14:03:09.897 UTC [1] LOG:  starting PostgreSQL 17.2 (Debian 17.2-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
postgres  | 2024-11-29 14:03:09.897 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
postgres  | 2024-11-29 14:03:09.897 UTC [1] LOG:  listening on IPv6 address "::", port 5432
postgres  | 2024-11-29 14:03:09.900 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres  | 2024-11-29 14:03:09.907 UTC [29] LOG:  database system was shut down at 2024-11-29 14:03:08 UTC
postgres  | 2024-11-29 14:03:09.913 UTC [1] LOG:  database system is ready to accept connections
```

## Conectar al contenedor

```shell
$ docker exec -it postgres bash
root@420ccea8c5ee:/# 
```

## Conectar a `psql`

```
root@420ccea8c5ee:/# psql -U myuser -d mydb
psql (17.2 (Debian 17.2-1.pgdg120+1))
Type "help" for help.

mydb=# 
```