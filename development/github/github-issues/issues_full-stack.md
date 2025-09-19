<!-- TOC -->

- [Java](#java)
  - [Instalación de Java Development Kit](#instalación-de-java-development-kit)
  - [Instalación de Maven](#instalación-de-maven)
  - [Comprobar acceso a dependencia: `kaizten-utils`](#comprobar-acceso-a-dependencia-kaizten-utils)
- [Docker](#docker)
  - [Instalación](#instalación)
  - [Nociones básicas](#nociones-básicas)
  - [Docker Compose. Instalación](#docker-compose-instalación)
- [NodeJS. Instalación](#nodejs-instalación)
- [Yarn](#yarn)
  - [Instalación](#instalación-1)
  - [Comprobar acceso a dependencia: `kaizten-typescript`](#comprobar-acceso-a-dependencia-kaizten-typescript)
  - [Comprobar acceso a dependencia: `kaizten-vue`](#comprobar-acceso-a-dependencia-kaizten-vue)
- [Visual Studio Code](#visual-studio-code)
  - [Instalación](#instalación-2)
  - [Extensión `Draw.io`](#extensión-drawio)
  - [Extensión `MongoDB`](#extensión-mongodb)
  - [Extensión `Vue - Official`](#extensión-vue---official)
- [Arquitectura hexagonal](#arquitectura-hexagonal)
- [Back-end](#back-end)
  - [Primeros pasos](#primeros-pasos)
  - [Añadir dependencia: `kaizten-utils`](#añadir-dependencia-kaizten-utils)
  - [Dockerfile](#dockerfile)
  - [GitHub action](#github-action)
  - [Dominio](#dominio)
    - [Descripción del dominio](#descripción-del-dominio)
    - [Entidades](#entidades)
    - [Enumerados](#enumerados)
    - [Objetos valor](#objetos-valor)
    - [Tests de entidades](#tests-de-entidades)
    - [Tests de los enumerados](#tests-de-los-enumerados)
    - [Tests de objetos valor](#tests-de-objetos-valor)
  - [Aplicación](#aplicación)
    - [Casos de uso](#casos-de-uso)
    - [Servicios](#servicios)
    - [Repositorios](#repositorios)
  - [Adaptador MongoDB](#adaptador-mongodb)
    - [Descripción general](#descripción-general)
    - [Implementación de repositorios](#implementación-de-repositorios)
    - [Configuración](#configuración)
    - [Escritores](#escritores)
    - [Lectores](#lectores)
  - [Adaptador REST](#adaptador-rest)
    - [Controladores](#controladores)
    - [Peticiones](#peticiones)
    - [Respuestas](#respuestas)
    - [Deserializadores](#deserializadores)
    - [Serializadores](#serializadores)
    - [Configuración](#configuración-1)
    - [Documentación](#documentación)
  - [Operaciones bulk](#operaciones-bulk)
  - [Configuración](#configuración-2)
    - [Aplicación](#aplicación-1)
  - [SonarQube](#sonarqube)
  - [Websocket](#websocket)
- [Front-end](#front-end)
  - [Primeros pasos](#primeros-pasos-1)
  - [Añadir dependencia: `kaizten-typescript`](#añadir-dependencia-kaizten-typescript)
  - [Añadir dependencia: `kaizten-vue`](#añadir-dependencia-kaizten-vue)
  - [Dockerfile](#dockerfile-1)
  - [GitHub action](#github-action-1)
  - [Dominio](#dominio-1)
  - [Aplicación](#aplicación-2)
    - [Casos de uso](#casos-de-uso-1)
    - [Servicios](#servicios-1)
    - [Repositorios](#repositorios-1)
  - [Adaptador HTTP](#adaptador-http)
    - [Primeros pasos](#primeros-pasos-2)
    - [Data transfer objects](#data-transfer-objects)
    - [Probar adaptador HTTP](#probar-adaptador-http)
  - [Adaptador Vue.js](#adaptador-vuejs)
    - [Primeros pasos](#primeros-pasos-3)
    - [Router](#router)
    - [Gestor de estados](#gestor-de-estados)
    - [Data transfer objects para vistas](#data-transfer-objects-para-vistas)
    - [Vistas](#vistas)
    - [Internacionalización](#internacionalización)
  - [Integración de Vuetify](#integración-de-vuetify)
- [Docker compose](#docker-compose)
- [Algoritmo](#algoritmo)
  - [Implementación](#implementación)
  - [Algoritmo como servicio](#algoritmo-como-servicio)
- [Grafana](#grafana)
  - [Primeros pasos](#primeros-pasos-4)
  - [Integración en front-end](#integración-en-front-end)
<!-- /TOC -->

## Java

### Instalación de Java Development Kit

Hola, en el proyecto deberíamos usar al menos [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html). El Java Development Kit (JDK) es un conjunto de herramientas y recursos necesarios para desarrollar aplicaciones en Java. 

**Pasos a realizar:** 

1. El JDK incluye un compilador, bibliotecas, y otras utilidades para crear, depurar y ejecutar programas Java. Puedes instalar el JDK de Java tal como sigue:
    ```shell
    $ sudo add-apt-repository ppa:linuxuprising/java
    $ sudo apt update
    $ sudo apt install oracle-java17-installer oracle-java17-set-default
    ```

2. Una vez realizado el paso previo, comprueba que tienes instalado en tu máquina al menos esta versión. Para ello, ejecuta lo siguiente:
    ```shell
    $ java -version
    java version "17.0.6" 2023-01-17 LTS
    Java(TM) SE Runtime Environment (build 17.0.6+9-LTS-190)
    Java HotSpot(TM) 64-Bit Server VM (build 17.0.6+9-LTS-190, mixed mode, sharing)
    ```

    Cabe señalar que, si tienes una versión superior de Java a la `17`, no habrá problema para el desarrollo del proyecto.

3. Pon un comentario en este issue mostrando la salida del comando `java -version` para comprobar que has instalado correctamente [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) en tu máquina.

### Instalación de Maven

Hola, para compilar proyectos en Java se pueden usar herramientas como [Maven](https://maven.apache.org). Esta herramienta ayudará a para construir los componentes en Java de una forma sencilla. 

**Pasos a realizar:**

1. Instala al menos la versión `3.9.5` de [Maven](https://maven.apache.org). Esto puedes hacerlo tal como sigue:
    ```shell
    $ wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz -P /tmp
    $ sudo tar xf /tmp/apache-maven-3.9.5-bin.tar.gz -C /opt
    ```
2. Una vez instalado [Maven](https://maven.apache.org) hay que configurar variables de entorno:
    ```shell
    $ sudo gedit /etc/profile.d/maven.sh
    ```
    Añade el siguiente contenido:
    ```shell
    export JAVA_HOME=/usr/lib/jvm/java-17-oracle
    export M3_HOME=/opt/maven
    export MAVEN_HOME=/opt/maven
    export PATH=${M3_HOME}/bin:${PATH}
    ```
3. A continuación ejecuta lo siguiente para guardar las variables de entorno oportunamente:
    ```shell
    $ sudo chmod +x /etc/profile.d/maven.sh
    $ source /etc/profile.d/maven.sh
    ```

    A continuación tienes un ejemplo de cómo debería estar tu máquina:
    ```shell
    $ mvn -v
    Apache Maven 3.9.5 (57804ffe001d7215b5e7bcb531cf83df38f93546)
    Maven home: /opt/maven
    Java version: 17.0.6, vendor: Ubuntu, runtime: /usr/lib/jvm/java-17-oracle
    Default locale: en_US, platform encoding: UTF-8
    OS name: "linux", version: "6.2.0-36-generic", arch: "amd64", family: "unix"
    ```
    Cabe señalar que, si tienes una versión superior de [Maven](https://maven.apache.org) a la `3.9.5`, no habrá problema para el desarrollo del proyecto.

4. Pon un comentario en este issue mostrando la salida del comando `mvn -v` para comprobar que has instalado correctamente [Maven](https://maven.apache.org) en tu máquina.

### Comprobar acceso a dependencia: `kaizten-utils`

Hola, desde hace un tiempo hemos ido trabajando en una librería de utilidades destinada a facilitar la realización de proyectos en Java: [`kaizten-utils`](https://github.com/kaizten/kaizten-utils). Se trata de una pequeña librería donde hay bastantes clases, interfaces, enumerados y métodos que usamos regularmente. En tu proyecto pueden ser de utilidad para validar entidades por ejemplo. Acabo de agregarte como colaborador al repositorio de [`kaizten-utils`](https://github.com/kaizten/kaizten-utils) para que puedas acceder a su distribución y puedas añadirla como dependencia a tu proyecto.

**Pasos a realizar:**

1. Comprueba que te ha llegado una invitación a [`kaizten-utils`](https://github.com/kaizten/kaizten-utils) y acéptala.
2. Crea un token personal en tu cuenta de [GitHub](https://www.github.com). Aquí tienes los [pasos](https://docs.github.com/es/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). El tipo de token que debes crear es `Personal access tokens (classic)`. Además, es importante que cuando crees el token marques la opción `read-packages`.
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

4. Abre una terminal y comprueba que puedes acceder al paquete publicado con las credenciales que has establecido, tal como se muestra a continuación:
   ```sh
   $ mvn dependency:get -DgroupId=com.kaizten -DartifactId=kaizten-utils -Dversion=1.0-SNAPSHOT
    [INFO] Scanning for projects...
    [INFO] 
    [INFO] ------------------< org.apache.maven:standalone-pom >-------------------
    [INFO] Building Maven Stub Project (No POM) 1
    [INFO] --------------------------------[ pom ]---------------------------------
    [INFO] 
    [INFO] --- dependency:3.7.0:get (default-cli) @ standalone-pom ---
    [INFO] Resolving com.kaizten:kaizten-utils:jar:1.0-SNAPSHOT with transitive dependencies
    Downloading from github: https://maven.pkg.github.com/kaizten/*/com/kaizten/kaizten-utils/1.0-SNAPSHOT/maven-metadata.xml
    Downloading from central: https://repo1.maven.org/maven2/com/kaizten/kaizten-utils/1.0-SNAPSHOT/maven-metadata.xml
    Downloaded from github: https://maven.pkg.github.com/kaizten/*/com/kaizten/kaizten-utils/1.0-SNAPSHOT/maven-metadata.xml (14 kB at 8.9 kB/s)
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  3.102 s
    [INFO] Finished at: 2025-09-16T17:40:18+01:00
    [INFO] ------------------------------------------------------------------------
   ```
   Es importante que compruebes que la salida sea similar a la mostrada.

## Docker

### Instalación

Hola, [Docker](https://www.docker.com) es una plataforma de software que permite crear, implementar y ejecutar aplicaciones en contenedores. Un contenedor es un paquete de software que incluye todo lo necesario para que una aplicación se ejecute, incluyendo el código, las bibliotecas y las dependencias que sean necesarias. Los contenedores son independientes del sistema operativo y se pueden ejecutar en cualquier plataforma que admita Docker.

**Pasos a realizar:**

1. En la siguiente página tienes los pasos para realizar la instalación de [Docker](https://www.docker.com) en Ubuntu: https://docs.docker.com/engine/install/ubuntu/ Si tienes otro sistema operativo puedes encontrar [aquí](https://docs.docker.com/engine/install/) cómo instalar la herramienta.
2. Una vez realizados estos pasos, comprueba que tienes instalado Docker en tu máquina, tal como sigue:
    ```shell
    $ docker -v
    Docker version 27.2.1, build 9e34c9b
    ```
    Comprueba que tienes al menos la versión `27` de [Docker](https://www.docker.com). 

3. Es importante que puedes ejecutar `docker` sin necesitar emplear `sudo`. Si necesitas usar `sudo`, revisa [este artículo](https://docs.docker.com/engine/install/linux-postinstall/) donde se indica cómo ejecutarlo como usuario convencional.

### Nociones básicas

Hola, te paso [una referencia](https://www.freecodecamp.org/espanol/news/guia-de-docker-para-principiantes-como-crear-tu-primera-aplicacion-docker/) para que vayas comprobando cómo funciona [Docker](https://www.docker.com).

**Pasos a realizar:**

1. Lee con calma la referencia anterior para que veas cómo se puede crear una imagen [Docker](https://www.docker.com) de un código básico y cómo se puede crear un contenedor a partir de la imagen creada.

### Docker Compose. Instalación

Hola, [Docker Compose](https://docs.docker.com/compose/) es una herramienta de orquestación de contenedores que permite definir, configurar y ejecutar aplicaciones multi-contenedor Docker. Con [Docker Compose](https://docs.docker.com/compose/), se puede definir la configuración de múltiples servicios, redes y volúmenes, y luego iniciarlos y detenerlos todos juntos con un solo comando. Básicamente, [Docker Compose](https://docs.docker.com/compose/) es una herramienta que simplifica el proceso de gestión de múltiples contenedores de [Docker](https://www.docker.com) en un entorno de producción. Permite definir la configuración de cada contenedor, así como las conexiones entre ellos, en un archivo [YAML](https://en.wikipedia.org/wiki/YAML). Esto hace que sea fácil de leer y entender, y también es fácil de compartir con otros desarrolladores.

**Pasos a realizar:**

1. En la siguiente página tienes los pasos para realizar la instalación de [Docker Compose](https://docs.docker.com/compose/) en tu máquina: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

2. Comprueba que tienes instalado [Docker Compose](https://docs.docker.com/compose/) en tu máquina, tal como sigue:
    ```shell
    $ docker compose version
    Docker Compose version v2.31.0
    ```

## NodeJS. Instalación

Hola, una herramienta que será necesaria en el proyecto en [NodeJS](https://nodejs.org). Puedes instalarla siguiendo los pasos que tienes recogidos en el [repositorio de GitHub](https://github.com/nodesource/distributions). 

**Pasos a realizar:**

1. Realiza los siguientes pasos para instalar [NodeJS](https://nodejs.org):
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

2. Una vez instalado, debes comprobar que tienes al menos la siguiente versión de [NodeJS](https://nodejs.org) en tu máquina:
    ```shell
    $ node -v
    v22.13.0
    ```

## Yarn

### Instalación

Hola, para la creación del front-end será utilizar un administrador de paquetes. [Yarn](https://yarnpkg.com) es un administrador de paquetes de código abierto utilizado en el desarrollo de software para gestionar dependencias y facilitar la construcción de proyectos en lenguajes de programación como [JavaScript](https://developer.mozilla.org/es/docs/Web/JavaScript) o [TypeScript](https://www.typescriptlang.org).

**Pasos a realizar:**

1. Instala [Yarn](https://yarnpkg.com) siguiendo alguna de las siguientes 2 opciones:
    - Instalación a través de repositorio:
        ```shell
        $ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/yarn.gpg
        $ echo "deb [signed-by=/etc/apt/trusted.gpg.d/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        $ sudo apt update
        $ sudo apt install yarn
        ```
    - Si tienes previamente instalado [`npm`](https://www.npmjs.com) en tu máquina:
        ```shell
        $ sudo npm install -g yarn
        ```
2. Una vez instalado, debes comprobar que tienes al menos la versión `1.22.22` en tu máquina. Esto es:
    ```shell
    $ yarn --version
    1.22.22
    ```

### Comprobar acceso a dependencia: `kaizten-typescript`

Hola, hemos creado una pequeña librería de utilidades en [TypeScript](https://www.typescriptlang.org) que nos ayuda en el desarrollo de proyectos de front-end: [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript). En ella hay diversas utilidades para trabajar con fechas, conexiones a servidor, etc.

**Pasos a realizar:**

1. Comprueba que te ha llegado una invitación a [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript) y acéptala.
2. Si existe, elimina el archivo `yarn.lock` (`rm yarn.lock`).
3. Comprueba que puedes acceder a la librería, tal como sigue:
    ```sh
    $ npm install @kaizten/kaizten-typescript@1.0.0 --dry-run
    add @kaizten/kaizten-typescript 1.0.0
    add yocto-queue 0.1.0
    add yargs-parser 21.1.1
    add yargs 17.7.2
    add yallist 3.1.1
    add y18n 5.0.8
    add write-file-atomic 4.0.2
    add wrappy 1.0.2
    add wrap-ansi 7.0.0
    add word-wrap 1.2.5
    add which 2.0.2
    add walker 1.0.8
    add vuetify 3.10.1
    add vue-i18n 11.1.12
    add vue 3.5.21
    add v8-to-istanbul 9.3.0
    add util-deprecate 1.0.2
    add uri-js 4.4.1
    add update-browserslist-db 1.1.3
    add undici-types 7.12.0
    add type-fest 0.21.3
    add type-detect 4.0.8
    add type-check 0.4.0
    add tslib 2.8.1
    add to-regex-range 5.0.1
    add tmpl 1.0.5
    add text-encoding 0.6.4
    add test-exclude 6.0.0
    add supports-preserve-symlinks-flag 1.0.0
    add supports-color 7.2.0
    add strip-json-comments 3.1.1
    add strip-final-newline 2.0.0
    add strip-bom 4.0.0
    add strip-ansi 6.0.1
    add string-width 4.2.3
    add string-length 4.0.2
    add string_decoder 1.1.1
    add stream-source 0.3.5
    add stack-utils 2.0.6
    add escape-string-regexp 2.0.0
    add sprintf-js 1.0.3
    add source-map-support 0.5.13
    add source-map-js 1.2.1
    add source-map 0.6.1
    add slice-source 0.4.1
    add slash 3.0.0
    add sisteransi 1.0.5
    add signal-exit 3.0.7
    add shebang-regex 3.0.0
    add shebang-command 2.0.0
    add shapefile 0.6.6
    add commander 2.20.3
    add setimmediate 1.0.5
    add semver 6.3.1
    add safer-buffer 2.1.2
    add safe-buffer 5.1.2
    add rxjs 7.8.2
    add rw 1.3.3
    add robust-predicates 3.0.2
    add resolve.exports 2.0.3
    add resolve-from 4.0.0
    add resolve-cwd 3.0.0
    add resolve-from 5.0.0
    add resolve 1.22.10
    add require-from-string 2.0.2
    add require-directory 2.1.1
    add readable-stream 2.3.8
    add react-is 18.3.1
    add pure-rand 6.1.0
    add punycode 2.3.1
    add prompts 2.4.2
    add process-nextick-args 2.0.1
    add pretty-format 29.7.0
    add ansi-styles 5.2.0
    add prelude-ls 1.2.1
    add postcss 8.5.6
    add pkg-dir 4.2.0
    add p-locate 4.1.0
    add p-limit 2.3.0
    add locate-path 5.0.0
    add find-up 4.1.0
    add pirates 4.0.7
    add picomatch 2.3.1
    add picocolors 1.1.1
    add path-source 0.1.3
    add path-parse 1.0.7
    add path-key 3.1.1
    add path-is-absolute 1.0.1
    add path-exists 4.0.0
    add parse-json 5.2.0
    add parent-module 1.0.1
    add pako 1.0.11
    add p-try 2.2.0
    add p-locate 5.0.0
    add p-limit 3.1.0
    add optionator 0.9.4
    add onetime 5.1.2
    add once 1.4.0
    add npm-run-path 4.0.1
    add normalize-path 3.0.0
    add node-releases 2.0.21
    add node-int64 0.4.0
    add natural-compare 1.4.0
    add nanoid 3.3.11
    add ms 2.1.3
    add minimatch 3.1.2
    add mimic-fn 2.1.0
    add micromatch 4.0.8
    add merge-stream 2.0.0
    add makeerror 1.0.12
    add make-dir 4.0.0
    add semver 7.7.2
    add magic-string 0.30.19
    add lru-cache 5.1.1
    add lodash.merge 4.6.2
    add locate-path 6.0.0
    add lines-and-columns 1.2.4
    add lie 3.3.0
    add levn 0.4.1
    add leven 3.1.0
    add leaflet 1.9.4
    add kleur 3.0.3
    add keyv 4.5.4
    add jszip 3.10.1
    add json5 2.2.3
    add json-stable-stringify-without-jsonify 1.0.1
    add json-schema-traverse 1.0.0
    add json-parse-even-better-errors 2.3.1
    add json-buffer 3.0.1
    add jsesc 3.1.0
    add js-yaml 4.1.0
    add js-tokens 4.0.0
    add jest-worker 29.7.0
    add supports-color 8.1.1
    add jest-watcher 29.7.0
    add jest-validate 29.7.0
    add camelcase 6.3.0
    add jest-util 29.7.0
    add jest-snapshot 29.7.0
    add semver 7.7.2
    add jest-runtime 29.7.0
    add jest-runner 29.7.0
    add jest-resolve-dependencies 29.7.0
    add jest-resolve 29.7.0
    add jest-regex-util 29.6.3
    add jest-pnp-resolver 1.2.3
    add jest-mock 29.7.0
    add jest-message-util 29.7.0
    add jest-matcher-utils 29.7.0
    add jest-leak-detector 29.7.0
    add jest-haste-map 29.7.0
    add jest-get-type 29.6.3
    add jest-environment-node 29.7.0
    add jest-each 29.7.0
    add jest-docblock 29.7.0
    add jest-diff 29.7.0
    add jest-config 29.7.0
    add jest-cli 29.7.0
    add jest-circus 29.7.0
    add jest-changed-files 29.7.0
    add jest 29.7.0
    add istanbul-reports 3.2.0
    add istanbul-lib-source-maps 4.0.1
    add istanbul-lib-report 3.0.1
    add istanbul-lib-instrument 6.0.3
    add semver 7.7.2
    add istanbul-lib-coverage 3.2.2
    add isexe 2.0.0
    add isarray 1.0.0
    add is-stream 2.0.1
    add is-number 7.0.0
    add is-glob 4.0.3
    add is-generator-fn 2.1.0
    add is-fullwidth-code-point 3.0.0
    add is-extglob 2.1.1
    add is-core-module 2.16.1
    add is-arrayish 0.2.1
    add internmap 2.0.3
    add inherits 2.0.4
    add inflight 1.0.6
    add imurmurhash 0.1.4
    add import-local 3.2.0
    add import-fresh 3.3.1
    add immediate 3.0.6
    add ignore 5.3.2
    add iconv-lite 0.6.3
    add human-signals 2.1.0
    add html-escaper 2.0.2
    add hasown 2.0.2
    add has-flag 4.0.0
    add gsap 3.13.0
    add graceful-fs 4.2.11
    add globals 14.0.0
    add glob-parent 6.0.2
    add glob 7.2.3
    add get-stream 6.0.1
    add get-package-type 0.1.0
    add get-caller-file 2.0.5
    add geojson-validation 1.0.2
    add geojson 0.5.0
    add gensync 1.0.0-beta.2
    add function-bind 1.1.2
    add fsevents 2.3.3
    add fs.realpath 1.0.0
    add flatted 3.3.3
    add flat-cache 4.0.1
    add find-up 5.0.0
    add fill-range 7.1.1
    add file-source 0.6.1
    add file-entry-cache 8.0.0
    add fb-watchman 2.0.2
    add fast-uri 3.1.0
    add fast-levenshtein 2.0.6
    add fast-json-stable-stringify 2.1.0
    add fast-deep-equal 3.1.3
    add expect 29.7.0
    add exit 0.1.2
    add execa 5.1.1
    add esutils 2.0.3
    add estree-walker 2.0.2
    add estraverse 5.3.0
    add esrecurse 4.3.0
    add esquery 1.6.0
    add esprima 4.0.1
    add espree 10.4.0
    add eslint-visitor-keys 4.2.1
    add eslint-scope 8.4.0
    add eslint 9.35.0
    add json-schema-traverse 0.4.1
    add ajv 6.12.6
    add escape-string-regexp 4.0.0
    add escalade 3.2.0
    add error-ex 1.3.4
    add entities 4.5.0
    add emoji-regex 8.0.0
    add emittery 0.13.1
    add electron-to-chromium 1.5.220
    add diff-sequences 29.6.3
    add detect-newline 3.1.0
    add delaunator 5.0.1
    add deepmerge 4.3.1
    add deep-is 0.1.4
    add dedent 1.7.0
    add debug 4.4.3
    add dayjs 1.11.18
    add d3-zoom 3.0.0
    add d3-transition 3.0.1
    add d3-timer 3.0.1
    add d3-time-format 4.1.0
    add d3-time 3.1.0
    add d3-shape 3.2.0
    add d3-selection 3.0.0
    add d3-scale-chromatic 3.1.0
    add d3-scale 4.0.2
    add d3-random 3.0.1
    add d3-quadtree 3.0.1
    add d3-polygon 3.0.1
    add d3-path 3.1.0
    add d3-interpolate 3.0.1
    add d3-hierarchy 3.1.2
    add d3-geo 3.1.1
    add d3-format 3.1.0
    add d3-force 3.0.0
    add d3-fetch 3.0.1
    add d3-ease 3.0.1
    add d3-dsv 3.0.1
    add d3-drag 3.0.0
    add d3-dispatch 3.0.1
    add d3-delaunay 6.0.4
    add d3-contour 4.0.2
    add d3-color 3.1.0
    add d3-cloud 1.2.7
    add d3-dispatch 1.0.6
    add d3-chord 3.0.1
    add d3-brush 3.0.0
    add d3-axis 3.0.0
    add d3-array 3.2.4
    add d3 7.9.0
    add csstype 3.1.3
    add cross-spawn 7.0.6
    add create-jest 29.7.0
    add core-util-is 1.0.3
    add convert-source-map 2.0.0
    add concat-map 0.0.1
    add commander 7.2.0
    add color-name 1.1.4
    add color-convert 2.0.1
    add collect-v8-coverage 1.0.2
    add co 4.6.0
    add cliui 8.0.1
    add cjs-module-lexer 1.4.3
    add ci-info 3.9.0
    add char-regex 1.0.2
    add chalk 4.1.2
    add caniuse-lite 1.0.30001743
    add camelcase 5.3.1
    add callsites 3.1.0
    add buffer-from 1.1.2
    add bser 2.1.1
    add browserslist 4.26.2
    add braces 3.0.3
    add brace-expansion 1.1.12
    add baseline-browser-mapping 2.8.4
    add balanced-match 1.0.2
    add babel-preset-jest 29.6.3
    add babel-preset-current-node-syntax 1.2.0
    add babel-plugin-jest-hoist 29.6.3
    add babel-plugin-istanbul 6.1.1
    add istanbul-lib-instrument 5.2.1
    add babel-jest 29.7.0
    add array-source 0.0.4
    add argparse 2.0.1
    add anymatch 3.1.3
    add ansi-styles 4.3.0
    add ansi-regex 5.0.1
    add ansi-escapes 4.3.2
    add ajv-formats 3.0.1
    add ajv 8.17.1
    add acorn-jsx 5.3.2
    add acorn 8.15.0
    add @vue/shared 3.5.21
    add @vue/server-renderer 3.5.21
    add @vue/runtime-dom 3.5.21
    add @vue/runtime-core 3.5.21
    add @vue/reactivity 3.5.21
    add @vue/devtools-api 6.6.4
    add @vue/compiler-ssr 3.5.21
    add @vue/compiler-sfc 3.5.21
    add @vue/compiler-dom 3.5.21
    add @vue/compiler-core 3.5.21
    add @types/yargs-parser 21.0.3
    add @types/yargs 17.0.33
    add @types/stack-utils 2.0.3
    add @types/node 24.5.1
    add @types/live-server 1.2.3
    add @types/leaflet 1.9.20
    add @types/json-schema 7.0.15
    add @types/istanbul-reports 3.0.4
    add @types/istanbul-lib-report 3.0.3
    add @types/istanbul-lib-coverage 2.0.6
    add @types/graceful-fs 4.1.9
    add @types/geojson 7946.0.16
    add @types/estree 1.0.8
    add @types/d3-zoom 3.0.8
    add @types/d3-transition 3.0.9
    add @types/d3-timer 3.0.2
    add @types/d3-time-format 4.0.3
    add @types/d3-time 3.0.4
    add @types/d3-shape 3.1.7
    add @types/d3-selection 3.0.11
    add @types/d3-scale-chromatic 3.1.0
    add @types/d3-scale 4.0.9
    add @types/d3-random 3.0.3
    add @types/d3-quadtree 3.0.6
    add @types/d3-polygon 3.0.2
    add @types/d3-path 3.1.1
    add @types/d3-interpolate 3.0.4
    add @types/d3-hierarchy 3.1.7
    add @types/d3-geo 3.1.0
    add @types/d3-format 3.0.4
    add @types/d3-force 3.0.10
    add @types/d3-fetch 3.0.7
    add @types/d3-ease 3.0.2
    add @types/d3-dsv 3.0.7
    add @types/d3-drag 3.0.7
    add @types/d3-dispatch 3.0.7
    add @types/d3-delaunay 6.0.4
    add @types/d3-contour 3.0.6
    add @types/d3-color 3.1.3
    add @types/d3-chord 3.0.6
    add @types/d3-brush 3.0.6
    add @types/d3-axis 3.0.6
    add @types/d3-array 3.2.2
    add @types/d3 7.4.3
    add @types/babel__traverse 7.28.0
    add @types/babel__template 7.4.4
    add @types/babel__generator 7.27.0
    add @types/babel__core 7.20.5
    add @tmcw/togeojson 7.1.2
    add @sinonjs/fake-timers 10.3.0
    add @sinonjs/commons 3.0.1
    add @sinclair/typebox 0.27.8
    add @kaizten/kaizten-vue 1.0.0
    add @kaizten/kaizten-visualization-typescript 1.0.0
    add @types/leaflet 1.9.3
    add @kaizten/kaizten-simulation-typescript 1.0.0
    add @jridgewell/trace-mapping 0.3.31
    add @jridgewell/sourcemap-codec 1.5.5
    add @jridgewell/resolve-uri 3.1.2
    add @jridgewell/remapping 2.3.5
    add @jridgewell/gen-mapping 0.3.13
    add @jest/types 29.6.3
    add @jest/transform 29.7.0
    add @jest/test-sequencer 29.7.0
    add @jest/test-result 29.7.0
    add @jest/source-map 29.6.3
    add @jest/schemas 29.6.3
    add @jest/reporters 29.7.0
    add @jest/globals 29.7.0
    add @jest/fake-timers 29.7.0
    add @jest/expect-utils 29.7.0
    add @jest/expect 29.7.0
    add @jest/environment 29.7.0
    add @jest/core 29.7.0
    add @jest/console 29.7.0
    add @istanbuljs/schema 0.1.3
    add @istanbuljs/load-nyc-config 1.1.0
    add resolve-from 5.0.0
    add p-locate 4.1.0
    add p-limit 2.3.0
    add locate-path 5.0.0
    add js-yaml 3.14.1
    add find-up 4.1.0
    add argparse 1.0.10
    add @intlify/shared 11.1.12
    add @intlify/message-compiler 11.1.12
    add @intlify/core-base 11.1.12
    add @humanwhocodes/retry 0.4.3
    add @humanwhocodes/module-importer 1.0.1
    add @humanfs/node 0.16.7
    add @humanfs/core 0.19.1
    add @eslint/plugin-kit 0.3.5
    add @eslint/object-schema 2.1.6
    add @eslint/js 9.35.0
    add @eslint/eslintrc 3.3.1
    add json-schema-traverse 0.4.1
    add ajv 6.12.6
    add @eslint/core 0.15.2
    add @eslint/config-helpers 0.3.1
    add @eslint/config-array 0.21.0
    add @eslint-community/regexpp 4.12.1
    add @eslint-community/eslint-utils 4.9.0
    add eslint-visitor-keys 3.4.3
    add @bcoe/v8-coverage 0.2.3
    add @babel/types 7.28.4
    add @babel/traverse 7.28.4
    add @babel/template 7.27.2
    add @babel/plugin-syntax-typescript 7.27.1
    add @babel/plugin-syntax-top-level-await 7.14.5
    add @babel/plugin-syntax-private-property-in-object 7.14.5
    add @babel/plugin-syntax-optional-chaining 7.8.3
    add @babel/plugin-syntax-optional-catch-binding 7.8.3
    add @babel/plugin-syntax-object-rest-spread 7.8.3
    add @babel/plugin-syntax-numeric-separator 7.10.4
    add @babel/plugin-syntax-nullish-coalescing-operator 7.8.3
    add @babel/plugin-syntax-logical-assignment-operators 7.10.4
    add @babel/plugin-syntax-jsx 7.27.1
    add @babel/plugin-syntax-json-strings 7.8.3
    add @babel/plugin-syntax-import-meta 7.10.4
    add @babel/plugin-syntax-import-attributes 7.27.1
    add @babel/plugin-syntax-class-static-block 7.14.5
    add @babel/plugin-syntax-class-properties 7.12.13
    add @babel/plugin-syntax-bigint 7.8.3
    add @babel/plugin-syntax-async-generators 7.8.4
    add @babel/parser 7.28.4
    add @babel/helpers 7.28.4
    add @babel/helper-validator-option 7.27.1
    add @babel/helper-validator-identifier 7.27.1
    add @babel/helper-string-parser 7.27.1
    add @babel/helper-plugin-utils 7.27.1
    add @babel/helper-module-transforms 7.28.3
    add @babel/helper-module-imports 7.27.1
    add @babel/helper-globals 7.28.0
    add @babel/helper-compilation-targets 7.27.2
    add @babel/generator 7.28.3
    add @babel/core 7.28.4
    add @babel/compat-data 7.28.4
    add @babel/code-frame 7.27.1

    added 468 packages in 876ms

    59 packages are looking for funding
      run `npm fund` for details
    ```

    En este caso, la librería no se instalará sino que se comprobará si es posible acceder a ella.

### Comprobar acceso a dependencia: `kaizten-vue`

Hola, hemos creado una librería con algunos componentes sencillos que nos ayudan al desarrollo de aplicaciones en Vue.js: [`kaizten-vue`](https://github.com/kaizten/kaizten-vue).

**Pasos a realizar:**

1. Comprueba que te ha llegado una invitación a [`kaizten-vue`](https://github.com/kaizten/kaizten-vue) y acéptala.
2. Si existe, elimina el archivo `yarn.lock` (`rm yarn.lock`).
3. Comprueba que puedes acceder a la librería, tal como sigue:
    ```sh
    npm install @kaizten/kaizten-vue@1.0.0 --dry-run
    add @kaizten/kaizten-vue 1.0.0
    add yocto-queue 0.1.0
    add yargs-parser 21.1.1
    add yargs 17.7.2
    add yallist 3.1.1
    add y18n 5.0.8
    add write-file-atomic 4.0.2
    add wrappy 1.0.2
    add wrap-ansi 7.0.0
    add word-wrap 1.2.5
    add which 2.0.2
    add walker 1.0.8
    add vuetify 3.10.1
    add vue-i18n 11.1.12
    add vue 3.5.21
    add v8-to-istanbul 9.3.0
    add util-deprecate 1.0.2
    add uri-js 4.4.1
    add update-browserslist-db 1.1.3
    add undici-types 7.12.0
    add type-fest 0.21.3
    add type-detect 4.0.8
    add type-check 0.4.0
    add tslib 2.8.1
    add to-regex-range 5.0.1
    add tmpl 1.0.5
    add text-encoding 0.6.4
    add test-exclude 6.0.0
    add supports-preserve-symlinks-flag 1.0.0
    add supports-color 7.2.0
    add strip-json-comments 3.1.1
    add strip-final-newline 2.0.0
    add strip-bom 4.0.0
    add strip-ansi 6.0.1
    add string-width 4.2.3
    add string-length 4.0.2
    add string_decoder 1.1.1
    add stream-source 0.3.5
    add stack-utils 2.0.6
    add escape-string-regexp 2.0.0
    add sprintf-js 1.0.3
    add source-map-support 0.5.13
    add source-map-js 1.2.1
    add source-map 0.6.1
    add slice-source 0.4.1
    add slash 3.0.0
    add sisteransi 1.0.5
    add signal-exit 3.0.7
    add shebang-regex 3.0.0
    add shebang-command 2.0.0
    add shapefile 0.6.6
    add commander 2.20.3
    add setimmediate 1.0.5
    add semver 6.3.1
    add safer-buffer 2.1.2
    add safe-buffer 5.1.2
    add rxjs 7.8.2
    add rw 1.3.3
    add robust-predicates 3.0.2
    add resolve.exports 2.0.3
    add resolve-from 4.0.0
    add resolve-cwd 3.0.0
    add resolve-from 5.0.0
    add resolve 1.22.10
    add require-from-string 2.0.2
    add require-directory 2.1.1
    add readable-stream 2.3.8
    add react-is 18.3.1
    add pure-rand 6.1.0
    add punycode 2.3.1
    add prompts 2.4.2
    add process-nextick-args 2.0.1
    add pretty-format 29.7.0
    add ansi-styles 5.2.0
    add prelude-ls 1.2.1
    add postcss 8.5.6
    add pkg-dir 4.2.0
    add p-locate 4.1.0
    add p-limit 2.3.0
    add locate-path 5.0.0
    add find-up 4.1.0
    add pirates 4.0.7
    add picomatch 2.3.1
    add picocolors 1.1.1
    add path-source 0.1.3
    add path-parse 1.0.7
    add path-key 3.1.1
    add path-is-absolute 1.0.1
    add path-exists 4.0.0
    add parse-json 5.2.0
    add parent-module 1.0.1
    add pako 1.0.11
    add p-try 2.2.0
    add p-locate 5.0.0
    add p-limit 3.1.0
    add optionator 0.9.4
    add onetime 5.1.2
    add once 1.4.0
    add npm-run-path 4.0.1
    add normalize-path 3.0.0
    add node-releases 2.0.21
    add node-int64 0.4.0
    add natural-compare 1.4.0
    add nanoid 3.3.11
    add ms 2.1.3
    add minimatch 3.1.2
    add mimic-fn 2.1.0
    add micromatch 4.0.8
    add merge-stream 2.0.0
    add makeerror 1.0.12
    add make-dir 4.0.0
    add semver 7.7.2
    add magic-string 0.30.19
    add lru-cache 5.1.1
    add lodash.merge 4.6.2
    add locate-path 6.0.0
    add lines-and-columns 1.2.4
    add lie 3.3.0
    add levn 0.4.1
    add leven 3.1.0
    add leaflet 1.9.4
    add kleur 3.0.3
    add keyv 4.5.4
    add jszip 3.10.1
    add json5 2.2.3
    add json-stable-stringify-without-jsonify 1.0.1
    add json-schema-traverse 1.0.0
    add json-parse-even-better-errors 2.3.1
    add json-buffer 3.0.1
    add jsesc 3.1.0
    add js-yaml 4.1.0
    add js-tokens 4.0.0
    add jest-worker 29.7.0
    add supports-color 8.1.1
    add jest-watcher 29.7.0
    add jest-validate 29.7.0
    add camelcase 6.3.0
    add jest-util 29.7.0
    add jest-snapshot 29.7.0
    add semver 7.7.2
    add jest-runtime 29.7.0
    add jest-runner 29.7.0
    add jest-resolve-dependencies 29.7.0
    add jest-resolve 29.7.0
    add jest-regex-util 29.6.3
    add jest-pnp-resolver 1.2.3
    add jest-mock 29.7.0
    add jest-message-util 29.7.0
    add jest-matcher-utils 29.7.0
    add jest-leak-detector 29.7.0
    add jest-haste-map 29.7.0
    add jest-get-type 29.6.3
    add jest-environment-node 29.7.0
    add jest-each 29.7.0
    add jest-docblock 29.7.0
    add jest-diff 29.7.0
    add jest-config 29.7.0
    add jest-cli 29.7.0
    add jest-circus 29.7.0
    add jest-changed-files 29.7.0
    add jest 29.7.0
    add istanbul-reports 3.2.0
    add istanbul-lib-source-maps 4.0.1
    add istanbul-lib-report 3.0.1
    add istanbul-lib-instrument 6.0.3
    add semver 7.7.2
    add istanbul-lib-coverage 3.2.2
    add isexe 2.0.0
    add isarray 1.0.0
    add is-stream 2.0.1
    add is-number 7.0.0
    add is-glob 4.0.3
    add is-generator-fn 2.1.0
    add is-fullwidth-code-point 3.0.0
    add is-extglob 2.1.1
    add is-core-module 2.16.1
    add is-arrayish 0.2.1
    add internmap 2.0.3
    add inherits 2.0.4
    add inflight 1.0.6
    add imurmurhash 0.1.4
    add import-local 3.2.0
    add import-fresh 3.3.1
    add immediate 3.0.6
    add ignore 5.3.2
    add iconv-lite 0.6.3
    add human-signals 2.1.0
    add html-escaper 2.0.2
    add hasown 2.0.2
    add has-flag 4.0.0
    add gsap 3.13.0
    add graceful-fs 4.2.11
    add globals 14.0.0
    add glob-parent 6.0.2
    add glob 7.2.3
    add get-stream 6.0.1
    add get-package-type 0.1.0
    add get-caller-file 2.0.5
    add geojson-validation 1.0.2
    add geojson 0.5.0
    add gensync 1.0.0-beta.2
    add function-bind 1.1.2
    add fsevents 2.3.3
    add fs.realpath 1.0.0
    add flatted 3.3.3
    add flat-cache 4.0.1
    add find-up 5.0.0
    add fill-range 7.1.1
    add file-source 0.6.1
    add file-entry-cache 8.0.0
    add fb-watchman 2.0.2
    add fast-uri 3.1.0
    add fast-levenshtein 2.0.6
    add fast-json-stable-stringify 2.1.0
    add fast-deep-equal 3.1.3
    add expect 29.7.0
    add exit 0.1.2
    add execa 5.1.1
    add esutils 2.0.3
    add estree-walker 2.0.2
    add estraverse 5.3.0
    add esrecurse 4.3.0
    add esquery 1.6.0
    add esprima 4.0.1
    add espree 10.4.0
    add eslint-visitor-keys 4.2.1
    add eslint-scope 8.4.0
    add eslint 9.35.0
    add json-schema-traverse 0.4.1
    add ajv 6.12.6
    add escape-string-regexp 4.0.0
    add escalade 3.2.0
    add error-ex 1.3.4
    add entities 4.5.0
    add emoji-regex 8.0.0
    add emittery 0.13.1
    add electron-to-chromium 1.5.220
    add diff-sequences 29.6.3
    add detect-newline 3.1.0
    add delaunator 5.0.1
    add deepmerge 4.3.1
    add deep-is 0.1.4
    add dedent 1.7.0
    add debug 4.4.3
    add dayjs 1.11.18
    add d3-zoom 3.0.0
    add d3-transition 3.0.1
    add d3-timer 3.0.1
    add d3-time-format 4.1.0
    add d3-time 3.1.0
    add d3-shape 3.2.0
    add d3-selection 3.0.0
    add d3-scale-chromatic 3.1.0
    add d3-scale 4.0.2
    add d3-random 3.0.1
    add d3-quadtree 3.0.1
    add d3-polygon 3.0.1
    add d3-path 3.1.0
    add d3-interpolate 3.0.1
    add d3-hierarchy 3.1.2
    add d3-geo 3.1.1
    add d3-format 3.1.0
    add d3-force 3.0.0
    add d3-fetch 3.0.1
    add d3-ease 3.0.1
    add d3-dsv 3.0.1
    add d3-drag 3.0.0
    add d3-dispatch 3.0.1
    add d3-delaunay 6.0.4
    add d3-contour 4.0.2
    add d3-color 3.1.0
    add d3-cloud 1.2.7
    add d3-dispatch 1.0.6
    add d3-chord 3.0.1
    add d3-brush 3.0.0
    add d3-axis 3.0.0
    add d3-array 3.2.4
    add d3 7.9.0
    add csstype 3.1.3
    add cross-spawn 7.0.6
    add create-jest 29.7.0
    add core-util-is 1.0.3
    add convert-source-map 2.0.0
    add concat-map 0.0.1
    add commander 7.2.0
    add color-name 1.1.4
    add color-convert 2.0.1
    add collect-v8-coverage 1.0.2
    add co 4.6.0
    add cliui 8.0.1
    add cjs-module-lexer 1.4.3
    add ci-info 3.9.0
    add char-regex 1.0.2
    add chalk 4.1.2
    add caniuse-lite 1.0.30001743
    add camelcase 5.3.1
    add callsites 3.1.0
    add buffer-from 1.1.2
    add bser 2.1.1
    add browserslist 4.26.2
    add braces 3.0.3
    add brace-expansion 1.1.12
    add baseline-browser-mapping 2.8.4
    add balanced-match 1.0.2
    add babel-preset-jest 29.6.3
    add babel-preset-current-node-syntax 1.2.0
    add babel-plugin-jest-hoist 29.6.3
    add babel-plugin-istanbul 6.1.1
    add istanbul-lib-instrument 5.2.1
    add babel-jest 29.7.0
    add array-source 0.0.4
    add argparse 2.0.1
    add anymatch 3.1.3
    add ansi-styles 4.3.0
    add ansi-regex 5.0.1
    add ansi-escapes 4.3.2
    add ajv-formats 3.0.1
    add ajv 8.17.1
    add acorn-jsx 5.3.2
    add acorn 8.15.0
    add @vue/shared 3.5.21
    add @vue/server-renderer 3.5.21
    add @vue/runtime-dom 3.5.21
    add @vue/runtime-core 3.5.21
    add @vue/reactivity 3.5.21
    add @vue/devtools-api 6.6.4
    add @vue/compiler-ssr 3.5.21
    add @vue/compiler-sfc 3.5.21
    add @vue/compiler-dom 3.5.21
    add @vue/compiler-core 3.5.21
    add @types/yargs-parser 21.0.3
    add @types/yargs 17.0.33
    add @types/stack-utils 2.0.3
    add @types/node 24.5.1
    add @types/live-server 1.2.3
    add @types/leaflet 1.9.20
    add @types/json-schema 7.0.15
    add @types/istanbul-reports 3.0.4
    add @types/istanbul-lib-report 3.0.3
    add @types/istanbul-lib-coverage 2.0.6
    add @types/graceful-fs 4.1.9
    add @types/geojson 7946.0.16
    add @types/estree 1.0.8
    add @types/d3-zoom 3.0.8
    add @types/d3-transition 3.0.9
    add @types/d3-timer 3.0.2
    add @types/d3-time-format 4.0.3
    add @types/d3-time 3.0.4
    add @types/d3-shape 3.1.7
    add @types/d3-selection 3.0.11
    add @types/d3-scale-chromatic 3.1.0
    add @types/d3-scale 4.0.9
    add @types/d3-random 3.0.3
    add @types/d3-quadtree 3.0.6
    add @types/d3-polygon 3.0.2
    add @types/d3-path 3.1.1
    add @types/d3-interpolate 3.0.4
    add @types/d3-hierarchy 3.1.7
    add @types/d3-geo 3.1.0
    add @types/d3-format 3.0.4
    add @types/d3-force 3.0.10
    add @types/d3-fetch 3.0.7
    add @types/d3-ease 3.0.2
    add @types/d3-dsv 3.0.7
    add @types/d3-drag 3.0.7
    add @types/d3-dispatch 3.0.7
    add @types/d3-delaunay 6.0.4
    add @types/d3-contour 3.0.6
    add @types/d3-color 3.1.3
    add @types/d3-chord 3.0.6
    add @types/d3-brush 3.0.6
    add @types/d3-axis 3.0.6
    add @types/d3-array 3.2.2
    add @types/d3 7.4.3
    add @types/babel__traverse 7.28.0
    add @types/babel__template 7.4.4
    add @types/babel__generator 7.27.0
    add @types/babel__core 7.20.5
    add @tmcw/togeojson 7.1.2
    add @sinonjs/fake-timers 10.3.0
    add @sinonjs/commons 3.0.1
    add @sinclair/typebox 0.27.8
    add @kaizten/kaizten-visualization-typescript 1.0.0
    add @types/leaflet 1.9.3
    add @kaizten/kaizten-typescript 1.0.0
    add @kaizten/kaizten-simulation-typescript 1.0.0
    add @jridgewell/trace-mapping 0.3.31
    add @jridgewell/sourcemap-codec 1.5.5
    add @jridgewell/resolve-uri 3.1.2
    add @jridgewell/remapping 2.3.5
    add @jridgewell/gen-mapping 0.3.13
    add @jest/types 29.6.3
    add @jest/transform 29.7.0
    add @jest/test-sequencer 29.7.0
    add @jest/test-result 29.7.0
    add @jest/source-map 29.6.3
    add @jest/schemas 29.6.3
    add @jest/reporters 29.7.0
    add @jest/globals 29.7.0
    add @jest/fake-timers 29.7.0
    add @jest/expect-utils 29.7.0
    add @jest/expect 29.7.0
    add @jest/environment 29.7.0
    add @jest/core 29.7.0
    add @jest/console 29.7.0
    add @istanbuljs/schema 0.1.3
    add @istanbuljs/load-nyc-config 1.1.0
    add resolve-from 5.0.0
    add p-locate 4.1.0
    add p-limit 2.3.0
    add locate-path 5.0.0
    add js-yaml 3.14.1
    add find-up 4.1.0
    add argparse 1.0.10
    add @intlify/shared 11.1.12
    add @intlify/message-compiler 11.1.12
    add @intlify/core-base 11.1.12
    add @humanwhocodes/retry 0.4.3
    add @humanwhocodes/module-importer 1.0.1
    add @humanfs/node 0.16.7
    add @humanfs/core 0.19.1
    add @eslint/plugin-kit 0.3.5
    add @eslint/object-schema 2.1.6
    add @eslint/js 9.35.0
    add @eslint/eslintrc 3.3.1
    add json-schema-traverse 0.4.1
    add ajv 6.12.6
    add @eslint/core 0.15.2
    add @eslint/config-helpers 0.3.1
    add @eslint/config-array 0.21.0
    add @eslint-community/regexpp 4.12.1
    add @eslint-community/eslint-utils 4.9.0
    add eslint-visitor-keys 3.4.3
    add @bcoe/v8-coverage 0.2.3
    add @babel/types 7.28.4
    add @babel/traverse 7.28.4
    add @babel/template 7.27.2
    add @babel/plugin-syntax-typescript 7.27.1
    add @babel/plugin-syntax-top-level-await 7.14.5
    add @babel/plugin-syntax-private-property-in-object 7.14.5
    add @babel/plugin-syntax-optional-chaining 7.8.3
    add @babel/plugin-syntax-optional-catch-binding 7.8.3
    add @babel/plugin-syntax-object-rest-spread 7.8.3
    add @babel/plugin-syntax-numeric-separator 7.10.4
    add @babel/plugin-syntax-nullish-coalescing-operator 7.8.3
    add @babel/plugin-syntax-logical-assignment-operators 7.10.4
    add @babel/plugin-syntax-jsx 7.27.1
    add @babel/plugin-syntax-json-strings 7.8.3
    add @babel/plugin-syntax-import-meta 7.10.4
    add @babel/plugin-syntax-import-attributes 7.27.1
    add @babel/plugin-syntax-class-static-block 7.14.5
    add @babel/plugin-syntax-class-properties 7.12.13
    add @babel/plugin-syntax-bigint 7.8.3
    add @babel/plugin-syntax-async-generators 7.8.4
    add @babel/parser 7.28.4
    add @babel/helpers 7.28.4
    add @babel/helper-validator-option 7.27.1
    add @babel/helper-validator-identifier 7.27.1
    add @babel/helper-string-parser 7.27.1
    add @babel/helper-plugin-utils 7.27.1
    add @babel/helper-module-transforms 7.28.3
    add @babel/helper-module-imports 7.27.1
    add @babel/helper-globals 7.28.0
    add @babel/helper-compilation-targets 7.27.2
    add @babel/generator 7.28.3
    add @babel/core 7.28.4
    add @babel/compat-data 7.28.4
    add @babel/code-frame 7.27.1

    added 468 packages in 3s

    59 packages are looking for funding
      run `npm fund` for details
    ```
    En este caso, la librería no se instalará sino que se comprobará si es posible acceder a ella.

## Visual Studio Code

### Instalación

Hola, para poder programar de manera cómoda y eficiente es aconsejable emplear un entorno de programación integrado (IDE, por sus siglas en inglés). Actualmente uno de los IDE más versátiles es [Visual Studio Code](https://code.visualstudio.com) (VSC). [Visual Studio Code](https://code.visualstudio.com) es un IDE desarrollado por Microsoft para Windows, Linux, macOS y Web. Incluye soporte para la depuración, control integrado de [Git](https://git-scm.com), resaltado de sintaxis, finalización inteligente de código, fragmentos y refactorización (modificación del código fuente sin cambiar su comportamiento). El IDE es personalizable, por lo que sus usuarios pueden cambiar el tema del editor, los atajos de teclado y las preferencias. Es gratuito y de código abierto y es uno de los IDE más utilizados en la actualidad. 

**Pasos a realizar:**

1. Si no empleas ya un IDE diferente como [NetBeans](https://netbeans.apache.org), [IntelliJ IDEA](https://www.jetbrains.com/idea/), o [Eclipse](https://eclipseide.org), entre otros, te propongo instalar [Visual Studio Code](https://code.visualstudio.com) (al menos la versión `1.99.0`) en tu máquina. 
2. Cuando hayas instalado [Visual Studio Code](https://code.visualstudio.com), ejecuta el siguiente comando desde una terminal para comprobar que se ha instalado correctamente:
    ```shell
    $ code --version
    1.99.0
    4437686ffebaf200fa4a6e6e67f735f3edf24ada
    x64
    ```
3. Comprueba que puedes arrancar [Visual Studio Code](https://code.visualstudio.com), o bien haciendo doble click en el icono del programa o ejecutando el siguiente comando desde una terminal:
    ```shell
    $ code 
    ```

### Extensión `Draw.io`

Hola, una herramienta particularmente interesante para poder hacer diagramas sencillos es [Draw.io](https://app.diagrams.net). Es una herramienta gratuita con la que puedes realizar diagramas de una manera muy cómoda. Además, en [Visual Studio Code](https://code.visualstudio.com) hay una extensión que permite crear estos diagramas sin tener que salir del IDE.

**Pasos a realizar:**

1. Instala la extensión de [Draw.io](https://app.diagrams.net) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio).

### Extensión `MongoDB`

Hola, [MongoDB](https://www.mongodb.com) es una base de datos NoSQL que almacena datos en formato JSON flexible. Por regla general, para poder trabajar con [MongoDB](https://www.mongodb.com) es necesario conectarse mediante una terminal. Sin embargo, la extensión de [MongoDB](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) para [Visual Studio Code](https://code.visualstudio.com) es una herramienta que facilita la interacción con bases de datos [MongoDB](https://www.mongodb.com) directamente desde el IDE. De esta manera, será posible que accedas a tus bases de datos [MongoDB](https://www.mongodb.com) de manera gráfica, permitiendo crear o eliminar documentos, entre otras, de una manera sencilla.

**Pasos a realizar:**

1. Instala la extensión de [MongoDB](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode).

### Extensión `Vue - Official`

Hola, [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar) es una extensión para [Visual Studio Code](https://code.visualstudio.com/) diseñada específicamente para mejorar el desarrollo en entornos de [Vue.js](https://vuejs.org). Esta extensión ofrece un soporte avanzado para el desarrollo de aplicaciones [Vue.js](https://vuejs.org), agilizando la escritura de código, mejorando la detección de errores y proporcionando una experiencia de desarrollo más fluida y eficiente. Si usas [Visual Studio Code](https://code.visualstudio.com), creo que sería interesante que instalaras esta extensión y, de esta manera, puedas desarrollar de forma más eficaz aplicaciones hechas con [Vue.js](https://vuejs.org).

**Pasos a realizar:**

1. Instala la extensión de [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=Vue.volar).

## Arquitectura hexagonal

La arquitectura hexagonal es un enfoque de diseño de software que busca aislar la lógica central del negocio de las dependencias externas, como bases de datos, interfaces de usuario o servicios externos (correo electrónico, pasarelas de pago, autenticación de usuarios, etc.). Su objetivo principal es crear aplicaciones más flexibles, escalables y fáciles de probar, permitiendo que la lógica de negocio se mantenga independiente de los detalles técnicos.

En esta arquitectura, la lógica del negocio reside en el núcleo de la aplicación, mientras que las interacciones con el mundo exterior se gestionan a través de adaptadores, garantizando que el núcleo se mantenga limpio y enfocado exclusivamente en las reglas de negocio.

La arquitectura hexagonal proporciona varios beneficios:

- *Desacoplamiento.* Permite separar la lógica de negocio de las capas externas (interfaces, almacenamiento, APIs externas), lo que facilita la evolución del sistema sin romper el núcleo de la aplicación.
- *Testabilidad.* Al estar la lógica de negocio desacoplada, es más fácil escribir pruebas unitarias y pruebas de integración, ya que se pueden simular (mockear) las dependencias externas.
- *Flexibilidad.* Facilita la adición de nuevas interfaces o adaptadores sin afectar la lógica interna. Por ejemplo, cambiar de una base de datos SQL a una NoSQL o exponer una [API REST](https://es.wikipedia.org/wiki/Transferencia_de_Estado_Representacional) y [GraphQL](https://graphql.org) al mismo tiempo.
- *Mantenibilidad.* Al dividir las responsabilidades claramente en capas, el sistema se vuelve más fácil de entender, mantener y extender.

La imagen siguiente muestra un esquema general de cómo se organiza una aplicación con arquitectura hexagonal:

![Esquema general de arquitectura hexagonal](https://kaizten.github.io/images/hexagonal-architecture_overview.png)

A continuación se exponen las principales capas de la arquitectura hexagonal que vamos a immplementaro:

**1. Capa de adaptadores**

La capa de adaptadores es el punto de entrada y salida de la aplicación. Esta capa incluye adaptadores como controladores HTTP, conectores de bases de datos, y otros componentes que interactúan con agentes externos. Los adaptadores transforman las solicitudes del mundo exterior (donde está el usuario de la aplicación) en algo que el núcleo de la aplicación pueda entender y viceversa.

**2. Capa de aplicación**

La capa de aplicación es la encargada de coordinar las operaciones del sistema. Se centra en qué se debe hacer, sin preocuparse de los detalles técnicos de cómo se hace. Los componentes principales en esta capa son los casos de uso, servicios y repositorios.

- *Casos de uso.* Representan la lógica que resuelve tareas específicas. Son la entrada principal a la lógica de negocio.
- *Servicios.* Implementación concreta de los casos de uso.
- *Repositorios.* Son interfaces que proporcionan acceso a la capa de dominio, ocultando detalles de almacenamiento.

**3. Capa de dominio**

La capa de dominio contiene las entidades y objetos valor que representan la lógica central del negocio. Esta capa no conoce nada sobre las capas externas y se enfoca exclusivamente en las reglas y procesos que gobiernan el sistema.

- *Entidades.* Objetos que tienen una identidad única y un ciclo de vida. Ejemplo: `Pedido`, `Cliente`. Los atributos de las entidades son generalmente objetos de valor, que son descritos a continuación.
- *Objetos de valor.* Objetos inmutables cuya identidad depende de los valores de sus atributos y no de su lugar en la memoria de la máquina. Ejemplo: `Dirección`, `Moneda`. Generalmente, son objetos empleados como tipo de los atributos de las entidades.
- *Enumerados.* Objetos inmutables que pueden tomar un valor de un conjunto preestablecido. 

Por último, en la imagen anterior aparece un elemento adicional llamado `Configuration` que es un componente general y trasversal a toda la aplicación destinado a configurar la misma y conectar cada elemento de la forma oportuna.

## Back-end

### Primeros pasos

Hola, el back-end de la aplicación vamos a realizarla mediante [Spring Boot](https://spring.io/projects/spring-boot). Se trata de un framework para la creación de aplicaciones empresariales en Java y otros lenguajes compatibles con la [Java virtual machine](https://en.wikipedia.org/wiki/Java_virtual_machine) como Scala o Kotlin.

**Pasos a realizar:**

1. Accede a [Spring Initializr](https://start.spring.io/). En el formulario debes establecer lo siguiente:
      * `Project`: `Maven`
      * `Language`: `Java`
      * `Spring Boot`: `3.4.0`
      * `Project Metadata`:
        * `Group`: `com.kaizten`
        * `Artifact`: `back-end`
        * `Name`: `back-end`
        * `Package name`: `com.kaizten.project`
        * `Packaging`: `Jar`
        * `Java`: `17`
      El resto de los campos puedes configurarlos libremente. Una vez hayas cumplimentado el formulario de [Spring Initializr](https://start.spring.io/), debes pulsar `Generate` y descarga el archivo `back-end.zip` con el proyecto [Spring Boot](https://spring.io/projects/spring-boot) creado.
2. Descomprime `back-end.zip` dentro de la carpeta de tu repositorio. Con esto, debes tener una carpeta `back-end` en la raíz de tu repositorio. 
3. Compila el back-end, tal como se muestra a continuación:
    ```shell
    $ cd back-end
    $ mvn clean package
    [INFO] Scanning for projects...
    [INFO] 
    [INFO] --------------------------< kaizten.com:back-end >---------------------------
    [INFO] Building back-end 1.0-SNAPSHOT
    [INFO] --------------------------------[ jar ]---------------------------------
    ...
    [INFO] Building jar: /home/christopher/application/back-end/target/back-end-1.0-SNAPSHOT.jar
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  6.041 s
    [INFO] Finished at: 2023-10-26T18:39:46+01:00
    [INFO] ------------------------------------------------------------------------
    ```
4. Si todo ha ido correctamente, debes encontrar la distribución del back-end en formato JAR. Concretamente `back-end/target/back-end-1.0-SNAPSHOT.jar`. Comprueba que este archivo se encuentra disponible.
5. Sube los cambios al repositorio de tu proyecto para que el back-end esté disponible.

### Añadir dependencia: `kaizten-utils`

Hola, con el objetivo de evitar reescribir código, habría que añadir [`kaizten-utils`](https://github.com/kaizten/kaizten-utils) como dependencia al back-end.

**Pasos a realizar:**

1. Añade al archivo pom.xml la dependencia de kaizten-utils:

    ```sh
    <dependency>
      <groupId>com.kaizten</groupId>
      <artifactId>kaizten-utils</artifactId>
      <version>1.0-SNAPSHOT</version>
    </dependency>
    ```
2. Compila el proyecto para comprobar que la dependencia está disponible: `mvn clean package`.

### Dockerfile

Hola, la dockerización del back-end de la aplicación es crucial por varias razones fundamentales que influyen directamente en la eficiencia, portabilidad y escalabilidad del sistema. En particular, con [Docker](https://www.docker.com), las dependencias del back-end (bibliotecas, frameworks, entornos, etc.) se pueden empaquetar y versionar fácilmente, lo que simplifica la gestión de dependencias y las actualizaciones del software.

La dockerización del back-end requiere de un archivo `Dockerfile`. Se trata un archivo de texto que contiene instrucciones precisas para construir una imagen de [Docker](https://www.docker.com), especificando los pasos necesarios para configurar y ejecutar un entorno dentro de un contenedor. 

**Pasos a realizar:**

1. Para crear el `Dockerfile` tienes que crear el siguiente archivo dentro de la carpeta `back-end`:
    ```shell
    FROM openjdk:17-jdk-alpine

    EXPOSE 8080

    ARG JAR_FILE=target/*.jar

    COPY ${JAR_FILE} app.jar

    ENTRYPOINT ["java", "-jar", "/app.jar"]
    ```
    Es importante que lo guardes exactamente con el nombre `Dockerfile`. Esto es, no pongas extensiones en el nombre del fichero.

2. Una vez creado el `Dockerfile`, puedes crear la imagen [Docker](https://www.docker.com) de tu back-end. Para ello, ejecuta lo siguiente:
    ```shell
    $ cd back-end
    $ mvn clean package
    $ docker build -t dockerizedbackend .
    ```

3. Si todo ha ido correctamente, debes tener la imagen [Docker](https://www.docker.com) generada en tu máquina:
    ```shell
    $ docker images 
    REPOSITORY                            TAG       IMAGE ID       CREATED          SIZE
    dockerizedbackend                     latest    0ff1df35654b   24 seconds ago   352MB
    ```
    Comprueba que la imagen de [Docker](https://www.docker.com) se ha creado correctamente.

4. Finalmente, puedes crear un contenedor [Docker](https://www.docker.com) de esta imagen, tal como sigue:
    ```shell
    $ docker run -p 8081:8080 --name mycontainer dockerizedbackend
    ```
    El resultado debe ser que el back-end se ejecute de forma convencional, pero ahora no como un artefacto Java sino como un contenedor. Concretamente, se está creando un contenedor llamado `mycontainer` de la imagen previamente creada `dockerizedbackend`. Además, se está mapeando el puerto `8080` del contenedor en el puerto `8081` de tu máquina.

### GitHub action

Hola, la compilación del back-end y la generación de la imagen [Docker](https://www.docker.com) correspondiente requieren pasos manuales, lo que puede llevar a errores, inconsistencias y pérdida de tiempo. Para mejorar este proceso, se puede implementar una [GitHub action](https://github.com/features/actions) que automatice estas tareas con cada `push` realizado en el repositorio.

Cabe señalar que las [GitHub action](https://github.com/features/actions) se definen en la carpeta `.github/workflows` del repositorio. 

**Pasos a realizar:**

1. En el caso de que no exista, crea la carpeta `.github/workflows` en la raíz de tu repositorio. Es importante que te fijes bien en que se trata de una carpeta oculta.
2. Dentro de la carpeta `.github/workflows` crea el archivo `back-end_publish-docker-image.yml` con el siguiente contenido:
    ```yaml
    # GitHub action aimed at creating a Docker image of a Java project. 
    # The Docker image is pushed on DockerHub when created.
    #
    # Requirements:
    # - Secrets. In order to execute the GitHub action the following secrets must be set in the project
    # (Settings / Secrets / Actions):
    #   - KAIZTEN_DEVELOPMENT_USERNAME. Username of account kaiztendevelopment.
    #   - KAIZTEN_DEVELOPMENT_PASSWORD. Password of account kaiztendevelopment.
    #   - DOCKERHUB_USERNAME. Username of the user in DockerHub.
    #   - DOCKERHUB_PASSWORD. Password of the user in DockerHub.
    #
    # Author: Kaizten Analytics S.L. (development@kaizten.com)

    name: Back-end. Publish Docker image

    # Events that trigger the workflow
    on:
      push:
        branches:
          - main
        paths:
          - back-end/**
          - '!**.md'
      workflow_dispatch:

    # Working directory
    defaults:
      run:
        working-directory: back-end

    # Environment variables
    env:
      JAVA_VERSION: 17
      WORKING_DIRECTORY: back-end
      DOCKER_IMAGE_NAME: kaizten/<NOMBRE_PROYECTO>_back-end

    jobs:
      path-context:
        runs-on: ubuntu-latest
        steps:
          # Checkout of the repository
          - name: Checkout
            uses: actions/checkout@v4
          # Setting Java Development Kit
          - name: Set up Java Development Kit
            uses: actions/setup-java@v4
            with:
              java-version: ${{ env.JAVA_VERSION }}
              distribution: 'temurin'
              server-id: github
              server-username: MAVEN_USERNAME
              server-password: MAVEN_PASSWORD
          # Build artifact with Maven
          - name: Build with Maven
            run: mvn -B -Pgithub clean package
            env:
              MAVEN_USERNAME: ${{ secrets.KAIZTEN_DEVELOPMENT_USERNAME }}
              MAVEN_PASSWORD: ${{ secrets.KAIZTEN_DEVELOPMENT_PASSWORD }}
          # Build and publish Docker image in DockerHub
          - name: Build and push Docker image
            uses: mr-smithers-excellent/docker-build-push@v6
            with:
              image: ${{ env.DOCKER_IMAGE_NAME }}
              tags: latest
              registry: docker.io
              directory: ${{ env.WORKING_DIRECTORY }}
              dockerfile: ${{ env.WORKING_DIRECTORY }}/Dockerfile
              username: ${{ secrets.DOCKERHUB_USERNAME }}
              password: ${{ secrets.DOCKERHUB_PASSWORD }}
    ```

    La [GitHub action](https://github.com/features/actions) creada está destinada a que, cada vez que hagas un cambio en `back-end/` y lo subas al repositorio, se genere la imagen [Docker](https://www.docker.com) correspondiente y se publique en [Docker Hub](https://hub.docker.com). Fíjate que en el archivo hay definida una variable `DOCKER_IMAGE_NAME` que indica el nombre de la imagen [Docker](https://www.docker.com) que se genera con el lanzamiento de la [GitHub action](https://github.com/features/actions). En este punto es importante que sustituyas `<NOMBRE_PROYECTO>` por el nombre de tu proyecto.

3. Antes de pasar a probar la [GitHub action](https://github.com/features/actions), debes modificar el archivo `back-end/pom.xml` añadiendo la sección `<profiles>` que se muestra a continuación:
    ```xml
    <project>
      ...
      <profiles>
        <profile>
          <id>github</id>
          <activation>
            <activeByDefault>true</activeByDefault>
          </activation>
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
      ...
    </project>
    ```
    Esto se hace para que la [GitHub action](https://github.com/features/actions) sea capaz de encontrar el paquete [kaizten-utils](https://github.com/kaizten/kaizten-utils) que estás usando en el back-end.

4. Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `back-end/` y subiéndolos al repositorio. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` de la página de GitHub del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo electrónico indicando el error.

5. Una vez haya finalizado correctamente la ejecución de la [GitHub action](https://github.com/features/actions), comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.

### Dominio

#### Descripción del dominio

Hola, he puesto en el archivo `README.md` de tu repositorio un enlace a un documento donde se encuentra una primera versión del dominio de tu aplicación. Con seguridad, tendremos que hacerle cambios a medida que evolucione tu proyecto, pero sirve como un punto de referencia. En el documento se encuentran las principales entidades (objetos de negocio de tu aplicación) y, para cada una de ellas, se incluye un listado de propiedades que la caracteriza.

**Pasos a realizar:**

1. Revisa con calma el documento de descripción del dominio y plantea cualquier cuestión que consideres al respecto. En particular, analiza si consideras que falta o sobra algo.

#### Entidades

Hola, de acuerdo a la descripción del dominio planteada, tocaría realizar la implementación de las entidades de tu dominio.

**Pasos a realizar:**

1. Lee [este enlace](https://kaizten.github.io/development/ddd/entities) sobre cómo son las entidades en el contexto de [Domain-Driven Design](https://en.wikipedia.org/wiki/Domain-driven_design) para que comprendas cómo son y cuáles son sus utilidades. El enlace contiene además un ejemplo ilustrativo sobre cómo diseñar entidades en Java.
2. Si no está creada previamente, crea junto a la clase principal de tu back-end una carpeta `domain/entity`. 
3. Crea un archivo Java que incluya una clase por cada una de las entidades de tu dominio. 
4. Para cada entidad de tu dominio, pon los atributos indicados en el documento. En este momento, no te preocupes demasiado por los tipos de los atributos de las entidades. En todo caso, debes tener en cuenta que hay tipos como `UUID` (para representar identificadores unívocos) o `LocalDateTime` (para representar instantes de tiempo) que no es necesario que definas porque ya están definidos en el JDK de Java.
5. Para cada entidad de tu dominio, incluye métodos `get` y `set` para cada uno de los atributos.
6. Para cada entidad de tu dominio, sobreescribe el método `toString()` siguiendo el ejemplo del enlace anterior. Este método lo usaremos para poder imprimir por la salida estándar objetos de dichas entidades.
7. Para cada entidad de tu dominio, sobreescribe el método `equals()` siguiendo el ejemplo del enlace anterior. Fíjate que tienes que comprobar si los identificadores de los objetos a comparar son o no iguales.

#### Enumerados

Hola, de acuerdo a la descripción del dominio planteada, tocaría realizar la implementación de los enumerados de tu dominio.

**Pasos a realizar:**

1. Lee [este enlace](https://kaizten.github.io/development/ddd/enumerates) sobre cómo son los enumerados en el contexto de [Domain-Driven Design](https://en.wikipedia.org/wiki/Domain-driven_design) para que comprendas cómo son y cuáles son sus utilidades. El enlace contiene además un ejemplo ilustrativo sobre cómo diseñar enumerados en Java.
2. Si no está creada previamente, crea junto a la clase principal de tu back-end una carpeta `domain/enumerate`. 
3. Crea un archivo Java que incluya un `enum` por cada una de los enumerados de tu dominio. 
4. Para cada enumerado de tu dominio, pon los valores correspondientes de dicho enumerado así como métodos similares a los del código de ejemplo.

#### Objetos valor

Hola, es conveniente que los atributos de las entidades que tienes en el dominio de tu aplicación no sean tipos primitivos sino tipos definitos por ti. Es lo que denominamos *objetos valor*. 

**Pasos a realizar:**

1. Lee [este enlace](https://kaizten.github.io/development/ddd/value-objects) sobre cómo son los objetos valor en el contexto de [Domain-Driven Design](https://en.wikipedia.org/wiki/Domain-driven_design) para que comprendas cómo son y cuáles son sus utilidades. El enlace contiene además un ejemplo ilustrativo sobre cómo diseñar objetos valor en Java.
2. Si no está creada previamente, crea junto a la clase principal de tu back-end una carpeta `domain/valueobject`.
3. Crea un archivo Java que incluya una clase por cada una de los objetos valor de tu dominio. 
4. Para cada objeto valor de tu dominio, pon los atributos indicados en el documento. Estos atributos sí pueden ser tipos básicos como `int`, `String` o `double`, entre otros.
5. Para cada objeto valor de tu dominio, incluye métodos `get` para cada uno de los atributos.
6. Para cada objeto valor de tu dominio, sobreescribe el método `toString()` siguiendo el ejemplo del enlace anterior. Este método lo usaremos para poder imprimir por la salida estándar objetos de dichas objetos valor.
7. Para cada objeto valor de tu dominio, sobreescribe el método `equals()` siguiendo el ejemplo del enlace anterior. Fíjate que tienes que comprobar si los valores de todos los atributos son exactamente iguales en los objetos a comparar.

#### Tests de entidades

Hola, las entidades del dominio deben estar testeadas para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/entity_tests.html) tienes una guía de los tests que debería tener cada entidad de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las entidades y plantea cualquier duda que pueda surgirte.
2. Implementa para cada entidad de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

#### Tests de los enumerados

Hola, los enumerados del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/enumerate_tests.html) tienes una guía de los tests que debería tener cada enumerado de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las enumerados y plantea cualquier duda que pueda surgirte.
2. Implementa para cada enumerado de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

#### Tests de objetos valor

Hola, los objetos de valor del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/value-object_tests.html) tienes una guía de los tests que debería tener cada objeto de valor de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de los objetos de valor y plantea cualquier duda que pueda surgirte.
2. Implementa para cada objeto de valor de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

### Aplicación

#### Casos de uso

Hola, un caso de uso es una descripción detallada de cómo un sistema o aplicación interactúa con sus usuarios o con otros sistemas para cumplir un objetivo específico. Se enfoca en las acciones que realiza el usuario y cómo el sistema responde a esas acciones, proporcionando una visión clara de las funcionalidades necesarias.

**¿Por qué son importantes los casos de uso?**

Los casos de uso son esenciales para definir los requisitos funcionales de un sistema. En la arquitectura hexagonal (o puertos y adaptadores), los casos de uso desempeñan un papel crucial, ya que representan la lógica de negocio independiente de los detalles de implementación externos, como bases de datos o interfaces de usuario. Así, se favorece la separación de responsabilidades y se promueve una arquitectura más mantenible y flexible.

**Ejemplo:**

A continuación, te paso algunos casos de uso para la realización de operaciones tipo CRUD asociadas a una supuesta entidad `Employee`:
```java
// .../application/usecase/CreateEmployeeUseCase.java

public interface CreateEmployeeUseCase {

    Employee create(EmployeeName name, EmployeeAge age);
}
```

```java
// .../application/usecase/ReadEmployeeUseCase.java

public interface ReadEmployeeUseCase {

    Employee fetch(UUID id);

    List<Employee> fetchAll();
}
```

```java
// .../application/usecase/UpdateEmployeeUseCase.java

public interface UpdateEmployeeUseCase {

    Employee update(UUID id, EmployeeName newName, EmployeeAge newAge);
}
```

```java
// .../application/usecase/DeleteEmployeeUseCase.java

public interface DeleteEmployeeUseCase {

    Employee delete(UUID id);
}
```
En este ejemplo, definimos una interfaz por cada operación de tipo CRUD asociada a la entidad `Employee` en un archivo diferente. Dado que cada caso de uso es una interfaz Java, lo único que estamos definiendo es qué va a realizarse y no cómo, dado que esta responsabilidad recae en los servicios de la capa de aplicación.

**Pasos a realizar:**

1. En una implementación siguiendo la arquitectura hexagonal, los casos de uso deberían ubicarse en la carpeta correspondiente a la capa de aplicación. En este caso, si no existe, crea la carpeta `application/usecase`. 
2. Para cada entidad del dominio (`<ENTITY>`), siguiendo el ejemplo anteriormente visto, crea los siguientes casos de uso dentro de la carpeta `application/usecase`:
    * `Create<ENTITY>UseCase.java`
    * `Read<ENTITY>UseCase.java`
    * `Update<ENTITY>UseCase.java`
    * `Delete<ENTITY>UseCase.java`

    Es importante que cada caso de uso sea una interfaz Java y defina al menos un método destinado a aplicar el caso de uso.

#### Servicios

Hola, una vez tengas los casos de uso de la aplicación definidos sería necesario realizar su implementación. Para ello, crea una clase individual por cada caso de uso de la aplicación dentro de la carpeta `application/service`. 

**Ejemplo:**

Te paso un ejemplo básico:
```java
// .../application/service/CreateEmployeeService.java

public class CreateEmployeeService implements CreateEmployeeUseCase {

    @Autowired
    private <ENTITY>Repository repository;

    @Override
    Employee create(EmployeeName name, EmployeeAge age) {
        Employee newEmployee = new Employee(name, age);
        Employee savedEmployee = this.repository.save(newEmployee);
        return savedEmployee;
    }
}
```
Tal como puede verse en el ejemplo, el servicio emplea un repositorio para acceder/persistir los datos de la aplicación. De esta forma, se consigue desacoplar los servicios de la base de datos empleada.

**Pasos a realizar:**

1. En caso de que no exista previamente, crea la carpeta `application/service`.
2. Para cada entidad del dominio (`<ENTITY>`), siguiendo el ejemplo anteriormente visto, crea los siguientes servicios dentro de la carpeta `application/service`:
    * `Create<ENTITY>Service.java`
    * `Read<ENTITY>Service.java`
    * `Update<ENTITY>Service.java`
    * `Delete<ENTITY>Service.java`

    Es importante que cada servicio sea una clase Java que implemente el caso de uso correspondiente.

#### Repositorios

Hola, para que los casos de uso (implementados como servicios) estén desacoplados del lugar donde se almacenan los datos, es necesario crear [repositorios](https://our-academy.org/posts/el-patron-repository:-implementacion-y-buenas-practicas). En este contexto, un repositorio es una abstracción que define un conjunto de métodos para acceder y manipular datos en una base de datos u otro tipo de almacenamiento persistente. 

La idea detrás de utilizar una interfaz de repositorio es separar la lógica de acceso a datos de la lógica de negocio de una aplicación (contenido de la carpeta `application/` del back-end). Esta interfaz define métodos genéricos para realizar operaciones CRUD (Crear, Leer, Actualizar y Borrar) sobre los datos, como por ejemplo: crear, leer, actualizar y eliminar registros.

**Pasos a realizar:**

1. Si no existe previamente, crea la carpeta `application/repository`.
2. Por cada entidad de tu dominio (`<ENTITY>`), crea una interfaz `<ENTITY>Repository.java` dentro de la carpeta `application/repository`. Te paso un extracto básico:
    ```java
    // .../application/repository/<ENTITY>Repository.java

    public interface <ENTITY>Repository {

        public abstract void delete(<ENTITY> entity);

        public abstract List<<ENTITY>> fetchAll();

        public abstract <ENTITY> save(<ENTITY> entity);

        ...
    }
    ```

### Adaptador MongoDB

#### Descripción general

Hola, el adaptador de [MongoDB](https://www.mongodb.com) es el componente de tu back-end encargado de tratar con la base de datos. La siguiente imagen muestra su organización:

![Adaptador MongoDB](https://kaizten.github.io/images/hexagonal-architecture_mongo-adapter.png)

Tal como puede verse en la imagen, está organizado en los siguientes elementos:
* **Implementación de repositorios**. Es la implementación particular de cómo vamos a guardar y recuperar los datos desde la base de datos. Es importante destacar aquí que los repositorios están definidos en la capa de aplicación como interfaces Java, por lo que a nivel de caso de uso no se conoce qué base de datos se va a emplear. Esto permite que fácilmente puedas cambiar de base de datos, haciendo un nuevo adaptador particular o puedas evolucionar éste sin interferir con el resto de la aplicación.
* **Escritores**. Por cada entidad que se vaya a guardar en la base de datos, habrá un escritor que personalizará la forma en que se guarda dicha entidad en la base de datos.
* **Lectores**. Por cada entidad que se vaya a recuperar de la base de datos, habrá un lector que personalizará la forma en que se recupera dicha entidad desde la base de datos.

Teniendo esta estructura para el adaptador de [MongoDB](https://www.mongodb.com) es posible desacoplar la lógica de negocio (definida a través de los casos de uso) de la persistencia de los datos.

#### Implementación de repositorios

Hola, en la aplicación se empleará [MongoDB](https://www.mongodb.com) como sistema gestor de base de datos. Es un sistema de base de datos NoSQL, diseñado para manejar grandes volúmenes de datos de manera flexible y escalable. A diferencia de las bases de datos relacionales, [MongoDB](https://www.mongodb.com) utiliza un modelo de documentos, almacenando los datos en documentos similares a JSON, lo que facilita su manipulación y almacenamiento. 

**Pasos a realizar:**

1. Para poder trabajar con [MongoDB](https://www.mongodb.com) en tu back-end debes modificar el archivo `pom.xml` añadiendo a la sección `<dependencies>` la siguiente dependencia:
    ```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-mongodb</artifactId>
    </dependency>
    ```

2. Crea la carpeta `adapter/mongodb` dentro de tu back-end. En esta carpeta debes incluirse todo lo relacionado con el uso de la base de datos en el back-end. Concretamente, debes añadir la implementación de los repositorios de datos definidos en el back-end. Esto es, hay que implementar cómo realizar las operaciones CRUD (Create, Read, Update y Delete) de las diferentes entidades. 

3. En base a lo anterior, por cada repositorio de la capa de aplicación definido en tu back-end (carpeta `application/repository`) añade una implementación del mismo. A continuación puedes encontrar un pequeño extracto de cómo sería:
    ```java
    import org.springframework.data.mongodb.core.MongoTemplate;

    public class <ENTITY>MongoRepository implements <ENTITY>Repository {

        public static final String COLLECTION_NAME = "<entities>";
        @Autowired
        private MongoTemplate mongoTemplate;

        public List<<ENTITY>> findAll() {
            return this.mongoTemplate.findAll(<ENTITY>.class, COLLECTION_NAME);
        }

        ...
    }
    ```
    En este caso, debes sustituir `<ENTITY>` por el nombre de tu entidad. Al mismo tiempo, en el repositorio está definida `COLLECTION_NAME` para simplemente explicitar el nombre de la colección donde guardar las entidades dentro de [MongoDB](https://www.mongodb.com). En este sentido, también sustituye `<entities>` por el nombre de la entidad en minúscula y plural. Esto último, se debe a que [MongoDB](https://www.mongodb.com) propone que los nombres de las colecciones sean de esta manera. Por ejemplo, si tu entidad es `Employee`, la colección correspondientes debería llamarse `employees`.
    
    Por último, es también importante que te fijes en `mongoTemplate`, se trata del conector con [MongoDB](https://www.mongodb.com) y, por tanto, el elemento a través del cual se realizarán las consultas. Éste es el caso de `findAll`.

#### Configuración

Hola, una vez definidas las implementaciones de los repositorios para [MongoDB](https://www.mongodb.com), es necesario crear beans de éstas para que Spring Boot pueda inyectarlos oportunamente allí donde se necesiten.

**Pasos a realizar:**

1. Si no está creada previamente, crea la carpeta `configuration/` en el código del back-end. 
2. Crea la clase `configuration/MongoConfiguration.java`. A continuación puedes ver un extracto de cómo sería esta clase:
    ```java
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    import org.springframework.data.mongodb.MongoDatabaseFactory;
    import org.springframework.data.mongodb.config.AbstractMongoClientConfiguration;
    import org.springframework.data.mongodb.core.convert.DbRefResolver;
    import org.springframework.data.mongodb.core.convert.DefaultDbRefResolver;
    import org.springframework.data.mongodb.core.convert.DefaultMongoTypeMapper;
    import org.springframework.data.mongodb.core.convert.MappingMongoConverter;
    import org.springframework.data.mongodb.core.convert.MongoCustomConversions;
    import org.springframework.data.mongodb.core.mapping.MongoMappingContext;

    @Configuration
    public class MongoConfiguration extends AbstractMongoClientConfiguration {
        
        @Value("${spring.data.mongodb.uri}")
        private String uri;
        @Value("${spring.data.mongodb.database}")
        private String databaseName;

        @Bean
        public MongoClient mongoClient() {
            ConnectionString connectionString = new ConnectionString(this.uri);
            MongoClientSettings mongoClientSettings = MongoClientSettings.builder()
                    .uuidRepresentation(UuidRepresentation.STANDARD)
                    .applyConnectionString(connectionString)
                    .build();
            return MongoClients.create(mongoClientSettings);
        }

        @Bean
        public MappingMongoConverter mappingMongoConverter(
                MongoDatabaseFactory databaseFactory,
                MongoCustomConversions customConversions,
                MongoMappingContext mappingContext) {
            DbRefResolver dbRefResolver = new DefaultDbRefResolver(mongoDbFactory());
            MappingMongoConverter converter = new MappingMongoConverter(dbRefResolver, mappingContext);
            converter.setTypeMapper(new DefaultMongoTypeMapper(null));
            converter.setCustomConversions(customConversions());
            converter.afterPropertiesSet();
            return converter;
        }

        @Bean
        public MongoCustomConversions customConversions() {
            return new MongoCustomConversions(
                    Arrays.asList());
        }

        @Bean
        public <NAME_OF_REPOSITORY> <NAME_OF_REPOSITORY>() {
            return new <NAME_OF_MONGO_REPOSITORY>();
        }
        ...
    }
    ```
3. En esta clase de configuración se deben crear tantos beans como implementaciones de [MongoDB](https://www.mongodb.com) tengas en tu back-end. Además esta clase define métodos para personalizar conversiones de datos o para poder almacenar `UUID` como identificadores de las entidades del dominio. Éstos son aspectos por los que no hay que preocuparse en este momento. 

4. En `configuration/MongoConfiguration.java` es importante la definición de `uri` y `databaseName`. Son 2 propiedades que se pueden definir en el back-end para indicar dónde encontrar la base de datos y cuál es su nombre. Estas propiedades se definen en el archivo `resources/application.yml` de tu back-end. Si tienes un archivo `resources/application.properties` simplemente cámbiale la extensión para poder trabajar con él siendo un archivo `yaml`. El contenido de este archivo debe ser el siguiente:
    ```yaml
    spring:
      data:
        mongodb:
          uri: mongodb://localhost:27017/db-application # URI of MongoDB
          database: db-application # Database name 
    ```
    Tal como puede verse, se está definiendo la ubicación y nombre de la base de datos. De esta forma, si la base de datos estuviera en otro lugar que no fuera la misma máquina (`localhost`) o estuviera en disponible en otro puerto (actualmente `27017`), simplemente con cambiar este archivo o sobreescribir la propiedad en cuestión al arrancar el back-end sería suficiente.

#### Escritores

Hola, en aplicaciones que utilizan [MongoDB](https://www.mongodb.com) como base de datos y Spring Data como framework de persistencia, es habitual que surja la necesidad de guardar las entidades del dominio de una manera personalizada. Para ello, se utiliza la interfaz `org.springframework.core.convert.converter.Converter` junto con la anotación `@WritingConverter`. Esta combinación permite definir cómo se deben transformar las entidades del dominio antes de almacenarlas en la base de datos. 

**Ejemplo:**

A continuación puedes encontrar un ejemplo de un conversor:
```java
@WritingConverter
public class TrapWritingConverter implements Converter<Trap, Document> {

    private static final Logger logger = LoggerFactory.getLogger(TrapWritingConverter.class);
    private MongoConfiguration mongoConfiguration;

    public TrapWritingConverter(MongoConfiguration mongoConfiguration) {
        this.mongoConfiguration = mongoConfiguration;
    }

    @Override
    public Document convert(Trap trap) {
        logger.info("Trap with id '{}' to be written", trap.getId());
        Document document = new Document();
        // Required attributes:
        document.put(MongoFields.ID, trap.getId());
        document.put(MongoFields.NAME, trap.getName().getValue());
        document.put(MongoFields.TYPE, trap.getType().toString());
        document.put(MongoFields.ENTRY_POINT, trap.getEntryPoint().getId());
        Document geolocationDocument = new Document();
        geolocationDocument.put(MongoFields.LONGITUDE, trap.getGeolocation().getLongitude());
        geolocationDocument.put(MongoFields.LATITUDE, trap.getGeolocation().getLatitude());
        document.put(MongoFields.GEOLOCATION, geolocationDocument);
        document.put(MongoFields.CREATOR, trap.getCreator().getValue());
        // Optional attributes:
        trap.getDescription().ifPresent((description) -> document.put(MongoFields.DESCRIPTION, description.toString()));
        trap.getContactInformation().ifPresent((contactInformation) -> document.put(MongoFields.CONTACT_INFORMATION, contactInformation.toString()));
        if (trap.hasComments()) {
            MongoWritingUtils.toDocument(document, trap.getComments().get());
        }
        trap.getImages().ifPresent((images) -> {
            final List<UUID> uuids = new ArrayList<>(images.size());
            for (File image : images) {
                this.mongoConfiguration.fileRepository().saveFile(image);
                uuids.add(image.getId());
            }
            document.put(MongoFields.IMAGES, uuids);
        });
        trap.getInstallationDate().ifPresent((date) -> document.put(MongoFields.INSTALLATION_DATE, date));
        trap.getLeavingDate().ifPresent((date) -> document.put(MongoFields.LEAVING_DATE, date));
        return document;
    }
}
```
Es importante que te fijes en que `Converter` está definido para transformar objetos de la clase `Trap` en `Document` (documentos de [MongoDB](https://www.mongodb.com)). El método `convert` se encarga de especificar cómo se desea que se transforme el objeto de la clase `Trap` en un documento de [MongoDB](https://www.mongodb.com). Debes fijarte en particular en cómo se guarda el atributo `entryPoint` del objeto de tipo `Trap`. En este caso, en lugar de guardar el atributo directamente, lo cual provocaría que se guardara de forma anidada en el documento, se guarda únicamente su identificador. Cabe señalar que en el conversor se está empleando `MongoFields`. Se trata de una clase de la siguiente manera:
```java
public class MongoFields {

    public static final String ANALYZES = "analyzes";
    public static final String AREAS = "areas";
    public static final String BOX = "box";
    public static final String BYTES = "bytes";
    public static final String ID = "_id";
    ...
}
```

Como puede verse, utilizar un `@WritingConverter` es especialmente útil cuando las entidades del dominio contienen estructuras complejas o tipos de datos que no son compatibles de forma directa con el esquema de almacenamiento de MongoDB. Éste último caso es el que nos encontramos con los objetos de valor del dominio. En definitiva, se permite así realizar conversiones específicas que garanticen la integridad y precisión de los datos.

**Pasos a realizar:**

1. Escribe una clase llamada `<ENTITY>WritingConverter.java` anotada como `@WritingConverter` para cada entidad del dominio de la aplicación dentro de la carpeta `adapter/mongodb/writter`. De este modo, se asegurará que cada entidad tiene un proceso de conversión único y bien definido.
2. Escribe una clase `adapter/mongodb/MongoFields.java` donde definas el conjunto de campos de los documentos a crear por los conversores.
3. Añade el siguiente método a `configuration/MongoConfiguration.java`:
    ```java
    @Bean
    public MongoCustomConversions customConversions() {
        return new MongoCustomConversions(
                Arrays.asList(
                        ...
                        new TrapWritingConverter(this),
                        ...));
    }
    ```
    para registrar cada uno de los conversores que escribiste previamente.
4. Prueba cómo funciona la escritura de las entidades. Guarda alguna entidad en la base de datos y accede a [MongoDB](https://www.mongodb.com) para revisar cómo se ha persistido.

#### Lectores

Hola, en aplicaciones que utilizan [MongoDB](https://www.mongodb.com) como base de datos y Spring Data como framework de persistencia, es habitual que surja la necesidad de leer las entidades del dominio de una manera personalizada. Para ello, se utiliza la interfaz `org.springframework.core.convert.converter.Converter` junto con la anotación `@ReadingConverter`. Esta combinación permite definir cómo se deben transformar los documentos almacenados en la base de datos a entidades del dominio.

**Ejemplo:**

A continuación puedes encontrar un ejemplo de un conversor:
```java
@ReadingConverter
public class TrapReadingConverter implements Converter<Document, Trap> {

    private static final Logger logger = LoggerFactory.getLogger(TrapReadingConverter.class);
    private MongoConfiguration mongoConfiguration;

    public TrapReadingConverter(MongoConfiguration mongoConfiguration) {
        this.mongoConfiguration = mongoConfiguration;
    }

    @Override
    public Trap convert(Document document) {
        logger.error("Trap to read from document '{}'", document);
        // Required attributes:
        UUID id = (UUID) document.get(MongoFields.ID);
        TrapName name = TrapName.fromString(document.getString(MongoFields.NAME));
        TrapType type = TrapType.fromString(document.getString(MongoFields.TYPE));
        EntryPoint entryPoint = null;
        UUID entryPointId = (UUID) document.get(MongoFields.ENTRY_POINT);
        Optional<EntryPoint> optionalEntryPoint = this.mongoConfiguration.entryPointRepository()
                .fetchEntryPointById(entryPointId);
        if (optionalEntryPoint.isPresent()) {
            entryPoint = optionalEntryPoint.get();
        }
        Document geolocationDocument = (Document) document.get(MongoFields.GEOLOCATION);
        double longitude = geolocationDocument.getDouble(MongoFields.LONGITUDE);
        double latitude = geolocationDocument.getDouble(MongoFields.LATITUDE);
        KaiztenGeolocationPoint geolocation = new KaiztenGeolocationPoint(longitude, latitude);
        KaiztenJWTPreferredUsername creator = KaiztenJWTPreferredUsername.fromString(document.getString(MongoFields.CREATOR));
        Trap trap = new Trap(id, name, type, entryPoint, geolocation, creator);
        // Optional attributes:
        if (document.containsKey(MongoFields.CONTACT_INFORMATION)) {
            ContactInformation contactInformation = ContactInformation.fromString(document.getString(MongoFields.CONTACT_INFORMATION));
            trap.setContactInformation(contactInformation);
        }
        if (document.containsKey(MongoFields.DESCRIPTION)) {
            TrapDescription description = TrapDescription.fromString(document.getString(MongoFields.DESCRIPTION));
            trap.setDescription(description);
        }
        if (document.containsKey(MongoFields.COMMENTS)) {
            List<Comment> comments = MongoReadingUtils.parseComments(document);
            trap.addComments(comments);
        }
        if (document.containsKey(MongoFields.IMAGES)) {
            List<UUID> imageIds = document.getList(MongoFields.IMAGES, UUID.class);
            for (UUID imageId : imageIds) {
                this.mongoConfiguration.fileRepository()
                        .fetchFileById(imageId).ifPresent((image) -> {
                            trap.addImage(image);
                        });
            }
        }
        if (document.containsKey(MongoFields.INSTALLATION_DATE)) {
            LocalDate installationDate = KaiztenLocalDate.toLocalDate(document.getDate(MongoFields.INSTALLATION_DATE));
            trap.setInstallationDate(installationDate);
        }
        if (document.containsKey(MongoFields.LEAVING_DATE)) {
            LocalDate leavingDate = KaiztenLocalDate.toLocalDate(document.getDate(MongoFields.LEAVING_DATE));
            trap.setLeavingDate(leavingDate);
        }
        return trap;
    }
}
```

Es importante que te fijes en que `Converter` está definido para transformar objetos de tipo `Document` (documentos de [MongoDB](https://www.mongodb.com)) en objetos de la clase `Trap`. El método `convert` se encarga de especificar cómo se desea que el documento de MongoDB se transforme en un objeto de la clase `Trap`. Debes fijarte en particular en cómo se lee el atributo `entryPoint` del documento, ya que se recupera a partir de su identificador.

Cabe señalar que en el conversor se está empleando `MongoFields`. Se trata de una clase de la siguiente manera:
```java
public class MongoFields {

    public static final String ANALYZES = "analyzes";
    public static final String AREAS = "areas";
    public static final String BOX = "box";
    public static final String BYTES = "bytes";
    ...
}
```
Como puede verse, utilizar un `@ReadingConverter` es especialmente útil cuando los documentos almacenados contienen estructuras complejas o tipos de datos que no se pueden mapear directamente con las entidades del dominio. Esto permite realizar conversiones específicas que garantizan la integridad y precisión de los datos al ser leídos.

**Pasos a realizar:**

1. Escribe una clase llamada `<ENTITY>ReadingConverter.java` anotada como `@ReadingConverter` para cada entidad del dominio de la aplicación dentro de la carpeta `adapter/mongodb/reader`. De este modo, se asegurará que cada entidad tiene un proceso de lectura único y bien definido.
2. Escribe una clase `adapter/mongodb/MongoFields.java` donde definas el conjunto de campos de los documentos a leer por los conversores.
Añade el siguiente método a `configuration/MongoConfiguration.java`:
    ```java
    @Bean
    public MongoCustomConversions customConversions() {
        return new MongoCustomConversions(
                    Arrays.asList(
                            ...
                            new TrapReadingConverter(this),
                            ...));
    }
    ```
    para registrar cada uno de los conversores que escribiste previamente.

3. Prueba cómo funciona la lectura de las entidades. Recupera alguna entidad de la base de datos y verifica que todos los campos se mapean correctamente desde los documentos en [MongoDB](https://www.mongodb.com).

### Adaptador REST

#### Controladores

Hola, una [API REST](https://www.moesif.com/blog/technical/api-development/Rest-API-Tutorial-A-Complete-Beginners-Guide/) sirve como interfaz para que sistemas o aplicaciones se comuniquen y compartan datos de manera uniforme a través de la web mediante un conjunto de reglas y convenciones. El objetivo de este issue es implementar un adaptador REST en el back-end de la aplicación, permitiendo la exposición de endpoints que proporcionen funcionalidades específicas a los clientes a través de una interfaz RESTful.

**Pasos a realizar:**

1. Para poder crear una API REST en la aplicación debes añadir la siguiente dependencia al archivo `pom.xml` de tu back-end:
    ```xml
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    ```

2. Una vez añadida la dependencia, crea la carpeta `adapter/rest` dentro de tu código. En esta carpeta debes incluirse todo lo relacionado con el uso de la API REST en el back-end. Dentro de esta carpeta hay que definir los controladores. Un controlador REST es una clase dentro de una aplicación web que maneja las solicitudes HTTP entrantes, define y mapea endpoints (URLs) y proporciona respuestas adecuadas a esas solicitudes mediante el uso de métodos anotados con operaciones HTTP como `GET`, `POST`, `PUT`, `DELETE`, entre otros, siguiendo los principios de la arquitectura RESTful. Con este objetivo en mente, sería necesario crear la carpeta `adapter/rest/controller` e incluir en ella un controlador por cada una de las entidades de tu dominio. A continuación se muestra un extracto de un controlador:
    ```java
    @RestController
    @RequestMapping("/<entities>")
    public class <ENTITY>Controller {

        @Autowired
        private <NAME_OF_USE_CASE> <nameOfUseCase>;

        @GetMapping("/")
        public ResponseEntity<List<ENTITY>> getEntities() {
            List<ENTITY> entities = this.<nameOfUseCase>.fetchAll();
            return new ResponseEntity<>(entities, HttpStatus.OK);
        }

        // Other methods to manage entities
    }
    ```
    Tal como puede comprobarse, el controlador previo es capaz de manejar peticiones de tipo `GET` (véase la notación `GetMapping`) y emplea el caso de uso correspondiente para atender a las peticiones recibidas. Es importante aquí sustituir `<ENTITY>` por la entidad en cuestión y además sustituir `<entities>` por el nombre de las entidades en plural.

3. Una vez creado los controladores necesarios, la API REST puede probarse, entre otras, mediante la herramienta [curl](https://curl.se) o el plugin [Thunder client](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client) de [Visual Studio Code](https://code.visualstudio.com).

4. En base a lo anteriormente descrito, añade al back-end el controlador REST para manipular las peticiones recibidas por parte de los clientes.

#### Peticiones

Hola, los clientes que empleen el API REST definida en el back-end deberían emplear objetos de clases diferentes a las entidades del dominio para evitar el acoplamiento así como facilitar la validación de datos. Por ello, dentro del controlador `adapter/rest` crea una carpeta `request` donde añadir [data transfer objects](https://www.baeldung.com/java-dto-pattern) que representen los cuerpos de las peticiones REST a realizar.

**Pasos a realizar:**

1. Dentro de la carpeta creada, debes crear una clase `<ENTITY>PostRequestBody.java` y otra `<ENTITY>PutRequestBody.java` por cada entidad de tu dominio `<ENTITY>`. A continuación te paso un ejemplo ilustrativo para una entidad `Trap.java`:
    ```java
    public class TrapPostRequestBody {

        private TrapName name;
        private TrapDescription description;

        public void setName(TrapName name) {
            this.name = name;
        }

        public void setDescription(TrapDescription description) {
            this.description = description;
        }

        public Trap toTrap() {
            Trap trap = new Trap(this.name);
            trap.setDescription(this.description);
            return trap;
        }

        public String toString() {
            return String.format("TrapPostRequestBody={name=%s, description=%s}", 
                    this.name, this.description);
        }
    }
    ```
    Fíjate en la implementación del método estático que tiene la clase anterior. Está diseñado para convertir el DTO correspondiente en entidad.

2. Una vez creados los DTO, debes eliminar las entidades en los **parámetros de los controladores** creados en el adaptador. Esto significa que los controladores deben recibir DTO en lugar de entidades del dominio.

#### Respuestas

Hola, las respuestas proporcionadas por los controladores deben ser [data transfer objects](https://www.baeldung.com/java-dto-pattern) para evitar acoplamiento entre el adaptador REST y el dominio de la aplicación.

**Pasos a realizar:**

1. Dentro de la carpeta creada, debes crear una clase `<ENTITY>ResponseBody.java` por cada entidad de tu dominio `<ENTITY>`. A continuación te paso un ejemplo ilustrativo para una entidad `Trap.java`:
2. 
    ```java
    public class TrapResponseBody {

        private UUID id;
        private TrapName name;
        private TrapDescription description;

        public void setId(UUID id) {
            this.id = id;
        }

        public void setName(TrapName name) {
            this.name = name;
        }

        public void setDescription(TrapDescription description) {
            this.description = description;
        }

        public static TrapResponseBody from(Trap trap) {
            TrapResponseBody responseBody = new TrapResponseBody();
            responseBody.id = trap.getId();
            responseBody.name = trap.getName();
            trap.getDescription().ifPresent((description) -> {
                responseBody.description = description;
            });
            return responseBody;
        }

        public String toString() {
            return String.format("TrapResponseBody={id=%s, name=%s, description=%s}", +
                    this.id, this.name, this.description);
        }
    }
    ```
    Fíjate en la implementación del estático que tiene la clase anterior. Está diseñados para convertir la entidad en DTO.

3. Una vez creados los DTO, debes eliminar las entidades en los **valores de retorno** de los controladores creados en el adaptador. Esto significa que los controladores deben devolver DTO en lugar de entidades del dominio.

#### Deserializadores

Hola, cuando el usuario realiza una petición de tipo `POST` o `PUT`, el cuerpo de esta petición es un DTO previamente definido. Sin embargo, es necesario definir un deserializador que convierta el cuerpo de una petición `POST` o `PUT` en un DTO.

**Pasos a realizar:**

1. Crea una carpeta `adapter/rest/deserialization`. 
2. Dentro de la carpeta `adapter/rest/deserialization`, crea un deserializador por cada DTO de petición definido en la carpeta `adapter/rest/request`. A continuación tienes un ejemplo:
    ```java
    public class TrapPostRequestBodyDeserializer extends KaiztenJsonDeserializer<TrapPostRequestBody> {

        private static final Logger logger = LoggerFactory.getLogger(TrapPostRequestBodyDeserializer.class);

        @Override
        protected TrapPostRequestBody parse(JsonNode trapNode) {
            // Required attributes:
            final TrapName name = super.getRequiredAttribute(JsonFields.NAME, TrapName.class);
            final TrapDescription description = super.getOptionalAttribute(JsonFields.DESCRIPTION, TrapDescription.class);
            TrapPostRequestBody requestBody = new TrapPostRequestBody();
            requestBody.setName(name);
            requestBody.setDescription(description);
            return requestBody;
        }

        @Override
        protected Optional<List<ApiSubError>> validate(JsonNode trap) {
            List<ApiSubError> errors = new ArrayList<>();
            errors.addAll(this.validateName(trap));
            errors.addAll(this.validateDescription(trap));
            return (errors.isEmpty()) ? Optional.empty() : Optional.of(errors);
        }

        public List<ApiSubError> validateName(JsonNode inputJson) {
          final String fieldName = JsonFields.NAME;
          return KaiztenJsonValidator
                .validateRequiredString(inputJson, fieldName)
                .fold(
                        (ApiSubError error) -> List.of(error),
                        (String value) -> {
                            final List<ApiSubError> errors = new ArrayList<>();
                            TrapName obtainedObject = null;
                            try {
                                obtainedObject = new TrapName(value);
                            } catch (Exception exception) {
                                errors.add(ApiSubErrorMessageRejectedValueField.of(exception, value, fieldName));
                            }
                            super.addRequiredAttribute(fieldName, obtainedObject);
                            return errors;
                        });
        }

        public List<ApiSubError> validateDescription(JsonNode inputJson) {
            final String fieldName = JsonFields.DESCRIPTION;
            return KaiztenJsonValidator
                    .validateOptionalString(inputJson, fieldName)
                    .fold(
                            (ApiSubError error) -> List.of(error),
                            (String value) -> {
                                final List<ApiSubError> errors = new ArrayList<>();
                                TrapDescription obtainedObject = null;
                                if (value != null) {
                                    try {
                                        obtainedObject = new TrapDescription(value);
                                    } catch (Exception exception) {
                                        errors.add(ApiSubErrorMessageRejectedValueField.of(exception, value, fieldName));
                                    }
                                }
                                super.addOptionalAttribute(fieldName, obtainedObject);
                                return errors;
                            });
        }
    }
    ```

    En este caso, el método `validate` está destinado a validar cada uno de los campos del JSON de la petición correspondiente. Esto se hace mediante un método independiente para cada atributo (`validateName` y `validateDescription`). Cabe señalar que en `validateName` se comprueba el campo como cadena de texto requerida. Por su parte, `validateDescription` comprueba el campo como cadena de texto opcional. Por último, el método `parse` está dedicado a construir un objeto de la petición correspondiente a partir de los datos ya validados.

#### Serializadores

Hola, cuando el usuario realiza una petición de tipo, espera obtener una respuesta. Estas respuestas ya están modeladas en `adapter/rest/response`. Sin embargo, hay que convertirlas en formato JSON. Por este motivo, es necesario crear un serializador por cada posible tipo de respuesta a devolver por los controladores.

**Pasos a realizar:**

1. Crea un serializador por cada DTO de respuesta dentro de `adapter/rest/serialization`. A continuación tienes un ejemplo:
    ```java
    public class TrapResponseBodySerializer extends StdSerializer<TrapResponseBody> {

        private static final Logger logger = LoggerFactory.getLogger(TrapResponseBodySerializer.class);

        public TrapResponseBodySerializer() {
            this(null);
        }

        public TrapResponseBodySerializer(Class<TrapResponseBody> t) {
            super(t);
        }

        @Override
        public void serialize(TrapResponseBody entity, JsonGenerator generator, SerializerProvider provider) throws IOException {
            generator.writeStartObject();
            // Required attributes:
            generator.writeStringField(JsonFields.ID, entity.getId().toString());
            generator.writeStringField(JsonFields.NAME, entity.getName().getValue().toString());
            // Optional attributes:
            if (entity.hasDescription()) {
                generator.writeStringField(JsonFields.DESCRIPTION, entity.getDescription().get().getValue());
            }
            generator.writeEndObject();
        }
    }
    ```

#### Configuración

Hola, vamos a crear un archivo de configuración del adaptador REST. 

**Pasos a realizar:**

1. Crea `configuration/RestConfiguration.java` con el siguiente contenido:
    ```java
    @Configuration
    public class RestConfiguration {

        @Bean
        public Module dynamoDemoEntityDeserializer() {
            SimpleModule module = new SimpleModule();
            module.addDeserializer(
                    TrapPostRequestBody.class,
                    new TrapPostRequestBodyDeserializer(this.fetchEntryPointUseCase));
            module.addDeserializer(
                    TrapPutRequestBody.class,
                    new TrapPutRequestBodyDeserializer(this.fetchEntryPointUseCase));
            module.addSerializer(
                    TrapResponseBody.class,
                    new TrapResponseBodySerializer());
            // Remaining serializers and deserializers
            return module;
        }

        @Bean
        public ResponseEntityExceptionHandler responseEntityExceptionHandler() {
            return new KaiztenExceptionHandler();
        }

        @Bean
        public FilterConditionBuilder filterConditionBuilder() {
            return new FilterConditionBuilder();
        }

        @Bean
        public JwtAuthConverter jwtAuthConverter() {
            return new JwtAuthConverter();
        }
    }
    ```
    Tal como puedes comprobar, `RestConfiguration.java` define qué deserializador va a encargarse de convertir el cuerpo de la petición enviada en el DTO correspondiente. Hace lo propio con los serializadores. Por tanto, debes registrar cada serializador y deserializador que tengas definido en `adapter/rest/serialization`.

    Por último, `RestConfiguration.java` crea un objeto `ResponseEntityExceptionHandler` que ayuda a homogeneizar las respuestas de error que pueda emitir el back-end, así como crea los objetos `FilterConditionBuilder` y `JwtAuthConverter` que permiten gestionar filtros en las peticiones y JSON Web Token para securizar las mismas.

#### Documentación

Hola, [OpenAPI](https://www.openapis.org) es una especificación de API que describe cómo interactuar con una API RESTful (Representational State Transfer) de forma programática. Te paso un artículo sobre cómo funciona OpenAPI con Spring: https://www.baeldung.com/spring-rest-openapi-documentation Como se describe en el artículo, se puede emplear una librería que genera documentación en formato yaml de una API REST.

**Pasos a realizar:**

1. Para poder emplear OpenAPI 3.0, tendrías que añadir la dependencia correspondiente en el archivo `pom.xml` de tu back-end. Revisa el artículo anterior para esto. Una vez levantada la API, si accedes a `http://localhost:8181/v3/api-docs/` deberías ver la documentación en formato JSON. Si accedes a `http://localhost:8181/swagger-ui/index.html` debes poder ver la documentación de la API mediante `Swagger`.

2. Habría que añadir a los endpoints la documentación de los mismos para que apareciera mediante esta herramienta. De esta manera podríamos publicar luego la documentación y que nosotros mismos puedan consultarla libremente.

### Operaciones bulk

Este issue detalla el trabajo necesario para implementar operaciones bulk en la API REST, aprovechando una arquitectura hexagonal. Las operaciones bulk permiten realizar acciones sobre múltiples recursos en una sola solicitud, optimizando el rendimiento de la red al reducir el número de solicitudes HTTP y la sobrecarga de comunicación. Sin embargo, su implementación requiere modificaciones en distintas capas y adaptadores de la arquitectura hexagonal para garantizar la integración sin comprometer la consistencia y la modularidad del sistema.

**Objetivo:**
Agregar soporte a la API para operaciones bulk en recursos específicos, permitiendo, por ejemplo, realizar inserciones, actualizaciones o eliminaciones de múltiples instancias de un mismo recurso en una sola solicitud. Esto optimizará la comunicación y mejorará el rendimiento en operaciones de gran volumen.

**Ejemplos:**

A continuación se muestran algunos ejemplos de solicitudes y respuestas para `Trap` con el objetivo de esclarecer los esperado de este issue.

**Bulk Retrieve (GET /traps/bulk):**

En este caso, la respuesta devuelve un array de objetos `Trap` correspondientes a los IDs solicitados, permitiendo al cliente acceder a los detalles de cada trampa.

Solicitud:

```http
GET /traps/bulk?ids=101,102,103 HTTP/1.1
Host: api.trapservice.com
Accept: application/json
```

Respuesta Ejemplo:

```json
[
    {
        "id": 101,
        "name": "T01",
        "type": "OVITRAP",
        ...
    },
    {
        "id": 102,
        "name": "T02",
        "type": "OVITRAP",
        ...
    },
    {
        "id": 103,
        "name": "T03",
        "type": "OVITRAP",
        ...
    }
]
```

**Bulk Create (POST /traps/bulk):**

En esta respuesta, cada `Trap` enviada en la solicitud es confirmada como creada, devolviendo un `id` único asignado y un `status` que indica el resultado de la operación para cada trampa.

Solicitud:

```http
POST /traps/bulk HTTP/1.1
Host: api.trapservice.com
Content-Type: application/json
Accept: application/json

[
    {
        "name": "T04",
        "type": "OVITRAP",
        ...
    },
    {
        "name": "T05",
        "type": "OVITRAP",
        ...
    },
    {
        "name": "T06",
        "type": "OVITRAP",
        ...
    }
]
```

Respuesta Ejemplo:

```json
[
    {
        "id": 201,
        "name": "T04",
        "type": "OVITRAP",
        "status": "created",
        ...
    },
    {
        "id": 202,
        "name": "T05",
        "type": "OVITRAP",
        "status": "created",
        ...
    },
    {
        "id": 203,
        "name": "T06",
        "type": "OVITRAP",
        "status": "created",
        ...
    }
]
```

**Pasos a realizar:**

1. Capa de Aplicación (Casos de uso)
   - Crear los casos de uso y servicios para gestionar operaciones bulk específicas como por ejemplo, `BulkRetrieveTraps` y `BulkCreateTraps` en recursos específicos como `Trap`
   - Encapsular la lógica de cada operación en métodos individuales dentro de los casos de uso y servicios, gestionando las siguientes tareas:
2. Adaptador de Entrada HTTP (`src/adapter/http`)
   - Extender endpoints: Crear o modificar endpoints en el adaptador HTTP para procesar solicitudes bulk de recursos específicos. Por ejemplo: `GET /traps/bulk` para recuperar múltiples trampas, o `POST /traps/bulk` para crear múltiples trampas.
   - Deserialización de solicitudes: Asegurarse de que el adaptador HTTP pueda deserializar el cuerpo JSON de las solicitudes bulk en una lista de operaciones individuales, delegándolas a los casos de uso adecuados.
   - Gestión de errores y respuestas: Configurar el adaptador para devolver respuestas detalladas, con la posibilidad de usar el código `HTTP 200 OK`.
3. Adaptador de Persistencia (repositorio)
   - Implementación de operaciones para múltiples recursos: Modificar los repositorios para soportar la inserción, actualización o borrado de múltiples recursos.

### Configuración

#### Aplicación

Hola, una vez definidos e implementados los casos de uso de la aplicación, es necesario crear objetos de éstos (servicios). En el caso, en [Spring Boot](https://spring.io/projects/spring-boot) se emplean [beans](https://www.baeldung.com/spring-bean). Esto es, objetos que son gestionados por el propio framework con el objetivo de realizar [inversión de control](https://www.baeldung.com/inversion-control-and-dependency-injection-in-spring).

**Pasos a realizar:**

1. En base a lo anterior, para poder tener accesible cada uno de los casos de uso (servicios) de la aplicación, es necesario crear los beans correspondientes. Con este objetivo en mente, si no está creada previamente, crea la carpeta `configuration/` en el código del back-end. Añade a esta carpeta la clase `ApplicationConfiguration`. A continuación puedes ver un extracto de cómo sería esta clase:
    ```java
    ...
    import org.springframework.context.annotation.Configuration;

    @Configuration
    public class ApplicationConfiguration {

        @Bean
        public <NAME_OF_USE_CASE> <NAME_OF_USE_CASE>() {
            return new <NAME_OF_SERVICE>();
        }
        ...
    }
    ```

2. En este caso, debes crear un método que instancie (a través del operador `new`) un servicio de los que tengas definidos en tu aplicación, implementando de esta forma el caso de uso en cuestión. Este método debe estar anotado con `@Bean` para indicarle a [Spring Boot](https://spring.io/projects/spring-boot) que se trata de un bean. Por tanto, debes crear tantos beans como servicios tengas en tu aplicación. Por último, fíjate que la clase debe estar anotada con `@Configuration` para indicar que en ella se encuentra la definición de beans.

### SonarQube

SonarQube es una herramienta de código abierto utilizada para la inspección continua de la calidad del código. Permite identificar errores, vulnerabilidades y "code smells" (malas prácticas de codificación), mejorando así la calidad del software. Es compatible con muchos lenguajes de programación y facilita el análisis de proyectos al integrarse con entornos de desarrollo y CI/CD.

**Pasos a realizar:**

1. **Descargar la imagen de SonarQube**. Utiliza Docker para descargar la imagen oficial de SonarQube ejecutando el siguiente comando:
     ```shell
     docker pull sonarqube
     ```

1. **Ejecutar el contenedor de SonarQube**. Para ejecutar SonarQube, utiliza el siguiente comando para iniciar el contenedor:
     ```shell
     docker run -d --name sonarqube -p 9000:9000 sonarqube
     ```
    Este comando hará que SonarQube se ejecute en segundo plano (`-d`), asignando el puerto 9000 de tu máquina local al puerto 9000 del contenedor.

1. **Acceder a SonarQube**. Una vez que el contenedor esté en ejecución, puedes acceder a la interfaz web de SonarQube desde tu navegador entrando a la URL:
     ```shell
     http://localhost:9000
     ```
    Por defecto, las credenciales para acceder son:
     - **Usuario:** `admin`
     - **Contraseña:** `admin`

1. **Configurar y analizar el back-end**. Una vez dentro, puedes seguir el asistente para crear un proyecto y generar un token para analizar el código del back-end.
1. **Guardar proyecto**. Crea la carpeta `back-end/sonarqube` y guarda el proyecto creado para poder ejecutarlo de nuevo.
1. Comenta este issue añadiendo una imagen de los resultados obtenidos mediante SonarQube en el análisis del código.

### Websocket
Construir un servidor WebSocket en Spring Boot que genere operaciones matemáticas aleatorias y las envíe periódicamente a todos los clientes conectados. Las operaciones pueden incluir suma (+), resta (-), multiplicación (*) y división (/) con números enteros y se enviarán en intervalos regulares.

**Pasos a realizar:**
1. **Generar manualmente el proyecto con maven**, usa el siguiente comando en tu terminal:

```
mvn archetype:generate -DgroupId=com.example.websocket \
    -DartifactId=websocket-project \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false
```

Esto creará una carpeta llamada websocket-demo. Accede a ella con:

`cd websocket-demo`

Luego, edita el archivo pom.xml para agregar las dependencias necesarias.

2. **Agrega las dependencias necesarias al pom.xml**. Abre el archivo pom.xml y asegúrate de incluir estas dependencias:
   
```xml
<dependencies>
    <!-- Dependencia para WebSockets en Spring Boot -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-websocket</artifactId>
    </dependency>

    <!-- Dependencia para el servidor web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <!-- Dependencia para pruebas -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```
Después, compila e instala las dependencias con:

`mvn clean install`

3. **Configurar WebSockets en Spring Boot**. Crea la siguiente clase para configurar WebSockets.

`src/main/java/com/example/websocket/WebSocketConfig.java

```java
package com.example.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new MathWebSocketHandler(), "/math").setAllowedOrigins("*");
    }
}
```

4. **Implementar el WebSocketHandler**. Ahora, crea la lógica del servidor WebSocket que enviará operaciones matemáticas.

`src/main/java/com/example/websocket/MathWebSocketHandler.java`

```java
package com.example.websocket;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.Random;

public class MathWebSocketHandler extends TextWebSocketHandler {
    private static final Set<WebSocketSession> sessions = new CopyOnWriteArraySet<>();
    private static final Random random = new Random();
    private static final String[] OPERATORS = {"+", "-", "*", "/"};

    // Servicio que envía operaciones matemáticas periódicamente
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    static {
        scheduler.scheduleAtFixedRate(MathWebSocketHandler::sendMathOperationToClients, 0, 5, TimeUnit.SECONDS);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        sessions.add(session);
        System.out.println("Cliente conectado: " + session.getId());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) {
        sessions.remove(session);
        System.out.println("Cliente desconectado: " + session.getId());
    }

    private static void sendMathOperationToClients() {
        String operation = generateMathOperation();
        for (WebSocketSession session : sessions) {
            try {
                session.sendMessage(new TextMessage(operation));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static String generateMathOperation() {
        int num1 = random.nextInt(100) + 1;
        int num2 = random.nextInt(100) + 1;
        String operator = OPERATORS[random.nextInt(OPERATORS.length)];

        if (operator.equals("/") && num2 == 0) {
            num2 = 1; // Evitar divisiones por 0
        }

        return num1 + " " + operator + " " + num2;
    }
}
```

5. **Crear la clase principal**. En Spring Boot, necesitamos una clase con @SpringBootApplication para ejecutar el servidor.

`src/main/java/com/example/websocket/WebSocketApplication.java`

```java
package com.example.websocket;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class WebSocketApplication {
    public static void main(String[] args) {
        SpringApplication.run(WebSocketApplication.class, args);
    }
}
```

6. **Ejecutar el Servidor**. Ahora, ejecuta el servidor con:

`mvn spring-boot:run`

Verás un mensaje como:

`INFO  [main] SpringApplication: Started WebSocketApplication in 2.34 seconds`

7. **Probar con un Cliente WebSocket**. Para probarlo, puedes usar la consola del navegador. Abre las herramientas de desarrollo (F12 en Chrome o Edge) y en la pestaña Console, ejecuta:

```javascript
let socket = new WebSocket("ws://localhost:8080/math");

socket.onmessage = function(event) {
    console.log("Operación recibida:", event.data);
};

socket.onopen = function() {
    console.log("Conectado al WebSocket");
};
```
Esto mostrará operaciones matemáticas cada 5 segundos.


## Front-end

### Primeros pasos

Hola, dentro del repositorio habría que crear un front-end para la aplicación bajo desarrollo. En este caso, vamos a usar [Vite](https://vitejs.dev) como empaquetador, [Vue.js](https://vuejs.org) y [TypeScript](https://www.typescriptlang.org) como lenguaje de programación. 

**Pasos a realizar:**

1. Ejecuta lo siguiente:
    ```shell
    $ yarn create vite
    ```
    Es importante que establezcas los siguientes datos cuando crees el proyecto:
    * `Project name`: `front-end`
    * `Select a framework`: `Vue`
    * `Select a variant`: `TypeScript`

2. Una vez creado el proyecto, ejecuta lo siguiente para poder desplegar tu front-end en local:
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

3. Comprueba que puedes acceder a la URL `http://localhost:5173/` (o a la indicada por [Vite](https://vitejs.dev) en el despliegue) a través de tu navegador. Si todo funciona correctamente, debes poder visualizar un front-end por defecto.

### Añadir dependencia: `kaizten-typescript`

Hola, habría que añadir [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript) como dependencia al front-end para poder emplear las utilidades ya creadas.

**Pasos a realizar:**

1. Añade [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript) al front-end de la aplicación, tal como sigue:
    ```shell
    $ touch .npmrc
    $ echo "@kaizten:registry=https://npm.pkg.github.com" >> .npmrc
    $ yarn add @kaizten/kaizten-typescript@1.0.0
    ```

### Añadir dependencia: `kaizten-vue`

Hola, habría que añadir [`kaizten-vue`](https://github.com/kaizten/kaizten-vue) como dependencia al front-end para poder incluir los componentes de Vue.js ya creados.

**Pasos a realizar:**

1. Añade [`kaizten-vue`](https://github.com/kaizten/kaizten-vue) al front-end de la aplicación, tal como sigue:
    ```shell
    $ touch .npmrc
    $ echo "@kaizten:registry=https://npm.pkg.github.com" >> .npmrc
    $ yarn add @kaizten/kaizten-vue@1.0.0
    ```

### Dockerfile

Hola, actualmente, el proyecto carece de un Dockerfile para el front-end, lo que dificulta la estandarización y la facilidad de despliegue en entornos diversos. La inclusión de un Dockerfile específico para el front-end facilitará la creación de contenedores y permitirá una configuración más eficiente del entorno de desarrollo y producción.

**Pasos a realizar:**

1. Crea un archivo `front-end/Dockerfile`. El contenido debe ser el siguiente:
    ```shell
    # Develop stage
    FROM node:alpine as develop-stage
    LABEL maintainer="development@kaizten.com"

    ARG GITHUB_TOKEN
    ENV GITHUB_TOKEN $GITHUB_TOKEN

    WORKDIR /app

    RUN echo @kaizten:registry=https://npm.pkg.github.com/ >> ./.npmrc
    RUN echo //npm.pkg.github.com/:_authToken=$GITHUB_TOKEN >> ./.npmrc

    COPY package*.json ./
    RUN yarn install
    COPY . .

    # Build stage
    FROM develop-stage as build-stage
    RUN yarn build

    # Production stage
    FROM nginx:stable-alpine as production-stage
    COPY --from=build-stage /app/dist /usr/share/nginx/html
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    ```
    Una vez creado el `Dockerfile`, puedes crear la imagen Docker de tu front-end. Para ello, ejecuta lo siguiente:
    ```shell
    $ cd front-end
    $ docker build --build-arg GITHUB_TOKEN=<YOUR_TOKEN> -t dockerizedfrontend .
    ```
    donde debes reemplazar `YOUR_TOKEN` por tu token de GitHub.

2. Comprueba que la imagen Docker se ha generado correctamente. Esto es, debes tener la imagen Docker generada en tu máquina:
    ```shell
    $ docker images
    REPOSITORY                              TAG       IMAGE ID       CREATED         SIZE
    dockerizedfrontend                      latest    030e16f22f48   6 seconds ago   17.8MB
    ```

3. Comprueba que puedes crear un contenedor Docker de la imagen previamente generada. Tal como sigue:
    ```shell
    $ docker run -p 80:80 --name mycontainer dockerizedfrontend
    ```
    El resultado debe ser que el front-end se ejecute de forma convencional, pero ahora no como una aplicación [Vue.js](https://vuejs.org) sino como un contenedor. Concretamente, se está creando un contenedor llamado `mycontainer` de la imagen previamente creada `dockerizedfrontend`. Además, se está mapeando el puerto `80` del contenedor en el puerto `80` de tu máquina.

### GitHub action

Hola, la generación de la imagen Docker correspondiente requiere pasos manuales, lo que puede llevar a errores, inconsistencias y pérdida de tiempo. Para mejorar este proceso, se puede implementar una [GitHub action](https://github.com/features/actions) que automatice estas tareas con cada push realizado en el repositorio.

**Pasos a realizar:**

1. Las [GitHub action](https://github.com/features/actions) se definen en la carpeta `.github/workflows`. Crea esta carpeta dentro del repositorio si no la tienes aún creada. Es importante que te fijes bien en que se trata de una carpeta oculta. 

2. Dentro de la carpeta `.github/workflows` crea el archivo `front-end_publish-docker-image.yml` con el siguiente contenido:
    ```yaml
    name: Front-end. Publish Docker image

    # Events that trigger the workflow
    on:
      push:
        branches: 
          - main
        paths: 
          - front-end/**
          - '!**.md'
      workflow_dispatch:

    # Working directory
    defaults:
      run:
        working-directory: front-end

    # Environment variables
    env:
      WORKING_DIRECTORY: front-end
      DOCKER_IMAGE_NAME: kaizten/<NOMBRE_PROYECTO>_front-end

    jobs:
      publish-docker-image:
        runs-on: ubuntu-latest
        steps:
          # Checkout of the repository
          - uses: actions/checkout@v4
            name: Check out code
          # Build and publish Docker image in DockerHub
          - name: Build and push Docker image
            uses: mr-smithers-excellent/docker-build-push@v6
            with:
              image: ${{ env.DOCKER_IMAGE_NAME }}
              tags: latest
              registry: docker.io
              directory: ${{ env.WORKING_DIRECTORY }}
              dockerfile: ${{ env.WORKING_DIRECTORY }}/Dockerfile
              username: ${{ secrets.DOCKERHUB_USERNAME }}
              password: ${{ secrets.DOCKERHUB_PASSWORD }}
              buildArgs: GITHUB_TOKEN=${{ secrets.KAIZTEN_DEVELOPMENT_PASSWORD }}
    ```

    La [GitHub action](https://github.com/features/actions) creada está destinada a que, cada vez que hagas un cambio en `front-end/` y lo subas al repositorio, se genere la imagen Docker correspondiente y se publique en [Docker Hub](https://hub.docker.com). Fíjate que en el archivo hay definida una variable `DOCKER_IMAGE_NAME` que indica el nombre de la imagen Docker que se genera con el lanzamiento de la [GitHub action](https://github.com/features/actions). En este punto es importante que sustituyas `<NOMBRE_PROYECTO>` por el nombre de tu proyecto.

3. Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `front-end/` y subiéndolos al repositorio. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo indicando el error.

4. Una vez se ejecute la [GitHub action](https://github.com/features/actions), comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.

### Dominio

Hola, el objetivo es replicar la estructura y las clases del dominio existente en el back-end hacia el front-end utilizando [TypeScript](https://www.typescriptlang.org). Esto implica la creación de carpetas y clases en [TypeScript](https://www.typescriptlang.org) correspondientes a las clases Java del dominio del back-end.

**Pasos a realizar:**

1. Crea la carpeta `front-end/src/domain/entity` en el directorio del front-end para reflejar la estructura del back-end.
2. Crea la carpeta `front-end/src/domain/valueobject` en el mismo directorio para almacenar los objetos de valor del dominio.
3. Para cada clase y enumerado Java en el dominio del back-end, crea una clase equivalente en [TypeScript](https://www.typescriptlang.org) siguiendo la nomenclatura y la funcionalidad correspondiente. Las clases deben replicar la lógica de negocio y las propiedades definidas en el back-end.

    Una cuestión a tener en cuenta es que en [TypeScript](https://www.typescriptlang.org), a diferencia de Java (que utilizamos en el back-end), no existe soporte para la sobrecarga de constructores. En Java, es común definir múltiples constructores para las entidades de dominio, como uno que acepte un ID (típicamente para entidades ya existentes) y otro que genere el ID automáticamente (para entidades nuevas). Sin embargo, dado que [TypeScript](https://www.typescriptlang.org) carece de esta funcionalidad, debemos adoptar un enfoque diferente para manejar la construcción de entidades de dominio.

    Una alternativa para solventar esto es emplear parámetros opcionales en el constructor. De forma que definimos un solo constructor que acepta un parámetro opcional para el ID. Si se proporciona el ID, la entidad lo utiliza; de lo contrario, se genera uno automáticamente. Esto permite que el mismo constructor maneje ambas situaciones. A continuación un ejemplo:

    ```ts
    class Order {

        id: string;
        items: string[];

        constructor(items: string[], id?: string) {
            this.id = id || this.generateUniqueId(); // If no ID is provided, generate a new one
            this.items = items;
        }

        private generateUniqueId(): string {
            return Math.random().toString(36).substring(2, 15); // Example of generating a unique ID
        }
    }

    // Usage examples
    const existingOrder = new Order(['item1', 'item2'], '12345'); // Using an existing ID
    const newOrder = new Order(['item1', 'item2']); // Generating an ID automatically
    ```

### Aplicación

#### Casos de uso

Hola, en el front-end los casos de uso son útiles para gestionar la lógica relacionada con las interacciones del usuario y la comunicación con servicios. Esto permite que las funcionalidades estén mejor estructuradas y desacopladas de los detalles de implementación de la interfaz. El objetivo de este issue es crear casos de uso en el front-end que sigan la arquitectura hexagonal y estén programados en [TypeScript](https://www.typescriptlang.org).

**¿Por qué son importantes los casos de uso en el front-end?**

Los casos de uso ayudan a estructurar la lógica que conecta la interfaz del usuario con los servicios. Facilitan la separación de la lógica de negocio del manejo de la interfaz gráfica, permitiendo una mayor mantenibilidad y testabilidad.

A continuación, un ejemplo básico de un caso de uso para manejar el inicio de sesión de un usuario:

```ts
import { Either } from '@kaizten/kaizten-typescript';
import { DataError } from '@kaizten/kaizten-typescript';

// Define the use case interface
export interface ProcessPaymentUseCase {

    /**
     * Handles the login process using the user's credentials
     *
     * @param username The user's username.
     * @param password The user's password.
     * @returns A confirmation message or session token.
     */
    execute(username: string, password: string): Promise<Either<DataError, LoginConfirmationMessage>>;

    /**
     * Processes the payment based on the provided amount and payment details.
     *
     * @param amount The total amount to be paid.
     * @param paymentDetails The payment information (e.g., card number, expiration date).
     * @return A confirmation message or transaction status.
     */
    processPayment(amount: Amount, paymentDetails: PaymentDetails): Promise<Either<DataError, PaymentConfirmationMessage>>;
}
```

Este es un contrato que define la funcionalidad sin detalles de implementación.

**Pasos a realizar:**

1. En una arquitectura hexagonal de front-end, los casos de uso deberían estar en una carpeta que agrupe toda la lógica de negocio de la aplicación, tal que: `application/usecase`. Por tanto, define todos los casos de uso del front-end.

#### Servicios

Hola, una vez definidos los casos de uso de la aplicación, es necesario realizar su implementación como servicios. El objetivo de este issue es crear servicios en el front-end que sigan la arquitectura hexagonal y estén programados en [TypeScript](https://www.typescriptlang.org). En el front-end, los servicios se encargan de manejar la interacción con APIs u otros servicios externos. Para ello, crea una clase individual por cada caso de uso de la aplicación dentro de la carpeta `application/service`.

A continuación, te paso un extracto básico de un servicio de front-end:

```ts
import { Either } from '@kaizten/kaizten-typescript';
import { DataError } from '@kaizten/kaizten-typescript';

export class ProcessPaymentService implements ProcessPaymentUseCase {

    constructor(paymentRepository: PaymentRepository) {}

    async processPayment(amount: Amount, paymentDetails: PaymentDetails): Promise<Either<DataError, PaymentResponse>>; {
        // Use paymentRepository to communicate with the backend API
        return this.paymentRepository.processPayment(amount, paymentDetails);
    }
}
```

**Pasos a realizar:**

1. En este ejemplo, debes reemplazar `Amount`, `PaymentDetails` y `ConfirmationMessage` con los nombres y tipos de datos específicos que tu aplicación utiliza.

2. El servicio emplea un repository `PaymentRepository` que se encarga de realizar las peticiones a la API. Así se desacopla la lógica de negocio de la implementación de las llamadas `HTTP`. En tu caso, deberás disponer de repository: `<ENTITY>Repository`, donde <ENTITY> será el nombre la entidad correspondiente en cada caso.

    De esta forma, los servicios en el front-end se encargan de implementar la lógica de los casos de uso definidos. En este caso, `ProcessPaymentService` implementa la lógica para procesar pagos, utilizando `PaymentRepository` para realizar la comunicación con el back-end. De manera que desacoplamos la lógica de los servicios de la implementación de las llamadas HTTP, facilitando su mantenimiento.

#### Repositorios

Hola, el objetivo de este issue es crear la capa de repositorios en el front-end siguiendo la arquitectura hexagonal y programados en [TypeScript](https://www.typescriptlang.org). Los repositorios son una abstracción de la fuente de datos (como APIs, bases de datos, etc.), lo que permite desacoplar la lógica de negocio de cómo y dónde se obtienen o almacenan los datos.

**Pasos a realizar:**

1. Crear la carpeta `front-end/src/application/repository`. En esta carpeta se añadirán las interfaces de repositorios que definirán las operaciones necesarias para cada entidad.

2. Definir la interfaz del repositorio para la entidad `Payment`: Crea una interfaz que represente el repositorio de tu `ENTITY`. Esta interfaz debe incluir los métodos necesarios para realizar las operaciones básicas (CRUD). Aquí tienes un ejemplo de cómo puede verse:
    ```ts
    // PaymentRepository.ts
    import { Either } from '@kaizten/kaizten-typescript';
    import { DataError } from '@kaizten/kaizten-typescript';
    import { Payment } from '../domain/entity/Payment';
    import { PaymentResponse } from '../domain/entity/PaymentResponse';

    export interface PaymentRepository {
        getPayments(): Promise<Either<DataError, PaymentResponse>>;
        getPayment(id: string): Promise<Either<DataError, Payment>>;
        savePayment(payment: Payment): Promise<Either<DataError, Payment>>;
        deletePayment(id: string): Promise<Either<DataError, Payment>>;
        updatePayment(id: string, payment: Payment): Promise<Either<DataError, Payment>>;
        processPayment(amount: Amount, paymentDetails: PaymentDetails): Promise<Either<DataError, PaymentResponse>>;
    }
    ```

    En este ejemplo, la interfaz `PaymentRepository` define los métodos que serán utilizados por los servicios para gestionar los pagos. Cada método devuelve una promesa (`Promise`) que contiene una respuesta de tipo `Either`, lo que permite manejar tanto el resultado esperado como los errores (con `DataError`).

    Posteriormente, para cada interfaz, se puede crear una clase que implemente la lógica concreta de acceso a los datos, pero eso lo dejamos para otro issue. En este caso, simplemente necesitamos definir las interfaces.

    Este enfoque te permite trabajar con una arquitectura limpia y desacoplada en el front-end, lo que facilita el mantenimiento del código.

3. Por último, te paso una referencia sobre el funcionamiento de las [promesas en TypeScript](https://www.codecademy.com/resources/docs/typescript/promises). Léela con calma y plantea las dudas que puedan surgirte.

### Adaptador HTTP

#### Primeros pasos

Hola, los servicios definidos en el front-end se encargan de proporcionar las funcionalidades. Estos servicios recuperan y almacenan datos haciendo uso de los repositorios existentes. En este caso, los datos provienen del back-end de la aplicación. Por este motivo, es necesario crear un adaptador que permita recuperar/persistir los datos gestionados por el front-end. El uso de HTTP Repositories en una aplicación proporciona una estructura sólida y centralizada para manejar las interacciones con el back-end, y más concretamente su API, de manera eficiente, segura y escalable. Mejora la separación de responsabilidades, facilita el testing, y garantiza que las interacciones con la API sean consistentes y controladas, contribuyendo a un código más mantenible y flexible frente a cambios en la API o en los requisitos del sistema.

**Ejemplo:**

A continuación tienes un extracto de cómo sería un posible `VehicleHttpRepository`, asumiendo en el ejemplo que nuestro `<ENTITY>` será `Vehicle`:

```ts
import {
  Either,
  type DataError,
  http,
  type ApiError,
} from '@kaizten/kaizten-typescript';

import type { VehicleRepository } from '../../../application/repository/vehicle-repository';
import type { VehiclesResponse } from '../dto/vehicles-response';
import type { Vehicle } from '../../../domain/entity/vehicle';
import { VehicleJsonResponse } from '../dto/vehicle-json-response';
import { VehiclePostJsonRequest } from '../dto/vehicle-post-json-request';
import { VehiclePutJsonRequest } from '../dto/vehicle-put-json-request';
import type { VehicleAdd } from '../../vuejs/dto/vehicle-add';
import type { VehicleEdit } from '../../vuejs/dto/vehicle-edit';

export class VehicleHttpRepository implements VehicleRepository {
  private readonly API_URL = import.meta.env.VITE_APP_API_URL + 'vehicles';
  private headers: Headers = new Headers();

  constructor() {
    this.headers.append('Authorization', `Bearer ${this.keycloak?.token}`);
    this.headers.append('Content-Type', 'application/json');
  }

  public async get(
    page?: number,
    rowsPerPage?: number,
    filters?: string
  ): Promise<Either<DataError, VehiclesResponse>> {
    let url = this.API_URL;
    if (page != undefined && rowsPerPage != undefined) {
      url += `?page=${page}&size=${rowsPerPage}`;
    }
    if (filters != undefined) {
      url += `&${filters}`;
    }
    return new Promise((resolve, reject) => {
      http
        .get(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: VehicleJsonResponse[]) => {
              const totalItems: number = +(response.headers.get(
                'Total-Count'
              ) as string);
              const paginationCount: number = +(response.headers.get(
                'Pagination-Count'
              ) as string);
              const convertedData: Vehicle[] = [];
              data.forEach(vehicle => {
                convertedData.push(VehicleJsonResponse.toVehicle(vehicle));
              });
              const vehiclesResponse: VehiclesResponse = {
                vehiclesResponse: convertedData,
                totalItems: totalItems,
                paginationCount: paginationCount,
              };
              resolve(Either.right(vehiclesResponse));
            });
          } else {
            response.json().then((data: ApiError) => {
              reject(Either.left(data));
            });
          }
        })
        .catch((error: any) => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async getById(id: string): Promise<Either<DataError, Vehicle>> {
    const url = `${this.API_URL}/${id}`;
    return new Promise((resolve, reject) => {
      http
        .get(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: VehicleJsonResponse) => {
              resolve(Either.right(VehicleJsonResponse.toVehicle(data)));
            });
          } else {
            response.json().then((data: ApiError) => {
              reject(Either.left(data));
            });
          }
        })
        .catch((error: any) => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async register(
    vehicle: VehicleAdd
  ): Promise<Either<DataError, Vehicle>> {
    const body = VehiclePostJsonRequest.toRequest(vehicle);
    return new Promise((resolve, reject) => {
      http
        .post(this.API_URL, body, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: VehicleJsonResponse) => {
              resolve(Either.right(VehicleJsonResponse.toVehicle(data)));
            });
          } else {
            response.json().then((data: ApiError) => {
              reject(Either.left(data));
            });
          }
        })
        .catch((error: any) => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async delete(id: string): Promise<Either<DataError, Vehicle>> {
    const url = `${this.API_URL}/${id}`;
    return new Promise((resolve, reject) => {
      http
        .delete(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: VehicleJsonResponse) => {
              resolve(Either.right(VehicleJsonResponse.toVehicle(data)));
            });
          } else {
            response.json().then((data: ApiError) => {
              data.kind = 'ApiError';
              resolve(Either.left(data));
            });
          }
        })
        .catch((error: any) => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async update(
    id: string,
    vehicle: VehicleEdit
  ): Promise<Either<DataError, Vehicle>> {
    const url = `${this.API_URL}/${id}`;
    const body = VehiclePutJsonRequest.toRequest(vehicle);
    return new Promise((resolve, reject) => {
      http
        .put(url, body, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: VehicleJsonResponse) => {
              resolve(Either.right(VehicleJsonResponse.toVehicle(data)));
            });
          } else {
            response.json().then((data: ApiError) => {
              data.kind = 'ApiError';
              resolve(Either.left(data));
            });
          }
        })
        .catch((error: any) => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }
}
```

**Pasos a realizar:**

1. Crea una carpeta `adapter/http` en el directorio del proyecto del front-end. En esta carpeta se añadirá el código necesario para conectar el front-end con el back-end.
2. Para cada repositorio definido en tu front-end, crea una clase en [TypeScript](https://www.typescriptlang.org) dentro de `adapter/http` que implemente dicho repositorio. En este caso, debes tener en cuenta que debes sustituir `<ENTITY>` (o su versión en plural) por el nombre de la entidad que quieras consultar. Por otro lado, debes fijarte en que en el ejemplo aparecen `<ENTITY>JsonResponse` y `<ENTITY>Response`. Esto son data transfer objects (DTO) destinados a desacoplar capas en el front-end. Más específicamente, deberíamos para cada `<ENTITY>` disponer de un repositorio que maneje las operaciones HTTP relacionadas con la entidad, utilizando los DTOs definidos. Este repositorio debe gestionar las siguientes operaciones:
- GET (`get`): Obtener una lista de entidades paginada y/o filtrada. El método debe construir la URL de acuerdo a los parámetros recibidos (página, filtros, etc.) y devolver un `Either` con los datos o un error.
- GET BY ID (`getById`): Recuperar una entidad específica por su identificador. El método debe devolver un `Either` con el objeto de dominio o un error.
- POST (`create`): Crear una nueva entidad en el sistema, utilizando el DTO `<ENTITY>PostJsonRequest`. Debe manejar la serialización de datos y la respuesta de la API.
- DELETE (`delete`): Eliminar una entidad dado su identificador. La operación debe gestionar la respuesta HTTP y devolver el resultado en un `Either`.
- PUT (`update`): Actualizar una entidad existente utilizando el DTO `<ENTITY>PutJsonRequest`. La función debe manejar la serialización de los datos de entrada y la respuesta de la API.

#### Data transfer objects

Hola, para evitar el uso de las entidades en las peticiones al back-end, el adaptador `http` debería usar Data Transfer Objects (DTO). El uso de DTOs en el adaptador `http` no solo mejora la modularidad y el mantenimiento del sistema, sino que también aumenta la seguridad, la flexibilidad y la eficiencia en la manipulación de datos. Los DTOs son fundamentales para garantizar que las interacciones entre el front-end y el back-end estén bien estructuradas, sean seguras y se adapten a las necesidades evolutivas del software sin comprometer la integridad de las entidades del dominio.

**Ejemplo:**

A continuación tienes un extracto de varios ejemplos de DTOs, asumiendo en el ejemplo que nuestro `<ENTITY>` será `Vehicle`:
```ts
import { KaiztenUUID } from '@kaizten/kaizten-typescript';
import { Vehicle } from '../../../domain/entity/vehicle';
import { OrganizationResponseBody } from './organization-response-body';
import { VehicleNumberPlate } from '../../../domain/value-object/vehicle-number-plate';
import { VehicleCapacity } from '../../../domain/value-object/vehicle-capacity';
import { EmployeeName } from '../../../domain/value-object/employee-name';
import { VehicleType } from '../../../domain/enumerate/vehicle-type';

export class VehicleJsonResponse {
  id: string;
  numberPlate: string;
  capacity: number;
  driver?: string;
  type?: string;
  organization: OrganizationResponseBody;

  constructor(
    id: string,
    numberPlate: string,
    capacity: number,
    organization: OrganizationResponseBody,
    driver?: string,
    type?: string
  ) {
    this.id = id;
    this.numberPlate = numberPlate;
    this.capacity = capacity;
    this.organization = organization;
    this.driver = driver;
    this.type = type;
  }

  public static toVehicle(data: VehicleJsonResponse): Vehicle {
    return new Vehicle(
      new KaiztenUUID(data.id),
      new VehicleNumberPlate(data.numberPlate),
      new VehicleCapacity(data.capacity),
      OrganizationResponseBody.toOrganization(data.organization),
      'driver' in data ? new EmployeeName(data.driver!) : undefined,
      'type' in data ? VehicleType.fromString(data.type!) : undefined
    );
  }
}
```
```ts
import type { VehicleAdd } from '../../vuejs/dto/vehicle-add';

export class VehiclePostJsonRequest {
  numberPlate: string;
  capacity: number;
  driver?: string;
  type?: string;

  constructor(
    numberPlate: string,
    capacity: number,
    driver?: string,
    type?: string
  ) {
    this.numberPlate = numberPlate;
    this.capacity = capacity;
    this.driver = driver;
    this.type = type;
  }

  public static toRequest(data: VehicleAdd): VehiclePostJsonRequest {
    return new VehiclePostJsonRequest(
      data.numberPlate,
      data.capacity,
      data.driver ? data.driver : undefined,
      data.type ? data.type.key : undefined
    );
  }
}
```
```ts
import type { VehicleEdit } from '../../vuejs/dto/vehicle-edit';

export class VehiclePutJsonRequest {
  numberPlate?: string;
  capacity?: number;
  driver?: string;
  type?: string;

  constructor(
    numberPlate?: string,
    capacity?: number,
    driver?: string,
    type?: string
  ) {
    this.numberPlate = numberPlate;
    this.capacity = capacity;
    this.driver = driver;
    this.type = type;
  }

  public static toRequest(data: VehicleEdit): VehiclePutJsonRequest {
    return new VehiclePutJsonRequest(
      data.numberPlate,
      data.capacity,
      data.driver ? data.driver : undefined,
      data.type ? data.type.key : undefined
    );
  }
}
```

**Pasos a realizar:**

1. Crea la carpeta `src/adapter/http/dto` en el front-end. 
2. Para cada entidad del dominio, incluye un archivo con una clase en [TypeScript](https://www.typescriptlang.org) para cada petición y otro archivo para cada posible respuesta desde el back-end. A diferencia de las entidades, estos DTO deben tener `string` u otros tipos básicos para definir los atributos. Más específicamente, deberíamos para cada `<ENTITY>` disponer de:
   * **Crear DTO `<ENTITY>JsonResponse`:**
     - Ubicación: `src/adapter/http/dto/entity-json-response.ts`
     - Descripción: Implementar un DTO para representar la respuesta de una entidad en formato JSON desde la API. El DTO debe incluir los atributos con tipos básicos necesarios que reflejen la estructura de la entidad en el dominio, así como las relaciones con otras entidades que se recogeran a través de su ID. Debe disponer de un método estático `toDomainEntity` que convierte la respuesta JSON en una entidad del dominio usando los value objects y entidades definidos. 
   * **Crear DTO `<ENTITY>PostJsonRequest`:**
     - Ubicación: `src/adapter/http/dto/entity-post-json-request.ts`
     - Descripción: Desarrollar un DTO que represente las solicitudes POST para la creación de una entidad en la API. Este DTO deberá gestionar la serialización de los atributos necesarios para crear una nueva entidad. Debe disponer de un método estático `toRequest` que convierte un objeto de entrada en una instancia de `<ENTITY>PostJsonRequest`.
   * **Crear DTO `<ENTITY>PutJsonRequest`:**
     - Ubicación: `src/adapter/http/dto/entity-put-json-request.ts`
     - Descripción: Definir un DTO para las solicitudes PUT de actualización de una entidad, que permita modificar uno o varios atributos de forma parcial. Este DTO deberá soportar atributos opcionales. Debe disponer de un método estático `toRequest` que convierte un objeto de actualización en una instancia de `<ENTITY>PutJsonRequest`.

#### Probar adaptador HTTP

Hola, este issue tiene como objetivo probar la funcionalidad del repositorio HTTP de las entidades para asegurarse de que las peticiones HTTP al back-end funcionan correctamente. Las pruebas deben realizarse desde el componente principal `App.vue`, ejecutando las operaciones CRUD (obtener, registrar, actualizar y eliminar un vehículo) y verificando que las respuestas y errores se gestionan adecuadamente.

**Pasos a realizar:**

1. Vamos a suponer que nuestra entidad de trabajo es `Vehicle`, por lo que para probar dicha entidad, el primer paso es abrir el archivo `App.vue` y agregar las importaciones necesarias y setup para probar las operaciones del repositorio HTTP:
    ```ts
    <script lang="ts" setup>
    import { ref, onMounted } from 'vue';
    import { VehicleHttpRepository } from '@/adapter/http/repository/vehicle-http-repository';
    import { Vehicle } from '../../../domain/entity/vehicle';

    const vehicleRepo = new VehicleHttpRepository();

    const vehicleList = ref([]);
    const vehicleDetails = ref();
    const newVehicle = new Vehicle('ABC123', 4, 'John Doe');
    const updatedVehicle = new Vehicle('ABC123', 5, 'Jane Doe');

    // Métodos de prueba

    const getVehicles = async () => {
      const result = await vehicleRepo.get(1, 10);
      result.fold(
        error => console.error('Error getting vehicles:', error),
        data => (vehicleList.value = data.vehiclesResponse)
      );
    };

    const getVehicleById = async (id: string) => {
      const result = await vehicleRepo.getById(id);
      result.fold(
        error => console.error('Error getting vehicle:', error),
        data => (vehicleDetails.value = data)
      );
    };

    const registerVehicle = async () => {
      const result = await vehicleRepo.register(newVehicle);
      result.fold(
        error => console.error('Error registering vehicle:', error),
        data => console.log('Vehicle registered successfully:', data)
      );
    };

    const updateVehicle = async (id: string) => {
      const result = await vehicleRepo.update(id, updatedVehicle);
      result.fold(
        error => console.error('Error updating vehicle:', error),
        data => console.log('Vehicle updated successfully:', data)
      );
    };

    const deleteVehicle = async (id: string) => {
      const result = await vehicleRepo.delete(id);
      result.fold(
        error => console.error('Error deleting vehicle:', error),
        data => console.log('Vehicle deleted successfully:', data)
      );
    };

    // Ejecutar pruebas al cargar el componente
    onMounted(() => {
      getVehicles();
      getVehicleById('b79cb3ba-745e-5d9a-8903-4a02327a7e09'); // Usar ID de prueba
      registerVehicle();
      updateVehicle('b79cb3ba-745e-5d9a-8903-4a02327a7e09');  // Usar ID de prueba
      deleteVehicle('b79cb3ba-745e-5d9a-8903-4a02327a7e09');  // Usar ID de prueba
    });
    </script>
    ```
2. Modificar la plantilla de `App.vue`. Agrega los resultados de las pruebas al template para mostrar en la interfaz el estado de las operaciones:
    ```ts
    <template>
      <div>
        <h1>HTTP Repository Test</h1>
        <h2>Vehicles List:</h2>
        <ul>
          <li v-for="vehicle in vehicleList" :key="vehicle.id">
            {{ vehicle.numberPlate }} - {{ vehicle.capacity }} seats
          </li>
        </ul>
        <h2>Vehicle Details (ID: 1):</h2>
        <p v-if="vehicleDetails">
          Number Plate: {{ vehicleDetails.numberPlate }}<br />
          Capacity: {{ vehicleDetails.capacity }}<br />
          Driver: {{ vehicleDetails.driver }}
        </p>
      </div>
    </template>
    ```
3. Verifica en la consola que los métodos `get`, `getById`, `register`, `update` y `delete` están funcionando correctamente. Asegúrate de que los vehículos (o entidad usada) listados, los detalles de un vehículo (o entidad usada) específico, y los mensajes de registro, actualización y eliminación se muestren correctamente.

### Adaptador Vue.js

#### Primeros pasos

Hola, en el marco de nuestra arquitectura hexagonal, necesitamos integrar un adaptador para [Vue.js](https://vuejs.org).js que facilite la interacción entre la capa de presentación (fundamentalmente los componentes gráficos) y las capas internas (servicios, repositorios, etc.) de la aplicación. Este adaptador es crucial para garantizar una separación clara de preocupaciones y permitir la fácil sustitución de frameworks o bibliotecas en el futuro.

**Pasos a realizar:**

1. Crea una carpeta `adapter/vuejs` en el directorio del proyecto del front-end. Esta carpeta deberá contener todo el código relacionado con la interacción entre la capa de presentación y la lógica de la aplicación.
2. Crea una carpeta `adapter/vuejs/components`: Aquí estarán los componentes de Vue que se usan en las vistas. Sin embargo, nuestro objetivo es que el número de componentes en esta carpeta tienda a 0, ya que deberían ser parte de nuestra librería `kaizten-vue` en vez de estar dispersos por el proyecto.
3. Crea una carpeta `adapter/vuejs/dto`: En esta carpeta estarán los Data Transfer Objects (DTOs) que usaremos en las vistas de Vue. Esto incluye los DTO para agregar (`<entity>-add.ts`), editar (`<entity>-edit.ts`) y visualizar (`<entity>-info.ts`) entidades. Para más información sobre cómo estructurar y crear estos DTOs, revisa el issue correspondiente: **Data transfer objects para vistas**. Los DTOs son esenciales para evitar acoplamiento con las entidades del dominio, gestionar la validación de los datos en las vistas y organizar de manera clara la lógica de las operaciones básicas en el front-end.
4. Crea una carpeta `adapter/vuejs/plugins`: Aquí ubicamos los plugins necesarios para el proyecto, como la configuración de vuetify u otros plugins de Vue que empleemos.
5. Crea una carpeta `adapter/vuejs/stores`: En esta carpeta, organizamos los stores de Pinia para las diferentes entidades que manejamos en el front-end. Un store típico debe encargarse de gestionar el estado de la entidad correspondiente, incluyendo las acciones para obtener, actualizar, registrar y eliminar entidades desde los servicios del back-end. Además, debe incluir los métodos para manejar los errores y las notificaciones en la interfaz de usuario. Para más información sobre cómo estructurar y crear los stores, revisa el issue correspondiente: **Gestor de estados**
6. Crea una carpeta `adapter/vuejs/view`: Aquí colocaremos las vistas correspondientes al front-end. Estas vistas interactúan directamente con los stores y los DTOs del adaptador de Vue.js para la representación de las operaciones básicas como añadir, editar y visualizar las entidades. Para más información sobre cómo estructurar y crear las vistas básicas, revisa el issue correspondiente: **Vistas**
7. Crea una carpeta `adapter/vuejs/router`: Esta carpeta contendrá el archivo `index.ts`, que configurará el enrutador de Vue.js para gestionar la navegación dentro de la aplicación. Aquí definiremos las reglas de las rutas, los componentes asociados a cada una y las restricciones de autenticación y roles. Para más información sobre cómo estructurar y crear el router, revisa el issue correspondiente: **Router**
8. Crea una carpeta `adapter/vuejs/locales`. Esta carpeta contendrá las posibles traducciones que la aplicación requerirá. Con esto se conseguirá que la aplicación esté al menos en español e inglés, entre otros.

Aspectos básicos a tener en cuenta:
- La estructura del directorio `adapter/vuejs/` debe seguir la organización descrita.
- Los componentes de Vue deben ser migrados progresivamente a la librería `kaizten-vue`.
- Los DTOs deben estar correctamente configurados en la carpeta dto y ser utilizados en las vistas respectivas.
- Los stores deben gestionar correctamente el estado de las entidades y las interacciones con los servicios de back-end.
- Las vistas deben estar correctamente asociadas con los DTOs y stores para mantener la separación de responsabilidades.
- El enrutador de Vue.js debe estar correctamente configurado en la carpeta `router/index.ts` con las rutas necesarias.

#### Router

Hola, un router en desarrollo de front-end es una herramienta que facilita la navegación dentro de una aplicación web de una sola página (SPA). Funciona como un gestor de rutas, permitiendo definir diferentes URL que corresponden a distintas vistas o componentes de la aplicación. Este issue está enfocado en la configuración del enrutador dentro del adaptador de Vue.js en nuestra arquitectura hexagonal. La carpeta `adapter/vuejs/router/` será utilizada para gestionar todas las rutas y la lógica de navegación de la aplicación.

Dentro de la carpeta `adapter/vuejs/router/`, deberás configurar el archivo `index.ts`, el cual contendrá la configuración completa de las rutas, sus permisos de acceso, y los guards de navegación necesarios para la gestión de autenticación y la visualización de estados como el cargando.

[Aquí](https://router.vuejs.org) puedes encontrar el gestor de rutas oficial empleado en [Vue.js](https://vuejs.org).

**Pasos a realizar:**

1. El primer paso a realizar es su instalación en el front-end. Esto puedes hacerlo tal como se indica [aquí](https://router.vuejs.org/installation.html): 
    ```yml
    $ yarn add vue-router@4
    ```
2. Una vez instalado, debes añadir el gestor de rutas al archivo de entrada del front-end (`main.ts`). Para ello, importa el gestor de rutas y úsalo en la aplicación:
    ```ts
    ...
    import router from './router'; // Importa el router
    ...
    const app = createApp(App);
    app.use(router); // Usa el router
    app.mount('#app');
    ```
3. Crea la carpeta `adapter/vuejs/router` e introduce `router.ts`. Éste será el archivo de configuración del gestor de rutas del front-end. A continuación puedes ver un extracto de un archivo  `router.ts` donde se definen 2 rutas, de tal manera que cuando el usuario accede a cada una de ellas se le muestra el componente correspondiente:
    ```ts
    import {
      createRouter,
      createWebHistory,
      type Router,
      type NavigationGuardNext,
      type RouteLocationNormalized,
      type RouteRecordRaw,
    } from 'vue-router';

    const routes: RouteRecordRaw[] = [
      {
        path: '/', // first route
        name: 'Info',
        component: InfoPage, // component to be showed
      },
      {
        path: '/dashboard', // second route
        name: 'Dashboard',
        component: DashboardPage, // component to be showed
      },
      // additional routes must be here
    }

    const router: Router = createRouter({
        routes,
    });
    export default router;
    ```
4. Configura el gestor de rutas en tu aplicación de tal manera que se pueda acceder a las diferentes vistas a medida que se modifica la URL.

#### Gestor de estados

Hola, los gestores de estado son librerías que ayudan a administrar y sincronizar el estado de una aplicación. Permiten controlar los datos y su flujo a lo largo de la interfaz de usuario de manera organizada y predecible.

La carpeta stores dentro del adaptador `vuejs/` es donde gestionamos el estado de las entidades que manejamos en el front-end, utilizando [Pinia](https://pinia.vuejs.org) como sistema de gestión de estado. Cada entidad tendrá su propio store que se encargará de centralizar la lógica relacionada con la obtención, modificación y eliminación de datos, además de gestionar las notificaciones y el manejo de errores.

El store debe estar claramente desacoplado del dominio, manteniendo la lógica específica del front-end sin mezclarla con las entidades del dominio. Los stores interactúan con los services y repositories para realizar peticiones al back-end y actualizar el estado de la aplicación en el cliente.

Objetivos del store:
- Gestionar el estado de las entidades del front-end utilizando stores separados para cada entidad.
- Interactuar con los servicios del back-end para recuperar, registrar, actualizar y eliminar entidades.
- Manejar el ciclo de vida de las notificaciones y los errores que surgen durante la interacción con el servidor.
- Mantener el estado persistente para mejorar la experiencia de usuario y conservar información crítica entre recargas.

**Pasos a realizar:**

1. El primer paso para usar [Pinia](https://pinia.vuejs.org) es instalarlo:
    ```shell
    $ yarn add pinia
    ```
2. Una vez instalado, crea una instancia de [Pinia](https://pinia.vuejs.org) en el archivo principal del front-end (`main.ts`):
    ```ts
    import { createApp } from 'vue'
    import { createPinia } from 'pinia'
    import App from './App.vue'

    const pinia = createPinia()
    const app = createApp(App)

    app.use(pinia)
    app.mount('#app')
    ```
3. Crea la carpeta `adapter/vuejs/store` e introduce `store.ts`. Dentro de la carpeta `adapter/vuejs/store`, debes crear un archivo store específico para cada entidad del dominio con la que estés trabajando. Por ejemplo, si tu entidad es `Vehicle`, el archivo será `vehicle-store.ts`.
4. Configuración inicial del store. Cada store debe ser creado utilizando Pinia. Un store básico tendrá un estado inicial que contiene las propiedades relevantes de la entidad y un servicio para interactuar con el back-end. Un ejemplo básico sería:
    ```ts
    import { defineStore } from 'pinia';
    import { VehicleService } from '../../../application/service/vehicle-service';
    import { VehicleHttpRepository } from '../../http/repository/vehicle-http-repository';
    import type { Vehicle } from '../../../domain/entity/vehicle';

    export const useVehicleStore = defineStore('Vehicle', {
      state: () => ({
        vehicles: [] as Vehicle[], // Estado que almacena todas las entidades recuperadas
        vehicle: undefined as Vehicle | undefined, // Entidad seleccionada
        service: new VehicleService(new VehicleHttpRepository()), // Servicio que interactúa con el repositorio HTTP
        loading: false, // Indicador de estado de carga
        vehicleNotification: {
          flag: false,
          title: '',
          msg: '',
          icon: '',
          timeout: 4000,
          color: '',
        },
      }),
    });
    ```
5. Definir los getters. Los getters proporcionan una forma eficiente de acceder a propiedades del estado. Deben ser añadidos para facilitar la obtención de datos o propiedades calculadas en la aplicación.
    ```ts
    getters: {
      getLoading: (state) => state.loading, // Getter para saber si el store está en proceso de cargar datos
      getNumberOfVehicles: (state) => state.vehicles.length, // Número total de vehículos
    }
    ```
6. Implementar las actions. Las acciones son donde ocurre la lógica de negocio en el store. Cada store debe contener acciones que interactúen con los servicios para realizar peticiones al back-end. Las acciones deben ser responsables de:
   - Obtener todas las entidades.
   - Obtener una entidad por su ID.
   - Registrar una nueva entidad.
   - Actualizar una entidad existente.
   - Eliminar una entidad.
   - Manejar los errores en cada acción.
  
    Ejemplo de actions para `Vehicle`:

    ```ts
    actions: {
      async getVehicles(page?: number, rowsPerPage?: number, filters?: string) {
        this.loading = true;
        this.vehicles = [];
        const result = await this.service.get(page, rowsPerPage, filters);
        result.fold(
          error => {
            this.handleError(error);
            this.loading = false;
          },
          data => {
            this.vehicles = data.vehiclesResponse;
            this.loading = false;
          }
        );
      },

      async getVehicleById(id: string) {
        this.vehicle = undefined;
        const result = await this.service.getById(id);

        result.fold(
          error => {
            this.handleError(error);
          },
          data => {
            this.vehicle = data;
          }
        );
      },

      async registerVehicle(vehicle: Vehicle) {
        const result = await this.service.register(vehicle);
        result.fold(
          error => {
            this.handleError(error);
          },
          data => {
            this.vehicles.push(data);
            this.setNotification('Success', 'Vehicle added successfully', 'mdi-check', 'success');
          }
        );
      },

      async updateVehicle(id: string, vehicle: Vehicle) {
        const result = await this.service.update(id, vehicle);
        result.fold(
          error => {
            this.handleError(error);
          },
          data => {
            this.vehicles = this.vehicles.map(v => (v.getId() === data.getId() ? data : v));
            this.setNotification('Success', 'Vehicle updated successfully', 'mdi-check', 'success');
          }
        );
      },

      async deleteVehicle(id: string) {
        const result = await this.service.delete(id);
          result.fold(
          error => {
            this.handleError(error);
          },
          data => {
            this.vehicles = this.vehicles.filter(vehicle => vehicle.getId() !== data.getId());
            this.setNotification('Success', 'Vehicle deleted successfully', 'mdi-check', 'success');
          }
        );
      },
    }
    ```

1. Manejo de errores y notificaciones. Cada store debe tener mecanismos claros para gestionar errores y notificaciones al usuario. Esto se puede hacer mediante una función que defina cómo manejar los errores del back-end y otra para definir las notificaciones que se mostrarán al usuario.
    ```ts
    actions: {
      setNotification(title: string, msg: string, icon: string, color: string) {
        this.vehicleNotification = {
          flag: true,
          title,
          msg,
          icon,
          timeout: 4000,
          color,
        };
      },

      handleError(error: any) {
        console.error(error);
        this.setNotification('Error', 'An unexpected error occurred', 'mdi-alert', 'error');
      },
    }
    ```
8. Manejo de errores y notificaciones. Cada store debe tener mecanismos claros para gestionar errores y notificaciones al usuario. Esto se puede hacer mediante una función que defina cómo manejar los errores del back-end y otra para definir las notificaciones que se mostrarán al usuario.

**Aspectos básicos a tener en cuenta:**
- Cada entidad debe tener su propio store dentro de la carpeta stores.
- Los stores deben gestionar correctamente el estado, las acciones y el manejo de errores y notificaciones.
- Las acciones deben interactuar con los servicios del back-end a través de los repositories correspondientes.

#### Data transfer objects para vistas

Hola, las vistas y componentes que se emplean en el adaptador [Vue.js](https://vuejs.org) definidas en el front-end deberían emplear objetos de clases diferentes a las entidades del dominio para evitar el acoplamiento, el mal uso de las entidades o el uso masivo de variables dentro de las vistas así como facilitar la validación de datos. 

Por ello, dentro del adaptador de [Vue.js](https://vuejs.org) `adapter/vuejs` crea una carpeta `dto` donde añadir [Data Transfer Objects](https://www.baeldung.com/java-dto-pattern).

**Objetivos:**
- Los Data Transfer Objects (DTOs) permiten desacoplar las entidades del dominio de las vistas en el front-end. Esto evita que las entidades se utilicen directamente en las vistas, lo que podría causar acoplamiento indebido y facilitar errores. Los DTOs gestionan la lógica específica de las operaciones básicas de la aplicación, como agregar, editar y visualizar datos en las vistas. También son esenciales para validar los campos de los formularios y garantizar que las interacciones con el back-end estén bien estructuradas.

  Dentro de la carpeta creada, debes crear una clase `<entity>-add.ts`, `<entity>-edit.ts` y otra `<entity>-info.ts` por cada entidad de tu dominio `<entity>`. Cada uno de estos DTO tendrá una correspondencia directa con las vistas de operaciones básicas en [Vue.js](https://vuejs.org). Una vista para añadir una nueva entidad, una vista para editar una entidad existente y otra vista para ver la información de una entidad existente. Es por ello que cada DTO tiene características diferentes como se ilustra a continuación. Estos DTO tienen como funciones principales recoger los valores de los campos de los formularios de [Vue.js](https://vuejs.org) y validar en el campo del formulario los valores.

**Pasos a realizar:**

1. Crear `DTO EntityAdd.ts`. Su ubicación debe estar en `adapter/vuejs/dto/entity-add.ts`. Este DTO representa los datos necesarios para agregar una nueva entidad en el sistema. Contendrá los atributos básicos con tipos simples como string o number, y métodos para validar campos de formularios. Concretamente métodos estáticos como: `validateAttribute`, método para validar los campos antes de enviar los datos al back-end y `toDomainEntity` que convierte el DTO en una entidad del dominio que será utilizada por los stores. A continuación te paso un ejemplo ilustrativo para una entidad `Vehicle`:

    ```ts
    import type { EmployeeName } from '../value-object/employee-name';
    import type { VehicleCapacity } from '../value-object/vehicle-capacity';
    import type { VehicleNumberPlate } from '../value-object/vehicle-number-plate';

    export class VehicleAdd {

      /**
       * Number plate of the vehicle.
      */
      public numberPlate: string;
      /**
       * Number of seats in the vehicle.
      */
      public capacity: number;
      /**
       * Driver of the vehicle. It is an optional attribute.
      */
      public driver?: string;

      constructor(
        numberPlate: string,
        capacity: number,
        driver?: string
      ) {
        this.validate<string>(
          numberPlate,
          Vehicle.ERROR_NUMBER_PLATE_NOT_DEFINED
        );
        this.validate<number>(
          capacity,
          Vehicle.ERROR_CAPACITY_NOT_DEFINED
        );
        this.numberPlate = numberPlate;
        this.capacity = capacity;
        this.driver = driver;
      }

      private validate<T>(
        attribute: T | undefined,
        errorMessage: string
      ): asserts attribute is T {
        if (attribute === undefined || attribute === null) {
          throw new Error(errorMessage);
        }
      }

      static externalValidateNumberPlate(value: string): boolean | string {
        try {
          new VehicleNumberPlate(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static externalValidateCapacity(value: number): boolean | string {
        try {
          new VehicleCapacity(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static externalValidateDriver(value: string): boolean | string {
        try {
          new EmployeeName(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static random(): VehicleAdd {
        const numberPlate: = VehicleNumberPlate.random().getValue();
        const capacity: = VehicleCapacity.random().getValue();
        const driver: = EmployeeName.random().getValue();
        return new VehicleAdd(numberPlate, capacity, driver);
      }

      static toVehicle(vehicleAdd: VehicleAdd): Vehicle {
        return new Vehicle(
          new VehicleNumberPlate(vehicleAdd.numberPlate),
          new VehicleCapacity(vehicleAdd.capacity),
          vehicleAdd.driver ? new EmployeeName(vehicleAdd.driver) : undefined
        );
      }

    }
    ```

2. Crear DTO `EntityEdit.ts`. Su ubicación debe estar en `adapter/vuejs/dto/entity-edit.ts`. Este DTO maneja los datos necesarios para editar una entidad existente en el sistema. Contendrá los atributos que pueden ser modificados y métodos estáticos para convertir los DTOs en entidades del dominio.  A continuación te paso un ejemplo ilustrativo para una entidad `Vehicle`:

    ```ts
    import type { EmployeeName } from '../value-object/employee-name';
    import type { VehicleCapacity } from '../value-object/vehicle-capacity';
    import type { VehicleNumberPlate } from '../value-object/vehicle-number-plate';

    export class VehicleEdit {
      /**
       * Number plate of the vehicle.
      */
      public numberPlate: string;
      /**
       * Number of seats in the vehicle.
      */
      public capacity: number;
      /**
       * Driver of the vehicle. It is an optional attribute.
      */
      public driver?: string;

      constructor(
        numberPlate: string,
        capacity: number,
        driver?: string
      ) {
        this.validate<string>(
          numberPlate,
          Vehicle.ERROR_NUMBER_PLATE_NOT_DEFINED
        );
        this.validate<number>(
          capacity,
          Vehicle.ERROR_CAPACITY_NOT_DEFINED
        );
        this.numberPlate = numberPlate;
        this.capacity = capacity;
        this.driver = driver;
      }

      private validate<T>(
        attribute: T | undefined,
        errorMessage: string
      ): asserts attribute is T {
        if (attribute === undefined || attribute === null) {
          throw new Error(errorMessage);
        }
      }

      static externalValidateNumberPlate(value: string): boolean | string {
        try {
          new VehicleNumberPlate(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static externalValidateCapacity(value: number): boolean | string {
        try {
          new VehicleCapacity(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static externalValidateDriver(value: string): boolean | string {
        try {
          new EmployeeName(value);
          return true;
        } catch (error: any) {
          return error.message;
        }
      }

      static random(): VehicleEdit {
        const numberPlate: = VehicleNumberPlate.random().getValue();
        const capacity: = VehicleCapacity.random().getValue();
        const driver: = EmployeeName.random().getValue();
        return new VehicleEdit(numberPlate, capacity, driver);
      }

      static toVehicle(vehicleEdit: VehicleEdit): Vehicle {
        return new Vehicle(
          new VehicleNumberPlate(vehicleEdit.numberPlate),
          new VehicleCapacity(vehicleEdit.capacity),
          vehicleEdit.driver ? new EmployeeName(vehicleEdit.driver) : undefined,
          new KaiztenUUID(vehicleEdit.id)
        );
      }

    }
    ```

3. Crear DTO `EntityInfo.ts`. Su ubicación debe estar en `adapter/vuejs/dto/entity-info.ts`. Este DTO gestiona la representación de una entidad cuando se consulta su información. No incluye validaciones ni permite modificaciones, solo visualiza los datos relevantes. A continuación te paso un ejemplo ilustrativo para una entidad `Vehicle`:

    ```ts
    export class VehicleInfo {

      /**
       * Number plate of the vehicle.
      */
      public numberPlate: string;
      /**
       * Number of seats in the vehicle.
      */
      public capacity: number;
      /**
       * Driver of the vehicle. It is an optional attribute.
      */
      public driver?: string;

      constructor(
        numberPlate: string,
        capacity: number,
        driver?: string
      ) {
        this.validate<string>(
          numberPlate,
          Vehicle.ERROR_NUMBER_PLATE_NOT_DEFINED
        );
        this.validate<number>(
          capacity,
          Vehicle.ERROR_CAPACITY_NOT_DEFINED
        );
        this.numberPlate = numberPlate;
        this.capacity = capacity;
        this.driver = driver;
      }

      private validate<T>(
        attribute: T | undefined,
        errorMessage: string
      ): asserts attribute is T {
        if (attribute === undefined || attribute === null) {
          throw new Error(errorMessage);
        }
      }

      static random(): VehicleInfo {
        const numberPlate: = VehicleNumberPlate.random().getValue();
        const capacity: = VehicleCapacity.random().getValue();
        const driver: = EmployeeName.random().getValue();
        return new VehicleInfo(numberPlate, capacity, driver);
      }
    }
    ```

**Aspectos a tener en cuenta:**

- Separación de responsabilidades: Los DTOs evitan que las vistas interactúen directamente con las entidades del dominio, mejorando la modularidad y el mantenimiento del código. En los ejemplos expuestos hay algunas particularidades. A modo de ejemplo, el DTO de `VehicleAdd` y `VehicleEdit` son iguales. En este ejemplo no existen diferencias. No obstante, la idea de separarlos es para afianzar el uso de un DTO para cada vista de operación básica. Este debe ser nuestro estándar, al igual que implementar una vista por cada operación básica de una entidad (`add`, `edit` e `info`). 
- Validación y uso en formularios: Los DTOs deben incluir métodos de validación para asegurar que los datos capturados en las vistas sean correctos antes de ser enviados al servidor. Los atributos de las clases DTO son públicos pues necesitamos poder asociarlos directamente a los `v-model` de los campos en los formularios de las vistas. Por esta razón, carecen de `getters` y `setters`. Además de, en los casos de `VehicleAdd` y `VehicleEdit`, disponer de métodos estáticos `externalValidate`,  que nos van a permitir validar los campos en los formularios de las vistas. Estos métodos se apoyan en la validación de los objetos valor correspondientes. En el caso del DTO `VehicleInfo` no es necesario validar, pues los formularios básicos de información solo permiten visualizar la información de una entidad. Por lo tanto, los DTOs deben ser compatibles con los formularios y las validaciones de las vistas, permitiendo una interacción fluida con los componentes de Vue.js. En el código mostrado a continuación se aprecia el uso de un DTO `const vehicleAdd: VehicleAdd ...` en un campo de un formulario:
    ```ts
    ...
        <v-text-field
          v-model="vehicleAdd.numberPlate"
          :rules="[
            (value: string) => VehicleAdd.externalValidate(value),
          ]"
          :label="t('numberPlate') + ' *'"
          color="primary"
        ></v-text-field>
    ...
    ```
- Transformación a entidades del dominio: Los DTOs deben tener métodos que conviertan sus datos en entidades del dominio, manteniendo así el flujo de datos consistente con el back-end.

#### Vistas

Hola, las vistas en el adaptador Vue.js deben, al menos, pues dependerá de cada aplicación, manejar las operaciones básicas sobre las entidades: agregar, editar, visualizar y listar. Estas vistas están diseñadas para interactuar con los DTOs definidos en la carpeta correspondiente, con los stores para gestionar el estado, y con las rutas configuradas en el router.

A continuación se proporcionan ejemplos para la gestión de una entidad `Vehicle` que cubren las operaciones básicas: `AddVehicle`, `EditVehicle`, `ShowVehicle` y `VehiclesView`. Cada vista debe seguir una estructura consistente para facilitar el mantenimiento y la extensibilidad.
Objetivos:
- Crear vistas consistentes que manejen las operaciones CRUD básicas.
- Utilizar DTOs en los formularios para agregar y editar entidades.
- Usar los stores para la gestión de estado.
- Incorporar validación de formularios y gestión de notificaciones.
- Implementar navegación entre vistas utilizando el enrutador.

**Pasos a realizar para cada entidad:**

1. Generar la vista `AddEntity.vue`. La vista de añadir entidad permite al usuario agregar una nueva entidad mediante un formulario. Se utiliza un DTO para gestionar los valores y la validación de los campos.
Aspectos a tener en cuenta:
   - Crear un componente que renderice un formulario con los campos necesarios para la entidad.
   - Asignar el formulario a un DTO específico (`EntityAdd`) que manejará los valores de los campos.
   - Implementar la validación de los campos utilizando las reglas de validación del DTO.
   - Implementar una acción para enviar los datos al servidor utilizando el store correspondiente.
   - Manejar las notificaciones en caso de éxito o error, y redirigir al usuario a la vista de la lista de entidades tras la adición exitosa.
   A continuación un ejemplo para `AddVehicle.vue`:
    ```ts
    <template>
      <subtitle-app-bar :title="t('addVehicle', 0)" :flag="true" />
      <snackbar :notification="vehicleNotification" />

      <v-row>
        <v-col cols="12" md="12">
          <v-card>
            <v-card-title>
              <v-icon>mdi-car-cog</v-icon>
              {{ t('vehicle') }}
            </v-card-title>
            <v-card-text>
              <v-form ref="VehicleForm">
                <v-text-field
                  v-model="newVehicle.numberPlate"
                  :rules="[
                    (value: string) =>
                      VehicleAdd.externalValidateNumberPlate(value),
                  ]"
                  :label="t('numberPlate') + ' *'"
                  color="primary"
                  required
                ></v-text-field>
                <v-text-field
                  v-model="newVehicle.capacity"
                  :rules="[
                    (value: number) => VehicleAdd.externalValidateCapacity(value),
                  ]"
                  :label="t('capacity') + ' *'"
                  color="primary"
                  type="number"
                  required
                ></v-text-field>
                <v-text-field
                  v-model="newVehicle.driver"
                  :rules="[
                    (value: string) =>
                      !value || VehicleAdd.externalValidateDriver(value),
                  ]"
                  :label="t('driver')"
                  color="primary"
                ></v-text-field>
                <v-select
                  v-model="newVehicle.type"
                  :items="vehicleTypes"
                  :label="t('type')"
                  color="primary"
                  return-object
                ></v-select>
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                @click="validate"
                prepend-icon="mdi-plus"
                variant="elevated"
                color="success"
              >
                {{ t('save') }}
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </template>

    <script lang="ts" setup>
    import { onMounted, ref, watch } from 'vue';
    import { storeToRefs } from 'pinia';
    import { useI18n } from 'vue-i18n';
    import router from '@/router';

    import { useVehicleStore } from '../../stores/vehicle-store';
    import { VehicleAdd } from '../../dto/vehicle-add';
    import SubtitleAppBar from '../../components/SubtitleAppBar.vue';
    import Snackbar from '../../components/Snackbar.vue';
    import { VehicleTypeValues } from '@/main/ts/aidel/domain/enumerate/vehicle-type';
    import { SelectorInterface } from '@kaizten/kaizten-typescript';

    const { t } = useI18n();
    const vehicleStore = useVehicleStore();
    const { vehicleNotification } = storeToRefs(vehicleStore);
    const newVehicle = ref<VehicleAdd>(new VehicleAdd('', 0, undefined, undefined));
    const VehicleForm = ref();
    const errors = ref<string[]>([]);
    const vehicleTypes = ref<SelectorInterface[]>([]);

    onMounted(() => {
      setVehicleTypes();
    });

    const registerVehicle = async () => {
      await vehicleStore.registerVehicle(
        VehicleAdd.toVehicle(newVehicle.value as VehicleAdd)
      );
    };

    const validate = async () => {
      VehicleForm.value?.validate().then(valid => {
        errors.value = [];
        if (valid.valid) {
          registerVehicle();
        } else {
          vehicleStore.setNotification(
            t('messages.errorFormValidate'),
            t('messages.checkForm'),
            'mdi-alert-circle',
            'error'
          );
        }
      });
    };

    const setVehicleTypes = () => {
      for (let i = 0; i < Object.keys(VehicleTypeValues).length; i++) {
        vehicleTypes.value.push(
          new SelectorInterface(
            t(Object.keys(VehicleTypeValues)[i].toLowerCase()),
            Object.keys(VehicleTypeValues)[i]
          )
        );
      }
    };

    watch(
      () => vehicleNotification.value,
      newValue => {
        if (newValue.color === 'success') {
          setTimeout(() => {
            router.push({ name: 'Vehicles' });
          }, 1000);
        }
      }
    );
    </script>

    <style scoped></style>
    ```
> :warning: En este caso se están empleando traducciones de texto mediante `t('ETIQUETA')`. La librería [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) está destinada a esto.

1. Generar la vista `EditEntity.vue`. La vista de editar entidad permite al usuario modificar una entidad existente. Se utiliza un DTO (`EntityEdit`) para manejar los valores y validaciones del formulario.
Aspectos a tener en cuenta:
      - Recuperar la entidad desde el back-end cuando se carga la vista.
      - Mostrar un formulario pre-rellenado con los datos de la entidad.
      - Implementar las reglas de validación mediante el DTO `EntityEdit`.
      - Implementar una acción para actualizar la entidad en el servidor.
      - Manejar notificaciones de éxito o error, y redirigir a la vista de la lista de entidades tras una actualización exitosa.
    
    A continuación un ejemplo para `EditVehicle.vue`:
    ```ts
    <template>
      <subtitle-app-bar :title="title" :flag="true" />
      <snackbar :notification="vehicleNotification" />
      <v-row v-if="!loading">
        <v-col cols="12" md="12">
          <v-card>
            <v-card-title>
              <v-icon>mdi-car-cog</v-icon>
              {{ t('vehicle') }}
            </v-card-title>
            <v-card-text>
              <v-form ref="VehicleForm">
                <v-text-field
                  v-model="newVehicle!.numberPlate"
                  :rules="[
                    (value: string) =>
                      VehicleEdit.externalValidateNumberPlate(value),
                  ]"
                  :label="t('numberPlate') + ' *'"
                  color="primary"
                ></v-text-field>
                <v-text-field
                  v-model="newVehicle!.capacity"
                  :rules="[
                    (value: number) => VehicleEdit.externalValidateCapacity(value),
                  ]"
                  :label="t('capacity') + ' *'"
                  color="primary"
                  type="number"
                ></v-text-field>
                <v-text-field
                  v-model="newVehicle!.driver"
                  :rules="[
                    (value: string) =>
                      !value || VehicleEdit.externalValidateDriver(value),
                  ]"
                  :label="t('driver')"
                  color="primary"
                ></v-text-field>
                <v-select
                  v-model="newVehicle!.type"
                  :items="vehicleTypes"
                  :label="t('type')"
                  color="primary"
                  return-object
                ></v-select>
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                @click="validate"
                prepend-icon="mdi-plus"
                variant="elevated"
                color="success"
              >
                {{ t('edit') }}
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </template>

    <script lang="ts" setup>
    import { onMounted, ref, watch } from 'vue';
    import { storeToRefs } from 'pinia';
    import { useI18n } from 'vue-i18n';
    import { useRoute } from 'vue-router';
    import router from '@/router';

    import { useVehicleStore } from '../../stores/vehicle-store';
    import { VehicleEdit } from '../../dto/vehicle-edit';
    import SubtitleAppBar from '../../components/SubtitleAppBar.vue';
    import Snackbar from '../../components/Snackbar.vue';
    import { VehicleTypeValues } from '@/main/ts/aidel/domain/enumerate/vehicle-type';
    import { SelectorInterface } from '@kaizten/kaizten-typescript';

    const { t } = useI18n();
    const route = useRoute();
    const vehicleStore = useVehicleStore();
    const { vehicle, vehicleNotification } = storeToRefs(vehicleStore);
    const loading = ref(true);
    const title = ref('');
    const vehicleId = ref(route.params.id.toString());
    const VehicleForm = ref();
    const newVehicle = ref<VehicleEdit>();
    const errors = ref<string[]>([]);
    const vehicleTypes = ref<SelectorInterface[]>([]);

    onMounted(async () => {
      loading.value = true;
      await vehicleStore.getVehicleById(vehicleId.value);
      setVehicle();
      setVehicleTypes();
      title.value = t('vehicle') + ' ' + vehicle.value!.getNumberPlate().getValue();
      loading.value = false;
    });

    const setVehicle = () => {
      if (vehicle.value) {
        newVehicle.value = new VehicleEdit(
          vehicle.value.getId().getValue(),
          vehicle.value.getNumberPlate().getValue(),
          vehicle.value.getCapacity().getValue(),
          vehicle.value.getDriver()
            ? vehicle.value.getDriver()!.getValue()
            : undefined,
          vehicle.value.getType()
            ? new SelectorInterface(
                t(vehicle.value.getType()!.getValue().toLowerCase()),
                vehicle.value.getType()!.getValue()
              )
            : undefined
        );
      }
    };

    const updateVehicle = async () => {
      if (!newVehicle.value) return;
      await vehicleStore.updateVehicle(
        vehicleId.value,
        VehicleEdit.toVehicle(newVehicle.value)
      );
    };

    const validate = async () => {
      VehicleForm.value?.validate().then(valid => {
        errors.value = [];
        if (valid.valid) {
          updateVehicle();
        } else {
          vehicleStore.setNotification(
            t('messages.errorFormValidate'),
            t('messages.checkForm'),
            'mdi-alert-circle',
            'error'
          );
        }
      });
    };

    const setVehicleTypes = () => {
      for (let i = 0; i < Object.keys(VehicleTypeValues).length; i++) {
        vehicleTypes.value.push(
          new SelectorInterface(
            t(Object.keys(VehicleTypeValues)[i].toLowerCase()),
            Object.keys(VehicleTypeValues)[i]
          )
        );
      }
    };

    watch(
      () => vehicleNotification.value,
      newValue => {
        if (newValue.color === 'success') {
          setTimeout(() => {
            router.push({ name: 'Vehicles' });
          }, 1000);
        }
      }
    );
    </script>

    <style scoped></style>
    ```

1. Generar la vista `ShowEntity.vue`. La vista de mostrar entidad permite al usuario visualizar los detalles de una entidad sin la opción de editarla. Los campos están deshabilitados, y solo se muestra la información de la entidad.
Aspectos a tener en cuenta:
      - Recuperar la entidad desde el back-end.
      - Renderizar un formulario o campos que muestren la información de la entidad.
      - No se requiere validación en esta vista, ya que no se permite la edición.
      - Esta vista solo es informativa, sin acciones adicionales.
  
    A continuación un ejemplo para `ShowVehicle.vue`:
    ```ts
    <template>
      <subtitle-app-bar :title="title" :flag="true" />
      <v-row v-if="!loading && vehicleInfo">
        <v-col cols="12" md="12">
          <v-card>
            <v-card-title>
              <v-icon>mdi-car-cog</v-icon>
              {{ t('vehicle') }}
            </v-card-title>
            <v-card-text>
              <v-form ref="VehicleForm">
                <v-text-field
                  v-model="vehicleInfo!.numberPlate"
                  :label="t('numberPlate') + ' *'"
                  color="primary"
                  disabled
                ></v-text-field>
                <v-text-field
                  v-model="vehicleInfo!.capacity"
                  :label="t('capacity') + ' *'"
                  color="primary"
                  type="number"
                  disabled
                ></v-text-field>
                <v-text-field
                  v-model="vehicleInfo!.driver"
                  :label="t('driver')"
                  color="primary"
                  disabled
                ></v-text-field>
                <v-text-field
                  :model-value="vehicleInfo.type ? t(vehicleInfo.type) : ''"
                  :label="t('type')"
                  color="primary"
                  disabled
                ></v-text-field>
              </v-form>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </template>

    <script lang="ts" setup>
    import { onMounted, ref } from 'vue';
    import { storeToRefs } from 'pinia';
    import { useI18n } from 'vue-i18n';
    import { useRoute } from 'vue-router';
    import { useVehicleStore } from '../../stores/vehicle-store';
    import SubtitleAppBar from '../../components/SubtitleAppBar.vue';
    import { VehicleInfo } from '../../dto/vehicle-info';
    import { OrganizationInfo } from '../../dto/organization-info';

    const { t } = useI18n();
    const route = useRoute();
    const vehicleStore = useVehicleStore();
    const { vehicle } = storeToRefs(vehicleStore);
    const loading = ref(true);
    const title = ref('');
    const vehicleId = ref(route.params.id.toString());
    const vehicleInfo = ref<VehicleInfo>();

    onMounted(async () => {
      loading.value = true;
      await vehicleStore.getVehicleById(vehicleId.value);
      setVehicle();
      title.value = t('vehicle') + ' ' + vehicle.value?.getNumberPlate().getValue();
      loading.value = false;
    });

    const setVehicle = () => {
      if (vehicle.value) {
        vehicleInfo.value = new VehicleInfo(
          vehicle.value.getId().getValue(),
          vehicle.value.getNumberPlate().getValue(),
          vehicle.value.getCapacity().getValue(),
          new OrganizationInfo(
            vehicle.value.getOrganization().getId().getValue(),
            vehicle.value.getOrganization().getName().getValue()
          ),
          vehicle.value.getDriver() ? vehicle.value.getDriver()!.getValue() : '',
          vehicle.value.getType()
            ? vehicle.value.getType()?.getValue().toLowerCase()
            : ''
        );
      }
    };
    </script>

    <style scoped></style>
    ```

1. Generar la vista `EntitiesView.vue`. La vista de listar entidades muestra todas las entidades del sistema en forma de tabla o lista, con opciones para agregar, editar, ver y eliminar entidades.
Aspectos a tener en cuenta:
   - Implementar una tabla que muestre todas las entidades recuperadas desde el servidor.
   - Añadir botones de acción para agregar, editar, ver o eliminar una entidad.
   - Gestionar la eliminación mediante un diálogo de confirmación.
   - Implementar paginación y filtros si es necesario.
   - Implementar las acciones para redirigir a las vistas correspondientes de agregar, editar o mostrar.
  
    A continuación un ejemplo para `ShowVehicle.vue`:
    ```ts
    <template>
      <subtitle-app-bar :title="t('vehicle', 0)" :flag="false" />
      <Snackbar :notification="vehicleNotification" />
      <div class="ma-4">
        <v-row class="px-5">
          <v-col cols="12" md="auto">
            <v-btn class="mb-5" color="#124E73" @click="addVehicle()">
              <v-icon>mdi-plus</v-icon>
              {{ t('addVehicle') }}
            </v-btn>
          </v-col>
        </v-row>
      </div>
      <div class="ma-4">
        <v-data-table-server
          v-model:items-per-page="itemsPerPage"
          :headers="headers"
          :items-length="serverItemsLenght"
          :items="vehicles"
          :loading="loading"
          :items-per-page-options="[5, 10, 20, 50]"
          item-value="numberPlate"
          hover
          @update:options="loadItems"
        >
          <template v-slot:item.actions="{ item }">
            <v-icon size="small" class="me-2" @click="showItem(item.getId().getValue())" color="#049DBF">mdi-eye</v-icon>
            <v-icon size="small" class="me-2" @click="editItem(item.getId().getValue())" color="success">mdi-pencil</v-icon>
            <v-icon size="small" @click="deleteItem(item.getId().getValue())" color="error">mdi-delete</v-icon>
          </template>
        </v-data-table-server>
      </div>

      <v-dialog v-model="dialogDelete" max-width="500">
        <v-card>
          <v-card-title class="text-h5">{{ t('delete') }}</v-card-title>
          <v-card-text>{{ t('deleteQuestionVehicle') }}</v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn class="mx-2" color="error" @click="dialogDelete = false">{{ t('disagree') }}</v-btn>
            <v-btn class="mx-2" color="success" @click="clickOnDeleteDialog()">{{ t('agree') }}</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </template>

    <script lang="ts" setup>
    import { ref } from 'vue';
    import { storeToRefs } from 'pinia';
    import { useI18n } from 'vue-i18n';
    import router from '@/router';

    import SubtitleAppBar from '../../components/SubtitleAppBar.vue';
    import Snackbar from '../../components/Snackbar.vue';

    import { useVehicleStore } from '../../stores/vehicle-store';

    const { t } = useI18n();
    const vehicleStore = useVehicleStore();
    const { vehicles, vehicleNotification, serverItemsLenght, itemsPerPage } = storeToRefs(vehicleStore);
    const headers: any[] = [
      {
        title: t('numberPlate'),
        align: 'start',
        sortable: false,
        key: 'numberPlate',
      },
      {
        title: t('capacity'),
        align: 'center',
        sortable: false,
        key: 'capacity',
      },
      { title: t('actions'), align: 'center', sortable: false, key: 'actions' },
    ];
    const loading = ref(true);
    const dialogDelete = ref(false);
    const selectedIdVehicle = ref();

    const loadItems = async (options: any) => {
      loading.value = true;
      await vehicleStore.getVehicles(options.page, options.itemsPerPage);
      loading.value = false;
    };

    const addVehicle = () => {
      router.push({ name: 'AddVehicle' });
    };

    const showItem = (itemId: string) => {
      router.push({ name: 'ShowVehicle', params: { id: itemId } });
    };

    const editItem = (itemId: string) => {
      router.push({ name: 'EditVehicle', params: { id: itemId } });
    };

    const deleteItem = (itemId: string) => {
      dialogDelete.value = true;
      selectedIdVehicle.value = itemId;
    };

    const clickOnDeleteDialog = async () => {
      await vehicleStore.deleteVehicle(selectedIdVehicle.value);
      await vehicleStore.getVehicles();
      dialogDelete.value = false;
    };
    </script>

    <style scoped>
    .th {
      background-color: #0a3143;
    }
    </style>
    ```

Aspectos a tener en cuenta:
- Cada vista (`AddEntity`, `EditEntity`, `ShowEntity`, `Entities`) debe seguir las plantillas proporcionadas.
- El formulario debe estar asociado a un DTO específico (`EntityAdd`, `EntityEdit`, `EntityInfo`).
- Los stores deben ser utilizados para manejar el estado y las interacciones con el back-end.
- La validación y manejo de errores debe implementarse correctamente en los formularios.
- La navegación debe permitir moverse entre las vistas de forma fluida (agregar, editar, visualizar, listar).

#### Internacionalización

Hola, este issue tiene como objetivo, implementar la internacionalización de la aplicación de front-end utilizando [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) en la versión `^10.0.4`, asegurando que los archivos de traducción estén organizados dentro de `src/adapter/vuejs/locales`.

**Pasos a realizar:**

1. Instalación de [`vue-i18n`](https://www.npmjs.com/package/vue-i18n). Primero, asegúrate de instalar la dependencia [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) en tu proyecto:

    ```shell
    yarn add vue-i18n@^10.0.4
    ```

2. Organización de archivos de traducción. Crea una carpeta llamada `locales` dentro de `src/adapter/vuejs` para almacenar los archivos de traducción, como `en.json` y `es.json`, que contendrán las traducciones para cada idioma. Por tanto, deberías obtener algo similar a lo siguiente:

    ```lua
    src/
    |-- adapter/
    |   |-- vuejs/
    |       |-- locales/
    |           |-- en.json
    |           |-- es.json
    ```

    El contenido de `src/adapter/vuejs/locales/en.json` debería ser similar a esto:

    ```json
    {
      "welcome": "Welcome",
      "login": "Login",
      "logout": "Logout"
    }
    ```

    El contenido de `src/adapter/vuejs/locales/es.json` debería ser similar a esto:
    ```json
    {
      "welcome": "Bienvenido",
      "login": "Iniciar sesión",
      "logout": "Cerrar sesión"
    }
    ```

3. Configuración de [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) en `main.ts`. En tu archivo `main.ts`, importa [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) y configura la instancia apuntando a la nueva ubicación de los archivos de traducción:

    ```typescript
    import { createApp } from 'vue';
    import { createI18n } from 'vue-i18n';
    import App from './App.vue';

    // Importa los archivos de traducción desde la nueva ubicación
    import en from './adapter/vuejs/locales/en.json';
    import es from './adapter/vuejs/locales/es.json';

    // Configura `vue-i18n`
    const i18n = createI18n({
      legacy: false, // Usa la API de composición de `vue-i18n`
      locale: 'en', // Idioma predeterminado
      fallbackLocale: 'en', // Idioma de respaldo en caso de que una traducción no esté disponible
      messages: {
        en,
        es,
      },
    });

    // Crea y monta la aplicación
    const app = createApp(App);
    app.use(i18n);
    app.mount('#app');
    ```

4. Uso de [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) en los componentes y vistas. Para mostrar las traducciones en tus componentes, utiliza la función `t` proporcionada por [`vue-i18n`](https://www.npmjs.com/package/vue-i18n):

    ```ts
    <template>
      <div>
        <h1>{{ t('welcome') }}</h1>
        <button>{{ t('login') }}</button>
      </div>
    </template>

    <script lang="ts" setup>
    import { useI18n } from 'vue-i18n';

    const { t } = useI18n();
    </script>
    ```

5. Cambio dinámico de idiomas. Para permitir que los usuarios cambien el idioma de la aplicación, puedes crear un selector de idiomas y actualizar la propiedad `locale` de [`vue-i18n`](https://www.npmjs.com/package/vue-i18n):

    ```ts
    <template>
      <div>
        <select @change="changeLanguage($event)">
          <option value="en">English</option>
          <option value="es">Español</option>
        </select>
      </div>
    </template>

    <script lang="ts" setup>
    import { useI18n } from 'vue-i18n';

    const { locale } = useI18n();

    const changeLanguage = (event: Event) => {
      const selectedLanguage = (event.target as HTMLSelectElement).value;
      locale.value = selectedLanguage;
    };
    </script>
    ```

    La integración de [`vue-i18n`](https://www.npmjs.com/package/vue-i18n) con los archivos de traducción organizados en `src/adapter/vuejs/locales` proporciona una estructura coherente para gestionar múltiples idiomas en una aplicación `Vue.js`, facilitando la administración de las traducciones. Este enfoque mejora la experiencia del usuario y hace que la aplicación sea más accesible para una audiencia global.

### Integración de Vuetify

Hola, el diseño de componentes ad-hoc mediante [TypeScript](https://www.typescriptlang.org), CSS y HTML requiere una gran inversión de tiempo para obtener resultados visualmente atractivos. 

Una alternativa es emplear librerías de componentes que ya estén consolidadadas. [Vuetify](https://vuetifyjs.com) es una librería de componentes [Vue.js](https://vuejs.org) que ofrece una amplia gama de elementos predefinidos, diseños responsivos y una estética atractiva que podrían hacer atractiva la interfaz de usuario.

**Pasos a realizar:**

1. Instala [Vuetify](https://vuetifyjs.com) en el front-end para poder emplear los componentes que trae preestablecidos. Siguiendo las indicaciones de la [documentación](https://vuetifyjs.com/en/getting-started/installation/#existing-projects) para proyectos ya existentes, debes ejecutar lo siguiente:
    ```shell
    yarn add vuetify
    ```
2. Revisa el listado de componentes que tiene [Vuetify](https://vuetifyjs.com) desde [aquí](https://vuetifyjs.com/en/components/all) para que te hagas una idea de qué opciones puedes considerar a la hora de diseñar la interfaz de usuario.

## Docker compose

Hola, el proceso de despliegue de la aplicación involucra la creación individual de la base de datos, el back-end y el front-end. Esto no solo consume tiempo, sino que también puede generar inconsistencias en las versiones de cada componente, dificultando las pruebas y el mantenimiento.

La creación de un Docker Compose se presenta como una solución eficiente para simplificar el despliegue de la aplicación en su conjunto. Esta herramienta permite definir y gestionar de manera unificada los contenedores de la base de datos, el back-end y el front-end, lo que facilita su despliegue y ejecución simultánea con una sola instrucción.

**Pasos a realizar:**

1. Para ello, crea un la raíz del repositorio un archivo llamado `docker-compose.yml` con el siguiente contenido:
    ```shell
    services:

      # Front-end
      front-end:
        image: kaizten/<NOMBRE-PROYECTO>_front-end:latest
        container_name: front-end
        ports:
          - 80:80
        depends_on:
          - back-end
        profiles: ["full"]

      # Back-end
      back-end:
        image: kaizten/<NOMBRE-PROYECTO>_back-end:latest
        container_name: back-end
        ports:
          - 8080:8080    
        environment:
          - SPRING_DATA_MONGODB_URI=mongodb://mongo:27017/db-application
        depends_on:
          - mongodb
        profiles: ["back-end", "full"]
      
      # MongoDB
      mongodb:
        image: mongo:latest
        container_name: mongo
        command: mongod --port 27017
        ports:
          - 27017:27017
        volumes:
          - mongodb_volume:/data/db
        profiles: ["database", "back-end", "full"]

      # Watchtower
      watchtower:
        image: containrrr/watchtower
        container_name: watchtower
        restart: always    
        environment:
          WATCHTOWER_CLEANUP: "true"
          WATCHTOWER_DEBUG: "true"
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
        command: --interval 30

    volumes:
      mongodb_volume: {}

    networks:
      default:
        name: fullstack-network
    ```
    Es importante que sustituyas `<NOMBRE-PROYECTO>` por el nombre de tu proyecto en particular.

2. Una vez creado este archivo, puedes ejecutar el proyecto de la siguiente manera:
    ```shell
    docker compose --profile <PERFIL> up
    ```
    En este caso, `<PERFIL>` debe ser uno de los siguientes perfiles definidos en el archivo `docker-compose.yml`:
      * `database`. Únicamente crea el contenedor de la base de datos. Es particularmente interesante cuando se está desarrollando el back-end.
      * `back-end`. Crea contenedores tanto de la base de datos como del back-end, lo cual es interesante a la hora de desarrollar el front-end.
      * `full`. Crea contenedores de la base de datos, back-end y front-end, por lo que tendrías la versión completamente desplegada.

3. Prueba el archivo con los diferentes perfiles y avísame si te funciona correctamente o bien tienes algún problema.

## Algoritmo

### Implementación

Hola, sería necesario crear un algoritmo que reciba como entrada el JSON con los datos proporcionados por el back-end y genere otro JSON incluyendo la solución al problema planteado.

**Pasos a realizar:**

1. Crea en la raíz del repositorio componente hecho en Java llamado `algorithm`. Esto puedes hacerlo ejecutando lo siguiente en la raíz de tu repositorio:
   ```shell
   mvn archetype:generate -DgroupId=com.kaizten.project -DartifactId=algorithm -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.5 -DinteractiveMode=false
   ```

   El resultado debe ser que tengan una nueva carpeta `algorithm` donde desarrollar el algoritmo.

### Algoritmo como servicio

Hola, una vez realizada la implementación del algoritmo, habría que publicarlo como servicio. El objetivo es que haya un endpoint al que pasarle un archivo con los datos de entrada y proporcione como salida otro con el resultado obtenido por el algoritmo. Para evitar tener que programar esto, te pasamos una imagen Docker que debe facilitarte la labor.

**Pasos a realizar:**

1. Añade al archivo `docker-compose.yml` de la aplicación lo siguiente:
    ```yaml
    kaizten-task-lite:
      image: kaizten/kaizten-task-lite:latest
      container_name: kaizten-task-lite
      ports:
        - 9000:8080
      volumes:
        - /home/user/:/tmp
    ```
    En este caso, se está creando un contenedor llamado `kaizten-task-lite` en el puerto `9000`. Puedes elegir otro puerto si prefieres siempre que no se solape con los ya definidos en el archivo de Docker Compose. Por su parte, para poder usar el servicio, crea las siguientes carpetas en algún lugar de tu sistema de archivos:
    * `algorithms/`. Incluye el JAR del algoritmo creado en esta carpeta.
    * `instances/`. Es la carpeta donde debes añadir los ficheros que serán los datos de entrada del algoritmo.
    * `solutions/`. Es el lugar donde se guardarán los resultados obtenidos por el algoritmo al ejecutarse.

    Debes cambiar `/home/user` por la ruta donde hayas creado las carpetas `algorithms/`, `instances/` y `solutions/`.
2. Una vez creado el contenedor Docker puedes hacer lo siguiente:
   * Consultar listado de algoritmos disponibles en `algorithms/`: `curl localhost:9000/algorithms | json_pp`. En este caso, debe proporcionar el listado de distribuciones de algoritmos que tengas guardados en la carpeta `algorithms/`. A continuación se muestra un ejemplo:
      ```shell
      [
        "/tmp/algorithms/algorithm-01.jar",
        "/tmp/algorithms/algorithm-02.jar"
      ]
      ```
    * Ejecutar uno de los algoritmos: `curl -X POST -H "Content-Type: multipart/form-data" -F "instance=@/home/user/instances/test.json" http://localhost:9000/algorithms/my-algorithm.jar`. En este ejemplo, se está tratando de ejecutar `my-algorithm.jar` (debe estar disponible en la carpeta `algorithms/`) usando como datos de entrada `/home/user/instances/test.json`. Es importante que tengas presente que la petición finalizará cuando finalice la ejecución del algoritmo.
   * Consultar listado de soluciones obtenidas y guardadas en `solutions/`: `curl localhost:9000/solutions | json_pp`. A continuación se muestra un ejemplo:
      ```shell
      [
        "/tmp/solutions/solution_2023-11-26T19:51:32.701751113.json"
      ]
      ```
   * Descargar un archivo de solución guardado en `solutions/`: `curl localhost:9000/solutions/solution_2023-11-26T19:51:32.701751113.json --output mySolution.json`

## Grafana

### Primeros pasos

Hola, [Grafana](https://grafana.com) es una plataforma de análisis y visualización de datos de código abierto que permite monitorizar, analizar y visualizar datos en tiempo real desde diferentes fuentes de datos. Es una herramienta muy popular para monitorizar sistemas y aplicaciones, y se utiliza en una amplia variedad de campos, como la logística, la energía, la salud y la fabricación.

Con [Grafana](https://grafana.com), podemos crear paneles (cuadros de mando o dashboards) personalizados y tableros de control con una variedad de visualizaciones de datos, incluyendo gráficos de línea, barras, diagramas de dispersión, mapas, etc. También es compatible con una amplia gama de fuentes de datos, como bases de datos relacionales, bases de datos NoSQL, sistemas de monitorización de infraestructura, sistemas de registro de eventos y más.

**Pasos a realizar:**

1. El primer paso para poder usar [Grafana](https://grafana.com) es crear un contenedor. Esto se hace tal como indica la propia [imagen oficial de Docker](https://hub.docker.com/r/grafana/grafana):
    ```shell
    $ docker run -d --name=grafana -p 3000:3000 grafana/grafana
    ```
    Si todo ha ido bien, una vez ejecutes este comando, puedes acceder a `http://localhost:3000` y se debe mostrar la página de login de [Grafana](https://grafana.com). Las credenciales de acceso por defecto son las siguientes:
   - Usuario: `admin`
   - Contraseña: `admin`

    A partir de este punto, ya puedes empezar a trabajar con [Grafana](https://grafana.com) para crear cuadros de mandos. Para ello, realiza los siguientes pasos.
2. Crea una carpeta `dashboards` en el repositorio para guardar los cuadros de mandos que vayas creando.
3. Crea un primer cuadro de mandos y añade el plugin [JSON API](https://grafana.github.io/grafana-json-datasource/). Está diseñado para inyectar datos desde JSON en los cuadros de mandos. Revisa la sección [Getting started](https://grafana.github.io/grafana-json-datasource/installation) sobre cómo usarlo. Con este objetivo en mente, replica el ejemplo descrito en [este enlace del blog de Grafana](https://grafana.com/blog/2023/08/30/grafana-json-api-how-to-import-third-party-data-sources-in-grafana-cloud/). En el ejemplo tendrás que crear un gráfico extrayendo datos en formato JSON desde una API pública.
4. Exporta el cuadro de mandos en la carpeta `dashboards` previamente creada. De esta manera, cuando vuelvas a arrancar [Grafana](https://grafana.com) tendrás todo montado y no tendrás que repetir el proceso.

### Integración en front-end

Hola, los cuadros de mandos realizados con [Grafana](https://grafana.com) pueden ser integrados en una aplicación web, incluso adaptando el estilo (tipografía, colores, logotipos, etc.).

**Pasos a realizar:**

1. Crea un componente en el front-end que integre el cuadro de mandos diseñado. Sería tal como sigue:
    ```ts
    <template>
      <div>
        <iframe src="http://localhost:3000/d/ec6dc56d-f2e9-4701-a519-611f39913516/graphics-kaizten-traps?orgId=1&from=1544526872810&to=1702293272810"></iframe>
      </div>
    </template>

    <style scoped>
    iframe {
      width: 100%;
      height: 100vh;
    }
    </style>
    ```
    En este caso, tendrías que modificar la URL del iframe para que haga referencia a la del cuadro de mandos.
