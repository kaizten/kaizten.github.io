# Infraestructura necesaria

Para la correcta realización de tus prácticas en Kaizten Analytics debes contar con una infraestructura básica de desarrollo previamente configurada en tu equipo.

En primer lugar, sería necesario tener [Ubuntu 24.04](https://ubuntu.com/download/desktop) (o superior) como sistema operativo base, ya que será el entorno de referencia utilizado durante las prácticas. Si usas otro sistema operativo, debes crear una partición en tu disco duro con este sistema operativo.

Además, entre otros, deberás tener instalados los siguientes componentes:

* [JDK 17 (o superior)](https://www.oracle.com/java/technologies/downloads/): entorno de desarrollo necesario para ejecutar y compilar aplicaciones Java.
* [Maven](https://maven.apache.org/download.cgi): herramienta de gestión y construcción de proyectos Java.
* [curl](https://www.cyberciti.biz/faq/how-to-install-curl-command-on-a-ubuntu-linux/): herramienta de línea de comandos utilizada para transferir datos desde o hacia un servidor.
* [Git](https://github.com/git-guides/install-git#debianubuntu): sistema de control de versiones distribuido, indispensable para la colaboración y gestión del código.
* [yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)
 sistema de gestión de dependencias para el soporte de aplicaciones y librerías TypeScript.
* [TypeScript](https://www.typescriptlang.org/download/): lenguaje tipado que se compila a JavaScript y se utilizará en el desarrollo de algunos módulos.
* [Docker](https://docs.docker.com/engine/install/ubuntu/): para la ejecución de servicios y entornos aislados.
* [Docker Compose](https://docs.docker.com/compose/install/linux/): para la definición y orquestación de servicios en contenedores a través de ficheros YAML, permitiendo levantar entornos completos de desarrollo y pruebas de forma sencilla.

Es importante mantener estos componentes actualizados y correctamente configurados en el PATH de tu sistema para asegurar que todos los comandos y dependencias se resuelvan sin problemas.

Por último, puedes comprobar que tienes todos los elementos de tu equipo correctamente instalados mediante el siguiente script:

```sh
https://kaizten.github.io/development/bash/script-infrastructure-checker.sh
```

> :warning: Puedes ejecutar el script sin necesidad de descargarlo mediante el comando `curl -s https://kaizten.github.io/development/bash/script-infrastructure-checker.sh | bash`

Al ejecutar este script se analiza tu equipo y se indica si éste cumple con los requerimientos de instalaciones y versiones.