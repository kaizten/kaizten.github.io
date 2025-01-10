<!-- TOC -->

- [Docker Compose](#docker-compose)
- [Primeros pasos](#primeros-pasos)
- [Dependencia: `kaizten-utils`](#dependencia-kaizten-utils)
- [Dockerfile](#dockerfile)
- [GitHub action](#github-action)
- [Dominio](#dominio)
  - [Entidades](#entidades)
  - [Objetos valor](#objetos-valor)
- [API REST. Documentación](#api-rest-documentación)
- [Arquitectura hexagonal](#arquitectura-hexagonal)
- [Objetos valor](#objetos-valor-1)
- [Gitignore](#gitignore)
- [Dockerizar](#dockerizar)
- [GitHub Action](#github-action-1)
- [Trampas](#trampas)
- [Trampas - tests](#trampas---tests)
- [Tests. `DELETE`](#tests-delete)
- [Tests. `GET`](#tests-get)
- [Tests. `OPTIONS`](#tests-options)
- [Tests. `POST`](#tests-post)
- [Paginación](#paginación)
- [Primeros pasos](#primeros-pasos-1)
- [GitHub action](#github-action-2)
- [Dependencia: `kaizten-typescript`](#dependencia-kaizten-typescript)
- [Dominio](#dominio-1)
  - [Entidades](#entidades-1)
- [Aplicación](#aplicación)
  - [Servicios y repositorios](#servicios-y-repositorios)
- [Pinia como gestor de estados](#pinia-como-gestor-de-estados)
- [Dockerizar](#dockerizar-1)
- [GitHub Action](#github-action-3)
- [Internacionalización](#internacionalización)
- [Paleta de colores](#paleta-de-colores)
- [Trampas](#trampas-1)
- [Instalación](#instalación)
- [Nociones básicas](#nociones-básicas)
- [Docker Compose. Instalación](#docker-compose-instalación)
- [Primeros pasos](#primeros-pasos-2)
- [Primeros pasos](#primeros-pasos-3)
- [Consumir API REST](#consumir-api-rest)
- [Selector de fecha](#selector-de-fecha)
- [Indicadores](#indicadores)
- [Diagrama Sankey](#diagrama-sankey)
- [Tabla de datos](#tabla-de-datos)
- [Cronología](#cronología)
- [Mapa de calor](#mapa-de-calor)
- [Selector de barco](#selector-de-barco)
- [Docker compose. Instalación de plugins](#docker-compose-instalación-de-plugins)
- [Instalación](#instalación-1)
- [Dependencia `cplex.jar`](#dependencia-cplexjar)
- [Instalación](#instalación-2)
- [JCommander. Primeros pasos](#jcommander-primeros-pasos)
- [Tests de API REST](#tests-de-api-rest)
- [Organización](#organización)
- [Servicios y repositorios](#servicios-y-repositorios-1)
- [Adaptador REST](#adaptador-rest)
- [Adaptador VueJs](#adaptador-vuejs)
- [Gestión de usuarios](#gestión-de-usuarios)
- [Descripción del problema de optimización](#descripción-del-problema-de-optimización)
- [README.md](#readmemd)
- [Generador de instancias](#generador-de-instancias)
- [Visualizador de instancias de problema](#visualizador-de-instancias-de-problema)
- [Visualizador de soluciones](#visualizador-de-soluciones)
- [Representación de problema de optimización](#representación-de-problema-de-optimización)
- [Modelo matemático del problema de optimización](#modelo-matemático-del-problema-de-optimización)
- [Algoritmo aleatorio](#algoritmo-aleatorio)

<!-- /TOC -->

# Acceso a back-end

El front-end siempre trata de acceder a `localhost:PUERTO_BACK` independientemente de que el back esté o no en esa máquina. Por ejemplo, cuando levantamos la aplicación con Docker Compose en una máquina y accedemos al front-end desde otra se produce el siguiente error:

![Screenshot from 2021-11-04 13-22-42](https://user-images.githubusercontent.com/28759795/140321197-9a89739e-b476-4ead-8dbc-f3a68c528b34.png)

La `dirección+puerto` del back-end debe estar pasado como variable de entorno en el Docker Compose. A continuación se incluye un fragmento de Docker Compose para front-end para otra herramienta:
```
environment:
      - SPRING_DATA_MONGODB_URI=mongodb://kaizten-mongo:27017/smartsad-db
      - SPRING_PROFILES_ACTIVE=production
      - KAIZTEN_TASK_URI=http://kaizten-task-rest-api:8443
```
En este caso, la última línea es la que indica cómo establecer el la dirección del back-end.

# Imagen corporativa de la aplicación

- Definir un nombre para la aplicación. En el documento "DRIVE/Productos/Posibles nombres" hay una batería de posibles nombres, aunque se puede usar otro.
- Definir una paleta de colores para la aplicación.
- Definir lema para la aplicación.
- Definir tipografía para la aplicación.
- Cambiar el nombre al repositorio y a los elementos correspondientes del código en base al nombre, tipografía y lema elegidos.
- Diseñar un logo básico para la aplicación y ponerlo en la aplicación.

# Creación de back-end

Actualmente la aplicación no tiene back-end para gestionar la información de la misma. Se hace necesario diseñar e implementar un back-end a modo de API REST donde se recojan las principales entidades que aparecen en la aplicación.

# Pantalla de login

El acceso a la aplicación debe realizarse mediante una pantalla de login donde el usuario pueda introducir sus credenciales (nombre de usuario y contraseña). Al mismo tiempo, debe tener las siguientes opciones:
- Creación de nuevo usuario
- Recuperación de contraseña

# Perfil del usuario

El usuario que accede a la aplicación debe poder consultar su perfil. Por ejemplo, mediante un botón en la parte superior derecha. 

El perfil del usuario debe permitir configurar al menos lo siguiente:
- Colores preferentes de la aplicación.
- Imagen de usuario.
- Idioma preferente.

# Uso de API key en Kaizten Task

https://github.com/kaizten/kaizten-task ya obliga a incluir el API key en cada petición.

Por tanto, hay que hacer lo siguiente:
1. Recuperar el API key desde el servicio de autenticación de usuarios. El API key se debe recuperar una única vez al loguearse el usuario.
2. Modificar las peticiones al API para que se incluya el API key del usuario en cuestión.

# Project Full stack

## Docker Compose

Hola, para poder desplegar la aplicación de forma sencilla se puede emplear [Docker Compose](https://docs.docker.com/compose/). Es una herramienta que permite definir el conjunto de contenedores que componen una aplicación y crearlos de una sola vez.

Para que el despliegue funcione correctamente, las imágenes del front-end y del back-end deben estar publicadas en [Docker Compose](https://docs.docker.com/compose/) previamente, de tal manera que sea posible poder acceder a ellas. En este caso, tenemos una cuenta que es [`softwarebuild`](https://hub.docker.com/u/softwarebuild) donde publicar las imágenes del proyecto. Posteriormente, si lo deseas, podrás configurar tu propia cuenta y publicar en ella las imágenes.

En [este enlace](https://gist.github.com/cexposit/5e848e073108c2ce81f47bcedb881dc3) puedes encontrar un ejemplo de archivo `docker-compose.yml` donde se consideran contenedores simultáneamente de MongoDB, de un back-end y de un front-end.

En este caso, necesitarías crear un archivo `docker-compose.yml` en el repositorio que desplegara al menos un contenedor del front-end y otro del back-end. Una vez tengas este archivo creado en el repositorio podrás desplegar la aplicación mediante el comando `docker-compose up`.

# Back-end

## Primeros pasos

Hola, el back-end de la aplicación vamos a realizarla mediante [Spring Boot](https://spring.io/projects/spring-boot). Se trata de un framework para la creación de aplicaciones empresariales en Java y otros lenguajes compatibles con la Java Virtual Machine.

Con el objetivo de crear el back-end de la aplicación, debes realizar los siguientes pasos:

1. Accede a [Spring Initializr](https://start.spring.io/). En el formulario debes establecer lo siguiente:
* `Project`: `Maven`
* `Language`: `Java`
* `Spring Boot`: `3.1.5`
* `Project Metadata`:
  * `Group`: `com.kaizten`
  * `Artifact`: `back-end`
  * `Name`: `back-end`
  * `Package name`: `com.kaizten.project`
  * `Packaging`: `Jar`
  * `Java`: `17`
El resto de los campos puedes configurarlos libremente. Una vez hayas cumplimentado el formulario de [Spring Initializr](https://start.spring.io/), debes pulsar `Generate` y descarga el archivo `back-end.zip` con el proyecto Spring creado.
2. Descomprime `back-end.zip` dentro de la carpeta de tu repositorio. Con esto, debes tener una carpeta `back-end` en tu repositorio.
3. Compila el back-end:
```shell
$ cd back-end
$ mvn clean package
[INFO] Scanning for projects...
[INFO] 
[INFO] --------------------------< ull.es:back-end >---------------------------
[INFO] Building back-end 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
...
[INFO] Building jar: /home/christopher/kaizten/back-end/target/back-end-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.041 s
[INFO] Finished at: 2023-10-26T18:39:46+01:00
[INFO] ------------------------------------------------------------------------
```
Si todo ha ido correctamente, debes encontrar la distribución del back-end en formato JAR. Concretamente `back-end/target/back-end-1.0-SNAPSHOT.jar`.

## Dependencia: `kaizten-utils`

Hola, en la empresa hemos ido trabajando en una librería de utilidades para facilitarnos la realización de proyectos en Java: `kaizten-utils`. Se trata de una pequeña librería donde hay bastantes métodos que usamos regularmente. En tu proyecto pueden ser de utilidad para validar recursos por ejemplo. Acabamos de agregarte como colaborador al repositorio para que puedas acceder a su distribución y puedas añadirla como dependencia a tu proyecto.

Para usar `kaizten-utils` debes hacer lo siguiente:
1. Comprueba que te ha llegado una invitación a [kaizten-utils](https://github.com/kaizten/kaizten-utils) y acéptala.
2. Crea un token personal en tu cuenta de GitHub. Aquí tienes los [pasos](https://docs.github.com/es/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). El tipo de token que debes crear es `Personal access tokens (classic)`. Además, es importante que cuando crees el token marques la opción `read-packages`.
3. Crea el fichero `settings.xml` en el lugar donde tengas instalado Maven. Habitualmente el lugar es `~/.m2`, de tal manera que al final tengas `~/.m2/settings.xml`. El contenido de este fichero debe ser así:
```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>

  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo1.maven.org/maven2</url>
        </repository>
        <repository>
          <id>github</id>
          <url>https://maven.pkg.github.com/kaizten/*</url>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

  <servers>
    <server>
      <id>github</id>
      <username>USERNAME</username>
      <password>TOKEN</password>
    </server>
  </servers>
</settings>
```
Debes sustituir `USERNAME` por tu nombre de usuario de GitHub y `TOKEN` por el valor de tu token personal (creado en el paso previo).

4. Añade al archivo `pom.xml` la dependencia de `kaizten-utils`:
```xml
<dependency>
  <groupId>com.kaizten</groupId>
  <artifactId>kaizten-utils</artifactId>
  <version>1.0-SNAPSHOT</version>
</dependency>
```
5. Haz uso de cualquier elemento de la librería. Por ejemplo, añade las siguientes líneas a tu código:
```java
import com.kaizten.utils.string.KaiztenString;
...
System.out.println(KaiztenString.isBoolean("hola"));
```
6. Compila el proyecto para comprobar que la dependencia está disponible: `mvn clean package`.

## Dockerfile

Hola, la dockerización del back-end de la aplicación es crucial por varias razones fundamentales que influyen directamente en la eficiencia, portabilidad y escalabilidad del sistema. En particular, con Docker, las dependencias del back-end (bibliotecas, frameworks, entornos, etc.) se pueden empaquetar y versionar fácilmente, lo que simplifica la gestión de dependencias y las actualizaciones del software.

La dockerización del back-end requiere de un archivo `Dockerfile`. Se trata un archivo de texto que contiene instrucciones precisas para construir una imagen de Docker, especificando los pasos necesarios para configurar y ejecutar un entorno dentro de un contenedor. 

Para crear el `Dockerfile` tienes que crear el siguiente archivo dentro de la carpeta `back-end`:
```
FROM openjdk:17-jdk-alpine

EXPOSE 8080

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
```
Es importante que lo guardes con el nombre `Dockerfile`.

Una vez creado el `Dockerfile`, puedes crear la imagen Docker de tu back-end. Para ello, ejecuta lo siguiente:
```java
$ cd back-end
$ mvn clean package
$ docker build -t dockerizedbackend .
```
Si todo ha ido correctamente, debes tener la imagen Docker generada en tu máquina:
```
docker images 
REPOSITORY                            TAG       IMAGE ID       CREATED          SIZE
dockerizedbackend                     latest    0ff1df35654b   24 seconds ago   352MB
```
Finalmente, puedes crear un contenedor Docker de esta imagen, tal como sigue:
```
docker run -p 8081:8080 --name mycontainer dockerizedbackend
```
El resultado debe ser que el back-end se ejecute de forma convencional, pero ahora no como un artefacto Java sino como un contenedor. Concretamente, se está creando un contenedor llamado `mycontainer` de la imagen previamente creada `dockerizedbackend`. Además, se está mapeando el puerto `8080` del contenedor en el puerto `8081` de tu máquina.

## GitHub action

Hola, he añadido al back-end un archivo `Dockerfile` destinado a crear la imagen Docker de este componente de software. También he añadido una [GitHub action](https://github.com/features/actions) a la carpeta `.github/workflows` del repositorio destinada a que, cada vez que hagas un cambio en `back-end/`, se genere la imagen Docker correspondiente y se publique en [Docker Hub](https://hub.docker.com). Por último, he modificado el archivo `pom.xml` para añadir [perfiles Maven](https://maven.apache.org/guides/introduction/introduction-to-profiles.html) con el objetivo de que mediante la [GitHub action](https://github.com/features/actions) se pueda acceder a los paquetes Java definidos en la organización [`ull-tfg`](https://github.com/ull-tfg).

Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `back-end/`. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo indicando el error.

En el archivo `.github/workflows/back-end_publish-docker-image.yml` hay definida una variable `DOCKER_IMAGE_NAME` que indica el nombre de la imagen Docker que se genera con el lanzamiento de la [GitHub action](https://github.com/features/actions). Por tanto, una vez se ejecute, comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.

## Dominio

### Entidades

Hola, en [este documento](https://docs.google.com/document/d/1gKlDYboDOnTPDRBkZLiZta-GazZWc7OZQpjMGg3yvgU/edit) se encuentra una primera versión del dominio de tu aplicación. Con seguridad, tendremos que hacerle cambios a medida que evolucione tu proyecto, pero sirve como un punto de referencia. En el documento se encuentran las principales entidades (objetos de negocio de tu aplicación) y, para cada una de ellas, se incluye un listado de propiedades que las caracterizan. Revisa con calma el documento y avisa con cualquier duda que pueda surgirte.

En base a lo anterior, puedes crear junto a la clase principal de tu back-end una carpeta `domain` y dentro de ésta otra carpeta `entity` en la que definir una clase Java por cada una de las entidades de tu dominio. Para cada entidad, pon los atributos indicados, los métodos get y set correspondientes y sobreescribe `toString()` para poder imprimir por la salida estándar objetos de dichas entidades. En este momento, no te preocupes demasiado por los tipos de los atributos de las entidades.

### Objetos valor

Hola, es conveniente que los atributos de las entidades que tienes en el dominio de tu aplicación no sean tipos primitivos sino tipos definitos por ti. Antes de proceder con el código, lee con calma este artículo: https://leanmind.es/es/blog/primitive-obsesion-value-objects/ Es un artículo interesante sobre cómo funcionan los objetos valor y tiene ejemplos en Java.

Te paso un ejemplo de un objeto valor para que lo hagas de forma similar:
```
import java.util.Objects;
import java.util.regex.Pattern;

public class TrapDescription {

    public static final int MAX_LENGTH = 2000;
    public static final String REGULAR_EXPRESSION = "^[a-zA-Z-\\d\\s\\.-_]*$";
    public static final String ERROR_NOT_DEFINED = "Description of the trap is not defined";
    public static final String ERROR_EMPTY = "Description of the trap cannot be empty";
    public static final String ERROR_MAX_LENGTH = "Description of the trap must be at most " + MAX_LENGTH + " characters in length";
    public static final String ERROR_WRONG_FORMAT = "Description of the trap must only contain alphanumeric characters and spaces";
    private String value;

    public TrapDescription(String value) {
        this.validate(value);
        this.value = UllString.simplify(value);
    }

    private void validate(String value) {
        if (value == null) {
            throw new NullPointerException(ERROR_NOT_DEFINED);
        }
        value = UllString.simplify(value);
        final int length = value.length();
        if (length == 0) {
            throw new IllegalArgumentException(ERROR_EMPTY);
        }
        if (length > MAX_LENGTH) {
            throw new IllegalArgumentException(ERROR_MAX_LENGTH);
        }
        if (!Pattern.compile(REGULAR_EXPRESSION).matcher(value).matches()) {
            throw new IllegalArgumentException(ERROR_WRONG_FORMAT);
        }
    }

    @Override
    public boolean equals(Object other) {
        if (other == this) {
            return true;
        }
        if (!(other instanceof TrapDescription)) {
            return false;
        }
        TrapDescription otherTrapDescription = (TrapDescription) other;
        return (this.value.equals(otherTrapDescription.value));
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.value);
    }

    public static TrapDescription random() {
        String value = "";
        while (value.isEmpty()) {
            value = UllString.random(UllRandom.random(1, MAX_LENGTH + 1),
                    REGULAR_EXPRESSION);
            value = UllString.simplify(value);
        }
        return new TrapDescription(value);
    }

    public String getValue() {
        return this.value;
    }

    public String toString() {
        return this.value;
    }
}
```
Fíjate que no tiene setters. Esto es sumamente importante. Tiene además un método para validación, el `equals` y `hashCode` sobrecargados y también otro que genera objetos aleatorios.

Teniendo esto claro, lo que tendrías que hacer es crear una carpeta `objectvalue` dentro de la carpeta `domain` donde definas una clase para cada objeto valor (de forma similar a `TrapDescription`) y que las uses estos nuevos tipos definidos por ti en los atributos de las entidades de tu dominio (carpeta `domain/entity`). Debes tener en cuenta que hay tipos como `UUID` (para representar identificadores unívocos) o `LocalDateTime` (para representar instantes de tiempo) que no es necesario que definas porque ya los tenemos en Java.

Cualquier cosa ve comentando este issue.

## API REST. Documentación

Hola, [OpenAPI](https://www.openapis.org) es una especificación de API que describe cómo interactuar con una API RESTful (Representational State Transfer) de forma programática. Te paso un artículo sobre cómo funciona OpenAPI con Spring: https://www.baeldung.com/spring-rest-openapi-documentation Como se describe en el artículo, se puede emplear una librería que genera documentación en formato yaml de una API REST.

Para poder emplear OpenAPI 3.0, tendrías que añadir la dependencia correspondiente en el archivo `pom.xml` de tu back-end. Revisa el artículo anterior para esto. Una vez levantada la API, si accedes a `http://localhost:8181/v3/api-docs/` deberías ver la documentación en formato JSON. Si accedes a `http://localhost:8181/swagger-ui/index.html` debes poder ver la documentación de la API mediante `Swagger`.

Habría que añadir a los endpoints la documentación de los mismos para que apareciera mediante esta herramienta. De esta manera podríamos publicar luego la documentación y que nosotros mismos puedan consultarla libremente.

## Arquitectura hexagonal

Hola, lee [este artículo](https://blog.allegro.tech/2020/05/hexagonal-architecture-by-example.html) sobre arquitectura hexagonal. Es una forma de organizar los elementos del back-end para que sea mantenible y limpia.

A medida que vayas avanzando en la lectura sobre arquitectura hexagonal ve modificando la organización de paquetes del back-end de la forma que indica el artículo.

## Objetos valor

Hola, tal como estuvimos hablando hoy, es conveniente que los atributos de las entidades que tienes en el dominio de tu aplicación no sean tipos primitivos sino tipos definitos por ti. Por ejemplo, `latitude` y `longitude` en `Warehouse` debería ser de tipo `Geolocation` en lugar de `double`. Ve cambiando algún atributo de esa clase por ejemplo y avísame a medida que lo hagas.

Antes de proceder con el código, lee con calma este artículo: https://leanmind.es/es/blog/primitive-obsesion-value-objects/ Es un artículo interesante sobre cómo funcionan los objetos valor y tiene ejemplos en Java.

Cualquier cosa ve comentando este issue :)

## Gitignore

Hola, añade un archivo `.gitignore` al back-end para que no se suba la carpeta `target`. Aquí tienes un [ejemplo](https://github.com/spring-projects/spring-framework/blob/main/.gitignore).

## Dockerizar

- [ ] Crear fichero Dockerfile para dockerizar el back-end de la aplicación. Aquí tienes un tutorial sobre cómo dockerizar una aplicación desarrollada en Spring: https://spring.io/guides/gs/spring-boot-docker/
- [ ] Prueba que puedes crear la imagen Docker.
- [ ] Crea un contenedor Docker a partir de la imagen creada.

## GitHub Action

Hola, cada vez que hagas un commit sobre la carpeta donde está el back-end de la aplicación debe crearse la imagen Docker correspondiente y publicarse en [Docker Hub](https://hub.docker.com/). Esta plataforma es el repositorio oficial de imágenes Docker. Por tanto:
- Crea una carpeta `.github/workflows` en tu repositorio si ésta no está creada previamente.
- Crea un archivo de workflow en la carpeta anterior de tal manera que cada vez que se realice un `push` en la carpeta del back-end de tu repositorio se cree la imagen Docker correspondiente mediante el Dockerfile que tienes en la carpeta del back-end y se publique en tu cuenta de [Docker Hub](https://hub.docker.com/). En [este enlace](https://gist.github.com/cexposit/0f594a230067d9094e0ed3aff1a8a681) puedes encontrar un ejemplo de cómo sería este archivo. Si te fijas, en el ejemplo anterior se emplean los secretos `DOCKERHUB_USERNAME` y `DOCKERHUB_PASSWORD`. Estos secretos están ya configurados en tu repositorio.
- Realiza algún cambio en archivos de la carpeta donde está el back-end y haz un `push` en el repositorio. Inmediatamente podrás comprobar que en la pestaña `Actions` del repositorio se lanza una acción con el nombre que has establecido en el fichero anterior. Si todo ha ido correctamente encontrarás un mensaje afirmativo en esta pestaña y la imagen se encontrará disponible en la cuenta [`softwarebuild`](https://hub.docker.com/u/softwarebuild). En caso contrario, podrás encontrar un mensaje de error y recibirás un correo indicando que la construcción de la imagen ha fallado.

Finalmente, es importante que establezcas un nombre para tu imagen que no se solape con el de otra imagen previamente creada en [`softwarebuild`](https://hub.docker.com/u/softwarebuild).

## Trampas

Hola, en el API REST se debe gestionar las posibles trampas de mosquitos. 

Una trampa tendrá los siguientes datos:
- Id. Identificador del recurso. Asignado por MongoDB.
- Nombre. Cadena de texto con una longitud entre 1 y 100 caracteres (por ejemplo).
- Descripción (opcional). Cadena de texto con una longitud entre 0 y 2000 caracteres (por ejemplo).
- Geolocalización. Latitud y longitud donde se encuentra la trampa.
- Tipo. Puede ser:
  - Sin atrayentes
  - Con cebos
  - De luz
  - Embudo de Berlese
- Imágenes (opcional). Conjunto de fotos de la trampa. 

Crea un endpoint `/traps` con al menos los siguientes métodos:
- `GET`. Devuelve todos los recursos.
- `POST`. Crea un nuevo recurso.
- `PUT`. Modifica un recurso.
- `DELETE`. Borra un recurso.
- `GET /traps/:id`. Devuelve un recurso a partir de su `id`.

En el repositorio he incluido algunas carpetas y códigos para que los tengas de referencia a la hora de crear el endpoint. Se corresponden a una pequeña aplicación cuya documentación pública puedes encontrar [aquí](https://kaizten.github.io/smart-sad-rest-api.html#employees). Tendrías que hacer algo parecido. Empieza mirando la carpeta `domain` para que crees el recurso `Trap` y a partir de ahí, mira `services` y `repository`, que permitirán acceder a MongoDB.

Ve subiendo el código a medida que lo hagas y comenta este issue para estar notificado.

## Trampas - tests

Hola, el endpoint creado debe ser testeado para comprobar que funciona correctamente. En este [enlace](https://stackabuse.com/guide-to-unit-testing-spring-boot-rest-apis/) puedes encontrar una descripción de cómo comenzar a realizar tests de un API REST.

En nuestro caso tendrías que al menos tester lo siguiente:
- `GET`. Devuelve todos los recursos.
- `POST`. Crea un nuevo recurso.
- `PUT`. Modifica un recurso.
- `DELETE`. Borra un recurso.
- `GET /traps/:id`. Devuelve un recurso a partir de su `id`.

## Tests. `DELETE`

Hola, en el documento `java/guidelines-back-end.md` está recogido los tests a realizar a los distintos recursos expuestos a través del API REST. 

Sería necesario incluir en el proyecto los tests para [`DELETE resource/`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#delete-resource) y [`DELETE resource/:id`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#delete-resourceid) siguiendo las indicaciones recogidas en [Tests](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#tests).

## Tests. `GET`

Hola, en el documento `java/guidelines-back-end.md` está recogido los tests a realizar a los distintos recursos expuestos a través del API REST. 

Sería necesario incluir en el proyecto los tests para [`GET resource/`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#get-resource) y [`GET resource/:id`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#get-resourceid) siguiendo las indicaciones recogidas en [Tests](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#tests).

## Tests. `OPTIONS`

Hola, en el documento `java/guidelines-back-end.md` está recogido los tests a realizar a los distintos recursos expuestos a través del API REST. 

Sería necesario incluir en el proyecto los tests para [`OPTIONS resource/`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#options-resource) y [`OPTIONS resource/:id`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#options-resourceid) siguiendo las indicaciones recogidas en [Tests](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#tests).

## Tests. `POST`

Hola, en el documento `java/guidelines-back-end.md` está recogido los tests a realizar a los distintos recursos expuestos a través del API REST. 

Sería necesario incluir en el proyecto los tests para [`POST resource/`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#post-resource) y [`POST resource/:id`](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#post-resourceid) siguiendo las indicaciones recogidas en [Tests](https://github.com/kaizten/kaizten-base/blob/main/java/guidelines-back-end.md#tests).

## Paginación

Hola, recientemente hemos añadido `KaiztenRequestParameterValidation.java` a la librería `kaizten-utils` porque nos ayuda a validar los request parameters `page` y `size`. De esta manera, en los métodos `GET` de todos controladores puedes poner esto al comienzo:
```java
final List<ApiSubError> errors = new ArrayList<>();
final int pageValue = KaiztenRequestParameterValidation.validateRequestParameterPage(page, errors);
final int sizeValue = KaiztenRequestParameterValidation.validateRequestParameterSize(size, errors);
KaiztenRestUtils.throwExceptionIfErrors(errors);
```
Con ello, si el cliente envía `page` o `size` se comprueban sus valores o se cogen los valores por defecto. A partir de ahí, puedes usar `pageValue` y `sizeValue` al tiempo que eliminas de tu back-end las validaciones ad-hoc implementadas.

Saludos :)

# Front-end

## Primeros pasos

Hola, dentro del repositorio habría que crear un front-end para la aplicación bajo desarrollo. En este caso, vamos a usar [Vite](https://vitejs.dev) como empaquetador, [Vue.js](https://vuejs.org) y TypeScript como lenguaje de programación. Con este objetivo en mente, ejecuta lo siguiente:
```shell
$ yarn create vite
```
Es importante que establezcas los siguientes datos cuando crees el proyecto:
* `Project name`: `front-end`
* `Select a framework`: `Vue`
* `Select a variant`: `TypeScript`

Una vez creado el proyecto, ejecuta lo siguiente para poder desplegar tu front-end en local:
```shell
$ cd front-end
$ yarn
$ yarn dev
```
De esta manera, tu front-end estará desplegado en tu máquina local en la dirección indicada por [Vite](https://vitejs.dev). A continuación puedes ver un ejemplo de cómo debería ser la salida:
```shell
  VITE v4.5.0  ready in 318 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h to show help
```
Comprueba que puedes acceder a la URL `http://localhost:5173/` (o a la indicada por [Vite](https://vitejs.dev) en el despliegue) a través de tu navegador. Si todo funciona correctamente, debes poder visualizar un front-end por defecto.

## GitHub action

Hola, he añadido al front-end un archivo `Dockerfile` destinado a crear la imagen Docker de este componente de software. También he añadido una [GitHub action](https://github.com/features/actions) a la carpeta `.github/workflows` del repositorio destinada a que, cada vez que hagas un cambio en `front-end/`, se genere la imagen Docker correspondiente y se publique en [Docker Hub](https://hub.docker.com).

Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `front-end/`. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo indicando el error.

En el archivo `.github/workflows/front-end_publish-docker-image.yml` hay definida una variable `DOCKER_IMAGE_NAME` que indica el nombre de la imagen Docker que se genera con el lanzamiento de la [GitHub action](https://github.com/features/actions). Por tanto, una vez se ejecute, comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.

## Dependencia: `kaizten-typescript`

Hola, en la empresa hemos creado internamente una pequeña librería de utilidades en TypeScript que nos ayuda en el desarrollo de nuestros proyectos de front-end: [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript). En ella hay diversas utilidades para trabajar con fechas, conexiones a servidor, etc.

Añade [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript) al front-end de la aplicación, tal como sigue:
```shell
$ yarn add @kaizten/kaizten-typescript@1.0.0
```
Una vez hayas añadido la dependencia en el front-end debes ser capaz de realizar la instalación de las dependencias:
```shell
$ yarn install
```
Para probar que la librería está integrada correctamente en el front-end puedes añadir lo siguiente al archivo `src/main.ts`:
```ts
...
import { KaiztenUUID } from "@kaizten/kaizten-typescript"

console.log(KaiztenUUID.random());
...
```
De esta manera, cuando arranques el front-end (`yarn dev`) se debe mostrar en la consola del navegador un UUID aleatoria que se encuentra definido en `kaizten-typescript`.

## Dominio

### Entidades

xxx

## Aplicación

### Servicios y repositorios

Hola, el objetivo de este issue es crear servicios en el front-end que sigan la arquitectura hexagonal y estén programados en TypeScript. La arquitectura hexagonal es una forma organizativa que promueve la separación de las preocupaciones en una aplicación. En el contexto de nuestro proyecto, esto significa que queremos tener una capa de servicios que sea independiente de la capa de presentación (interfaz de usuario) y que pueda ser fácilmente sustituida o probada por separado.

En base a lo anterior, 
1. Crea una nueva carpeta llamada `application/services` en el directorio del proyecto del front-end. En esta carpeta se añadirán los servicios de la aplicación.
2. Crea una nueva carpeta llamada `application/repository` en el directorio del proyecto del front-end. En esta carpeta se añadirán los repositorios de la aplicación.
3. Crea dentro de la carpeta `application/repository` una interfaz en TypeScript para cada una de las entidades del dominio. Cada repositorio debe definir los métodos necesarios para realizar las operaciones CRUD. Por ejemplo, 
```
getENTITIES:() => Promise<Either<DataError, ENTITYResponse>>;
```
define el método `getENTITIES` destinado a proporcionar el conjunto de entidades o bien `DataError` si se produjera algún error en la recuperación de datos. Cabe señalar que `Either` y `DataError` están ambos en la librería `kaizten-typescript`.
4. Dentro de la carpeta `application/services`, crea un conjunto de servicios que se encarguen de la lógica de negocio de la aplicación. Esto es, por cada entidad del dominio crea una clase en TypeScript con los métodos necesarios para hacer las operaciones CRUD de dicha entidad. Estos métodos deben devolver una promesa (`Promise`). Cada servicio debe tener el repositorio correspondiente como atributo privado y establecido a través del constructor de la clase. De esta manera, el repositorio correspondiente debe ser empleado para obtener los datos solicitados al servicio, tal como sigue:
```
public getENTITIES = (): Promise<Either<DataError, ENTITYResponse>> => {
    return this.repository.getENTITIES();
};
```

## Pinia como gestor de estados

Hola, habría que emplear [Pinia](https://pinia.vuejs.org) como gestor de estados en el front-end.

## Dockerizar

- [ ] Crear fichero Dockerfile para dockerizar el front-end de la aplicación. Aquí tienes un tutorial sobre cómo dockerizar una aplicación desarrollada en Vue.js: https://es.vuejs.org/v2/cookbook/dockerize-vuejs-app.html. 
- [ ] Prueba que puedes crear la imagen Docker.
- [ ] Crea un contenedor Docker a partir de la imagen creada.

## GitHub Action

Hola, cada vez que hagas un commit sobre la carpeta donde está el front-end de la aplicación debe crearse la imagen Docker correspondiente y publicarse en [Docker Hub](https://hub.docker.com/). Esta plataforma es el repositorio oficial de imágenes Docker. Por tanto:
- Crea una carpeta `.github/workflows` en tu repositorio si ésta no está creada previamente.
- Crea un archivo de workflow en la carpeta anterior de tal manera que cada vez que se realice un `push` en la carpeta del front-end de tu repositorio se cree la imagen Docker correspondiente mediante el Dockerfile que tienes en la carpeta del front-end y se publique en tu cuenta de [Docker Hub](https://hub.docker.com/). En [este enlace](https://gist.github.com/cexposit/da6c00aae017a42e76810b6ec671f312) puedes encontrar un ejemplo de cómo sería este archivo. Si te fijas, en el ejemplo anterior se emplean los secretos `DOCKERHUB_USERNAME` y `DOCKERHUB_PASSWORD`. Estos secretos están ya configurados en tu repositorio.
- Realiza algún cambio en archivos de la carpeta donde está el front-end y haz un `push` en el repositorio. Inmediatamente podrás comprobar que en la pestaña `Actions` del repositorio se lanza una acción con el nombre que has establecido en el fichero anterior. Si todo ha ido correctamente encontrarás un mensaje afirmativo en esta pestaña y la imagen se encontrará disponible en la cuenta [`softwarebuild`](https://hub.docker.com/u/softwarebuild). En caso contrario, podrás encontrar un mensaje de error y recibirás un correo indicando que la construcción de la imagen ha fallado.

Finalmente, es importante que establezcas un nombre para tu imagen que no se solape con el de otra imagen previamente creada en [`softwarebuild`](https://hub.docker.com/u/softwarebuild).

## Internacionalización

Hola, en la aplicación sería necesario permitir la utilización de varios idiomas. En el caso se Vue.js puedes emplear [Vue I18n](https://kazupon.github.io/vue-i18n/).

Añade la librería Vue I18n al front-end para permitir que el front-end esté en los siguientes idiomas:
- Español
- Inglés

Por otro lado, incluye un botón en la barra superior que permita al usuario cambiar el idioma.

Comprueba que cuando arranca la aplicación se emplea el idioma usado en el navegador y el botón de idioma que has puesto tiene dicho idioma seleccionado para que sea coherente. 

## Paleta de colores

Hola, la paleta de colores de la herramienta está definida en [este documento](https://docs.google.com/document/d/124c7hA4r7Kz0d-0HZc6r9YAT7qXM4v0Ug4BMjiJenGQ/edit). El front-end debería usar esta paleta de colores para mantener la homogeneidad y coherencia. En [Vuetify](https://vuetifyjs.com) se define la paleta de colores tal como se indica en [este enlace](https://vuetifyjs.com/en/styles/colors/#javascript-color-pack).

Por tanto:
1. Añade la paleta de colores al front-end siguiendo las instrucciones de la documentación de [Vuetify](https://vuetifyjs.com).
2. Revisa que no se usen colores *ad-hoc* en los diferentes componentes o vistas. De esta manera se evita que posteriores cambios en la paleta de lugar a incoherencias de colores.

## Trampas

Hola, en el front-end es necesario poder gestionar las trampas. Concretamente, sería necesario que el usuario pudiera hacer lo siguiente:
- Crear un nuevo recurso.
- Editar un recurso.
- Borrar un recurso.
- Listar todos los recursos disponibles.
- Consultar un recurso concreto.

# Docker

## Instalación

Hola, [Docker](https://www.docker.com) es una plataforma de software que permite crear, implementar y ejecutar aplicaciones en contenedores. Un contenedor es un paquete de software que incluye todo lo necesario para que una aplicación se ejecute, incluyendo el código, las bibliotecas y las dependencias. Los contenedores son independientes del sistema operativo y se pueden ejecutar en cualquier plataforma que admita Docker.

En la siguiente página tienes los pasos para realizar la instalación de Docker en tu máquina: https://docs.docker.com/engine/install/ubuntu/

Una vez realizados estos pasos, comprueba que tienes instalado Docker en tu máquina, tal como sigue:
```shell
docker -v
Docker version 20.10.21, build baeda1f
```
Es importante que puedes ejecutar `docker` sin necesitar emplear `sudo`. Si necesitas usar `sudo`, revisa [este artículo](https://docs.docker.com/engine/install/linux-postinstall/) donde se indica cómo ejecutarlo como usuario convencional.

## Nociones básicas

Hola, te paso [una referencia](https://www.freecodecamp.org/espanol/news/guia-de-docker-para-principiantes-como-crear-tu-primera-aplicacion-docker/) para que vayas comprobando cómo funciona Docker.

Por favor, leela con calma para que veas cómo se puede crear una imagen Docker de un código básico y cómo se puede crear un contenedor a partir de la imagen creada.

## Docker Compose. Instalación

Hola, [Docker Compose](https://docs.docker.com/compose/) es una herramienta de orquestación de contenedores que permite definir, configurar y ejecutar aplicaciones multi-contenedor Docker. Con Compose, se puede definir la configuración de múltiples servicios, redes y volúmenes, y luego iniciarlos y detenerlos todos juntos con un solo comando. Básicamente, Docker Compose es una herramienta que simplifica el proceso de gestión de múltiples contenedores de Docker en un entorno de producción. Permite definir la configuración de cada contenedor, así como las conexiones entre ellos, en un archivo YAML. Esto hace que sea fácil de leer y entender, y también es fácil de compartir con otros desarrolladores.

En la siguiente página tienes los pasos para realizar la instalación de Docker Compose en tu máquina: https://docs.docker.com/compose/install/

 Comprueba que tienes instalado Docker Compose en tu máquina, tal como sigue:
```shell
docker-compose -v
docker-compose version 1.29.0, build 07737305
```

# GitHub

## Primeros pasos

Hola, [GitHub](https://github.com) es una plataforma de desarrollo colaborativo para alojar proyectos utilizando el sistema de control de versiones [Git](https://git-scm.com/). Concretamente, es una plataforma en línea que permite a los desarrolladores y equipos de desarrollo colaborar en proyectos de software de manera eficiente. Permite a los usuarios alojar, gestionar y seguir el progreso de sus proyectos. Aquí, los repositorios son el corazón de la colaboración, y contienen el código fuente de un proyecto, junto con su historial de cambios.

1. Para empezar a trabajar con [GitHub](https://github.com) debes instalar [Git](https://git-scm.com/) en tu máquina. Por tanto, instala [Git](https://git-scm.com/) en tu máquina y comprueba desde una terminal que está correctamente instalado. En máquinas Linux sería así:
```shell
sudo apt install git
```
Deberías obtener algo similar a esto:
```shell
$ git --version
git version 2.34.1
```
2. Una vez instalado correctamente [Git](https://git-scm.com/) en tu máquina y tengas tu cuenta de [GitHub](https://github.com), lo que debes hacer es clonar todos los repositorios que te compartamos. Te dejo [un enlace](https://docs.github.com/es/repositories/creating-and-managing-repositories/cloning-a-repository) sobre cómo clonar un repositorio al que te haya llegado una invitación. De forma resumida, tendrás que abrir una terminal y ejecutar lo siguiente:
```shell
git clone git@github.com:kaizten/NOMBRE_REPOSITORIO.git
```
siendo `NOMBRE_REPOSITORIO` el nombre del repositorio en cuestión. Este comando lo puedes ver accediendo a la web del repositorio en [GitHub](https://github.com), pulsando el botón verde `<> Code>`, desde la opción `Clone` `SSH`. Cuando hayas clonado un repositorio tendrás una copia en tu máquina local de lo que se encuentra en dicho repositorio. 

Indica a través de este issue si has podido clonar los repositorios compartidos contigo de manera correcta.

# Grafana

## Primeros pasos

Hola, [Grafana](https://grafana.com) es una plataforma de análisis y visualización de datos de código abierto que permite monitorizar, analizar y visualizar datos en tiempo real desde diferentes fuentes de datos. Es una herramienta muy popular para monitorizar sistemas y aplicaciones, y se utiliza en una amplia variedad de campos, como la tecnología, la energía, la salud y la fabricación.

Con [Grafana](https://grafana.com), podemos crear paneles (cuadros de mando o dashboards) personalizados y tableros de control con una variedad de visualizaciones de datos, incluyendo gráficos de línea, barras, tortas, diagramas de dispersión, mapas y más. También es compatible con una amplia gama de fuentes de datos, como bases de datos relacionales, bases de datos NoSQL, sistemas de monitorización de infraestructura, sistemas de registro de eventos y más.

El primer paso para poder usar [Grafana](https://grafana.com) es crear un contenedor. Esto se hace tal como indica la propia [imagen oficial de Docker](https://hub.docker.com/r/grafana/grafana):
```shell
docker run -d --name=grafana -p 3000:3000 grafana/grafana
```
Si todo ha ido bien, una vez ejecutes este comando, puedes acceder a `http://localhost:3000` y se debe mostrar la página de login de [Grafana](https://grafana.com). Tanto el nombre de usuario como la contraseña por defecto es `admin`. A partir de este punto, ya puedes empezar a trabajar con [Grafana](https://grafana.com) para crear cuadros de mandos.

Te paso un primer tutorial en español que hemos usado en otras ocasiones para familiarizarte con Grafana y la construcción de cuadros de mando: [https://www.stratebi.es/todobi/Jun19/Trabajando_con_Grafana.pdf](https://www.stratebi.es/todobi/Jun19/Trabajando_con_Grafana.pdf) De momento, ve probando a crear un primer cuadro de mandos con alguna tabla o gráfico sencillo con los datos que prefieras. Luego iremos concretando qué forma debe tener.

Usa la carpeta `dashboards` del repositorio para guardar los cuadros de mandos que vayas creando. Crea la carpeta si no está creada.

En este primer cuadro de mandos puedes emplear un archivo que elijas con datos en formato [CSV](https://es.wikipedia.org/wiki/Valores_separados_por_comas) para posteriormente visualizarlos. A continuación tienes una descripción completa de cómo trabajar con datos [CSV](https://es.wikipedia.org/wiki/Valores_separados_por_comas) con Grafana: https://grafana.github.io/grafana-csv-datasource/

## Consumir API REST

Hola, en Grafana es posible crear cuadros de mando que consuman los datos provenientes de una API REST externa. [Aquí](https://blog.hubspot.es/website/que-es-api-rest) te dejo un enlace donde se realiza una descripción muy sencilla y poco técnica sobre qué es una API REST y para qué sirve. Una vez entendido este artículo, puedes leer este [otro artículo](https://appmaster.io/es/blog/ejemplos-de-api-de-descanso) para profundizar sobre la temática.

Como decía, es posible consumir una API REST desde Grafana. Para ello, puedes emplear el plugin [Grafana Infinity Datasource](https://sriramajeyam.com/grafana-infinity-datasource/). Trata de instalar el plugin directamente en Docker, tal como señala [aquí](https://sriramajeyam.com/grafana-infinity-datasource/wiki/installation).Una vez instalado el plugin, visualiza con calma [este video](https://www.youtube.com/watch?v=Wmgs1E9Ry-s) donde el propio autor del plugin muestra cómo crear un cuadro de mandos mediante [Grafana Infinity Datasource](https://sriramajeyam.com/grafana-infinity-datasource/).

Una vez instalado el plugin, crea un cuadro de mandos donde consultes un endpoint externo con formato JSON. Tanto en el vídeo anterior como [aquí](https://sriramajeyam.com/grafana-infinity-datasource/wiki/json) tienes ejemplos de cómo consumir un endpoint público.

## Selector de fecha

Hola, en el cuadro de mandos sería necesario incluir un selector (dropdown) donde poder elegir la fecha: fecha de inicio y fecha de fin. Esto está hecho por defecto en los cuadros de mandos de Grafana (parte superior derecha) pero debe comprobarse que la información mostrada se corresponde exclusivamente a la ventana de tiempo seleccionada.

## Indicadores

Hola, sería interesante que en el cuadro de mandos apareciera una sección dedicada a indicadores generales. Algunos de ellos podrían ser los siguientes:
- Número de barcos
- Número de puertos de origen
- Número de puertos de destino
- Distancia promedio
- Velocidad promedio

## Diagrama Sankey

Hola, cuando puedas, añade un [diagrama Sankey](https://en.wikipedia.org/wiki/Sankey_diagram) con los orígenes (parte izquierda) y destinos de los barcos (parte derecha).

## Tabla de datos

Hola, cuando puedas, añade una tabla en el cuadro de mandos donde cada fila sea un barco.

Añade un desplegable donde se pueda elegir uno o varios puertos (o todos) y que la tabla esté ordenada por ETA.

## Cronología

Hola, cuando puedas, añade al cuadro de mandos un gráfico donde:
- Eje x: tiempo
- Eje y: eventos de llegada a puerto

De esta manera se podría ver cuándo van a ir llegando a puerto los distintos barcos.

Aquí se podría añadir un desplegable para elegir el puerto o los puertos de interés.

## Mapa de calor

Hola, trata de añadir un mapa de calor sobre las posiciones de los barcos de tal manera que aparezca en rojo (por ejemplo) donde hay más barcos y en verde (por ejemplo) donde menos para así analizar la intensidad de tráfico marítimo.

## Selector de barco

Hola, en el cuadro de mandos sería interesante contar con un selector (dropdown) donde poder elegir el barco que se desea monitorizar. Del barco elegido sería interesante mostrar en paneles diferentes:
- Evolución de la distancia
- Evolución de la velocidad

## Docker compose. Instalación de plugins

Hola, cuando se arranca Grafana a través de Docker Compose es necesario tener los plugins instalados antes de cargar los cuadros de mandos. Los plugins necesarios para cargar los cuadros de mando pueden ser especificados como variables de entorno del contenedor de Grafana en la sección `environment`. En [esta sección](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/#install-plugins-in-the-docker-container) de la documentación oficial de Grafana se indica cómo instalar los plugins al arrancar el contenedor.

Revisa los plugins que se están empleando en los cuadros de mandos y modifica el Docker Compose para que se instalen los plugins al arrancar el contenedor.

# CPLEX

## Instalación

Hola, para poder implementar y resolver los modelos matemáticos podemos usar CPLEX. Te dejo por aquí, la versión 12.8 tanto para Linux como para Windows:
* Linux: https://drive.google.com/file/d/1PXShTd9bjxXxR_s5wPUPwrj52W1V3hUp/view?usp=sharing
* Windows: https://drive.google.com/file/d/1JuuctN4E6Mxsl5722YDTz-x4-QMwJRkY/view?usp=sharing

Instala el software en tu ordenador y comprueba que está correctamente instalado. A continuación, se muestra la versión de CPLEX instalada en `/opt/ibm/ILOG/CPLEX_Studio128/cplex/bin/x86-64_linux/`:
```shell
$ /opt/ibm/ILOG/CPLEX_Studio128/cplex/bin/x86-64_linux/cplex

Welcome to IBM(R) ILOG(R) CPLEX(R) Interactive Optimizer 12.8.0.0
  with Simplex, Mixed Integer & Barrier Optimizers
5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55 5655-Y21
Copyright IBM Corp. 1988, 2017.  All Rights Reserved.

Type 'help' for a list of available commands.
Type 'help' followed by a command name for more
information on commands.

CPLEX> 
```

## Dependencia `cplex.jar`

Hola, una vez instalado CPLEX en tu máquina, es necesario que conectes Java con CPLEX para poder programar modelos matemáticos desde el código fuente. Esto se realiza a través de un archivo `cplex.jar` que se encuentra donde instalaste CPLEX. Por tanto, debes buscar `cplex.jar` en la instalación de CPLEX y luego usar `mvn` para proceder a la instalación de este archivo. Te paso ejemplos de cómo sería tanto en Linux como en Windows:
- Linux: `mvn install:install-file -DgroupId=cplex -DartifactId=cplex -Dversion=12.8 -Dpackaging=jar -Dfile=/opt/ibm/ILOG/CPLEX_Studio128/cplex/lib/cplex.jar`
- Windows: `mvn install:install-file -DgroupId=cplex -DartifactId=cplex -Dversion=12.8 -Dpackaging=jar -Dfile=C:\Program Files\IBM\ILOG\CPLEX_Studio128\cplex\lib\cplex.jar`

En cualquiera de los casos, debes cambiar la ruta de `cplex.jar` por la ruta que tenga en tu ordenador.

# Java

## Instalación

Hola, en el proyecto deberíamos usar al menos [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html). Por ello, comprueba que tienes instalado en tu máquina al menos esta versión, tal como sigue:
```shell
java -version
java version "17.0.1" 2021-10-19 LTS
Java(TM) SE Runtime Environment (build 17.0.1+12-LTS-39)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.1+12-LTS-39, mixed mode, sharing)
```
Si tienes una versión superior a la 17 no hay problema.

Por otro lado, debes tener al menos [Maven](https://maven.apache.org) 3.8.5 para construir los componentes en Java. A continuación tienes un ejemplo de cómo debería estar tu máquina:
```shell
mvn -v
Apache Maven 3.8.5 (3599d3414f046de2324203b78ddcf9b5e4388aa0)
Maven home: /opt/apache-maven-3.8.5
Java version: 17.0.1, vendor: Oracle Corporation, runtime: /usr/lib/jvm/java-17-oracle
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.15.0-52-generic", arch: "amd64", family: "unix"
```
Al igual que en el caso de Java, si tienes una versión superior de Maven no hay problema. En el caso de que no tengas al menos estas versiones, instálalas o actualiza las versiones que tengas instaladas.

Pon un comentario a este issue mostrando las salidas de los comandos siguientes para poder comprobar las versiones instaladas de las herramientas:
* `java -version`
* `mvn -v`

## JCommander. Primeros pasos

Hola, la gestión de los argumentos que el usuario proporciona a través de la línea de comandos cuando usa los componentes en Java puede realizarse a través de [JCommander](https://jcommander.org/). Concretamente, [JCommander](https://jcommander.org/) es una biblioteca de Java que proporciona una forma sencilla y conveniente de analizar y gestionar argumentos de línea de comandos en aplicaciones Java. Facilita la definición de opciones de línea de comandos, argumentos y sus valores correspondientes, permitiendo a los desarrolladores crear interfaces de línea de comandos de manera más eficiente. [JCommander](https://jcommander.org/) simplifica la tarea de procesar y validar las entradas del usuario al ejecutar una aplicación Java desde la línea de comandos, lo que la hace útil para desarrollar aplicaciones de línea de comandos y utilidades en Java.

Lo primero que debes hacer para poder emplearla es añadirla a tu archivo de dependencias `pom.xml`:
```
        <dependency>
            <groupId>com.beust</groupId>
            <artifactId>jcommander</artifactId>
            <version>1.82</version>
        </dependency>
```
Luego puedes crear una clase que defina los argumentos de tu aplicación. Te paso un ejemplo:
```java
import java.util.List;
import java.util.Optional;

import com.beust.jcommander.Parameter;

public class Arguments {

    final int FLIGHTS = 100;
    final int EMPLOYEES = 50;
    final int PLANNING_HORIZON = 7;
    final String STARTING_DATE = "2023-01-15";

    @Parameter(names = {
            "-h", "--help"
    }, description = "Prints this help and exists", help = true)
    public boolean help = false;
    @Parameter(names = {
            "-f", "--flights"
    }, description = "Number of flights")
    public int flights = FLIGHTS;
    @Parameter(names = {
            "-e", "--employees"
    }, description = "Number of employees")
    public int employees = EMPLOYEES;
    @Parameter(names = {
            "-p", "--planning"
    }, description = "Number of days of the planning horizon")
    public int planningHorizon = PLANNING_HORIZON;
    @Parameter(names = {
            "--startingDate"
    }, description = "Starting date of the planning horizon")
    public String startingDate = STARTING_DATE;

    public Optional<List<String>> checkArguments() {
        return Optional.empty();
    }

    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("help=").append(this.help);
        stringBuilder.append(",");
        stringBuilder.append("flights=").append(this.flights);
        stringBuilder.append(",");
        stringBuilder.append("employees=").append(this.employees);
        stringBuilder.append(",");
        stringBuilder.append("planningHorizon=").append(this.planningHorizon);
        stringBuilder.append(",");
        stringBuilder.append("startingDate=").append(this.startingDate);
        return stringBuilder.toString();
    }
}
```
Finalmente, en el método principal de tu aplicación puedes comprobar el paso de valores a través de la línea de comandos:
```java
public static void main(String[] args) throws JsonProcessingException, ParseException {
        Arguments arguments = new Arguments();
        JCommander jCommander = JCommander.newBuilder().addObject(arguments).build();
        jCommander.setProgramName(INSTANCE_GENERATOR_NAME);
        jCommander.parse(args);
        if (arguments.help) {
            jCommander.setUsageFormatter(new UnixStyleUsageFormatter(jCommander));
            jCommander.usage();
            return;
        }
...
```
De esta manera, la aplicación puede ejecutarse, entre otras muchas combinaciones, tal como sigue:
```java
java -jar app.jar --help
```
Por tanto, trata de replicar los pasos para que la aplicación pueda gestionar los argumentos que el usuario le pase por línea de comandos.

# Visual Studio Code. Instalación

Hola, para poder programar de manera cómoda y eficiente es aconsejable emplear un entorno de programación integrado (IDE, por sus siglas en inglés). Actualmente uno de los IDE más versátiles es [Visual Studio Code](https://code.visualstudio.com) (VSC). [Visual Studio Code](https://code.visualstudio.com) es un IDE desarrollado por Microsoft para Windows, Linux, macOS y Web. Incluye soporte para la depuración, control integrado de [Git](https://git-scm.com), resaltado de sintaxis, finalización inteligente de código, fragmentos y refactorización (modificación del código fuente sin cambiar su comportamiento). El IDE es personalizable, por lo que sus usuarios pueden cambiar el tema del editor, los atajos de teclado y las preferencias. Es gratuito y de código abierto y es uno de los IDEs más utilizados en la actualidad. 

Por tanto, trata de instalar al menos la versión 1.8.2 de [Visual Studio Code](https://code.visualstudio.com) en tu máquina. Cuando lo hayas hecho, ejecuta lo siguiente desde una terminal para comprobar que se ha instalado correctamente:
```shell
$ code --version
1.82.2
abd2f3db4bdb28f9e95536dfa84d8479f1eb312d
x64
```
También comprueba que puedes arrancar el IDE, o bien haciendo doble click en el icono del programa o ejecutando lo siguiente desde una terminal:
```shell
$ code 
```

# NodeJS. Instalación

Hola, una herramienta que será necesaria en el proyecto en [NodeJS](https://nodejs.org). Puedes instalarla siguiendo los pasos que tienes recogidos en el [repositorio de GitHub](https://github.com/nodesource/distributions). Te dejo por aquí los pasos:
```shell
$ sudo apt-get update
$ sudo apt-get install -y ca-certificates curl gnupg
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
$ NODE_MAJOR=20
$ echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
$ sudo apt-get update
$ sudo apt-get install nodejs -y
```
Una vez instalado, debes comprobar que tienes al menos la versión `20.9` de [NodeJS](https://nodejs.org) en tu máquina. Esto es:
```shell
$ node -v
v20.9.0
```

# Yarn. Instalación

Hola, para la creación del front-end será utilizar un administrador de paquetes. [Yarn](https://yarnpkg.com) es un administrador de paquetes de código abierto utilizado en el desarrollo de software para gestionar dependencias y facilitar la construcción de proyectos en lenguajes de programación como JavaScript o TypeScript.

Puedes instalar [Yarn](https://yarnpkg.com) siguiendo alguna de las siguientes opciones:
1. Instalación a través de repositorio::
```shell
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/yarn.gpg
$ echo "deb [signed-by=/etc/apt/trusted.gpg.d/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
$ sudo apt update
$ sudo apt install yarn
```
2. Si tienes previamente instalado [`npm`](https://www.npmjs.com) en tu máquina:
```shell
$ sudo npm install -g yarn
```

En cualquiera de los casos, una vez instalado, debes comprobar que tienes al menos la versión `1.22.19` en tu máquina. Esto es:
```shell
$ yarn --version
1.22.19
```

<!-- OTROS ISSUES A REVISAR -->

# Arquitectura hexagonal

Hola, en [este enlace](https://www.baeldung.com/hexagonal-architecture-ddd-spring) puedes encontrar una descripción sencilla de cómo es la arquitectura hexagonal y cómo se implementa empleando Spring Boot. En este caso, el dominio y los casos de uso son el elemento central. No dependen de nada. A partir de ahí aparecen los adaptadores (API REST, base de datos, etc.) que se comunican con el dominio a través de puertos. 

Trata de leer el artículo con calma y hazme saber qué dudas te surgen al respecto.

# Proyecto full-stack. Plantilla

Hola, en [este repositorio](https://github.com/ull-tfg/template-project-full-stack) puedes encontrar una plantilla básica (con bastantes cosas por mejorar y completar) de proyecto full-stack. Está organizado de la siguiente manera:
* `back-end`. Componente para la gestión de datos y lógica de negocio en el servidor. Está desarrollado en Spring Boot con una arquitectura hexagonal.
* `front-end`. Componente para la interacción del usuario con la aplicación. Está desarrollado en Vue 3 con TypeScript. Tiene configurado además [Vuetify](https://vuetifyjs.com/) para que puedas crear componentes gráficos más fácilmente.
* `.github`. Contiene las acciones empleadas en la aplicación. En este caso, hay acciones destinadas a la creación de imágenes [Docker](https://help.clouding.io/hc/es/articles/360010283060-Trabajando-con-im%C3%A1genes-en-Docker) y su publicación en [DockerHub](https://geekflare.com/es/docker-hub-introduction/).
* `docker-compose.yml`. Archivo de [Docker Compose](https://iescelia.org/ciberseguridad/serie-docker-que-es-docker-compose/) destinado al despliegue de la aplicación.

Ahora mismo, lo que puedes hacer es haciendo una copia en tu repositorio, ir revisando la plantilla e indicar cuáles son las principales dudas que te surgen al respecto. Aprovecharemos tu opinión para ir mejorando la plantilla y también aclarando dudas al respecto. Recuerda que iremos actualizando la plantilla con correcciones para facilitarte que puedas ir avanzando.

## Tests de API REST

Hola, actualmente, la API REST carece de tests unitarios para validar su funcionalidad y garantizar su calidad. Esto se ha convertido en un problema, ya que no tenemos una forma confiable de verificar si los cambios realizados en el código introducen errores o rompen la funcionalidad existente. Por lo tanto, es necesario implementar algunas pruebas.

Cubrir las principales funcionalidades de la API con tests, incluyendo:
- Verificar que los endpoints respondan correctamente a las peticiones HTTP (códigos de respuesta, headers y cuerpo).
- Probar los casos de éxito y los casos de error para cada endpoint.

Te dejo [aquí](https://www.baeldung.com/spring-boot-testing) un artículo sobre cómo crear tests de una API mediante Spring Boot.

# Front-end

## Organización

Hola, algo en lo que no hemos entrado aún es en el front-end. Éste también debería organizarse con el objetivo de que se obtenga un código mantenible. En este sentido, deberías tener un carpeta `src/domain` donde tengas una clase en TypeScript por cada una de las entidades de tu back-end. 

Si te fijas, ahora mismo los datos los tienes acoplados a los componentes. Esto no ayuda a que le hagas cambios al front-end fácilmente.

## Servicios y repositorios

Hola, en el front-end es interesante por motivos de mantenibilidad seguir también con una arquitectura limpia, hexagonal u otra. 

En base a lo anterior, crea una carpeta `src/application` donde meter servicios y repositorios. Crea una clase en TypeScript que constituya un servicio para cada uno de los recursos que tienes en el API REST. Por ejemplo, puedes llamar a cada archivo `<resource>Service.ts`. Cada servicio se encargará de satisfacer los casos de uso de tu aplicación, de forma similar a como se hace en el back-end.

Por otro lado, define una interfaz en TypeScript para cada uno de los recursos de tu API REST. Por ejemplo, puedes llamar a cada archivo `<resource>Repository.ts`. Estas interfaces serán las que definen cómo se recuperan/almacenan los datos desde donde se encuentren. En tu caso, están en el back-end.

Hecho esto, tendrás un servicio y un repositorio por cada recurso. En este caso, cada servicio tiene que tener como atributo el repositorio correspondiente. Al mismo tiempo, cada método de un servicio invoca al método correspondiente del repositorio para recuperar/almacenar los recursos en cuestión.

## Adaptador REST

Hola, para recuperar propiamente los recursos desde el back-end es necesario crear adaptadores. Con este objetivo en mente,  crea en el front-end la carpeta `src/adapter/rest/` y dentro crea, para cada recurso definido en el API REST de tu back-end, una clase en TypeScript `<resource>RestRepository.ts` que implemente el repositorio correspondiente `src/application/<resource>Repository.ts`.

Son las implementaciones de los repositorios los que deben hacer las peticiones al back-end para recuperar/almacenar los recursos a medida que lo soliciten los servicios definidos.

## Adaptador VueJs

Hola, la comunición entre el usuario y la aplicación la vamos a hacer en este proyecto mediante `Vue.js`. Sin embargo, los componentes de Vue.js no deben ser los encargados de crear, modificar, etc. absolutamente nada. Para eso tenemos los servicios de la aplicación. Esto es, nuestros casos de uso.

Por ello, crea la carpeta `src/adaptar/vuejs` y dentro mete todos los componentes que has creado hasta el momento.

## Gestión de usuarios

Hola, la gestión de usuarios se hace habitualmente con un servidor de identidades y de autenticación. Una alternativa interesante es Keycloack. En [esta página](https://www.keycloak.org/getting-started/getting-started-docker) puedes ver cómo se puede ejecutar usando Docker.

Fíjate que, una vez levantes KeyCloack, puedes crear usuarios, sus roles, etc. Al menos deberías crear el rol de administrador (tú, como desarrollador de la aplicación), gestor portuario (que pueda acceder a todas las funcionalidades) y usuario (solo ver el live tracker). Usa los términos que consideres.

Una vez hayas podido crear usuarios, el siguiente paso es usar KeyCloack en el front-end. Te paso [un enlace](https://blog.devgenius.io/security-in-vuejs-3-0-with-authentication-and-authorization-by-keycloak-part-1-ae884889fa0d) donde lo hace. 

Cualquier cosa me vas diciendo y lo vemos.



# Project Optimization

## Descripción del problema de optimización

Hola, [este enlace](ENLACE OVERLEAF) es el lugar donde vamos a tratar de tener la descripción del problema de optimización a modelar matemáticamente así como sus formulaciones. Es un documento hecho en [LaTeX](https://www.latex-project.org) empleando la herramienta online [Overleaf](https://overleaf.com). Se trata de un documento de trabajo, por tanto, modifícalo libremente.

Para poder acceder al documento primero debes contar con una cuenta de [Overleaf](https://overleaf.com). Por tanto, si no tienes cuenta en [Overleaf](https://overleaf.com), crea una e indícame por aquí tu dirección para poder añadirte.

## README.md

Hola, en la raiz del repositorio puedes encontrar un archivo `README.md` donde he recogido el diagrama a seguir para el proyecto. También hay una descripción de problema de instancia, solución, presentación de instancia de problema y representación de solución. Son únicamente ejemplos para que los tengas de referencia. Tendrás que ir modificándolo a medida que vayas avanzando en los diferentes componentes.

Saludos :)

## Generador de instancias

Hola, tal como se recoge en el diagrama que tienes en el `README.md`, uno de los componentes del proyecto es el generador de instancias. 

En este punto, podemos empezar definiendo e implementando el generador de instancias. Se trata de un programa que, en base a las características definidas por el usuario a través de línea de comandos, genera un archivo JSON con los datos de la instancia del problema. 

En la carpeta `instance_generator` encontrarás un ejemplo funcional de un generador de instancias para otro problema (un Shared VRP). El objetivo de este código es que te sirva como punto de referencia. Por ello, si lo consideras, modifícalo en base a tus necesidades.

Para hacer el generador de instancias lleva a cabo los siguientes pasos:
Dentro de `instance_generator` incluye el código del generador de instancias. Los parámetros de entrada del generador de instancia deben ser los siguientes:
* Parámetros obligatorios:
  * Número de atraques: `b`
  * Número de buques: `v`
  * Número de zonas de almacenamiento: `s`
* Parámetros opcionales:
  * Help. Muestra la ayuda del programa y finaliza.
  * Nombre del archivo JSON a generar.
  * Mínimo valor para el tiempo de servicio de cada buque (expresado en segundos). 
  * Máximo valor para el tiempo de servicio de cada buque (expresado en segundos).
  * Mínimo valor para el tiempo de llegada de cada buque.
  * Máximo valor para el tiempo de llegada de cada buque.
  * Mínimo número de contenedores para cada zona de almacenamiento.
  * Máximo número de contenedores para cada zona de almacenamiento.
  * ...

Tal como puedes comprobar en el código de ejemplo, el usuario debe poder establer el valor de los parámetros a través de la línea de comandos siguiendo las directrices POSIX que puedes encontrar en este enlace: https://nullprogram.com/blog/2020/08/01/

Tal como se indicó con anterioridad, hay parámetros obligatorios y otros opcionales. En este sentido, debes tener en cuenta lo siguiente:
* Parámetros obligatorios. El usuario debe poder establecer el valor de cada parámetro mediante una opción corta `-o` (o su equivalente largo `--output`). 
* Parámetros opcionales. Deben tener un valor por defecto por si el usuario no introduce valor alguno.

La salida del generador de instancias debe ser un JSON. Empieza haciendo un ejemplo básico y vamos discutiendo cómo va quedando.

Finalmente, modifica `README.md` dentro de `instance_generator` para describir cómo es tu generador de instancias, cómo se ejecuta, etc.

## Visualizador de instancias de problema

Hola, tal como se recoge en el diagrama que tienes en el `README.md`, uno de los componentes del proyecto es el visualizador de instancias de problema. Este componente será útil para poder comprobar gráficamente qué instancias se tienen del problema. 

En este caso, dentro de la carpeta `instance_viewer` tienes un ejemplo de visualizador de instancias de problema. Lo tienes para que te sirva de referencia a la hora de crear el tuyo para el problema. Para ello, dentro de `instance_viewer` incluye el código para visualizar instancias del problema de optimización. Este código debe recibir a través de la línea de comandos los siguientes parámetros:
* Parámetros obligatorios:
  * Instancia de problema en formato JSON. Debes comprobar que el argumento pasado por el usuario es un JSON válido (tener extensión `.json` o `.JSON`, tener el formato correcto de una instancia de problema, etc.).
* Parámetros opcionales:
  * Help. Muestra la ayuda del programa y finaliza.
  * Nombre del archivo PNG a generar. Debes comprobar que el argumento pasado por el usuario es un PNG válido (tener extensión `.png` o `.PNG`).

Finalmente, modifica `README.md` dentro de `instance_viewer` donde describas el visualizador de instancias de problema, la salida de su ejecución, etc.

## Visualizador de soluciones

Hola, tal como se recoge en el diagrama que tienes en el `README.md`, uno de los componentes del proyecto es el visualizador de soluciones de problema. Este componente será útil para poder comprobar gráficamente cómo son las soluciones alcanzadas a través de las técnicas algorítmicas implementadas. 

En este caso, dentro de la carpeta `solution_viewer` tienes un ejemplo de visualizador de soluciones de problema. Lo tienes para que te sirva de referencia a la hora de crear el tuyo para el problema. Para ello, dentro de `solution_viewer` incluye el código para visualizar soluciones del problema de optimización. Este código debe recibir a través de la línea de comandos los siguientes parámetros:
* Parámetros obligatorios:
  * Solución del problema en formato JSON. Debes comprobar que el argumento pasado por el usuario es un JSON válido (tener extensión `.json` o `.JSON`, tener el formato correcto de una solución de problema, etc.).
* Parámetros opcionales:
  * Help. Muestra la ayuda del programa y finaliza.
  * Nombre del archivo PNG a generar. Debes comprobar que el argumento pasado por el usuario es un PNG válido (tener extensión `.png` o `.PNG`).

Finalmente, modifica `README.md` dentro de `solution_viewer` donde describas el visualizador de soluciones de problema, la salida de su ejecución, etc.

## Representación de problema de optimización

Hola, crea dentro del repositorio una carpeta con el nombre el problema. Dentro de esta carpeta incluye al menos las siguientes clases:
- `OptimizationProblem`. Clase que representa cómo es el problema de optimización a resolver. Incluye dentro de la clase lo siguiente:
    - todos los datos necesarios para representar el problema. Estos datos están incluidos en una instancia.
    - un objeto de tipo `Evaluator`.
- `Solution`. Clase que representa cómo es una solución. Incluye dentro de la clase:
    - todos los datos necesarios para representar una solución.
    - un objeto de tipo `OptimizationProblem`
    - un número, `objectiveFunctionValue`, que representará el valor de función objetivo de la solución.
- `Evaluator`. Clase que contenga un método que reciba una solución y devuelva su valor de función objetivo.
- `InstanceReader`. Clase con un método que reciba un fichero JSON de instancia de problema y devolverá un objeto `OptimizationProblem`.

## Modelo matemático del problema de optimización

Hola, el problema de optimización puede resolverse de forma exacta mediante un modelo matemático. Para ello, realiza lo siguiente:
1. Crea una carpeta `optimization_model` en el repositorio.
2. Crea en la carpeta `optimization_model` un proyecto con la implementación del modelo matemático del problema de optimización.

## Algoritmo aleatorio

Hola, tal como se recoge en el diagrama que tienes en el `README.md`, se debe contar con algún algoritmo destinado a resolver las instancias de problema que tengamos. Para ello, en este punto, el objetivo es diseñar un algoritmo que genere aleatoriamente soluciones para el problema de optimización. 

La carpeta `random_algorithm` incluye un código de ejemplo que puedes usar como referencia. Si lo consideras, modifícalo libremente. Este código debe recibir a través de la línea de comandos los siguientes parámetros:
* Parámetros obligatorios:
  * Instancia de problema en formato JSON. Debes comprobar que el argumento pasado por el usuario es un JSON válido (tener extensión `.json` o `.JSON`, tener el formato correcto de una instancia de problema, etc.).
* Parámetros opcionales:
  * Help. Muestra la ayuda del programa y finaliza.
  * Solución del problema en formato JSON. Debes comprobar que el argumento pasado por el usuario es un JSON válido (tener extensión `.json` o `.JSON`, tener el formato correcto de una solución de problema, etc.).

Finalmente, modifica `README.md` dentro de `random_algorithm` donde describas el algoritmo de generación de soluciones aleatorias, la salida de su ejecución, etc.