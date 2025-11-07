<!-- TOC -->

- [Front-end](#front-end)
  - [Primeros pasos](#primeros-pasos)
  - [Añadir dependencia: `kaizten-typescript`](#añadir-dependencia-kaizten-typescript)
  - [Añadir dependencia: `kaizten-vue`](#añadir-dependencia-kaizten-vue)
  - [Dockerfile](#dockerfile-1)
  - [GitHub action](#github-action-1)
  - [Dominio](#dominio)
  - [Aplicación](#aplicación-1)
    - [Casos de uso](#casos-de-uso)
    - [Servicios](#servicios)
    - [Repositorios](#repositorios)
  - [Adaptador HTTP](#adaptador-http)
    - [Primeros pasos](#primeros-pasos-1)
    - [Data transfer objects](#data-transfer-objects)
    - [Probar adaptador HTTP](#probar-adaptador-http)
  - [Adaptador Vue.js](#adaptador-vuejs)
    - [Primeros pasos](#primeros-pasos-2)
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
  - [Primeros pasos](#primeros-pasos-3)
  - [Integración en front-end](#integración-en-front-end)
<!-- /TOC -->

### Dockerfile

Hola, la dockerización es crucial por varias razones fundamentales que influyen directamente en la eficiencia, portabilidad y escalabilidad del sistema. En particular, con [Docker](https://www.docker.com), las dependencias (bibliotecas, frameworks, entornos, etc.) se pueden empaquetar y versionar fácilmente, lo que simplifica la gestión de dependencias y las actualizaciones del software.

La dockerización requiere de un archivo `Dockerfile`. Se trata un archivo de texto que contiene instrucciones precisas para construir una imagen de [Docker](https://www.docker.com), especificando los pasos necesarios para configurar y ejecutar un entorno dentro de un contenedor. 

**Pasos a realizar:**

1. Para crear el `Dockerfile` tienes que crear el siguiente archivo dentro de la carpeta del componente:
    ```shell
    FROM eclipse-temurin:17-jdk-alpine

    EXPOSE 8080

    ARG JAR_FILE=target/*.jar

    COPY ${JAR_FILE} app.jar

    ENTRYPOINT ["java", "-jar", "/app.jar"]
    ```
    Es importante que lo guardes exactamente con el nombre `Dockerfile`. Esto es, no pongas extensiones en el nombre del fichero.

2. Una vez creado el `Dockerfile`, puedes crear la imagen [Docker](https://www.docker.com) de tu componente. Para ello, ejecuta lo siguiente:
    ```shell
    $ cd <COMPONENT-FOLDER>
    $ mvn clean package
    $ docker build -t dockerizedcomponent .
    ```
    En este caso, `<COMPONENT-FOLDER> es el nombre de tu componente.

3. Si todo ha ido correctamente, debes tener la imagen [Docker](https://www.docker.com) generada en tu máquina:
    ```shell
    $ docker images 
    REPOSITORY                            TAG       IMAGE ID       CREATED          SIZE
    dockerizedcomponent                   latest    0ff1df35654b   24 seconds ago   352MB
    ```
    Comprueba que la imagen de [Docker](https://www.docker.com) se ha creado correctamente.

4. Finalmente, puedes crear un contenedor [Docker](https://www.docker.com) de esta imagen, tal como sigue:
    ```shell
    $ docker run -p 8081:8080 --name mycontainer dockerizedcomponent
    ```
    El resultado debe ser que el componente se ejecute de forma convencional, pero ahora no como un artefacto Java sino como un contenedor. Concretamente, se está creando un contenedor llamado `mycontainer` de la imagen previamente creada `dockerizedcomponent`.

### GitHub action

Hola, la compilación del componente y la generación de la imagen [Docker](https://www.docker.com) correspondiente requieren pasos manuales, lo que puede llevar a errores, inconsistencias y pérdida de tiempo. Para mejorar este proceso, se puede implementar una [GitHub action](https://github.com/features/actions) que automatice estas tareas con cada `push` realizado en el repositorio.

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

    name: <COMPONENT-NAME>. Publish Docker image

    # Events that trigger the workflow
    on:
      push:
        branches:
          - main
        paths:
          - <COMPONENT-FOLDER>/**
          - '!**.md'
      workflow_dispatch:

    # Working directory
    defaults:
      run:
        working-directory: <COMPONENT-FOLDER>

    # Environment variables
    env:
      JAVA_VERSION: 17
      WORKING_DIRECTORY: <COMPONENT-FOLDER>
      DOCKER_IMAGE_NAME: kaizten/<PROJECT-NAME>_<COMPONENT-NAME>

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

    La [GitHub action](https://github.com/features/actions) creada está destinada a que, cada vez que hagas un cambio en la carpeta de tu componente (salvo que estos cambios sean en archivos `.md`) y lo subas al repositorio, se genere la imagen [Docker](https://www.docker.com) correspondiente y se publique en [Docker Hub](https://hub.docker.com). Fíjate que en el archivo hay definida una variable `DOCKER_IMAGE_NAME` que indica el nombre de la imagen [Docker](https://www.docker.com) que se genera con el lanzamiento de la [GitHub action](https://github.com/features/actions). 
    
    Por último, es importante que sustituyas lo siguiente:
    * `<PROJECT-NAME>` por el nombre de tu proyecto.
    * `<COMPONENT-NAME>` por el nombre de tu componente.
    * `<COMPONENT-FOLDER>` por el nombre de la carpeta de tu componente. 

3. Antes de pasar a probar la [GitHub action](https://github.com/features/actions), debes modificar el archivo `<COMPONENT-FOLDER>/pom.xml` añadiendo la sección `<profiles>` que se muestra a continuación:
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
    Esto se hace para que la [GitHub action](https://github.com/features/actions) sea capaz de encontrar el paquete [kaizten-utils](https://github.com/kaizten/kaizten-utils) que estás usando en el componente.

4. Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `<COMPONENT-FOLDER>/` (salvo los archivos `.md` que han sido excluídos) y subiéndolos al repositorio. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` de la página de GitHub del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo electrónico indicando el error. En tal caso, procede a revisar el error y tratar de corregirlo.

5. Una vez haya finalizado correctamente la ejecución de la [GitHub action](https://github.com/features/actions), comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.