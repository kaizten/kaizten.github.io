# Issues proyecto de optimización

<!-- TOC -->
- [GitHub](#github)
  - [Primeros pasos](#primeros-pasos)
- [Java](#java)
  - [Instalación de JDK](#instalación-de-jdk)
  - [Instalación de Maven](#instalación-de-maven)
  - [Dependencia: `kaizten-utils`](#dependencia-kaizten-utils)
- [Docker](#docker)
  - [Instalación](#instalación)
  - [Docker Compose. Instalación](#docker-compose-instalación)
- [CPLEX](#cplex)
  - [Instalación](#instalación-1)
  - [Dependencia `cplex.jar`](#dependencia-cplexjar)
- [Visual Studio Code](#visual-studio-code)
  - [Instalación](#instalación-2)
  - [Extensión `Draw.io`](#extensión-drawio)
  - [Extensión `Vue - Official`](#extensión-vue---official)
- [Descripción del problema de optimización](#descripción-del-problema-de-optimización)
<!-- /TOC -->

## GitHub

### Primeros pasos

Hola, [GitHub](https://github.com) es una plataforma de desarrollo colaborativo para alojar proyectos utilizando el sistema de control de versiones [Git](https://git-scm.com/). Concretamente, es una plataforma en línea que permite a los desarrolladores y equipos de desarrollo colaborar en proyectos de software de manera eficiente. Permite a los usuarios alojar, gestionar y seguir el progreso de sus proyectos. Aquí, los repositorios son el corazón de la colaboración, y contienen el código fuente de un proyecto, junto con su historial de cambios.

1. Para empezar a trabajar con [GitHub](https://github.com) debes instalar [Git](https://git-scm.com/) en tu máquina. Por tanto, instala [Git](https://git-scm.com/) en tu máquina y comprueba desde una terminal que está correctamente instalado. En máquinas Linux sería así:
```shell
$ sudo apt install git
```
Deberías obtener algo similar a esto:
```shell
$ git --version
git version 2.34.1
```
2. Una vez instalado correctamente [Git](https://git-scm.com/) en tu máquina y tengas tu cuenta de [GitHub](https://github.com), lo que debes hacer es clonar todos los repositorios que te compartamos. Te dejo [un enlace](https://docs.github.com/es/repositories/creating-and-managing-repositories/cloning-a-repository) sobre cómo clonar un repositorio al que te haya llegado una invitación. De forma resumida, tendrás que abrir una terminal y ejecutar lo siguiente:
```shell
$ git clone git@github.com:kaizten/NOMBRE_REPOSITORIO.git
```
siendo `NOMBRE_REPOSITORIO` el nombre del repositorio en cuestión. Este comando lo puedes ver accediendo a la web del repositorio en [GitHub](https://github.com), pulsando el botón verde `<> Code>`, desde la opción `Clone` `SSH`. Cuando hayas clonado un repositorio tendrás una copia en tu máquina local de lo que se encuentra en dicho repositorio. 

Indica a través de este issue si has podido clonar los repositorios compartidos contigo de manera correcta.

## Java

### Instalación de JDK

Hola, en el proyecto deberíamos usar al menos [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html). Puedes instalar el JDK de Java tal como sigue:
```shell
$ sudo add-apt-repository ppa:linuxuprising/java
$ sudo apt update
$ sudo apt install oracle-java17-installer oracle-java17-set-default
```

Una vez realizados los pasos previos, comprueba que tienes instalado en tu máquina al menos esta versión. Para ello, ejecuta lo siguiente:
```shell
$ java -version
java version "17.0.6" 2023-01-17 LTS
Java(TM) SE Runtime Environment (build 17.0.6+9-LTS-190)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.6+9-LTS-190, mixed mode, sharing)
```
Cabe señalar que si tienes una versión superior de Java a la 17 no hay problema.

Pon un comentario en este issue mostrando la salida del comando `java -version` para comprobar que has instalado correctamente [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) en tu máquina.

### Instalación de Maven

Hola, para compilar proyectos en Java se pueden usar herramientas como [Maven](https://maven.apache.org). Esta herramienta ayudará a para construir los componentes en Java de una forma sencilla. Por ello, habría que instalar tener instalada al menos la versión `3.9.5` de [Maven](https://maven.apache.org). A continuación tienes un ejemplo de cómo debería estar tu máquina:
```shell
$ mvn -v
Apache Maven 3.9.5 (57804ffe001d7215b5e7bcb531cf83df38f93546)
Maven home: /opt/maven
Java version: 17.0.6, vendor: Ubuntu, runtime: /usr/lib/jvm/java-17-oracle
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.2.0-36-generic", arch: "amd64", family: "unix"
```
Cabe señalar que si tienes una versión superior de [Maven](https://maven.apache.org) a la 3.9.5 no hay problema.

Pon un comentario en este issue mostrando la salida del comando `mvn -v` para comprobar que has instalado correctamente [Maven](https://maven.apache.org) en tu máquina.
  
### Dependencia: `kaizten-utils`

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

## Docker

### Instalación

Hola, [Docker](https://www.docker.com) es una plataforma de software que permite crear, implementar y ejecutar aplicaciones en contenedores. Un contenedor es un paquete de software que incluye todo lo necesario para que una aplicación se ejecute, incluyendo el código, las bibliotecas y las dependencias. Los contenedores son independientes del sistema operativo y se pueden ejecutar en cualquier plataforma que admita Docker.

En la siguiente página tienes los pasos para realizar la instalación de [Docker](https://www.docker.com) en Ubuntu: https://docs.docker.com/engine/install/ubuntu/ Si tienes otro sistema operativo puedes encontrar [aquí](https://docs.docker.com/engine/install/) cómo instalar la herramienta.

Una vez realizados estos pasos, comprueba que tienes instalado Docker en tu máquina, tal como sigue:
```shell
$ docker -v
Docker version 27.2.1, build 9e34c9b
```
Comprueba que tienes al menos la versión 27 de [Docker](https://www.docker.com). Al mismo tiempo, es importante que puedes ejecutar `docker` sin necesitar emplear `sudo`. Si necesitas usar `sudo`, revisa [este artículo](https://docs.docker.com/engine/install/linux-postinstall/) donde se indica cómo ejecutarlo como usuario convencional.

### Docker Compose. Instalación

Hola, [Docker Compose](https://docs.docker.com/compose/) es una herramienta de orquestación de contenedores que permite definir, configurar y ejecutar aplicaciones multi-contenedor Docker. Con Compose, se puede definir la configuración de múltiples servicios, redes y volúmenes, y luego iniciarlos y detenerlos todos juntos con un solo comando. Básicamente, Docker Compose es una herramienta que simplifica el proceso de gestión de múltiples contenedores de Docker en un entorno de producción. Permite definir la configuración de cada contenedor, así como las conexiones entre ellos, en un archivo YAML. Esto hace que sea fácil de leer y entender, y también es fácil de compartir con otros desarrolladores.

En la siguiente página tienes los pasos para realizar la instalación de Docker Compose en tu máquina: https://docs.docker.com/compose/install/

 Comprueba que tienes instalado Docker Compose en tu máquina, tal como sigue:
```shell
$ docker-compose -v
docker-compose version 1.29.0, build 07737305
```

## CPLEX

### Instalación

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

### Dependencia `cplex.jar`

Hola, una vez instalado CPLEX en tu máquina, es necesario que conectes Java con CPLEX para poder programar modelos matemáticos desde el código fuente. Esto se realiza a través de un archivo `cplex.jar` que se encuentra donde instalaste CPLEX. 

En base a lo anterior, debes buscar `cplex.jar` en la instalación de CPLEX y luego usar `mvn` para proceder a la instalación de este archivo. Te paso ejemplos de cómo sería tanto en Linux como en Windows:
* Linux: `mvn install:install-file -DgroupId=cplex -DartifactId=cplex -Dversion=12.8 -Dpackaging=jar -Dfile=/opt/ibm/ILOG/CPLEX_Studio128/cplex/lib/cplex.jar`
* Windows: `mvn install:install-file -DgroupId=cplex -DartifactId=cplex -Dversion=12.8 -Dpackaging=jar -Dfile="C:\Program Files\IBM\ILOG\CPLEX_Studio128\cplex\lib\cplex.jar"`

En cualquiera de los casos, debes cambiar la ruta de `cplex.jar` por la ruta que tenga en tu ordenador.

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

Hola, una herramienta particularmente interesante para poder hacer diagramas sencillos es [Draw.io](https://app.diagrams.net). Es una herramienta gratuita con la que puedes realizar diagramas de una manera muy cómoda. Además, en [Visual Studio Code](https://code.visualstudio.com) hay una extensión que permite crear estos diagramas sin tener que salir de la herramienta.

**Pasos a realizar:**

1. Instala la extensión de [Draw.io](https://app.diagrams.net) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio).

### Extensión `Vue - Official`

Hola, [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar) es una extensión para [Visual Studio Code](https://code.visualstudio.com/) diseñada específicamente para mejorar el desarrollo en entornos de [Vue.js](https://vuejs.org). Esta extensión ofrece un soporte avanzado para el desarrollo de aplicaciones [Vue.js](https://vuejs.org), agilizando la escritura de código, mejorando la detección de errores y proporcionando una experiencia de desarrollo más fluida y eficiente. Si usas [Visual Studio Code](https://code.visualstudio.com) creo que sería interesante que instalar esta extensión y, de esta manera, puedas trabajar de forma más eficaz con [Vue.js](https://vuejs.org).

**Pasos a realizar:**

1. Instala la extensión de [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=Vue.volar).

## Descripción del problema de optimización

Hola, [este enlace](ENLACE OVERLEAF) es el lugar donde vamos a tratar de tener la descripción del problema de optimización a modelar matemáticamente así como sus formulaciones. Es un documento hecho en [LaTeX](https://www.latex-project.org) empleando la herramienta online [Overleaf](https://overleaf.com). Se trata de un documento de trabajo, por tanto, modifícalo libremente.

Para poder acceder al documento primero debes contar con una cuenta de [Overleaf](https://overleaf.com). Por tanto, si no tienes cuenta en [Overleaf](https://overleaf.com), crea una e indícame por aquí tu dirección para poder añadirte.
