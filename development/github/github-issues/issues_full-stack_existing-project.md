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
- [`script-github-commit.sh`](#script-github-commitsh)
- [Back-end](#back-end)
  - [Dominio](#dominio)
    - [Objetos valor](#objetos-valor)
    - [Enumerados](#enumerados)
    - [Entidades](#entidades)
      - [Tests de entidades](#tests-de-entidades)
      - [Tests de los enumerados](#tests-de-los-enumerados)
      - [Tests de objetos valor](#tests-de-objetos-valor)
  - [Aplicación](#aplicación)
    - [Casos de uso](#casos-de-uso)
    - [Adaptador REST](#adaptador-rest)
      - [DTO](#dto)
- [Front-end](#front-end)
  - [Adaptadores](#adaptadores)
    - [Vue.js](#vuejs)
      - [Componentes](#componentes)
        - [Header](#header)
        - [KPI](#kpi)
        - [Language selector](#language-selector)
        - [Snackbar](#snackbar)
        - [Theme switch](#theme-switch)
      - [Carpeta de traducciones](#carpeta-de-traducciones)
- [Sheriff](#sheriff)

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
    Docker version 29.1.5, build 9e34c9b
    ```
    Comprueba que tienes al menos la versión `29` de [Docker](https://www.docker.com). 

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
    v22.22.0
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
    yarn add git+ssh://git@github.com/kaizten/kaizten-vue.git --dry-run
    yarn add v1.22.22
    info No lockfile found.
    [1/4] Resolving packages...
    [2/4] Fetching packages...
    [3/4] Linking dependencies...
    [4/4] Building fresh packages...

    success Saved lockfile.
    success Saved 1 new dependency.
    info Direct dependencies
    └─ kaizten-vue@0.0.0
    info All dependencies
    └─ kaizten-vue@0.0.0
    Done in 8.47s.
    ```
    En este caso, la librería no se instalará sino que se comprobará si es posible acceder a ella.

## Visual Studio Code

### Instalación

Hola, para poder programar de manera cómoda y eficiente es aconsejable emplear un entorno de programación integrado (IDE, por sus siglas en inglés). Actualmente uno de los IDE más versátiles es [Visual Studio Code](https://code.visualstudio.com) (VSC). [Visual Studio Code](https://code.visualstudio.com) es un IDE desarrollado por Microsoft para Windows, Linux, macOS y Web. Incluye soporte para la depuración, control integrado de [Git](https://git-scm.com), resaltado de sintaxis, finalización inteligente de código, fragmentos y refactorización (modificación del código fuente sin cambiar su comportamiento). El IDE es personalizable, por lo que sus usuarios pueden cambiar el tema del editor, los atajos de teclado y las preferencias. Es gratuito y de código abierto y es uno de los IDE más utilizados en la actualidad. 

**Pasos a realizar:**

1. Si no empleas ya un IDE diferente como [NetBeans](https://netbeans.apache.org), [IntelliJ IDEA](https://www.jetbrains.com/idea/), o [Eclipse](https://eclipseide.org), entre otros, te propongo instalar [Visual Studio Code](https://code.visualstudio.com) (al menos la versión `1.111.0`) en tu máquina. 
2. Cuando hayas instalado [Visual Studio Code](https://code.visualstudio.com), ejecuta el siguiente comando desde una terminal para comprobar que se ha instalado correctamente:
    ```shell
    $ code --version
    1.111.0
    ce099c1ed25d9eb3076c11e4a280f3eb52b4fbeb
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

## `script-github-commit.sh`

Hola, hemos preparado un script estándar para gestionemos nuestros commits y pushes de manera segura y ordenada. El script se llama `script-github-commit.sh` y puedes encontrarlo en la raíz de tu repositorio de trabajo. Su función principal es subir tus cambios al repositorio remoto en [GitHub](www.github.com) evitando conflictos innecesarios.

**¿Qué hace este script?**

1. Hace un `git pull` al inicio. Esto asegura que siempre tengas la versión más reciente del repositorio antes de subir tus cambios. De esta manera:
    * Así evitas sobrescribir el trabajo de otros compañeros.
    * Si hay conflictos, `git` te avisará y tendrás que resolverlos antes de continuar.
2. Añade todos los cambios (`git add .`):
    * Detecta y prepara automáticamente los archivos modificados para el `commit`.
3. Comprueba si realmente hay cambios pendientes:
    * Si hay cambios, te pedirá un mensaje de `commit`.
    * Si no hay nada nuevo, te lo indicará y no hará nada más.
4. Sube los cambios al repositorio (`git push`):
    * Solo si todo ha ido bien, los cambios se envían al repositorio remoto.

**Algunas cuestiones importantes a tener en cuenta:**

1. Usa siempre este script para subir cambios. De esta manera garantizamos que antes de cada `push` tu copia local esté sincronizada con el repositorio remoto.
2. Nunca fuerces subidas (`git push --force`). Forzar un `push` puede borrar el trabajo de otros compañeros. 
3. No crees nuevas ramas sin avisar. Todos trabajamos en la rama definida para el proyecto (generalmente `main`). Crear ramas adicionales sin coordinación puede complicar el flujo de trabajo.
4. Escribe mensajes de commit claros. Recuerda que el historial de commits es la memoria del proyecto. Mensajes como `cambios` o `varios` no ayudan.

**Pasos a realizar:**

1. Haz algún cambio menor en el código de tu repositorio (por ejemplo, añadir algún espacio en blanco).
2. Ejecuta el script, tal como sigue:
    ```sh
   ./script-github-commit.sh 
    📥 Pulling repository...
    Already up-to-date.
    ✏️  Enter your message in the commit: new feature aimed at generating reports
    [main c99075f] new feature aimed at generating reports
    1 file changed, 32 insertions(+)
    🚀 Pushing data to remote GitHub repository:
    Enumerating objects: 11, done.
    Counting objects: 100% (11/11), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (6/6), 1.54 KiB | 262.00 KiB/s, done.
    Total 6 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: Resolving deltas: 100% (5/5), completed with 5 local objects.
    To github.com:kaizten/kaizten-base.git
      ebc4a96..c99075f  main -> main
    ✅ Done!
    ```
    Comprueba que todo ha funcionado correctamente.

## Back-end

### Dominio

#### Objetos valor

Hola, si te parece bien, vamos a ir revisando cada parte del código para que corregir cosas. 

Podemos empezar por los objetos valor del dominio. En el siguiente enlace tienes una descripción sobre cómo diseñar objetos valor y qué características deben cumplir:

[https://kaizten.github.io/development/ddd/value-objects.html](https://kaizten.github.io/development/ddd/value-objects.html)

Revisa con calma los objetos valor que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

#### Enumerados

Hola, otro aspecto a revisar del dominio son los enumerados. En el siguiente enlace tienes una descripción sobre cómo diseñar enumerados y qué características deben cumplir:

[https://kaizten.github.io/development/ddd/enumerates.html](https://kaizten.github.io/development/ddd/enumerates.html)

Revisa con calma los enumerados que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

#### Entidades

Hola, el elemento fundamental del dominio son las entidades. Te paso un enlace donde se describen:

[https://kaizten.github.io/development/ddd/entities.html](https://kaizten.github.io/development/ddd/entities.html)

Revisa con calma las entidades que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

##### Tests de entidades

Hola, las entidades del dominio deben estar testeadas para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/hexagonal-architecture/entity_tests.html) tienes una guía de los tests que debería tener cada entidad de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las entidades y plantea cualquier duda que pueda surgirte.
2. Implementa para cada entidad de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

##### Tests de los enumerados

Hola, los enumerados del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/hexagonal-architecture/enumerate_tests.html) tienes una guía de los tests que debería tener cada enumerado de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las enumerados y plantea cualquier duda que pueda surgirte.
2. Implementa para cada enumerado de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

##### Tests de objetos valor

Hola, los objetos de valor del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/hexagonal-architecture/value-object_tests.html) tienes una guía de los tests que debería tener cada objeto de valor de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de los objetos de valor y plantea cualquier duda que pueda surgirte.
2. Implementa para cada objeto de valor de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

### Aplicación

#### Casos de uso

Hola, habría que ir definiendo bien y revisando los casos de uso de la aplicación. Cada caso de uso debe ser una **interfaz** con un **único método** (por lo general). Deben estar en la carpeta `application/usecase`.

Por ello, revisa que, para cada entidad, hayan casos de uso para la creación, eliminación, búsqueda y actualización. Esto es, si tienes una entidad `<ENTITY>.java`, deberías tener los siguientes casos de uso:
- `Create<ENTITY>UseCase.java`
- `Delete<ENTITY>UseCase.java`
- `Fetch<ENTITY>UseCase.java`
- `Update<ENTITY>UseCase.java`

Los servicios deben ser clases que implementen dichos casos de uso. **Debes tener un servicio por cada caso de uso.** Siguiendo el caso anterior, el servicio sería `CreateContainerService` y debería estar en la carpeta `application/service` que ya tienes creada.

Disculpa que se me olvidaban cosas jeje

Una vez creado cada caso de uso, los controladores (en `adaptar/rest`) deben usar los casos de uso. **Nunca los servicios.** Por tanto, revisa que tengan casos de uso inyectados en lugar de servicios. Por ejemplo, `ContainerController.createContainer` usa un servicio, lo cual sería incorrecto.

Por último, tendrías que ir a `ApplicationConfiguration` y cambiar esto:
```java
@Bean
public ContainerService containerService() {
    return new ContainerService();
}
```
por esto
```
@Bean
public CreateContainerUseCase createContainerUseCase() {
    return new CreateContainerService();
}
```
Con esto, obligas a que siempre se use el caso de uso (`CreateContainerUseCase`) sin conocer su implementación particular (`CreateContainerService`).

#### Adaptador REST

##### DTO

Hola, los clientes que empleen el API REST definida en el back-end deberían emplear objetos de clases diferentes a las entidades del dominio para evitar el acoplamiento así como facilitar la validación de datos. Por ello, dentro del controlador `adapter/rest` crea una carpeta `dto` donde añadir [Data Transfer Objects](https://www.baeldung.com/java-dto-pattern).

**Pasos a realizar:**

1. Dentro de la carpeta del adaptador REST (`adapter/rest/dto`)), debes crear una clase `<ENTITY>PostRequestBody.java`, otra `<ENTITY>PutRequestBody.java` y otra `<ENTITY>ResponseBody.java` por cada entidad de tu dominio `<ENTITY>`. A continuación te paso un ejemplo ilustrativo para una entidad `Trap.java`:
```java
public class TrapPostRequestBody {

    private TrapName name;
    private TrapDescription description;
    private TrapType type;
    private UUID entryPoint;
    private KaiztenGeolocationPoint geolocation;
    private LocalDate installationDate;
    private LocalDate leavingDate;
    private ContactInformation contactInformation;
    private List<Comment> comments;
    private List<UUID> imageUUID;

    public LocalDate getInstallationDate() {
        return this.installationDate;
    }

    public void setInstallationDate(LocalDate installationDate) {
        this.installationDate = installationDate;
    }

    public LocalDate getLeavingDate() {
        return this.leavingDate;
    }

    public void setLeavingDate(LocalDate leavingDate) {
        this.leavingDate = leavingDate;
    }

    public TrapName getName() {
        return this.name;
    }

    public void setName(TrapName name) {
        this.name = name;
    }

    public TrapDescription getDescription() {
        return this.description;
    }

    public void setDescription(TrapDescription description) {
        this.description = description;
    }

    public ContactInformation getContactInformation() {
        return this.contactInformation;
    }

    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
    }

    public void setGeolocation(KaiztenGeolocationPoint geolocation) {
        this.geolocation = geolocation;
    }

    public KaiztenGeolocationPoint getGeolocation() {
        return this.geolocation;
    }

    public List<Comment> getComments() {
        return this.comments;
    }

    public TrapType getType() {
        return this.type;
    }

    public List<UUID> getImageUUID() {
        return this.imageUUID;
    }

    public UUID getEntryPoint() {
        return this.entryPoint;
    }

    public int getNumberOfImages() {
        return (this.hasImages()) ? this.imageUUID.size() : 0;
    }

    private boolean hasComments() {
        return this.comments != null && !this.comments.isEmpty();
    }

    public boolean hasImages() {
        return this.imageUUID != null && !this.imageUUID.isEmpty();
    }

    public boolean hasGeolocation() {
        return this.geolocation != null;
    }

    public boolean hasType() {
        return (this.type != null);
    }

    public void setEntryPoint(UUID entryPoint) {
        this.entryPoint = entryPoint;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void setImageUUID(List<UUID> images) {
        this.imageUUID = images;
    }

    public void setType(TrapType type) {
        this.type = type;
    }

    public Trap toTrap(
            FetchEntryPointUseCase fetchEntryPointUseCase,
            FetchFileUseCase fetchFileUseCase,
            JwtAuthConverter authConverter,
            Authentication authentication) {
        EntryPoint ep = fetchEntryPointUseCase.fetchEntryPointById(this.entryPoint).orElseThrow();
        JwtAuthenticationToken jwtAuthenticationToken = (JwtAuthenticationToken) authentication;
        Jwt jwt = jwtAuthenticationToken.getToken();
        String principalAttribute = authConverter.getPrincipleClaimName(jwt);
        KaiztenJWTPreferredUsername preferredUsername = new KaiztenJWTPreferredUsername(principalAttribute);
        Trap trap = new Trap(
                this.getName(),
                this.getType(),
                ep,
                this.getGeolocation(),
                preferredUsername);
        // Optional attributes:
        trap.setContactInformation(this.getContactInformation());
        trap.setDescription(this.getDescription());
        if (this.hasComments()) {
            for (Comment comment : this.comments) {
                trap.addComment(comment);
            }
        }
        if (this.hasImages()) {
            for (UUID uuid : this.imageUUID) {
                fetchFileUseCase.fetchFileById(uuid).ifPresent((image) -> {
                    trap.addImage(image);
                });
            }
        }
        trap.setInstallationDate(this.getInstallationDate());
        trap.setLeavingDate(this.getLeavingDate());
        return trap;
    }

    public String toString() {
        final String representationType = (this.hasType()) ? this.type.toString() : "null";
        final String representationGeolocation = (this.hasGeolocation()) ? this.geolocation.toString() : "null";
        final String representationImages = (this.hasImages()) ? this.imageUUID.toString() : "null";
        return "TrapPostRequestBody={" +
                "name=" + this.name + "," +
                "contactInformation=" + this.contactInformation + "," +
                "description=" + this.description + "," +
                "type=" + representationType + "," +
                "entryPoint=" + this.entryPoint + "," +
                "geolocation=" + representationGeolocation + "," +
                "images=" + representationImages + "," +
                "installationDate=" + this.installationDate + "," +
                "leavingDate=" + this.leavingDate +
                "}";
    }
}
```
y 
```java
public class TrapResponseBody {

    private UUID id;
    private TrapName name;
    private TrapDescription description;
    private TrapType type;
    private UUID entryPoint;
    private KaiztenGeolocationPoint geolocation;
    private LocalDate installationDate;
    private LocalDate leavingDate;
    private ContactInformation contactInformation;
    private List<UUID> images;
    private List<Comment> comments;
    private KaiztenJWTPreferredUsername creator;

    public Optional<LocalDate> getInstallationDate() {
        return Optional.ofNullable(this.installationDate);
    }

    public void setInstallationDate(LocalDate installationDate) {
        this.installationDate = installationDate;
    }

    public Optional<LocalDate> getLeavingDate() {
        return Optional.ofNullable(this.leavingDate);
    }

    public KaiztenJWTPreferredUsername getCreator() {
        return this.creator;
    }

    public void setLeavingDate(LocalDate leavingDate) {
        this.leavingDate = leavingDate;
    }

    public UUID getId() {
        return this.id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public TrapName getName() {
        return this.name;
    }

    public void setName(TrapName name) {
        this.name = name;
    }

    public Optional<TrapDescription> getDescription() {
        return Optional.ofNullable(this.description);
    }

    public void setDescription(TrapDescription description) {
        this.description = description;
    }

    public Optional<ContactInformation> getContactInformation() {
        return Optional.ofNullable(this.contactInformation);
    }

    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
    }

    public void setGeolocation(KaiztenGeolocationPoint geolocation) {
        this.geolocation = geolocation;
    }

    public KaiztenGeolocationPoint getGeolocation() {
        return this.geolocation;
    }

    public void setType(TrapType type) {
        this.type = type;
    }

    public TrapType getType() {
        return this.type;
    }

    public List<UUID> getImages() {
        return this.images;
    }

    public boolean hasImages() {
        return this.images != null;
    }

    public void setImages(List<UUID> images) {
        this.images = images;
    }

    public List<Comment> getComments() {
        return this.comments;
    }

    public boolean hasComments() {
        return this.comments != null && !this.comments.isEmpty();
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public UUID getEntryPoint() {
        return this.entryPoint;
    }

    public void setEntryPoint(UUID entryPoint) {
        this.entryPoint = entryPoint;
    }

    public void setCreator(KaiztenJWTPreferredUsername creator) {
        this.creator = creator;
    }

    public boolean hasDescription() {
        return this.description != null;
    }

    public boolean hasContactInformation() {
        return this.contactInformation != null;
    }

    public boolean hasInstallationDate() {
        return this.installationDate != null;
    }

    public boolean hasLeavingDate() {
        return this.leavingDate != null;
    }

    public static TrapResponseBody from(Trap trap) {
        TrapResponseBody responseBody = new TrapResponseBody();
        responseBody.id = trap.getId();
        responseBody.name = trap.getName();
        responseBody.type = trap.getType();
        responseBody.entryPoint = trap.getEntryPoint().getId();
        responseBody.geolocation = trap.getGeolocation();
        responseBody.creator = trap.getCreator();
        if (trap.hasImages()) {
            responseBody.images = new ArrayList<>(trap.getNumberOfImages());
            for (File image : trap.getImages().get()) {
                responseBody.images.add(image.getId());
            }
        }
        if (trap.hasComments()) {
            responseBody.comments = new ArrayList<>(trap.getNumberOfComments());
            for (Comment comment : trap.getComments().get()) {
                responseBody.comments.add(comment);
            }
        }
        // Optional attributes:
        trap.getDescription().ifPresent((description) -> {
            responseBody.description = description;
        });
        trap.getInstallationDate().ifPresent((installationDate) -> {
            responseBody.installationDate = installationDate;
        });
        trap.getLeavingDate().ifPresent((leavingDate) -> {
            responseBody.leavingDate = leavingDate;
        });
        trap.getContactInformation().ifPresent((contactInformation) -> {
            responseBody.contactInformation = contactInformation;
        });
        return responseBody;
    }

    public String toString() {
        final String representationComments = (this.hasComments()) ? this.comments.toString() : "null";
        final String imagesId = (this.hasImages()) ? this.images.toString() : "null";
        return "TrapResponseBody={" +
                "id=" + this.id + "," +
                "name=" + this.name + "," +
                "contactInformation=" + this.contactInformation + "," +
                "description=" + this.description + "," +
                "type=" + type + "," +
                "entryPoint=" + this.entryPoint + "," +
                "geolocation=" + geolocation + "," +
                "comments=" + representationComments + "," +
                "images=" + imagesId + "," +
                "installationDate=" + this.installationDate + "," +
                "leavingDate=" + this.leavingDate + "," +
                "creator=" + this.creator +
                "}";
    }
}
```
Fíjate en la implementación de los métodos estáticos que tienen las clases anteriores. Están diseñados para convertir el DTO correspondiente en entidad (o viceversa) así como para generar objetos aleatoriamente. También es particularmente importante en que te fijes en que se retorna `Optional` en los getters de aquellos atributos que son opcionales en la entidad.

2. Una vez creados los DTO, debes eliminar las entidades en los parámetros y los valores de retorno de los controladores creados en el adaptador. Esto significa que los controladores deben recibir DTO y devolver DTO en lugar de entidades de tu dominio. 

## Front-end

### Adaptadores

#### Vue.js

##### Componentes

###### Header

Hola, en `kaizten-vue` hay un componente que permite mostrar una cabecera en la herramienta. La documentación y ejemplos de uso puedes encontrarlos [aquí](https://github.com/kaizten/kaizten-vue/tree/main/kaizten-vue/src/components/header).

**Pasos a realizar:**

1. Elimina el componente `NavBar.vue` y sustituye su uso por el de la librería `kaizten-vue`.
2. Si identificas alguna necesidad o error en el uso del componente existente en `kaizten-vue`, házmelo saber para tratar de mejorarlo o corregirlo y que en tu proyecto simplemente lo uses.

###### KPI

Hola, en `kaizten-vue` hay un componente que permite mostrar KPIs de diferentes formatos en una vista. La documentación y ejemplos de uso puedes encontrarlos [aquí](https://github.com/kaizten/kaizten-vue/tree/main/kaizten-vue/src/components/kpi).

**Pasos a realizar:**

1. Elimina el componente `DisplayKPIs.vue` y sustituye su uso por el de la librería `kaizten-vue`.
2. Si identificas alguna necesidad o error en el uso del componente existente en `kaizten-vue`, házmelo saber para tratar de mejorarlo o corregirlo y que en tu proyecto simplemente lo uses.

###### Language selector

Hola, en `kaizten-vue` hay un componente que permite seleccionar idiomas. La documentación y ejemplos de uso puedes encontrarlos [aquí](https://github.com/kaizten/kaizten-vue/tree/main/kaizten-vue/src/components/language-selector).

**Pasos a realizar:**

1. Elimina el componente `LanguageSelector.vue` y sustituye su uso por el de la librería `kaizten-vue`.
2. Si identificas alguna necesidad o error en el uso del componente existente en `kaizten-vue`, házmelo saber para tratar de mejorarlo o corregirlo y que en tu proyecto simplemente lo uses.

###### Snackbar

Hola, en `kaizten-vue` hay un componente que permite mostrar mensajes rápidos al usuario (snackbar). La documentación y ejemplos de uso puedes encontrarlos [aquí](https://github.com/kaizten/kaizten-vue/tree/main/kaizten-vue/src/components/snackbar).

**Pasos a realizar:**

1. Elimina el componente `Snackbar.vue` y sustituye su uso por el de la librería `kaizten-vue`.
2. Si identificas alguna necesidad o error en el uso del componente existente en `kaizten-vue`, házmelo saber para tratar de mejorarlo o corregirlo y que en tu proyecto simplemente lo uses.

###### Theme switch

Hola, en `kaizten-vue` hay un componente que permite cambiar el tema de la aplicación (oscuro/claro). La documentación y ejemplos de uso puedes encontrarlos [aquí](https://github.com/kaizten/kaizten-vue/tree/main/kaizten-vue/src/components/theme-switch).

**Pasos a realizar:**

1. Elimina el componente `ThemeSwitch.vue` y sustituye su uso por el de la librería `kaizten-vue`.
2. Si identificas alguna necesidad o error en el uso del componente existente en `kaizten-vue`, házmelo saber para tratar de mejorarlo o corregirlo y que en tu proyecto simplemente lo uses.

##### Carpeta de traducciones

Hola, las traducciones es algo relativo a la visualización de elementos en pantalla. 

**Pasos a realizar:**

1. Pon la carpeta `locales` dentro del adaptador de Vue.js. Esto es, `adapter/vuejs/locales`.

## Sheriff

Hola, en la empresa tenemos una herramienta llamada `Sheriff` para el control de calidad del código. Esta herramienta realiza diversas comprobaciones sobre los componentes de software existentes en el repositorio. Algunas de estas comprobaciones son: documentación adecuada, uso de `@Override` en métodos sobrecargados, uso de llaves en condicionales y bucles, etc.

En el repositorio, puedes encontrar un script llamado `sheriff.sh`. Este script aplica `Sheriff` sobre los componentes de software de tu repositorio y, si lo hay, te muestra un listado en formato JSON con los errores y warnings detectados. También, en cada error o warning te indica cómo resolverlo para ayudarte en la mejora de la calidad del código.

Es importante tener en cuenta que la ejecución del script puede tardar un cierto tiempo, especialmente cuando se analiza código TypeScript. Por tanto, sé paciente cuando ejecutes el script. El aspecto positivo es que únicamente analiza los archivos de código fuente que han cambiado desde la anterior ejecución del script.

En base a lo anterior, ejecuta el script `sheriff.sh`. Comprueba los posibles errores que muestra y corrígelos para mejorar la calidad del código.