# Issues visualización de datos mediante Grafana

<!-- TOC -->
- [GitHub](#github)
  - [Primeros pasos](#primeros-pasos)
- [Docker](#docker)
  - [Instalación](#instalación)
  - [Nociones básicas](#nociones-básicas)
  - [Docker Compose. Instalación](#docker-compose-instalación)
- [Visual Studio Code](#visual-studio-code)
  - [Instalación](#instalación-1)
  - [Extensión `Draw.io`](#extensión-drawio)
  - [Extensión `JSONata`](#extensión-jsonata)
- [Grafana](#grafana)
  - [Primeros pasos](#primeros-pasos-1)
  - [Variable](#variable)
- [Servidor de JSON (File Server)](#servidor-de-json-file-server)
- [Cuadro de mandos de instancia](#cuadro-de-mandos-de-instancia)
- [Notebook de JSONata](#notebook-de-jsonata)
- [Cuadros de mandos](#cuadros-de-mandos)
  - [Versiones finales](#versiones-finales)
  - [Documentación](#documentación)
<!-- /TOC -->

## GitHub

### Primeros pasos

Hola, [GitHub](https://github.com) es una plataforma de desarrollo colaborativo para alojar proyectos utilizando el sistema de control de versiones [Git](https://git-scm.com/). Concretamente, es una plataforma en línea que permite a los desarrolladores y equipos de desarrollo colaborar en proyectos de software de manera eficiente. Permite a los usuarios alojar, gestionar y seguir el progreso de sus proyectos. Aquí, los repositorios son el corazón de la colaboración, y contienen el código fuente de un proyecto, junto con su historial de cambios.

**Pasos a realizar:**

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

3. Indica a través de este issue si has podido clonar los repositorios compartidos contigo de manera correcta.

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

### Extensión `JSONata`

Hola, [JSONata](https://jsonata.org) es un lenguaje de consulta y transformación diseñado para procesar y manipular datos JSON de manera eficiente, permitiendo filtrar, transformar y extraer información de estructuras complejas de datos.

**Pasos a realizar:**

1. Instala la extensión [https://marketplace.visualstudio.com/items?itemName=bigbug.vscode-language-jsonata](https://marketplace.visualstudio.com/items?itemName=bigbug.vscode-language-jsonata) en tu [Visual Studio Code](https://code.visualstudio.com) para poder trabajar con [JSONata](https://jsonata.org) de forma sencilla. Tal como indica la documentación de la extensión, se hace de esta manera:
    ```
    Ctrl + P
    ```
    Una vez instalada la extensión deberías obtener algo similar a ![esto](https://kaizten.github.io/images/vscode-extension-jsonata.png)
2. `ext install bigbug.vscode-language-jsonata`
3. Instalar extensión

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

1. Crea una carpeta `dashboards` en el repositorio para guardar los cuadros de mandos que vayas creando.
2. Crea un primer cuadro de mandos y añade el plugin [JSON API](https://grafana.github.io/grafana-json-datasource/). Está diseñado para inyectar datos desde JSON en los cuadros de mandos. Revisa la sección [Getting started](https://grafana.github.io/grafana-json-datasource/installation) sobre cómo usarlo. 
3. Replica el ejemplo descrito en [este enlace del blog de Grafana](https://grafana.com/blog/2023/08/30/grafana-json-api-how-to-import-third-party-data-sources-in-grafana-cloud/). En el ejemplo tendrás que crear un gráfico extrayendo datos en formato JSON desde una API pública.
4. Exporta el cuadro de mandos en formato JSON en la carpeta `dashboards` previamente creada. De esta manera, cuando vuelvas a arrancar [Grafana](https://grafana.com) tendrás todo montado y no tendrás que repetir el proceso.

### Variable

Hola, sería necesario añadir una variable `sample` para que el usuario pueda elegir la o las muestras que desea consultar. Los gráficos del cuadro de mandos deberían actualizarse en base a los valores escogidos en el selector de la variable.

**Pasos a realizar:**

1. Revisa cómo se crean [variables en Grafana](https://grafana.com/docs/grafana/latest/dashboards/variables/).
2. Añade la variable indicada en el cuadro de mandos.

## Servidor de JSON (File Server)

Hola, el plugin [JSON API](https://grafana.github.io/grafana-json-datasource/) de [Grafana](https://grafana.com) requiere que el JSON con los datos a visualizar esté disponible en una URL. Sin embargo, en muchas ocasiones lo que se tiene es un archivo con formato JSON ubicado en algún lugar de nuestro ordenador, por ejemplo en nuestro escritorio. 

**Pasos a realizar:**

1. En casos como los anteriores, lo que se puede hacer es publicar ese archivo como una URL. Con Docker se puede hacer de esta manera:
    ```sh
    docker run --rm -it --name my-file-server -p 80:7000 -v /home/christopher/Downloads/:/data kaizten/file-server
    ```
    En este caso, se está levantando el servidor en `localhost:80` (podrías ponerlo en el puerto que quisieras) y sirviendo los archivos que están en mi carpeta `/home/christopher/Downloads/`. Tendrías que cambiar esta carpeta por la que consideres y donde se encuentren los archivos con formato JSON a visualizar. 

    Al acceder a través del navegador a `localhost:80` algo similar a esto:
    ![Ejemplo](https://kaizten.github.io/kaizten-tools/file-server/images/file-server.png). 

    A partir de ahí, puedes acceder a cualquier archivo de la carpeta mediante el navegador. Por ejemplo, `http://localhost:80/instance.json`.

2. Comprueba que te funciona correctamente y avísame a través de este issue.

## Cuadro de mandos de instancia

Hola, sería interesante desarrollar un cuadro de mandos para las instancias del problema. Esto es, para los escenarios posibles de la problemática a resolver. En este sentido, en la carpeta `data/ ` tienes una instancia en formato JSON (`instance.json`) que puedes emplear para probar el cuadro de mandos.

**Pasos a realizar:**

1. El cuadro de mandos debería incluir información relevante contenida en el archivo de instancia de problema. Por ejemplo:
   - Número de proveedores
   - Número de clientes
   - Número total de pallets enviados
   - Diagrama Sankey para representar el envío/recepción de pallets entre proveedores y clientes.
   - Histograma con la distribución del número de pallets enviados (eje y) por cada proveedor (eje x)
   - Histograma con la distribución del número de pallets recibidos (eje y) por cada cliente (eje x)
   - ...

2. A medida que vayas trabajando en el cuadro de mandos, guárdalo en la carpeta `dashboards/` del repositorio.

## Notebook de JSONata

Hola, el objetivo de este issue es crear tu primer notebook para trabajar con [JSONata](https://jsonata.org) desde tu [Visual Studio Code](https://code.visualstudio.com).

**Pasos a realizar:**

1. Si no está previamente creada, crea la carpeta `data/` en el repositorio.
2. Crea el archivo `example.json` y guárdalo en la carpeta `data/`. El contenido del archivo debe ser el siguiente:
    ```json
    {
      "employees": [
        { "name": "John", "age": 30, "department": "Sales" },
        { "name": "Jane", "age": 25, "department": "Marketing" },
        { "name": "Doe", "age": 40, "department": "Development" }
      ]
    }
    ```
3. Si no está previamente creada, crea la carpeta `jsonata-notebooks/` en el repositorio.
4. Crea el archivo `first-notebook.jsonata-book` dentro de la carpeta `jsonata-notebooks`. Al abrir el archivo con [Visual Studio Code](https://code.visualstudio.com), dado que ya tienes la extensión [https://marketplace.visualstudio.com/items?itemName=bigbug.vscode-language-jsonata](https://marketplace.visualstudio.com/items?itemName=bigbug.vscode-language-jsonata) instalada, debe verse de forma similar a como aparece a continuación:
![Ejemplo](https://kaizten.github.io/images/first-example.png)
6. Una vez creado el notebook, puedes cargar el archivo `data/example.json`, tal como aparece a continuación:
![Ejemplo](https://kaizten.github.io/images/loadfile.png)
7. Prueba otras consultas como `employees[1]` o `$count(employees)`. 
8. En la [página de JSONata](https://docs.jsonata.org/overview.html) tienes un amplio tutorial sobre cómo hacer consultas. Léelo con calma y practica con el notebook creado.

## Cuadros de mandos

### Versiones finales

Hola, cuando puedas, guarda las versiones finales de los cuadros de mandos creados.

**Pasos a realizar:**

1. Pon en la carpeta `dashboards/` los cuadros de mandos finales que has realizado. Ponles nombres representativos.
2. Saca una captura de cada uno de los cuadros de mandos en formato PNG y guárdala en `images/`. Puedes usar la extensión [GoFullPage](https://chromewebstore.google.com/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl) de Google Chrome. Esta extensión permite sacar una captura completa de una página web. Por tanto, abre cada cuadro de mandos con Grafana y usa la extensión para obtener el PNG correspondiente.

### Documentación

Hola, para cada cuadro de mandos creado añade una sección en el `readme.md` del repositorio con al menos lo siguiente:
* Nombre del cuadro de mandos.
* Imagen del elemento del cuadro de mandos. Guarda las imágenes en `images/`.
* Incluye el código de cada `Query` de Grafana y la configuración de los parámetros de cada una.
* Incluye una descripción cada `Transformación` de Grafana y la configuración de los parámetros de cada una.
* Incluye la configuración de cada elemento (panel de la derecha del elemento gráfico).
* Si has definido variables Grafana, enumera las variables definidas y cómo las has configurado.