- [`requirements.txt`](#requirementstxt)
- [Dockerfile](#dockerfile)
- [GitHub action](#github-action)

### `requirements.txt`

Los archivos `requirements.txt` son esenciales en componentes de Python, ya que permiten gestionar las dependencias del proyecto de manera eficiente. Este archivo contiene una lista de paquetes y sus versiones específicas que el proyecto necesita para funcionar correctamente. Al utilizar un archivo `requirements.txt`, se asegura que cualquier desarrollador o entorno pueda instalar las mismas dependencias y versiones, garantizando consistencia y evitando problemas de compatibilidad.

**¿Por qué es necesario?**

1. **Consistencia:** Permite que todos los desarrolladores trabajen con las mismas versiones de las dependencias.
2. **Portabilidad:** Facilita la instalación de dependencias en diferentes entornos, como servidores de producción o máquinas locales.
3. **Automatización:** Herramientas como `pip` pueden leer este archivo para instalar automáticamente todas las dependencias necesarias.

**Pasos a realizar:**

1. **Crear el archivo `requirements.txt`:**
    - Dentro de la carpeta del componente Python, crea un archivo llamado `requirements.txt`.
    - Añade en este archivo todas las dependencias necesarias para el componente. Por ejemplo:
      ```
      flask==2.1.1
      requests==2.28.1
      numpy==1.23.5
      ```
      Asegúrate de especificar las versiones exactas de cada paquete para evitar inconsistencias.

2. **Instalar las dependencias:**
    - Una vez creado el archivo, instala las dependencias ejecutando el siguiente comando en la terminal:
      ```bash
      pip install -r requirements.txt
      ```
      Esto instalará todas las dependencias listadas en el archivo.

3. **Probar que todo funciona correctamente:**
    - Verifica que las dependencias se han instalado correctamente ejecutando el siguiente comando:
      ```bash
      pip freeze
      ```
      Este comando mostrará todas las dependencias instaladas en el entorno actual. Asegúrate de que coincidan con las listadas en el archivo `requirements.txt`.
    - Ejecuta el componente Python para confirmar que no hay errores relacionados con las dependencias. Por ejemplo:
      ```bash
      python main.py
      ```
      Si el componente se ejecuta sin problemas, significa que las dependencias están configuradas correctamente.

4. **Actualizar el archivo `requirements.txt` (opcional):**
    - Si en el futuro necesitas añadir nuevas dependencias, instálalas con `pip install` y luego actualiza el archivo `requirements.txt` ejecutando:
      ```bash
      pip freeze > requirements.txt
      ```
      Esto sobrescribirá el archivo con todas las dependencias actuales del entorno.

### Dockerfile

Hola, la dockerización es crucial por varias razones fundamentales que influyen directamente en la eficiencia, portabilidad y escalabilidad del sistema. En particular, con [Docker](https://www.docker.com), las dependencias (bibliotecas, frameworks, entornos, etc.) se pueden empaquetar y versionar fácilmente, lo que simplifica la gestión de dependencias y las actualizaciones del software.

La dockerización requiere de un archivo `Dockerfile`. Se trata un archivo de texto que contiene instrucciones precisas para construir una imagen de [Docker](https://www.docker.com), especificando los pasos necesarios para configurar y ejecutar un entorno dentro de un contenedor. 

**Pasos a realizar:**

1. Para crear el `Dockerfile` tienes que crear el siguiente archivo dentro de la carpeta del componente:
    ```shell
    FROM python:3.12-slim

    WORKDIR /app

    COPY requirements.txt requirements.txt
    RUN pip install --no-cache-dir -r requirements.txt

    COPY . .

    CMD ["python", "main.py"]
    ```
    Es importante que lo guardes exactamente con el nombre `Dockerfile`. Esto es, no pongas extensiones en el nombre del fichero.

2. Una vez creado el `Dockerfile`, puedes crear la imagen [Docker](https://www.docker.com) de tu componente. Para ello, ejecuta lo siguiente:
    ```shell
    $ cd <COMPONENT-FOLDER>
    $ docker build -t pythonizedcomponent .
    ```
    En este caso, `<COMPONENT-FOLDER>` es el nombre de tu componente.

3. Si todo ha ido correctamente, debes tener la imagen [Docker](https://www.docker.com) generada en tu máquina:
    ```shell
    $ docker images 
    REPOSITORY                            TAG       IMAGE ID       CREATED          SIZE
    pythonizedcomponent                   latest    0ff1df35654b   24 seconds ago   352MB
    ```
    Comprueba que la imagen de [Docker](https://www.docker.com) se ha creado correctamente.

4. Finalmente, puedes crear un contenedor [Docker](https://www.docker.com) de esta imagen, tal como sigue:
    ```shell
    $ docker run -p 8081:8080 --name mypythoncontainer pythonizedcomponent
    ```
    El resultado debe ser que el componente se ejecute de forma convencional, pero ahora no como un script Python sino como un contenedor. Concretamente, se está creando un contenedor llamado `mypythoncontainer` de la imagen previamente creada `pythonizedcomponent`.

### GitHub action

Hola, la compilación del componente y la generación de la imagen [Docker](https://www.docker.com) correspondiente requieren pasos manuales, lo que puede llevar a errores, inconsistencias y pérdida de tiempo. Para mejorar este proceso, se puede implementar una [GitHub action](https://github.com/features/actions) que automatice estas tareas con cada `push` realizado en el repositorio.

Cabe señalar que las [GitHub action](https://github.com/features/actions) se definen en la carpeta `.github/workflows` del repositorio. 

**Pasos a realizar:**

1. En el caso de que no exista, crea la carpeta `.github/workflows` en la raíz de tu repositorio. Es importante que te fijes bien en que se trata de una carpeta oculta.
   
2. Dentro de la carpeta `.github/workflows` crea el archivo `<COMPONENT-NAME>_publish-docker-image.yml` con el siguiente contenido:
    ```yaml
    # GitHub action aimed at creating a Docker image of a Python component. 
    # The Docker image is pushed on DockerHub when created.
    #
    # Requirements:
    # - Secrets. In order to execute the GitHub action the following secrets must be set in the project
    # (Settings / Secrets / Actions):
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
      DOCKER_IMAGE_NAME: kaizten/<PROJECT-NAME>_<COMPONENT-NAME>

    jobs:
      path-context:
        runs-on: ubuntu-latest
        steps:
          # Checkout of the repository
          - name: Checkout
            uses: actions/checkout@v4
          # Set up Python environment
          - name: Set up Python
            uses: actions/setup-python@v4
            with:
              python-version: '3.x'
          # Install dependencies
          - name: Install dependencies
            run: |
              pip install --upgrade pip
              pip install -r requirements.txt
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

3. Revisa la [GitHub action](https://github.com/features/actions) y prueba a ejecutarla haciendo algún cambio en alguno de los archivos de `<COMPONENT-FOLDER>/` (salvo los archivos `.md` que han sido excluidos) y subiéndolos al repositorio. Indícame si se ha ejecutado correctamente (puedes verlo en la pestaña `Actions` de la página de GitHub del repositorio). En caso de que se produzca algún error en la ejecución de la [GitHub action](https://github.com/features/actions) te llegará un correo electrónico indicando el error. En tal caso, procede a revisar el error y tratar de corregirlo.

4. Una vez haya finalizado correctamente la ejecución de la [GitHub action](https://github.com/features/actions), comprueba que la imagen se encuentra publicada en [Docker Hub](https://hub.docker.com) con el nombre establecido por la variable `DOCKER_IMAGE_NAME`.