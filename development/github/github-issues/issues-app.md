<!-- TOC -->

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
- [Arquitectura hexagonal](#arquitectura-hexagonal)
- [App](#app)
  - [Crear proyecto base](#crear-proyecto-base)
  - [Rutas y navegación](#rutas-y-navegación)
  - [Capa de dominio](#capa-de-dominio)
  - [Capa de aplicación](#capa-de-aplicación)
    - [1) Escenario A. Usar capa de aplicación existente desde un *core-typescript*](#1-escenario-a-usar-capa-de-aplicación-existente-desde-un-core-typescript)
      - [1.1 Instalación de dependencias](#11-instalación-de-dependencias-1)
      - [1.2 Estructura esperada](#12-estructura-esperada-1)
      - [1.3 Reexportar los componentes del core](#13-reexportar-los-componentes-del-core)
    - [2) Escenario B. Crear la capa de aplicación manualmente](#2-escenario-b-crear-la-capa-de-aplicación-manualmente)
      - [2.2 Principios de diseño](#22-principios-de-diseño)
      - [2.3 Ejemplo completo — Caso de uso de login](#23-ejemplo-completo--caso-de-uso-de-login)
        - [Definición del caso de uso](#definición-del-caso-de-uso)
        - [Implementación del servicio](#implementación-del-servicio)
        - [Flujo resumido](#flujo-resumido)
      - [2.4 Ejemplo de repositorio](#24-ejemplo-de-repositorio)
      - [2.5 Prácticas a seguir](#25-prácticas-a-seguir)
    - [3) Resultado esperado](#3-resultado-esperado)
  - [Capa de adaptadores HTTP](#capa-de-adaptadores-http)
    - [1) Escenario A. Usar adaptadores HTTP existentes desde un *core-typescript*](#1-escenario-a-usar-adaptadores-http-existentes-desde-un-core-typescript)
      - [1.1 Estructura esperada](#11-estructura-esperada)
      - [1.2 Reexportar adaptadores y DTOs desde el *core-typescript*](#12-reexportar-adaptadores-y-dtos-desde-el-core-typescript)
    - [2) Escenario B. Crear la capa de adaptadores HTTP manualmente](#2-escenario-b-crear-la-capa-de-adaptadores-http-manualmente)
      - [2.1 Estructura esperada](#21-estructura-esperada)
      - [2.2 Creación de repositorios HTTP](#22-creación-de-repositorios-http)
        - [Ejemplo: `OrganizationHttpRepository`](#ejemplo-organizationhttprepository)
      - [2.3 Creación de DTOs](#23-creación-de-dtos)
        - [Ejemplo: `OrganizationPutJsonRequest`](#ejemplo-organizationputjsonrequest)
        - [Ejemplo: `OrganizationPostJsonRequest`](#ejemplo-organizationpostjsonrequest)
        - [Ejemplo: `OrganizationJsonResponse`](#ejemplo-organizationjsonresponse)
<!-- /TOC -->

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

Hola, [Yarn](https://yarnpkg.com) es un administrador de paquetes de código abierto utilizado en el desarrollo de software para gestionar dependencias y facilitar la construcción de proyectos en lenguajes de programación como [JavaScript](https://developer.mozilla.org/es/docs/Web/JavaScript) o [TypeScript](https://www.typescriptlang.org).

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

Hola, hemos creado una pequeña librería de utilidades en [TypeScript](https://www.typescriptlang.org) que nos ayuda en el desarrollo de aplicaciones: [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript). En ella hay diversas utilidades para trabajar con fechas, conexiones a servidor, etc.

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

## `script-github-commit.sh`

En Kaizten Analytics hemos preparado un script estándar para gestionemos nuestros commits y pushes de manera segura y ordenada. El script se llama `script-github-commit.sh` y puedes encontrarlo en la raíz de tu repositorio de trabajo. Su función principal es subir tus cambios al repositorio remoto en [GitHub](www.github.com) evitando conflictos innecesarios.

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

## App

### Crear proyecto base

En este paso se creará la **base del proyecto móvil** con **Expo + TypeScript**, siguiendo una estructura limpia y escalable alineada con la **arquitectura hexagonal**. Se establecerán las **configuraciones iniciales**, las **dependencias principales** (navegación, UI, linting y testing) y la **estructura de carpetas** que servirá como punto de partida para el desarrollo modular de la aplicación.

**Pasos a realizar:**

**1. Crear proyecto Expo + TypeScript**

    ```bash
    npx create-expo-app@latest app -t expo-template-blank-typescript
    cd app
    ```

    > Esto crea la base con `App.tsx`, `app.json`, etc. Usaremos `App.tsx` como entrada y añadiremos un **`index.ts`** para registrar el root (opcional pero recomendado para consistencia).

**2. Dependencias**

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1 Navegación y UI**

Usa **`expo install`** para resolver versiones compatibles:
```bash
# Borramos archivos lock
rm package-lock.json
# React Navigation core + native stack
yarn add @react-navigation/native @react-navigation/native-stack
npx expo install react-native-gesture-handler react-native-screens react-native-safe-area-context @react-native-masked-view/masked-view

# Async Storage
yarn add @react-native-async-storage/async-storage

# UI (Paper) + Iconos (Expo)
yarn add react-native-paper @expo/vector-icons
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.2 Lint, Prettier y Testing**

```bash
# Borramos archivos lock
rm yarn.lock
# Añadimos dependencias
yarn add -D eslint prettier @types/jest jest @testing-library/react-native
```

**3. Scripts en `package.json`**

Edita `package.json` y añade estos flags en scripts:

```json
{
  ...
  "scripts": {
    ...
    "lint": "eslint . --ext .ts,.tsx",
    "test": "jest"
    ...
  }
  ...
}
```

**4. Estructura hexagonal y ficheros base**

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.1 Crear estructura**

En la raíz del proyecto ejecuta lo siguiente para crear la **estructura base de la arquitectura hexagonal**.
```bash
mkdir -p src/domain/{entity,valueobject,enumerate}
mkdir -p src/application/{usecase,service,repository}
mkdir -p src/adapter/{react-native/screens,http,persistence}
mkdir -p src/configuration
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.2 Raíz del proyecto `src/adapter/react-native/screens/App.tsx`**

El `App.tsx` generado en la raiz del proyecto pásalo a **dentro de `src/adapter/react-native/screens/App.tsx`** con el contenido que se expone a continuación, además apuntaremos la entrada a él (paso 4.3).

```tsx
import { StyleSheet } from 'react-native';
import { Provider as PaperProvider, Text } from 'react-native-paper';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { SafeAreaProvider, SafeAreaView } from 'react-native-safe-area-context';

const Stack = createNativeStackNavigator();

function HomeScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['top', 'left', 'right']}>
      <Text variant="titleMedium" style={styles.text}>
        Expo + TypeScript + Hexagonal
      </Text>
    </SafeAreaView>
  );
}

export default function App() {
  return (
    <PaperProvider>
      <SafeAreaProvider>
        <NavigationContainer>
          <Stack.Navigator>
            <Stack.Screen name="Inicio" component={HomeScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      </SafeAreaProvider>
    </PaperProvider>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  text: { textAlign: 'center' },
});
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.3 Crear `index.ts` (en la **raíz del proyecto**)**

Expo puede arrancar con `App.tsx` directo, pero usamos `index.ts` para registrar el root y apuntar a nuestra `App` bajo `src/`.

```ts
import { registerRootComponent } from 'expo';
import App from './src/adapter/react-native/screens/App';

registerRootComponent(App);
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.4 Ajustar la entrada de la app**

Edita `app.json` para que Expo use `index.ts` como entrada (propiedad `entryPoint`):
```json
{
  "expo": {
    ...
    "entryPoint": "index.ts",
    ...
  }
}
```
> No borres otras propiedades que ya existan en tu `app.json`; añade `entryPoint`.

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.5 Crear `tsconfig.json` (en la raíz)**
```json
{
  "compilerOptions": {
    "target": "esnext",
    "module": "esnext",
    "jsx": "react-jsx",
    "strict": true,
    "moduleResolution": "node",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "noEmit": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "baseUrl": "./src",
    "paths": {
      "@domain/*": ["domain/*"],
      "@application/*": ["application/*"],
      "@adapter/*": ["adapter/*"],
      "@configuration/*": ["configuration/*"]
    }
  },
  "include": ["src", "index.ts"],
  "exclude": ["node_modules"]
}
```

**5. Arranque**

Primero instala las siguientes dependencias para el arranque web:
```bash
npx expo install react-dom react-native-web
```

Posteriormente ejecuta:

```bash
yarn install
yarn start
# Pulsa "w" (Web), para verlo en web
```

Deberías ver en el navegador la pantalla inicial definida en **App.tsx**.


### Rutas y navegación

En este issue, el alumno aprenderá a **crear el sistema de navegación principal** de la aplicación móvil Expo con arquitectura hexagonal. El objetivo es disponer de un **menú lateral (Drawer)** y varias pantallas simples para probar las rutas y el sistema de navegación.

**Pasos a realizar:**

**1. Dependencias adicionales de navegación**

Ya que partimos del proyecto creado en el issue anterior, solo añadiremos el paquete del menú lateral.

```bash
# Menú lateral (Drawer Navigation)
yarn add @react-navigation/drawer
```

> **Nota:** Ya se instalaron las dependencias base (`@react-navigation/native`, `@react-navigation/native-stack`, `react-native-screens`, `react-native-safe-area-context`, etc.) en el issue anterior.


**2. Estructura de archivos de navegación**

Siguiendo la arquitectura hexagonal, la navegación se ubica dentro de la carpeta `adapter/react-native/navigation/`.

Crea las siguientes rutas y archivos:

```
src/
  adapter/
    react-native/
      navigation/
        AppNavigator.tsx
      screens/
        HomeScreen.tsx
        SettingsScreen.tsx
```

**3. Creación de pantallas de ejemplo**

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.1 Crear `src/adapter/react-native/screens/HomeScreen.tsx`**

```tsx
import { StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Text, Button } from 'react-native-paper';

export default function HomeScreen({ navigation }: any) {
  return (
    <SafeAreaView style={styles.container} edges={['top', 'left', 'right']}>
      <Text variant="titleLarge" style={styles.text}>
        Pantalla de inicio
      </Text>
      <Button mode="contained" onPress={() => navigation.navigate('Settings')}>
        Ir a configuración
      </Button>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  text: { marginBottom: 20, textAlign: 'center' }
});
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.2 Crear `src/adapter/react-native/screens/SettingsScreen.tsx`**

```tsx
import { StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Text } from 'react-native-paper';

export default function SettingsScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['top', 'left', 'right']}>
      <Text variant="titleLarge" style={styles.text}>
        Configuración
      </Text>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  text: { textAlign: 'center' }
});
```

**4. Definir el contenedor de navegación**

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.1 Crear `src/adapter/react-native/navigation/AppNavigator.tsx`**

Crea un contenedor que gestione las rutas y el menú lateral.

```tsx
import { createDrawerNavigator } from '@react-navigation/drawer';
import { NavigationContainer } from '@react-navigation/native';
import { Provider as PaperProvider } from 'react-native-paper';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import HomeScreen from '../screens/HomeScreen';
import SettingsScreen from '../screens/SettingsScreen';

const Drawer = createDrawerNavigator();

export default function AppNavigator() {
  return (
    <PaperProvider>
      <SafeAreaProvider>
        <NavigationContainer>
          <Drawer.Navigator
            initialRouteName="Home"
            screenOptions={{
              headerStyle: { backgroundColor: '#1976d2' },
              headerTintColor: 'white',
              drawerActiveBackgroundColor: '#e3f2fd',
              drawerActiveTintColor: '#1976d2',
              drawerLabelStyle: { fontSize: 16 }
            }}
          >
            <Drawer.Screen
              name="Home"
              component={HomeScreen}
              options={{ title: 'Inicio' }}
            />
            <Drawer.Screen
              name="Settings"
              component={SettingsScreen}
              options={{ title: 'Configuración' }}
            />
          </Drawer.Navigator>
        </NavigationContainer>
      </SafeAreaProvider>
    </PaperProvider>
  );
}
```

> El `Drawer.Navigator` define el menú lateral.  
> Cada `Drawer.Screen` es una pantalla accesible desde ese menú.  
> `PaperProvider` y `SafeAreaProvider` envuelven toda la app para estilos y zonas seguras.


**5. Conectar la navegación con la app principal**

Edita `src/adapter/react-native/screens/App.tsx` para que cargue el nuevo `AppNavigator`:

```tsx
import React from 'react';
import AppNavigator from '../navigation/AppNavigator';

export default function App() {
  return <AppNavigator />;
}
```

**6. Probar la navegación**

Ejecuta la aplicación con Expo:

```bash
yarn start
```

Pulsa:
- `w` para abrir en navegador web  

Deberías ver el menú lateral con dos opciones: **Inicio** y **Configuración**.  
Cada una muestra su respectiva pantalla.

**7. Revisión de la arquitectura resultante**

```
src/
  adapter/
    react-native/
      navigation/
        AppNavigator.tsx
      screens/
        HomeScreen.tsx
        SettingsScreen.tsx
      App.tsx
  application/
  domain/
  configuration/
```

Con esto, el alumno tiene un **sistema de navegación funcional**, con menú lateral y rutas integradas bajo la arquitectura hexagonal del proyecto para seguir ampliando.

### Capa de dominio

En este issue, debes definir la **capa de dominio** de la aplicación móvil React Native + TypeScript dentro de la arquitectura hexagonal. El dominio representa **el corazón de la aplicación**, donde residen las entidades, objetos de valor y enumerados que modelan la realidad del problema. El objetivo es que esta capa esté completamente tipada, organizada y desacoplada de cualquier tecnología (UI, API, persistencia). Pueden darse dos escenarios en tu proyecto:

**1. Escenario A. Usar dominio existente desde un *core-typescript***

Si el proyecto ya cuenta con un paquete `core-typescript`, **no debes duplicar** las clases, sino importar y reexportar lo necesario desde ese módulo.

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1 Instalación de dependencias**

```bash
yarn add @kaizten/core-typescript @kaizten/kaizten-typescript
```

> `@kaizten/core-typescript`: contiene las entidades, value objects y enumerados compartidos con el backend.  
> `@kaizten/kaizten-typescript`: proporciona utilidades comunes (tipos `Either`, `ApiError`, validadores, etc.).

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.2 Estructura esperada**

```
src/
  domain/
    index.ts
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.3 Reexportar las entidades del dominio**

En `src/domain/index.ts` reexporta los modelos relevantes desde el core:

```ts
// src/domain/index.ts
export { EntityA } from '@kaizten/core-typescript';
export { EntityB } from '@kaizten/core-typescript';
export { EntityC } from '@kaizten/core-typescript';
export { EntityD } from '@kaizten/core-typescript';
```

De esta forma, cualquier parte de la app podrá importar entidades o value objects desde `@domain`:

```ts
import { EntityA, EntityB, EntityC, EntityD } from '@domain';
```

> La principal ventaja es que el dominio queda centralizado, sin duplicar código ni generar inconsistencias entre backend y app.


**2. Escenario B. Crear el dominio manualmente**

Si no existe un paquete `core-typescript`, debes **replicar el dominio del backend Java** en TypeScript. El backend de Java debe encontrarse en la carpeta principal del repositorio en la carpeta `back-end`. Este, sigue una arquitectura hexagonal, por lo que será fácil localizar el dominio.

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1 Recordatorio de convenciones básicas**

- **Entities (`entity/`)**: representan objetos con identidad propia y ciclo de vida (por ejemplo: `User`, `Order`, `Product`, `Organization`).
- **Value Objects (`valueobject/`)**: representan conceptos sin identidad propia (por ejemplo: `Email`, `Money`, `Coordinates`, `OrganizationName`).
- **Enumerates (`enumerate/`)**: definen listas finitas de valores (por ejemplo: `OrderStatus`, `TrapType`, `IncidentType`).

Cada clase o enumerado debe definirse en su propio archivo, siguiendo la estructura:

```
src/domain/
  entity/
    Organization.ts
  valueobject/
    OrganizationName.ts
  enumerate/
    IncidentType.ts
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.2 Ejemplo de entidad en TypeScript**

```ts
export class Organization {
  static readonly ERROR_ID_NOT_DEFINED =
    'The id of the organization is not defined';
  static readonly ERROR_NAME_NOT_DEFINED =
    'The name of the organization is not defined';

  /**
   * Identifier of the organization. It is a computed attribute
   */
  private id: KaiztenUUID;
  /**
   * Name of the organization. It is a required attribute
   */
  private name: OrganizationName;
  /**
   * Description of the organization. It is an optional attribute
   */
  private description?: OrganizationDescription;

  constructor(
    name: OrganizationName,
    description?: OrganizationDescription,
    id?: KaiztenUUID
  ) {
    const generatedId = id ?? KaiztenUUID.random();
    this.validate<KaiztenUUID>(generatedId, Organization.ERROR_ID_NOT_DEFINED);
    this.validate<OrganizationName>(name, Organization.ERROR_NAME_NOT_DEFINED);
    this.id = generatedId;
    this.name = name;
    this.description = description;
  }

  private validate<T>(
    attribute: T | undefined,
    errorMessage: string
  ): asserts attribute is T {
    if (attribute === undefined || attribute === null) {
      throw new Error(errorMessage);
    }
  }

  public equals(other: any): boolean {
    if (this === other) {
      return true;
    }
    if (other === null || other === undefined) {
      return false;
    }
    if (!(other instanceof Organization)) {
      return false;
    }
    const otherOrganization: Organization = other as Organization;
    return this.id === otherOrganization.id;
  }

  public clone(): Organization {
    return Object.create(
      Object.getPrototypeOf(this),
      Object.getOwnPropertyDescriptors(this)
    );
  }

  public hashCode(): number {
    let hash = 0;
    for (let i = 0; i < this.id.getValue().length; i++) {
      const char = this.id.getValue().charCodeAt(i);
      hash = (hash << 5) - hash + char;
      hash |= 0; // Convert to 32bit integer
    }
    return hash;
  }

  public getId(): KaiztenUUID {
    return this.id;
  }

  public getName(): OrganizationName {
    return this.name;
  }

  public setName(name: OrganizationName): void {
    this.validate<OrganizationName>(name, Organization.ERROR_NAME_NOT_DEFINED);
    this.name = name;
  }

  public getDescription(): OrganizationDescription | undefined {
    return this.description;
  }

  public setDescription(description: OrganizationDescription): void {
    this.description = description;
  }

  public static random(): Organization {
    return new Organization(
      OrganizationName.random(),
      OrganizationDescription.random(),
      KaiztenUUID.random()
    );
  }

  public toString(): string {
    return `Organization: { id: ${this.id}, name: ${this.name}, description: ${this.description} }`;
  }
}
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.3 Ejemplo de Value Object**

```ts
export class OrganizationName {
  public static readonly MIN_LENGTH: number = 2;
  public static readonly MAX_LENGTH: number = 100;
  public static readonly REGULAR_EXPRESSION: RegExp = /^[a-zA-ZÀ-ÿ\s]*$/;
  public static readonly ERROR_NOT_DEFINED: string = `Name of the organization is not defined`;
  public static readonly ERROR_EMPTY: string =
    'Name of the organization is empty';
  public static readonly ERROR_MIN_LENGTH: string = `Name of the organization must be composed of at least ${OrganizationName.MIN_LENGTH} characters in length`;
  public static readonly ERROR_MAX_LENGTH: string = `Name of the organization must be composed of at most ${OrganizationName.MAX_LENGTH} characters in length`;
  public static readonly ERROR_WRONG_FORMAT: string = `The name can only contain letters`;

  private readonly value: string;

  constructor(value: string) {
    this.validate(value);
    this.value = simplify(value);
  }

  private validate(value: string) {
    if (value == null) {
      throw new TypeError(OrganizationName.ERROR_NOT_DEFINED);
    }
    value = simplify(value);
    const length = value.length;
    if (length === 0) {
      throw new Error(OrganizationName.ERROR_EMPTY);
    }
    if (length < OrganizationName.MIN_LENGTH) {
      throw new Error(OrganizationName.ERROR_MIN_LENGTH);
    }
    if (length > OrganizationName.MAX_LENGTH) {
      throw new Error(OrganizationName.ERROR_MAX_LENGTH);
    }
    if (!OrganizationName.REGULAR_EXPRESSION.test(value)) {
      throw new Error(OrganizationName.ERROR_WRONG_FORMAT);
    }
  }

  equals(other: any): boolean {
    if (other == this) {
      return true;
    }
    if (other == null || this.constructor !== other.constructor) {
      return false;
    }
    if (!(other instanceof OrganizationName)) {
      return false;
    }
    const otherOrganizationName = other as OrganizationName;
    return this.value === otherOrganizationName.value;
  }

  hashCode(): number {
    let hash = 0;
    for (let i = 0; i < this.value.length; i++) {
      const char = this.value.charCodeAt(i);
      hash = (hash << 5) - hash + char;
      hash |= 0; // Convert to 32bit integer
    }
    return hash;
  }

  static fromString(value: string): OrganizationName {
    return new OrganizationName(value);
  }

  static random(): OrganizationName {
    const value = OrganizationName.generateValidValue();
    return new OrganizationName(value);
  }

  static generateValidValue(): string {
    return randomAlphabeticLength(
      OrganizationName.MIN_LENGTH,
      OrganizationName.MAX_LENGTH
    );
  }

  static generateInvalidValue(): string {
    return '%=()';
  }

  getValue(): string {
    return this.value;
  }

  toString(): string {
    return this.value;
  }
}
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.4 Ejemplo de Enumerado**

```ts
export enum IncidentTypeValues {
  SICK_LEAVE = 'SICK_LEAVE',
  NO_SHOW = 'NO_SHOW',
  LATE_ARRIVAL = 'LATE_ARRIVAL',
  ASSIGNMENT_ERROR = 'ASSIGNMENT_ERROR',
  TECHNICAL_FAILURE = 'TECHNICAL_FAILURE',
  WEATHER_CONDITIONS = 'WEATHER_CONDITIONS',
  LOGISTICS_ISSUE = 'LOGISTICS_ISSUE',
  CLIENT_REQUEST = 'CLIENT_REQUEST',
  REQUIREMENT_CHANGE = 'REQUIREMENT_CHANGE',
}

export class IncidentType {
  public static readonly ERROR_NOT_DEFINED = 'Incident Type is not defined';
  public static readonly ERROR_EMPTY = 'Incident Type cannot be empty';
  public static readonly ERROR_WRONG_FORMAT = `Incident Type is not valid. Valid values are:  ${Object.values(IncidentTypeValues)}`;

  private readonly value: string;

  constructor(value: string) {
    this.validate(value);
    this.value = value;
  }

  private validate(value: string) {
    if (value === null) {
      throw new Error(IncidentType.ERROR_NOT_DEFINED);
    }

    value = simplify(value);
    const length = value.length;
    if (length === 0) {
      throw new Error(IncidentType.ERROR_EMPTY);
    }

    if (!IncidentType.isValid(value)) {
      throw new Error(IncidentType.ERROR_WRONG_FORMAT);
    }
  }

  public static isValid(value: string): value is IncidentTypeValues {
    return Object.values<string>(IncidentTypeValues).includes(value);
  }

  public equals(other: IncidentType): boolean {
    if (other == null) {
      return false;
    }
    return this.value === other.value;
  }

  public static fromString(value: string): IncidentType {
    return new IncidentType(value);
  }

  public static indexOf(value: string): number {
    return Object.values(IncidentTypeValues).indexOf(
      value as IncidentTypeValues
    );
  }

  public hashCode(): number {
    let hash = 0;
    for (let i = 0; i < this.value.length; i++) {
      const char = this.value.charCodeAt(i);
      hash = (hash << 5) - hash + char;
      hash |= 0; // Convert to 32bit integer
    }
    return hash;
  }

  public static random(): IncidentType {
    const values = Object.values(IncidentTypeValues);
    const randomIndex = Math.floor(Math.random() * values.length);
    return new IncidentType(values[randomIndex] as string);
  }

  public getValue(): string {
    return this.value;
  }

  public toString(): string {
    return this.value;
  }
}
```

**3. Consideraciones técnicas**

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1 Constructor único con parámetros opcionales**

En Java es común definir múltiples constructores; en TypeScript **esto no es posible**. Para mantener la misma funcionalidad, usa **parámetros opcionales**, por ejemplo:

```ts
export class Organization {
  ...
  constructor(
    name: OrganizationName,
    description?: OrganizationDescription,
    id?: KaiztenUUID
  ) {
    const generatedId = id ?? KaiztenUUID.random();
    this.validate<KaiztenUUID>(generatedId, Organization.ERROR_ID_NOT_DEFINED);
    this.validate<OrganizationName>(name, Organization.ERROR_NAME_NOT_DEFINED);
    this.id = generatedId;
    this.name = name;
    this.description = description;
  }
  ...
}
```

**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.2 Reglas de diseño del dominio**

- Es importante, no incluir lógica de red, almacenamiento o UI en el dominio.
- No acceder a APIs, AsyncStorage ni repositorios directamente desde el dominio.
- Solo debe contener la lógica de negocio pura (validaciones, comportamientos, etc.).
- Los value objects deben ser **inmutables**.

**4. Resultado esperado**

Tras este issue, la app debe contar con una **capa de dominio limpia, coherente y aislada**, ya sea importada desde un *core-typescript* o definida manualmente.

```
src/
  domain/
    entity/
      ...
    valueobject/
      ...
    enumerate/
      ...
  application/
  adapter/
  configuration/
```

> En el siguiente issue se trabajará la capa **application**, implementando repositorios, casos de usos y servicios que operen sobre este dominio.


### Capa de aplicación

En este issue, debes definir la **capa de aplicación** de tu app móvil React Native + TypeScript dentro de la arquitectura hexagonal. Esta capa representa la **lógica de negocio de alto nivel**, es decir, **cómo interactúan las entidades y servicios** para cumplir con los casos de uso de la aplicación. El objetivo es estructurar los **repositorios**, **casos de uso** y **servicios** de forma desacoplada, tipada y coherente con el dominio que ya definiste o importaste.

Pueden darse dos escenarios:

#### 1) Escenario A. Usar capa de aplicación existente desde un *core-typescript*

Si el proyecto ya cuenta con un paquete `core-typescript`, **no debes duplicar** la capa de aplicación, sino importar y reexportar lo necesario desde ese módulo.

##### 1.1 Instalación de dependencias
```bash
yarn add @kaizten/core-typescript @kaizten/kaizten-typescript
```

> `@kaizten/core-typescript`: contiene los repositorios, casos de uso y servicios compartidos con el backend.  
> `@kaizten/kaizten-typescript`: proporciona utilidades comunes (`Either`, `ApiError`, validadores, etc.).


##### 1.2 Estructura esperada
```
src/
  application/
    repository/
    usecase/
    service/
```

##### 1.3 Reexportar los componentes del core
Ejemplo de reexportación desde el `core-typescript`:

```ts
// src/application/repository/index.ts
export { RepositoryA } from '@kaizten/core-typescript';
export { RepositoryB } from '@kaizten/core-typescript';
export { RepositoryC } from '@kaizten/core-typescript';
export { RepositoryD } from '@kaizten/core-typescript';
export { RepositoryE } from '@kaizten/core-typescript';
export { RepositoryF } from '@kaizten/core-typescript';
export { RepositoryG } from '@kaizten/core-typescript';
```

```ts
// src/application/usecase/index.ts
export { UseCaseA } from '@kaizten/core-typescript';
export { UseCaseB } from '@kaizten/core-typescript';
export { UseCaseC } from '@kaizten/core-typescript';
export { UseCaseD } from '@kaizten/core-typescript';
export { UseCaseE } from '@kaizten/core-typescript';
export { UseCaseF } from '@kaizten/core-typescript';
export { UseCaseG } from '@kaizten/core-typescript';
```

```ts
// src/application/service/index.ts
export { ServiceA } from '@kaizten/core-typescript';
export { ServiceB } from '@kaizten/core-typescript';
export { ServiceC } from '@kaizten/core-typescript';
export { ServiceD } from '@kaizten/core-typescript';
export { ServiceE } from '@kaizten/core-typescript';
export { ServiceF } from '@kaizten/core-typescript';
export { ServiceG } from '@kaizten/core-typescript';
```

#### 2) Escenario B. Crear la capa de aplicación manualmente

Si no existe un *core-typescript*, deberás crear **repositorios**, **casos de uso** y **servicios** en tu proyecto. Esta capa actuará como **puente entre la interfaz (UI)** y la **lógica de dominio**.

##### 2.2 Principios de diseño

| Componente | Descripción | Ejemplo |
|-------------|--------------|----------|
| **Repository** | Define **qué operaciones** se necesitan para acceder a los datos. | `UserRepository`, `TaskRepository`, etc. |
| **Use Case** | Define la **intención del usuario** (el “qué”) sin detallar el “cómo”. | `LogInUserUseCase`, `CreateTaskUseCase`, etc. |
| **Service** | Implementa el **cómo**: orquesta repositorios, aplica reglas, devuelve resultados tipados (`Either<ApiError, T>`). | `LogInUserService`, `CreateTaskService`, etc. |


##### 2.3 Ejemplo completo — Caso de uso de login

###### Definición del caso de uso
```ts
import { AuthLoginRequest } from '@/domain/interface/auth-login-request';
import { AuthLoginResponse } from '@/domain/interface/auth-login-response';
import { ApiError, Either } from '@kaizten/kaizten-typescript';

export interface LogInUserUseCase {
  login(authLoginRequest: AuthLoginRequest): Promise<Either<ApiError, AuthLoginResponse>>;
}
```

**Explicación:**
- Define la **intención**: logear un usuario.
- No especifica cómo se ejecuta; eso lo hará el `Service`.
- Retorna un `Promise<Either<ApiError, AuthLoginResponse>>`, permitiendo manejar tanto errores (`Left`) como éxitos (`Right`).

###### Implementación del servicio
```ts
export class LogInUserService implements LogInUserUseCase {
  constructor(private repository: UserRepository) {}

  async login(authLoginRequest: AuthLoginRequest): Promise<Either<ApiError, AuthLoginResponse>> {
    return await this.repository.login(authLoginRequest);
  }
}
```

**Explicación:**
- Implementa el contrato definido en la interfaz.
- Inyecta un `UserRepository` para delegar el acceso a datos.
- Devuelve el resultado como un `Either<ApiError, AuthLoginResponse>`.

###### Flujo resumido

```text
 UI / Pantalla
     │
     ▼
 LogInUserUseCase (interface)
     │
     ▼
 LogInUserService (implementación)
     │
     ▼
 UserRepository (acceso a datos)
     │
     ▼
 API / DB
```

##### 2.4 Ejemplo de repositorio
```ts
export interface UserRepository {
  login(request: AuthLoginRequest): Promise<Either<ApiError, AuthLoginResponse>>;
  refresh(token: string): Promise<Either<ApiError, { accessToken: string }>>;
  logout(): Promise<Either<ApiError, void>>;
}
```

##### 2.5 Prácticas a seguir

- Cada caso de uso (`usecase`) tiene **una única responsabilidad**.  
- Los servicios (`service`) **implementan** los casos de uso y **no acceden directamente** a la API.  
- Los repositorios definen contratos, **no implementaciones** (eso se hará más adelante en la capa de adaptadores, en la que, por ejemplo, se implementarán los **repositorios HTTP**).
- Devuelve siempre `Promise<Either<ApiError, T>>` para tipar correctamente errores y respuestas.  
- Organiza los ficheros siguiendo el patrón `usecase/<action>-<entity>-use-case.ts` y `service/<action>-<entity>-service.ts`.

#### 3) Resultado esperado

Tras este issue, la app debe contar con una **capa de aplicación funcional y tipada**, que actúe como interfaz entre la lógica de dominio y la capa de infraestructura.

```
src/
  domain/
  application/
    repository/
    usecase/
    service/
  adapter/
  configuration/
```

> En el siguiente issue se trabajará la capa **adapter**, donde implementarás los repositorios HTTP, entre otros adaptadores.


### Capa de adaptadores HTTP

En este issue, debes definir la **capa de adaptadores HTTP** de tu app móvil React Native + TypeScript dentro de la arquitectura hexagonal. Esta capa representa el **puente entre la aplicación y las fuentes de datos externas (API, backend, etc.)**, proporcionando una implementación concreta de los **repositorios definidos en la capa de aplicación**.

El objetivo es estructurar correctamente los **repositorios HTTP**, reexportarlos desde un *core-typescript* si existen, o crearlos manualmente siguiendo buenas prácticas y usando **DTOs (Data Transfer Objects)** para desacoplar la comunicación entre capas.

Pueden darse dos escenarios:

#### 1) Escenario A. Usar adaptadores HTTP existentes desde un *core-typescript*

Si el proyecto ya cuenta con un paquete `core-typescript`, **no debes duplicar** los adaptadores HTTP, sino importarlos y reexportarlos desde ese módulo.

##### 1.1 Estructura esperada

```
src/
└── adapter/
    └── http/
        ├── repository/           # Reexporta repositorios HTTP del core
        │    └── index.ts
        ├── request/              # Reexporta DTOs de petición (POST, PUT)
        │    └── index.ts
        └── response/             # Reexporta DTOs de respuesta (GET)
             └── index.ts
```

> Esta separación permite mantener desacoplada la lógica de dominio/aplicación del framework de interfaz React Native.

##### 1.2 Reexportar adaptadores y DTOs desde el *core-typescript*

Ejemplo de `src/adapter/http/repository/index.ts`:

```ts
export { EntryPointHttpRepository } from '@kaizten/core-typescript';
export { ZoneHttpRepository } from '@kaizten/core-typescript';
...
```

Ejemplo de `src/adapter/http/response/index.ts`:
```ts
export { ZoneResponseBody } from '@kaizten/core-typescript';
export { EntryPointResponseBody } from '@kaizten/core-typescript';
...
```

Ejemplo de `src/adapter/http/request/index.ts`:
```ts
export { ZoneRequestBody } from '@kaizten/core-typescript';
export { EntryPointRequestBody } from '@kaizten/core-typescript';
...
```

#### 2) Escenario B. Crear la capa de adaptadores HTTP manualmente

Si no existe un *core-typescript*, deberás implementar los **repositorios HTTP** manualmente, siguiendo la interfaz definida en `application/repository`. Cada repositorio será responsable de interactuar con la API (GET, POST, PUT, DELETE) y devolver objetos de dominio o errores tipados mediante `Either<ApiError, T>`.

##### 2.1 Estructura esperada

```
src/
└── adapter/
    └── http/
        ├── repository/           # Implementaciones HTTP de los repositorios
        │    ├── organization-http-repository.ts
        │    ├── zone-http-repository.ts
        │    ├── trap-http-repository.ts
        │    └── ...
        ├── request/              # DTOs de petición (POST, PUT)
        │    ├── organization-post-json-request.ts
        │    ├── organization-put-json-request.ts
        │    └── ...
        └── response/             # DTOs de respuesta (GET)
             ├── organization-json-response.ts
             ├── zone-json-response.ts
             └── ...
```

##### 2.2 Creación de repositorios HTTP

Crea una carpeta `src/adapter/http/repository` en el proyecto del front-end. En ella se incluirán las clases que implementan los **repositorios HTTP**, responsables de comunicar la aplicación con el backend mediante peticiones REST. Para cada entidad `<ENTITY>` definida en la capa de aplicación:
- Crea un archivo `src/adapter/http/repository/<entity>-http-repository.ts`.  
- Implementa en él una clase `class <Entity>HttpRepository` que **implemente la interfaz** `<Entity>Repository` definida en issues previos en `application/repository`.  
- Usa los **DTOs** (`<ENTITY>JsonResponse`, `<ENTITY>PostJsonRequest`, `<ENTITY>PutJsonRequest`) para convertir los datos entre la API y las entidades del dominio. **Su definición se encuentra en el siguiente paso.**

Cada repositorio debe gestionar las operaciones básicas:

| Método | Descripción |
|--------|--------------|
| **`get(page?, size?, filters?)`** | Obtiene una lista paginada y/o filtrada de entidades. Construye la URL según los parámetros y devuelve `Either<ApiError, List<T>>`. |
| **`getById(id)`** | Recupera una entidad por su identificador. Devuelve `Either<ApiError, T>`. |
| **`create(entity)`** | Crea una nueva entidad en el sistema usando el DTO `PostJsonRequest`. |
| **`update(id, entity)`** | Actualiza una entidad existente mediante el DTO `PutJsonRequest`. |
| **`delete(id)`** | Elimina una entidad por su identificador. Devuelve `Either<ApiError, void>`. |

###### Ejemplo: `OrganizationHttpRepository`

```ts
import { Either, type DataError, http, type ApiError, KaiztenUUID } from '@kaizten/kaizten-typescript';
import { useKeycloakStore } from '../../vuejs/stores/keycloak-store';
import { OrganizationJsonRequest, OrganizationJsonResponse, type Organization, type OrganizationRepository, type OrganizationsResponse } from '@kaizten/aidel_core-typescript';

export class OrganizationHttpRepository implements OrganizationRepository {
  private readonly API_URL = import.meta.env.VITE_APP_API_URL + 'organizations';
  private headers: Headers = new Headers();
  private keycloak = useKeycloakStore().keycloak;

  constructor() {
    this.headers.append('Authorization', `Bearer ${this.keycloak?.token}`);
    this.headers.append('Content-Type', 'application/json');
  }

  public async readOrganizations(
    page?: number,
    rowsPerPage?: number,
    filters?: string
  ): Promise<Either<DataError, OrganizationsResponse>> {
    let url = this.API_URL;
    if (page != undefined && rowsPerPage != undefined) {
      url += `?page=${page}&size=${rowsPerPage}`;
    }
    if (filters != undefined) {
      url += `&${filters}`;
    }
    return new Promise(resolve => {
      http
        .get(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: OrganizationJsonResponse[]) => {
              const totalItems: number = +(response.headers.get(
                'Total-Count'
              ) as string);
              const paginationCount: number = +(response.headers.get(
                'Pagination-Count'
              ) as string);
              const convertedData: Organization[] = [];
              data.forEach(organization => {
                convertedData.push(
                  OrganizationJsonResponse.toOrganization(organization)
                );
              });
              const organizationsResponse: OrganizationsResponse = {
                organizations: convertedData,
                totalItems: totalItems,
                paginationCount: paginationCount,
              };
              resolve(Either.right(organizationsResponse));
            });
          } else {
            response.json().then((data: ApiError) => {
              Either.left(data);
            });
          }
        })
        .catch(error => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async readById(
    id: KaiztenUUID
  ): Promise<Either<DataError, Organization>> {
    const url = `${this.API_URL}/${id.getValue()}`;
    return new Promise(resolve => {
      http
        .get(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: OrganizationJsonResponse) => {
              resolve(
                Either.right(OrganizationJsonResponse.toOrganization(data))
              );
            });
          } else {
            response.json().then((data: ApiError) => {
              Either.left(data);
            });
          }
        })
        .catch(error => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async create(
    organization: Organization
  ): Promise<Either<DataError, Organization>> {
    const body = OrganizationJsonRequest.toRequest(organization);
    return new Promise(resolve => {
      http
        .post(this.API_URL, body, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: OrganizationJsonResponse) => {
              resolve(
                Either.right(OrganizationJsonResponse.toOrganization(data))
              );
            });
          } else {
            response.json().then((data: ApiError) => {
              Either.left(data);
            });
          }
        })
        .catch(error => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async delete(
    id: KaiztenUUID
  ): Promise<Either<DataError, Organization>> {
    const url = `${this.API_URL}/${id.getValue()}`;
    return new Promise(resolve => {
      http
        .delete(url, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: OrganizationJsonResponse) => {
              resolve(
                Either.right(OrganizationJsonResponse.toOrganization(data))
              );
            });
          } else {
            response.json().then((data: ApiError) => {
              data.kind = 'ApiError';
              resolve(Either.left(data));
            });
          }
        })
        .catch(error => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }

  public async update(
    id: KaiztenUUID,
    organization: Organization
  ): Promise<Either<DataError, Organization>> {
    const url = `${this.API_URL}/${id.getValue()}`;
    const body = OrganizationJsonRequest.toRequest(organization);
    return new Promise(resolve => {
      http
        .put(url, body, this.headers)
        .then(response => {
          if (response.ok) {
            response.json().then((data: OrganizationJsonResponse) => {
              resolve(
                Either.right(OrganizationJsonResponse.toOrganization(data))
              );
            });
          } else {
            response.json().then((data: ApiError) => {
              data.kind = 'ApiError';
              resolve(Either.left(data));
            });
          }
        })
        .catch(error => {
          resolve(Either.left({ kind: 'UnexpectedError', message: error }));
        });
    });
  }
}
```

##### 2.3 Creación de DTOs

Los **DTOs (Data Transfer Objects)** permiten separar la representación de los datos entre el front-end y el dominio. Crea los DTOs dentro de las carpetas `src/adapter/http/request` y `src/adapter/http/response`. A diferencia de las entidades del dominio, los DTOs usan tipos básicos (string, number, etc.) y se encargan de traducir los datos entre el front-end y la API.

Para cada entidad `<ENTITY>`, define:
 - `<ENTITY>JsonResponse` → `src/adapter/http/response/<entity>-json-response.ts`. Representa la respuesta JSON de la API. Incluye los atributos básicos y un método estático toDomainEntity() que convierte el JSON en la entidad del dominio usando sus value objects.
 - `<ENTITY>PostJsonRequest` → `src/adapter/http/request/<entity>-post-json-request.ts`. Define la solicitud POST para crear una nueva entidad. Incluye los campos requeridos y un método toRequest() que genera la carga útil (payload) adecuada.
 - `<ENTITY>PutJsonRequest` → `src/adapter/http/request/<entity>-put-json-request.ts`. Representa la solicitud PUT para actualizar entidades existentes. Usa campos opcionales y un método toRequest() que serializa los datos a enviar a la API.

###### Ejemplo: `OrganizationPutJsonRequest`
```ts
export class OrganizationPutJsonRequest {
  public name?: string;
  public description?: string;

  constructor(name?: string, description?: string) {
    this.name = name;
    this.description = description;
  }

  public static toRequest(data: Organization): OrganizationPutJsonRequest {
    return new OrganizationPutJsonRequest(
      data.name ? data.name : undefined,
      data.description ? data.description : undefined
    );
  }
}
```

###### Ejemplo: `OrganizationPostJsonRequest`
```ts
export class OrganizationPostJsonRequest {
  public name: string;
  public description?: string;

  constructor(name: string, description?: string) {
    this.name = name;
    this.description = description;
  }

  public static toRequest(data: Organization): OrganizationPostJsonRequest {
    return new OrganizationPostJsonRequest(
      data.name,
      data.description ? data.description : undefined
    );
  }
}
```

###### Ejemplo: `OrganizationJsonResponse`
```ts
export class OrganizationJsonResponse {
  public id: string;
  public name: string;
  public description?: string;

  constructor(id: string, name: string, description?: string) {
    this.id = id;
    this.name = name;
    this.description = description;
  }

  public static toDomainEntity(data: OrganizationJsonResponse): Organization {
    return new Organization(
      new OrganizationName(data.name),
      data.description
        ? new OrganizationDescription(data.description)
        : undefined,
      new KaiztenUUID(data.id)
    );
  }
}
```

