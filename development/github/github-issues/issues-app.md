<!-- TOC -->

- [Docker](#docker)
  - [Instalación](#instalación)
  - [Nociones básicas](#nociones-básicas)
  - [Docker Compose. Instalación](#docker-compose-instalación)
- [NodeJS. Instalación](#nodejs-instalación)
- [Yarn. Instalación](#yarn-instalación)
- [Visual Studio Code](#visual-studio-code)
  - [Instalación](#instalación-1)
  - [Extensión `Draw.io`](#extensión-drawio)
  - [Extensión `React Native Tools`](#extensión-react-native-tools)
- [Arquitectura hexagonal](#arquitectura-hexagonal)
<!-- /TOC -->

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
    $ docker-compose -v
    docker-compose version 1.29.0, build 07737305
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

1. Instala [Yarn](https://yarnpkg.com) siguiendo alguna de las siguientes opciones:
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
2. Una vez instalado, debes comprobar que tienes al menos la versión `1.22.19` en tu máquina. Esto es:
    ```shell
    $ yarn --version
    1.22.19
    ```

## Visual Studio Code

### Instalación

Hola, para poder programar de manera cómoda y eficiente es aconsejable emplear un entorno de programación integrado (IDE, por sus siglas en inglés). Actualmente uno de los IDE más versátiles es [Visual Studio Code](https://code.visualstudio.com) (VSC). [Visual Studio Code](https://code.visualstudio.com) es un IDE desarrollado por Microsoft para Windows, Linux, macOS y Web. Incluye soporte para la depuración, control integrado de [Git](https://git-scm.com), resaltado de sintaxis, finalización inteligente de código, fragmentos y refactorización (modificación del código fuente sin cambiar su comportamiento). El IDE es personalizable, por lo que sus usuarios pueden cambiar el tema del editor, los atajos de teclado y las preferencias. Es gratuito y de código abierto y es uno de los IDEs más utilizados en la actualidad. 

**Pasos a realizar:**

1. Si no empleas ya un IDE diferente como [NetBeans](https://netbeans.apache.org), [IntelliJ IDEA](https://www.jetbrains.com/idea/), o [Eclipse](https://eclipseide.org), entre otros, te propongo instalar [Visual Studio Code](https://code.visualstudio.com) (al menos la versión `1.93.1`) en tu máquina. 
2. Cuando hayas instalado [Visual Studio Code](https://code.visualstudio.com), ejecuta lo siguiente desde una terminal para comprobar que se ha instalado correctamente:
    ```shell
    $ code --version
    1.93.1
    38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40
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

### Extensión `React Native Tools`

Hola, [React Native Tools](https://marketplace.visualstudio.com/items?itemName=msjsdiag.vscode-react-native) es una extensión para [Visual Studio Code](https://code.visualstudio.com/) diseñada específicamente para ayudar en el desarrollo de aplicaciones mediante [React Native](https://reactnative.dev). Si usas [Visual Studio Code](https://code.visualstudio.com), esta extensión sería interesante tenerla porque te ayudará a trabajar de forma más cómoda..

**Pasos a realizar:**

1. Instala la extensión de [React Native Tools](https://marketplace.visualstudio.com/items?itemName=msjsdiag.vscode-react-native) en tu [Visual Studio Code](https://code.visualstudio.com) siguiendo los pasos descritos [aquí](https://marketplace.visualstudio.com/items?itemName=msjsdiag.vscode-react-native).

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