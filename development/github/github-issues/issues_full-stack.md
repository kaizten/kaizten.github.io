<!-- TOC -->

- [Java](#java)
  - [Instalación de Java Development Kit](#instalación-de-java-development-kit)
  - [Instalación de Maven](#instalación-de-maven)
- [Docker](#docker)
  - [Instalación](#instalación)
  - [Nociones básicas](#nociones-básicas)
  - [Docker Compose. Instalación](#docker-compose-instalación)
- [NodeJS. Instalación](#nodejs-instalación)
- [Yarn. Instalación](#yarn-instalación)
- [Visual Studio Code](#visual-studio-code)
  - [Instalación](#instalación-1)
  - [Extensión `Draw.io`](#extensión-drawio)
  - [Extensión `MongoDB`](#extensión-mongodb)
  - [Extensión `Vue - Official`](#extensión-vue---official)
- [Arquitectura hexagonal](#arquitectura-hexagonal)
- [Back-end](#back-end)
  - [Primeros pasos](#primeros-pasos)
  - [Dependencia: `kaizten-utils`](#dependencia-kaizten-utils)
  - [Dockerfile](#dockerfile)
  - [GitHub action](#github-action)
  - [Dominio](#dominio)
    - [Entidades](#entidades)
    - [Objetos valor](#objetos-valor)
  - [Aplicación](#aplicación)
    - [Casos de uso](#casos-de-uso)
    - [Servicios](#servicios)
    - [Repositorios](#repositorios)
  - [Adaptador MongoDB](#adaptador-mongodb)
    - [Repositorios](#repositorios-1)
    - [Configuración](#configuración)
    - [Escritores](#escritores)
    - [Lectores](#lectores)
  - [Adaptador REST](#adaptador-rest)
    - [Controladores](#controladores)
    - [Data transfer objects](#data-transfer-objects)
    - [Serializadores y deserializadores](#serializadores-y-deserializadores)
    - [Configuración](#configuración-1)
    - [Documentación](#documentación)
  - [Operaciones bulk](#operaciones-bulk)
  - [Configuración](#configuración-2)
    - [Aplicación](#aplicación-1)
  - [SonarQube](#sonarqube)
- [Front-end](#front-end)
  - [Primeros pasos](#primeros-pasos-1)
  - [Dependencia `kaizten-typescript`](#dependencia-kaizten-typescript)
  - [Dockerfile](#dockerfile-1)
  - [GitHub action](#github-action-1)
  - [Dominio](#dominio-1)
  - [Aplicación](#aplicación-2)
    - [Casos de uso](#casos-de-uso-1)
    - [Servicios](#servicios-1)
    - [Repositorios](#repositorios-2)
  - [Adaptador HTTP](#adaptador-http)
    - [Primeros pasos](#primeros-pasos-2)
    - [Data transfer objects](#data-transfer-objects-1)
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

1. Incluye un compilador, bibliotecas, y otras utilidades para crear, depurar y ejecutar programas Java. Puedes instalar el JDK de Java tal como sigue:
    ```shell
    $ sudo add-apt-repository ppa:linuxuprising/java
    $ sudo apt update
    $ sudo apt install oracle-java17-installer oracle-java17-set-default
    ```

2. Comprueba que tienes instalado en tu máquina al menos esta versión. Para ello, ejecuta lo siguiente:
    ```shell
    $ java -version
    java version "17.0.6" 2023-01-17 LTS
    Java(TM) SE Runtime Environment (build 17.0.6+9-LTS-190)
    Java HotSpot(TM) 64-Bit Server VM (build 17.0.6+9-LTS-190, mixed mode, sharing)
    ```

    Cabe señalar que si tienes una versión superior de Java a la 17 no hay problema.

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
    Cabe señalar que si tienes una versión superior de [Maven](https://maven.apache.org) a la 3.9.5 no hay problema.

4. Pon un comentario en este issue mostrando la salida del comando `mvn -v` para comprobar que has instalado correctamente [Maven](https://maven.apache.org) en tu máquina.

## Docker

### Instalación

Hola, [Docker](https://www.docker.com) es una plataforma de software que permite crear, implementar y ejecutar aplicaciones en contenedores. Un contenedor es un paquete de software que incluye todo lo necesario para que una aplicación se ejecute, incluyendo el código, las bibliotecas y las dependencias. Los contenedores son independientes del sistema operativo y se pueden ejecutar en cualquier plataforma que admita Docker.

**Pasos a realizar:**

1. En la siguiente página tienes los pasos para realizar la instalación de [Docker](https://www.docker.com) en Ubuntu: https://docs.docker.com/engine/install/ubuntu/ Si tienes otro sistema operativo puedes encontrar [aquí](https://docs.docker.com/engine/install/) cómo instalar la herramienta.
2. Una vez realizados estos pasos, comprueba que tienes instalado Docker en tu máquina, tal como sigue:
    ```shell
    $ docker -v
    Docker version 27.2.1, build 9e34c9b
    ```
    Comprueba que tienes al menos la versión 27 de [Docker](https://www.docker.com). 

3. Es importante que puedes ejecutar `docker` sin necesitar emplear `sudo`. Si necesitas usar `sudo`, revisa [este artículo](https://docs.docker.com/engine/install/linux-postinstall/) donde se indica cómo ejecutarlo como usuario convencional.

### Nociones básicas

Hola, te paso [una referencia](https://www.freecodecamp.org/espanol/news/guia-de-docker-para-principiantes-como-crear-tu-primera-aplicacion-docker/) para que vayas comprobando cómo funciona [Docker](https://www.docker.com).

**Pasos a realizar:**

1. Lee con calma la referencia anterior para que veas cómo se puede crear una imagen [Docker](https://www.docker.com) de un código básico y cómo se puede crear un contenedor a partir de la imagen creada.

### Docker Compose. Instalación

Hola, [Docker Compose](https://docs.docker.com/compose/) es una herramienta de orquestación de contenedores que permite definir, configurar y ejecutar aplicaciones multi-contenedor Docker. Con [Docker Compose](https://docs.docker.com/compose/), se puede definir la configuración de múltiples servicios, redes y volúmenes, y luego iniciarlos y detenerlos todos juntos con un solo comando. Básicamente, [Docker Compose](https://docs.docker.com/compose/) es una herramienta que simplifica el proceso de gestión de múltiples contenedores de Docker en un entorno de producción. Permite definir la configuración de cada contenedor, así como las conexiones entre ellos, en un archivo [YAML](https://en.wikipedia.org/wiki/YAML). Esto hace que sea fácil de leer y entender, y también es fácil de compartir con otros desarrolladores.

**Pasos a realizar:**

1. En la siguiente página tienes los pasos para realizar la instalación de [Docker Compose](https://docs.docker.com/compose/) en tu máquina: https://docs.docker.com/compose/install/

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

2. Una vez instalado, debes comprobar que tienes al menos la versión `20.15` de [NodeJS](https://nodejs.org) en tu máquina. Esto es:
    ```shell
    $ node -v
    v20.15.0
    ```

## Yarn. Instalación

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

## Visual Studio Code

### Instalación

Hola, para poder programar de manera cómoda y eficiente es aconsejable emplear un entorno de programación integrado (IDE, por sus siglas en inglés). Actualmente uno de los IDE más versátiles es [Visual Studio Code](https://code.visualstudio.com) (VSC). [Visual Studio Code](https://code.visualstudio.com) es un IDE desarrollado por Microsoft para Windows, Linux, macOS y Web. Incluye soporte para la depuración, control integrado de [Git](https://git-scm.com), resaltado de sintaxis, finalización inteligente de código, fragmentos y refactorización (modificación del código fuente sin cambiar su comportamiento). El IDE es personalizable, por lo que sus usuarios pueden cambiar el tema del editor, los atajos de teclado y las preferencias. Es gratuito y de código abierto y es uno de los IDEs más utilizados en la actualidad. 

**Pasos a realizar:**

1. Si no empleas ya un IDE diferente como [NetBeans](https://netbeans.apache.org), [IntelliJ IDEA](https://www.jetbrains.com/idea/), o [Eclipse](https://eclipseide.org), entre otros, te propongo instalar [Visual Studio Code](https://code.visualstudio.com) (al menos la versión `1.96.0`) en tu máquina. 
2. Cuando hayas instalado [Visual Studio Code](https://code.visualstudio.com), ejecuta lo siguiente desde una terminal para comprobar que se ha instalado correctamente:
    ```shell
    $ code --version
    1.96.0
    138f619c86f1199955d53b4166bef66ef252935c
    x64
    ```
3. Comprueba que puedes arrancar [Visual Studio Code](https://code.visualstudio.com), o bien haciendo doble click en el icono del programa o ejecutando lo siguiente desde una terminal:
    ```shell
    $ code 
    ```

### Extensión `Draw.io`

Hola, una herramienta particularmente interesante para poder hacer diagramas sencillos es [Draw.io](https://app.diagrams.net). Es una herramienta gratuita con la que puedes realizar diagramas de una manera muy cómoda. Además, en [Visual Studio Code](https://code.visualstudio.com) hay una extensión que permite crear estos diagramas sin tener que salir de la herramienta.

**Pasos a realizar:**

1. Instala la extensión de [Draw.io](https://app.diagrams.net) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio).

### Extensión `MongoDB`

Hola, [MongoDB](https://www.mongodb.com) es una base de datos NoSQL que almacena datos en formato JSON flexible, y la extensión mejora la productividad al integrar la administración y consulta de bases de datos MongoDB dentro de su flujo de trabajo de desarrollo en [Visual Studio Code](https://code.visualstudio.com).

Para poder trabajar con [MongoDB](https://www.mongodb.com) es necesario conectarse mediante una terminal. Sin embargo, la extensión de [MongoDB](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) para [Visual Studio Code](https://code.visualstudio.com) es una herramienta que facilita la interacción con bases de datos MongoDB directamente desde el entorno de desarrollo integrado de [Visual Studio Code](https://code.visualstudio.com). De esta manera, será posible que accedas a [MongoDB](https://www.mongodb.com) de manera gráfica, permitiendo crear o eliminar documentos, entre otras, de una manera sencilla.

**Pasos a realizar:**

1. Instala la extensión de [MongoDB](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode).

### Extensión `Vue - Official`

Hola, [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar) es una extensión para [Visual Studio Code](https://code.visualstudio.com/) diseñada específicamente para mejorar el desarrollo en entornos de [Vue.js](https://vuejs.org). Esta extensión ofrece un soporte avanzado para el desarrollo de aplicaciones [Vue.js](https://vuejs.org), agilizando la escritura de código, mejorando la detección de errores y proporcionando una experiencia de desarrollo más fluida y eficiente. Si usas [Visual Studio Code](https://code.visualstudio.com) creo que sería interesante que instalar esta extensión y, de esta manera, puedas trabajar de forma más eficaz con [Vue.js](https://vuejs.org).

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

A continuación se exponen las principales capas de la arquitectura hexagonal que vamos a immplementaro:

**1. Capa de adaptadores**

La capa de adaptadores es el punto de entrada y salida de la aplicación. Esta capa incluye adaptadores como controladores HTTP, conectores de bases de datos, y otros componentes que interactúan con agentes externos. Los adaptadores transforman las solicitudes del mundo exterior en algo que el núcleo de la aplicación pueda entender y viceversa.

**2. Capa de aplicación**

La capa de aplicación es la encargada de coordinar las operaciones del sistema. Se centra en qué se debe hacer, sin preocuparse de los detalles técnicos de cómo se hace. Los componentes principales en esta capa son los casos de uso, servicios y repositorios.

- *Casos de uso.* Representan la lógica que resuelve tareas específicas. Son la entrada principal a la lógica de negocio.
- *Servicios.* Implementación concreta de los casos de uso.
- *Repositorios.* Son interfaces que proporcionan acceso a la capa de dominio, ocultando detalles de almacenamiento.

**3. Capa de dominio**

La capa de dominio contiene las entidades y objetos valor que representan la lógica central del negocio. Esta capa no conoce nada sobre las capas externas y se enfoca exclusivamente en las reglas y procesos que gobiernan el sistema.

- *Entidades.* Objetos que tienen una identidad única y un ciclo de vida. Ejemplo: `Pedido`, `Cliente`. Los atributos de las entidades son generalmente objetos de valor, que son descritos a continuación.
- *Objetos de valor.* Objetos inmutables que tienen identidad propia. Ejemplo: `Dirección`, `Moneda`. Generalmente, son objetos empleados como tipo de los atributos de las entidades.

## Back-end

### Primeros pasos

Hola, el back-end de la aplicación vamos a realizarla mediante [Spring Boot](https://spring.io/projects/spring-boot). Se trata de un framework para la creación de aplicaciones empresariales en Java y otros lenguajes compatibles con la [Java virtual machine](https://en.wikipedia.org/wiki/Java_virtual_machine).

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
2. Descomprime `back-end.zip` dentro de la carpeta de tu repositorio. Con esto, debes tener una carpeta `back-end` en tu repositorio. 
3. Compila el back-end:
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
1. Si todo ha ido correctamente, debes encontrar la distribución del back-end en formato JAR. Concretamente `back-end/target/back-end-1.0-SNAPSHOT.jar`. Comprueba que este archivo se encuentra disponible.

### Dependencia: `kaizten-utils`

Hola, desde hace un tiempo hemos ido trabajando en una librería de utilidades para facilitarnos la realización de proyectos en Java: `kaizten-utils`. Se trata de una pequeña librería donde hay bastantes métodos que usamos regularmente. En tu proyecto pueden ser de utilidad para validar recursos por ejemplo. Acabamos de agregarte como colaborador al repositorio para que puedas acceder a su distribución y puedas añadirla como dependencia a tu proyecto.

**Pasos a realizar:**

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
5. Compila el proyecto para comprobar que la dependencia está disponible: `mvn clean package`.

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
    Es importante que lo guardes con el nombre `Dockerfile`.

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

4. Finalmente, puedes crear un contenedor Docker de esta imagen, tal como sigue:
    ```shell
    $ docker run -p 8081:8080 --name mycontainer dockerizedbackend
    ```
    El resultado debe ser que el back-end se ejecute de forma convencional, pero ahora no como un artefacto Java sino como un contenedor. Concretamente, se está creando un contenedor llamado `mycontainer` de la imagen previamente creada `dockerizedbackend`. Además, se está mapeando el puerto `8080` del contenedor en el puerto `8081` de tu máquina.

### GitHub action

Hola, la compilación del back-end y la generación de la imagen [Docker](https://www.docker.com) correspondiente requieren pasos manuales, lo que puede llevar a errores, inconsistencias y pérdida de tiempo. Para mejorar este proceso, se puede implementar una [GitHub action](https://github.com/features/actions) que automatice estas tareas con cada push realizado en el repositorio.

Las [GitHub action](https://github.com/features/actions) se definen en la carpeta `.github/workflows`. Crea esta carpeta dentro del repositorio si no la tienes aún creada. Es importante que te fijes bien en que se trata de una carpeta oculta. 

**Pasos a realizar:**

1. Dentro de la carpeta `.github/workflows` crea el archivo `back-end_publish-docker-image.yml` con el siguiente contenido:
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
    # Author: Kaizten Analytics S.L. (info@kaizten.com)

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

2. Antes de pasar a probar la [GitHub action](https://github.com/features/actions), debes modificar el archivo `back-end/pom.xml` añadiendo la sección `<profiles>` que se muestra a continuación:
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

3. Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `back-end/` y subiéndolos al repositorio. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo indicando el error.

4. Por último, una vez se ejecute la [GitHub action](https://github.com/features/actions), comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.

### Dominio

#### Entidades

Hola, en [este documento](https://docs.google.com/document/d/1gKlDYboDOnTPDRBkZLiZta-GazZWc7OZQpjMGg3yvgU/edit) se encuentra una primera versión del dominio de tu aplicación. Con seguridad, tendremos que hacerle cambios a medida que evolucione tu proyecto, pero sirve como un punto de referencia. En el documento se encuentran las principales entidades (objetos de negocio de tu aplicación) y, para cada una de ellas, se incluye un listado de propiedades que las caracterizan. Revisa con calma el documento y avisa con cualquier duda que pueda surgirte.

**Pasos a realizar:**

1. En base a lo anterior, puedes crear junto a la clase principal de tu back-end una carpeta `domain` y dentro de ésta otra carpeta `entity` en la que definir una clase Java por cada una de las entidades de tu dominio. Para cada entidad, pon los atributos indicados, los métodos get y set correspondientes y sobreescribe `toString()` para poder imprimir por la salida estándar objetos de dichas entidades. En este momento, no te preocupes demasiado por los tipos de los atributos de las entidades.

#### Objetos valor

Hola, es conveniente que los atributos de las entidades que tienes en el dominio de tu aplicación no sean tipos primitivos sino tipos definitos por ti. Antes de proceder con el código, lee con calma este artículo: https://kaizten.github.io/development/ddd/value-objects Tiene un ejemplo ilustrativo sobre cómo diseñar objetos valor en Java.

**Pasos a realizar:**

1. Crea una carpeta `valueobject` dentro de la carpeta `domain` donde definas una clase para cada objeto valor y que las uses estos nuevos tipos definidos por ti en los atributos de las entidades de tu dominio (carpeta `domain/entity`). Debes tener en cuenta que hay tipos como `UUID` (para representar identificadores unívocos) o `LocalDateTime` (para representar instantes de tiempo) que no es necesario que definas porque ya los tenemos en el JDK de Java.

### Aplicación

#### Casos de uso

Hola, un caso de uso es una descripción detallada de cómo un sistema o aplicación interactúa con sus usuarios o con otros sistemas para cumplir un objetivo específico. Se enfoca en las acciones que realiza el usuario y cómo el sistema responde a esas acciones, proporcionando una visión clara de las funcionalidades necesarias.

**¿Por qué son importantes los casos de uso?**

Los casos de uso son esenciales para definir los requisitos funcionales de un sistema. En la arquitectura hexagonal (o puertos y adaptadores), los casos de uso desempeñan un papel crucial, ya que representan la lógica de negocio independiente de los detalles de implementación externos, como bases de datos o interfaces de usuario. Así, se favorece la separación de responsabilidades y se promueve una arquitectura más mantenible y flexible.

**Ejemplo:**

A continuación, un ejemplo básico de un caso de uso para procesar pagos:
```java
public interface ProcessPaymentUseCase {

    /**
     * Processes the payment based on the provided amount and payment details.
     *
     * @param amount The total amount to be paid.
     * @param paymentDetails The payment information (e.g., card number, expiration date).
     * @return A confirmation message or transaction status.
     */
    ConfirmationMessage processPayment(Amount amount, PaymentDetails paymentDetails);
}
```
En este ejemplo, definimos una interfaz que especifica qué debe hacer la aplicación: procesar un pago. Sin embargo, no incluye la implementación, ya que esta responsabilidad recae en los servicios de la aplicación que interactúan con el caso de uso.

**Pasos a realizar:**

1. En una implementación siguiendo la arquitectura hexagonal, los casos de uso deberían ubicarse en la carpeta correspondiente a la capa de aplicación. En este caso: `/application/usecase`. Por tanto, define todos los casos de uso del back-end.

#### Servicios

Hola, una vez tengas los casos de uso de la aplicación definidos sería necesario realizar su implementación. Para ello, crea una clase individual por cada caso de uso de la aplicación dentro de la carpeta `application/service`. 

**Ejemplo:**

Te paso un ejemplo básico:
```java
public class ProcessPaymentService {

    @Autowired
    private <ENTITY>Repository repository;

    public class CreditCardPaymentService implements PaymentService {

    @Override
    ConfirmationMessage processPayment(Amount amount, PaymentDetails paymentDetails) {
        // use repository to access the data source
        ...
    }
}
```

**Pasos a realizar:**

1. En este caso, debes sustituir `<ENTITY>` por el nombre la entidad correspondiente en cada caso. Al mismo tiempo, tal como aparece en los comentarios, el servicio emplea un repositorio para acceder a los datos de la aplicación. De esta forma, por ejemplo, se desacoplan los servicios de la base de datos empleada.

#### Repositorios

Hola, para que los casos de uso (servicios) estén desacoplados del lugar donde se almacenan los datos, es necesario crear [repositorios](https://our-academy.org/posts/el-patron-repository:-implementacion-y-buenas-practicas). En este contexto, un repositorio es una abstracción que define un conjunto de métodos para acceder y manipular datos en una base de datos u otro tipo de almacenamiento persistente. 

La idea detrás de utilizar una interfaz de repositorio es separar la lógica de acceso a datos de la lógica de negocio de una aplicación (contenido de la carpeta `application/` del back-end). Esta interfaz define métodos genéricos para realizar operaciones CRUD (Crear, Leer, Actualizar y Borrar) en los datos, como por ejemplo: crear, leer, actualizar y eliminar registros.

**Pasos a realizar:**

En base a lo anterior, por cada entidad de tu dominio, crea una interfaz `<ENTIDAD>Repository.java` dentro de la carpeta `application/repository`. Te paso un extracto básico:
```java
public interface <ENTITY>Repository {

    public abstract void delete(<ENTITY> entity);

    public abstract List<<ENTITY>> fetchAll();

    public abstract <ENTITY> save(<ENTITY> entity);

    ...
}
```

### Adaptador MongoDB

#### Repositorios

Hola, en la aplicación se empleará [MongoDB](https://www.mongodb.com) como sistema gestor de base de datos. Es un sistema de base de datos NoSQL, diseñado para manejar grandes volúmenes de datos de manera flexible y escalable. A diferencia de las bases de datos relacionales, [MongoDB](https://www.mongodb.com) utiliza un modelo de documentos, almacenando los datos en documentos similares a JSON, lo que facilita su manipulación y almacenamiento. 

**Pasos a realizar:**

1. Para poder trabajar con [MongoDB](https://www.mongodb.com) en tu back-end debes modificar el archivo `pom.xml` añadiendo a la sección `<dependencies>` la siguiente dependencia:
    ```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-mongodb</artifactId>
    </dependency>
    ```

2. Una vez añadida la dependencia, crea la carpeta `adapter/mongodb` dentro de tu código. En esta carpeta debes incluirse todo lo relacionado con el uso de la base de datos en el back-end. Concretamente, debes añadir la implementación de los repositorios de datos definidos en el back-end. Esto es, hay que implementar cómo realizar las operaciones CRUD (Create, Read, Update y Delete) de las diferentes entidades. 

3. En base a lo anterior, por cada repositorio definido en tu back-end añade una implementación del mismo. A continuación puedes encontrar un pequeño extracto de cómo sería:
    ```java
    import org.springframework.data.mongodb.core.MongoTemplate;

    public class <ENTITY>MongoRepository implements <ENTITY>Repository {

        public static final String COLLECTION_NAME = "<ENTITY>";
        @Autowired
        private MongoTemplate mongoTemplate;

        public List<<ENTITY>> findAll() {
            return this.mongoTemplate.findAll(<ENTITY>.class, COLLECTION_NAME);
        }

        ...
    }
    ```
    En este caso, debes sustituir `<ENTITY>` por el nombre de tu entidad. Es también importante que te fijes en `mongoTemplate`, se trata del conector con [MongoDB](https://www.mongodb.com) y, por tanto, el elemento a través del cual se realizarán las consultas. Éste es el caso de `findAll`. Al mismo tiempo, está definida `COLLECTION_NAME` para simplemente explicitar el nombre de la colección donde guardar las entidades dentro de [MongoDB](https://www.mongodb.com).

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
            MappingMongoConverter converter = new MappingMongoConverte(dbRefResolver, mappingContext);
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

#### Data transfer objects

Hola, los clientes que empleen el API REST definida en el back-end deberían emplear objetos de clases diferentes a las entidades del dominio para evitar el acoplamiento así como facilitar la validación de datos. Por ello, dentro del controlador `adapter/rest` crea una carpeta `dto` donde añadir [Data Transfer Objects](https://www.baeldung.com/java-dto-pattern).

**Pasos a realizar:**

1. Dentro de la carpeta creada, debes crear una clase `<ENTITY>PostRequestBody.java`, otra `<ENTITY>PutRequestBody.java` y otra `<ENTITY>ResponseBody.java` por cada entidad de tu dominio `<ENTITY>`. A continuación te paso un ejemplo ilustrativo para una entidad `Trap.java`:
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

#### Serializadores y deserializadores

Hola, cuando el usuario realiza una petición de tipo `POST` o `PUT`, el cuerpo de esta petición es un DTO previamente definido. Sin embargo, es necesario definir lo siguiente:
* Un deserializador que convierta el cuerpo de una petición `POST` o `PUT` en un DTO.
* Un serializador por cada posible tipo de respuesta a devolver un controlador.

**Pasos a realizar:**

1. Crea una carpeta `adapter/rest/serialization`. Dentro de esta carpeta, crea un deserializador por cada DTO de petición definido en la carpeta `adapter/rest/dto`. A continuación tienes un ejemplo:
    ```java
    public class TrapPostRequestBodyDeserializer extends KaiztenJsonDeserializer<TrapPostRequestBody> {

        private static final Logger logger = LoggerFactory.getLogger(TrapPostRequestBodyDeserializer.class);
        private FetchEntryPointUseCase fetchEntryPointUseCase;

        public TrapPostRequestBodyDeserializer(FetchEntryPointUseCase fetchEntryPointUseCase) {
            this.fetchEntryPointUseCase = fetchEntryPointUseCase;
        }

        @Override
        protected TrapPostRequestBody parse(JsonNode trapNode) {
            // Required attributes:
            final UUID entryPoint = UUID.fromString(trapNode.get(JsonFields.ENTRYPOINT).asText());
            final TrapName name = new TrapName(trapNode.get(JsonFields.NAME).textValue());
            final TrapType type = TrapType.valueOf(trapNode.get(JsonFields.TYPE).textValue().trim().toUpperCase());
            final JsonNode nodeGeolocation = (trapNode.get(JsonFields.GEOLOCATION));
            final KaiztenGeolocationPoint geolocation = KaiztenGeolocationPoint.from(nodeGeolocation);
            // Optional attributes:
            final TrapDescription description = (trapNode.has(JsonFields.DESCRIPTION)) ? new TrapDescription(trapNode.get(JsonFields.DESCRIPTION).textValue()) : null;
            final ContactInformation contactInformation = (trapNode.has(JsonFields.CONTACT_INFORMATION)) ? new ContactInformation(trapNode.get(JsonFields.CONTACT_INFORMATION).textValue()) : null;
            final List<Comment> comments = this.parseComments(trapNode);
            final List<UUID> images = this.parseImages(trapNode);
            final LocalDate installationDate = (trapNode.has(JsonFields.INSTALLATION_DATE)) ? LocalDate.parse(trapNode.get(JsonFields.INSTALLATION_DATE).textValue()) : null;
            final LocalDate leavingDate = (trapNode.has(JsonFields.LEAVING_DATE)) ? LocalDate.parse(trapNode.get(JsonFields.LEAVING_DATE).textValue()) : null;
            //
            TrapPostRequestBody requestBody = new TrapPostRequestBody();
            requestBody.setEntryPoint(entryPoint);
            requestBody.setName(name);
            requestBody.setDescription(description);
            requestBody.setType(type);
            requestBody.setGeolocation(geolocation);
            requestBody.setContactInformation(contactInformation);
            requestBody.setComments(comments);
            requestBody.setImageUUID(images);
            requestBody.setInstallationDate(installationDate);
            requestBody.setLeavingDate(leavingDate);
            return requestBody;
        }

        @Override
        protected Optional<List<ApiSubError>> validate(JsonNode trap) {
            List<ApiSubError> errors = new ArrayList<>();
            errors.addAll(this.validateEntryPoint(trap));
            errors.addAll(this.validateName(trap));
            errors.addAll(this.validateDescription(trap));
            errors.addAll(this.validateType(trap));
            errors.addAll(this.validateGeolocation(trap));
            errors.addAll(this.validateContactInformation(trap));
            errors.addAll(this.validateComments(trap));
            errors.addAll(this.validateImages(trap));
            errors.addAll(this.validateInstallationDate(trap));
            errors.addAll(this.validateLeavingDate(trap));
            return (errors.isEmpty()) ? Optional.empty() : Optional.of(errors);
        }

        private List<Comment> parseComments(JsonNode trapNode) {
            List<Comment> comments = new ArrayList<>();
            if (trapNode.has(JsonFields.COMMENTS)) {
                ArrayNode arrayComments = (ArrayNode) trapNode.get(JsonFields.COMMENTS);
                for (final JsonNode commentNode : arrayComments) {
                    final CommentMessage message = new CommentMessage(commentNode.get(JsonFields.MESSAGE).asText());
                    final ZonedDateTime zonedDateTime = ZonedDateTime.parse(commentNode.get(JsonFields.TIMESTAMP).asText(), DateTimeFormatter.ISO_DATE_TIME);
                    final LocalDateTime date = zonedDateTime.toLocalDateTime();
                    Comment comment = new Comment(message, date);
                    comments.add(comment);
                }
            }
            return comments;
        }

        private List<UUID> parseImages(JsonNode trapNode) {
            List<UUID> images = new ArrayList<UUID>();
            if (trapNode.has(JsonFields.IMAGES)) {
                JsonNode nodeImages = (trapNode.get(JsonFields.IMAGES));
                Iterator<JsonNode> iteratorImages = nodeImages.elements();
                while (iteratorImages.hasNext()) {
                    JsonNode imageNode = iteratorImages.next();
                    UUID uuid = UUID.fromString(imageNode.textValue());
                    images.add(uuid);
                }
            }
            return images;
        }

        private List<ApiSubError> validateName(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.NAME)) {
                final String name = trapNode.get(JsonFields.NAME).textValue();
                try {
                    new TrapName(name);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            exception.getMessage(),
                            name,
                            JsonFields.NAME));
                }
            } else {
                errors.add(new ApiSubErrorMessageRejectedValueField(
                        TrapName.ERROR_NOT_DEFINED,
                        JsonFields.NAME));
            }
            return errors;
        }

        private List<ApiSubError> validateDescription(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.DESCRIPTION)) {
                final String description = trapNode.get(JsonFields.DESCRIPTION).textValue();
                try {
                    new TrapDescription(description);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            exception.getMessage(),
                            description,
                            JsonFields.DESCRIPTION));
                }
            }
            return errors;
        }

        private List<ApiSubError> validateContactInformation(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.CONTACT_INFORMATION)) {
                final String contactInformation = trapNode.get(JsonFields.CONTACT_INFORMATION).textValue();
                try {
                    new ContactInformation(contactInformation);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            exception.getMessage(),
                            contactInformation,
                            JsonFields.CONTACT_INFORMATION));
                }
            }
            return errors;
        }

        private List<ApiSubError> validateEntryPoint(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.ENTRYPOINT)) {
                try {
                    UUID uuid = UUID.fromString(trapNode.get(JsonFields.ENTRYPOINT).asText());
                    Optional<EntryPoint> optionalEntryPoint = this.fetchEntryPointUseCase.fetchEntryPointById(uuid);
                    if (!optionalEntryPoint.isPresent()) {
                        errors.add(new ApiSubErrorMessageRejectedValueField(
                                String.format(SamplingPostRequestBodyDeserializer.ERROR_TRAP_ID_NOT_FOUND, uuid.toString()),
                                JsonFields.TRAP_ID));
                    }
                } catch (IllegalArgumentException exception) {
                    errors.add(new ApiSubErrorMessage(SamplingPostRequestBody.ERROR_TRAP_ID_WRONG_FORMAT));
                }
            } else {
                errors.add(new ApiSubErrorMessageRejectedValueField(
                        SamplingPostRequestBodyDeserializer.ERROR_TRAP_ID_NOT_DEFINED,
                        JsonFields.TRAP_ID));
            }
            return errors;
        }

        private List<ApiSubError> validateType(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.TYPE)) {
                final String originalType = trapNode.get(JsonFields.TYPE).textValue();
                final String type = originalType.trim().toUpperCase();
                if (!TrapType.isValid(type)) {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            TrapControllerValidator.ERROR_TYPE_WRONG_FORMAT,
                            originalType,
                            JsonFields.TYPE));
                }
            } else {
                errors.add(new ApiSubErrorMessageRejectedValueField(
                        TrapControllerValidator.ERROR_TYPE_NOT_DEFINED,
                        JsonFields.TYPE));
            }
            return errors;
        }

        private List<ApiSubError> validateGeolocation(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.GEOLOCATION)) {
                final JsonNode nodeGeolocation = (trapNode.get(JsonFields.GEOLOCATION));
                try {
                    KaiztenGeolocationPoint.from(nodeGeolocation);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            exception.getMessage(),
                            JsonFields.GEOLOCATION));
                }
            } else {
                errors.add(new ApiSubErrorMessageRejectedValueField(
                        TrapControllerValidator.ERROR_GEOLOCATION_NOT_DEFINED,
                        JsonFields.GEOLOCATION));
            }
            return errors;
        }

        private List<ApiSubError> validateComments(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.COMMENTS)) {
                ArrayNode comments = (ArrayNode) trapNode.get(JsonFields.COMMENTS);
                for (final JsonNode comment : comments) {
                    if (comment.has(JsonFields.MESSAGE)) {
                        final String message = comment.get(JsonFields.MESSAGE).asText();
                        try {
                            new CommentMessage(message);
                        } catch (Exception exception) {
                            errors.add(new ApiSubErrorMessageRejectedValueField(
                                    exception.getMessage(),
                                    JsonFields.MESSAGE));
                        }
                    } else {
                        errors.add(new ApiSubErrorMessageRejectedValueField(
                                CommentMessage.ERROR_NOT_DEFINED,
                                JsonFields.MESSAGE));
                    }
                }
            }
            return errors;
        }

        private List<ApiSubError> validateImages(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.IMAGES)) {
                JsonNode nodeImages = (trapNode.get(JsonFields.IMAGES));
                if (nodeImages.isArray()) {
                    Iterator<JsonNode> iteratorImages = nodeImages.elements();
                    while (iteratorImages.hasNext()) {
                        JsonNode imageNode = iteratorImages.next();
                        errors.addAll(this.validateImageIdentifier(imageNode));
                    }
                } else {
                    errors.add(new ApiSubErrorMessageRejectedValueField(
                            TrapControllerValidator.ERROR_IMAGES_WRONG_FORMAT,
                            JsonFields.IMAGES));
                }
            }
            return errors;
        }

        private List<ApiSubError> validateImageIdentifier(JsonNode imageNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (imageNode.isTextual()) {
                try {
                    UUID.fromString(imageNode.textValue());
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessage(TrapControllerValidator.ERROR_ID_WRONG_FORMAT));
                }
            } else {
                errors.add(new ApiSubErrorMessage(TrapControllerValidator.ERROR_ID_NOT_TEXT));
            }
            return errors;
        }

        private List<ApiSubError> validateInstallationDate(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.INSTALLATION_DATE)) {
                final String installationDate = trapNode.get(JsonFields.INSTALLATION_DATE).textValue();
                try {
                    LocalDate.parse(installationDate);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessage(
                            TrapControllerValidator.ERROR_INSTALLATION_DATE_WRONG_FORMAT));
                }
            }
            return errors;
        }

        private List<ApiSubError> validateLeavingDate(JsonNode trapNode) {
            List<ApiSubError> errors = new ArrayList<>();
            if (trapNode.has(JsonFields.LEAVING_DATE)) {
                final String leavingDate = trapNode.get(JsonFields.LEAVING_DATE).textValue();
                try {
                    LocalDate.parse(leavingDate);
                } catch (Exception exception) {
                    errors.add(new ApiSubErrorMessage(
                            TrapControllerValidator.ERROR_LEAVING_DATE_WRONG_FORMAT));
                }
            }
            return errors;
        }
    }
    ```

2. Crea un serializador por cada DTO de respuesta dentro de `adapter/rest/serialization`. A continuación tienes un ejemplo:
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
            generator.writeStringField(JsonFields.ENTRYPOINT, entity.getEntryPoint().toString());
            generator.writeStringField(JsonFields.NAME, entity.getName().getValue().toString());
            generator.writeStringField(JsonFields.TYPE, entity.getType().toString());
            generator.writeFieldName(JsonFields.GEOLOCATION);
            generator.writeStartObject(JsonFields.GEOLOCATION);
            generator.writeNumberField(JsonFields.LONGITUDE, entity.getGeolocation().getLongitude());
            generator.writeNumberField(JsonFields.LATITUDE, entity.getGeolocation().getLatitude());
            generator.writeEndObject();
            generator.writeStringField(JsonFields.CREATOR, entity.getCreator().toString());
            // Optional attributes:
            if (entity.hasDescription()) {
                generator.writeStringField(JsonFields.DESCRIPTION, entity.getDescription().get().getValue());
            }
            if (entity.hasContactInformation()) {
                generator.writeStringField(JsonFields.CONTACT_INFORMATION, entity.getContactInformation().get().getValue());
            }
            if (entity.hasComments()) {
                generator.writeArrayFieldStart(JsonFields.COMMENTS);
                for (Comment comment : entity.getComments()) {
                    generator.writeStartObject();
                    generator.writeStringField(JsonFields.MESSAGE, comment.getMessage().getValue());
                    generator.writeStringField(JsonFields.TIMESTAMP, comment.getTimestamp().toString());
                    generator.writeEndObject();
                }
                generator.writeEndArray();
            }
            if (entity.hasImages()) {
                generator.writeArrayFieldStart(JsonFields.IMAGES);
                for (UUID imageUUID : entity.getImages()) {
                    generator.writeString(imageUUID.toString());
                }
                generator.writeEndArray();
            }
            if (entity.hasInstallationDate()) {
                generator.writeStringField(JsonFields.INSTALLATION_DATE, entity.getInstallationDate().get().toString());
            }
            if (entity.hasLeavingDate()) {
                generator.writeStringField(JsonFields.LEAVING_DATE, entity.getLeavingDate().get().toString());
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

### Dependencia `kaizten-typescript`

Hola, hemos creado una pequeña librería de utilidades en [TypeScript](https://www.typescriptlang.org) que nos ayuda en el desarrollo de proyectos de front-end: [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript). En ella hay diversas utilidades para trabajar con fechas, conexiones a servidor, etc.

**Pasos a realizar:**

1. Añade [`kaizten-typescript`](https://github.com/kaizten/kaizten-typescript) al front-end de la aplicación, tal como sigue:
    ```shell
    $ touch .npmrc
    $ echo "//npm.pkg.github.com/:_authToken=\${GITHUB_TOKEN}" >> .npmrc
    $ echo "@kaizten:registry=https://npm.pkg.github.com" >> .npmrc
    $ export GITHUB_TOKEN=<PERSONAL_ACCESS_TOKEN>
    $ yarn add @kaizten/kaizten-typescript@1.0.0
    ```
    Es importante que sustituyas `<PERSONAL_ACCESS_TOKEN>` por tu token personal de [GitHub](https://www.github.com). Si no lo tienes, crea un token personal en tu cuenta de GitHub. Aquí tienes los [pasos](https://docs.github.com/es/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). El tipo de token que debes crear es `Personal access tokens (classic)`. Además, es importante que cuando crees el token marques la opción `read-packages`.

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
    $ docker build -t dockerizedfrontend .
    ```

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
    version: "3.7"

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
