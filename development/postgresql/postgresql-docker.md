# PostgreSQL mediante Docker

- [PostgreSQL mediante Docker](#postgresql-mediante-docker)
  - [Prerrequisitos](#prerrequisitos)
  - [Paso 1: Descargar la imagen de PostgreSQL](#paso-1-descargar-la-imagen-de-postgresql)
  - [Paso 2: Ejecutar un contenedor de PostgreSQL](#paso-2-ejecutar-un-contenedor-de-postgresql)
  - [Paso 3: Crear un volumen para la persistencia de datos](#paso-3-crear-un-volumen-para-la-persistencia-de-datos)
  - [Paso 4: Conectar a PostgreSQL](#paso-4-conectar-a-postgresql)
    - [Opción 1. Conectar desde el contenedor](#opción-1-conectar-desde-el-contenedor)
    - [Opción 2.Conectar desde una aplicación externa](#opción-2conectar-desde-una-aplicación-externa)
    - [Verificar la conexión](#verificar-la-conexión)
  - [Paso 5: Detener y eliminar el contenedor](#paso-5-detener-y-eliminar-el-contenedor)
    - [Comprobación final](#comprobación-final)

Docker es una herramienta muy útil para ejecutar bases de datos como PostgreSQL de manera rápida y sencilla. A continuación, te mostraré cómo puedes configurar y ejecutar PostgreSQL usando Docker.

## Prerrequisitos

Antes de comenzar, asegúrate de tener lo siguiente instalado:

- [Docker](https://docs.docker.com/get-docker/): Docker es necesario para crear contenedores y gestionar imágenes. Puedes instalarlo siguiendo la guía oficial.
- [Docker Compose](https://docs.docker.com/compose/install/) (opcional): Si deseas manejar configuraciones más complejas, Docker Compose facilita el despliegue de múltiples servicios.

## Paso 1: Descargar la imagen de PostgreSQL

Para empezar, descarga la imagen oficial de PostgreSQL desde Docker Hub. Esto se puede hacer con el siguiente comando:

```shell
docker pull postgres
```

Este comando descarga la última versión de PostgreSQL. Si quieres una versión específica, puedes agregar el número de versión, por ejemplo:

```shell
docker pull postgres:15
```

## Paso 2: Ejecutar un contenedor de PostgreSQL

Ahora que tienes la imagen, puedes ejecutar PostgreSQL en un contenedor. Utiliza el siguiente comando:

```shell
docker run --name nombre_del_contenedor -e POSTGRES_PASSWORD=tu_contraseña -d -p 5432:5432 postgres
```

Desglose del comando:

- `--name nombre_del_contenedor`: Especifica un nombre para el contenedor.
- `-e POSTGRES_PASSWORD=tu_contraseña`: Establece la contraseña del usuario `postgres`.
- `-d`: Ejecuta el contenedor en segundo plano.
- `-p 5432:5432`: Mapea el puerto local `5432` al puerto `5432` del contenedor, que es donde PostgreSQL escucha por defecto.

## Paso 3: Crear un volumen para la persistencia de datos

Para asegurarte de que los datos de la base de datos se conserven, incluso si el contenedor se detiene o elimina, es recomendable usar un volumen:
```shell
docker volume create postgres_volume
```
Una vez creado el volumen, hay que ejecutar un contenedor:
```shell
docker run --name nombre_del_contenedor -e POSTGRES_PASSWORD=tu_contraseña -v postgres_volume:/var/lib/postgresql/data -d -p 5432:5432 postgres
```
- `-v postgres_volume:/var/lib/postgresql/data`: Usa el volumen llamado `postgres_volume` para almacenar los datos de la base de datos.

## Paso 4: Conectar a PostgreSQL

Una vez que el contenedor esté en ejecución, puedes conectarte a PostgreSQL de varias formas:

### Opción 1. Conectar desde el contenedor
Puedes conectarte directamente al contenedor usando el siguiente comando:

```shell
docker exec -it nombre_del_contenedor psql -U postgres
```

Esto te abrirá una consola de PostgreSQL donde puedes ejecutar comandos SQL.

### Opción 2.Conectar desde una aplicación externa

También puedes conectarte usando una aplicación externa, como pgAdmin o cualquier cliente SQL. Solo necesitas los siguientes datos:

- **Host**: `localhost` o la dirección IP del servidor donde está corriendo Docker.
- **Puerto**: `5432` (u otro si lo configuraste diferente).
- **Usuario**: `postgres`.
- **Contraseña**: La que definiste con el parámetro `POSTGRES_PASSWORD`.

### Verificar la conexión

Independientemente de la opción de conexión empleada, debes comprobar que la conexión se ha realizado correctamente. Para comprobar que PostgreSQL está funcionando correctamente, ejecuta el siguiente comando dentro del contenedor o desde `psql`:
```shell
SELECT version();
```
Esto debería mostrar un resultado similar a:
```shell
                                                 version                                                 
----------------------------------------------------------------------------------------------------------
 PostgreSQL 15.3 (Debian 15.3-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14), 64-bit
(1 row)
```
> Si ves este mensaje, la conexión está activa y PostgreSQL funciona correctamente.

## Paso 5: Detener y eliminar el contenedor

Para detener el contenedor, puedes usar el siguiente comando:

```shell
docker stop nombre_del_contenedor
```

Y para eliminarlo definitivamente:

```shell
docker rm nombre_del_contenedor
```

Si además deseas eliminar el volumen asociado (por ejemplo, `postgres_volume`) y empezar desde cero, ejecuta:
```shell
docker volume rm postgres_volume
```
> **Advertencia:** eliminar el volumen borrará todos los datos almacenados en la base de datos.

### Comprobación final

Puedes comprobar el estado de los contenedores y volúmenes con:
```shell
docker ps -a
docker volume ls
```
Si el contenedor y el volumen ya no aparecen, se han eliminado correctamente.