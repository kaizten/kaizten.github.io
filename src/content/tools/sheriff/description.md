## Control y mejora de la calidad del código con Sheriff

`Sheriff` es una herramienta desarrollada para comprobar automáticamente el cumplimiento de diferentes reglas de calidad, estilo y arquitectura en los componentes de software de nuestros proyectos.

Sheriff realiza comprobaciones sobre código Java, TypeScript, Vue y otros elementos del proyecto. Entre otras cuestiones, comprueba aspectos relacionados con documentación, formato y estructura del código, uso correcto de `@Override`, uso de llaves en estructuras de control, imports, reglas de arquitectura hexagonal, entidades y value objects, OpenAPI, ESLint, componentes Vue, traducciones, tests, etc.

Además de detectar problemas, **Sheriff dispone de mecanismos de corrección automática (`fixers`) para una parte de los errores que reporta**.

Para aquellos errores que no disponen de un fixer específico, Sheriff también puede utilizar **OpenAI Codex** para intentar realizar la corrección automáticamente. Finalmente, los problemas que no puedan resolverse mediante ninguno de estos mecanismos deberán corregirse manualmente.

Por tanto, el flujo general de trabajo será:

**analizar → aplicar fixers → utilizar Codex cuando corresponda → revisar cambios → compilar/testear → levantar y comprobar la aplicación → ejecutar Sheriff nuevamente**.

El objetivo no es únicamente conseguir que desaparezcan los errores reportados por Sheriff, sino mejorar el código manteniendo correctamente el comportamiento, los contratos y la arquitectura del software.

### Procedimiento

1. **Parte de un estado controlado del repositorio**

   Antes de comenzar, comprueba el estado del repositorio:

   ```bash
   git status
   ```

   Es recomendable no tener cambios locales no relacionados con este trabajo, ya que Sheriff y, especialmente, sus mecanismos de corrección automática pueden modificar archivos del proyecto.

   Esto permitirá revisar posteriormente mediante Git exactamente qué modificaciones se han realizado.

2. **Ejecuta inicialmente `sheriff.sh`**

   Desde la raíz del proyecto:

   ```bash
   ./sheriff.sh
   ```

   El script comprobará también si existe una versión más reciente de la imagen Docker de Sheriff y la actualizará cuando corresponda.

   La ejecución puede tardar cierto tiempo, especialmente en proyectos grandes o durante determinados análisis TypeScript.

   Sheriff mantiene información de los análisis anteriores, por lo que normalmente las siguientes ejecuciones se centrarán en los archivos nuevos o modificados.

3. **Revisa el resultado inicial de Sheriff**

   Comprueba los errores y warnings encontrados, prestando especial atención a:

   * `referenceCode`;
   * archivo afectado;
   * descripción del problema;
   * indicación proporcionada en `howToSolve`;
   * existencia o no de un fixer automático.

   No empieces corrigiendo manualmente todos los problemas sin comprobar antes cuáles puede resolver Sheriff automáticamente.

4. **Consulta los fixers disponibles**

   Sheriff permite consultar qué reglas disponen actualmente de un mecanismo de corrección automática:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --list
   ```

   El listado permite identificar qué `referenceCode` disponen de un fixer específico.

   Los fixers de Sheriff deben ser la **primera opción de corrección automática**, ya que implementan una transformación específicamente diseñada para resolver una regla concreta.

5. **Aplica los fixers automáticos disponibles**

   Para corregir los problemas detectados en el back-end:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component back-end
   ```

   Para el front-end:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component front-end
   ```

   Sheriff aplicará los fixers disponibles para los errores detectados.

   Por defecto, el proceso de corrección es **recursivo**: después de aplicar una corrección, Sheriff vuelve a analizar el fichero para comprobar el resultado y detectar los errores que continúan presentes o los que hayan podido aparecer como consecuencia de la modificación.

   Si se quiere aplicar únicamente un determinado tipo de corrección, puede utilizarse `--fixers` indicando uno o varios `referenceCode`:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component back-end \
     --fixers <REFERENCE_CODE>
   ```

   Cuando exista un número elevado de modificaciones, puede ser conveniente aplicar y validar las correcciones por grupos en lugar de aceptar un conjunto muy grande de cambios de una sola vez.

6. **Utiliza Codex para los errores sin fixer cuando sea posible**

   Sheriff dispone de integración con **OpenAI Codex** para intentar resolver automáticamente aquellos errores que **no disponen de un fixer específico**.

   Para habilitar esta funcionalidad debe utilizarse:

   ```text
   --use-codex
   ```

   Por ejemplo, para el back-end:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component back-end \
     --use-codex \
     --open-api-key "$OPENAI_API_KEY"
   ```

   Y para el front-end:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component front-end \
     --use-codex \
     --open-api-key "$OPENAI_API_KEY"
   ```

   La API key puede cargarse previamente en una variable de entorno:

   ```bash
   export OPENAI_API_KEY="..."
   ```

   o mediante el mecanismo seguro utilizado habitualmente en el entorno de desarrollo.

   **No incluyas nunca una API key directamente en el código, en un commit, en tickets, comentarios, documentación compartida o cualquier otro contenido que pueda quedar almacenado en el repositorio.**

   Sheriff utilizará el siguiente orden de actuación para cada problema:

   1. si existe un fixer específico de Sheriff, utilizará ese fixer;
   2. si no existe un fixer y se ha indicado `--use-codex`, intentará resolverlo mediante Codex;
   3. si no puede resolverse automáticamente, deberá revisarse manualmente.

   Codex recibe la información proporcionada por Sheriff para el error concreto, incluyendo el fichero afectado, el `referenceCode`, la descripción y `howToSolve`, e intenta realizar únicamente los cambios necesarios para resolverlo.

   **Las modificaciones realizadas por Codex deben tratarse siempre como una propuesta automática que requiere revisión.**

   El uso de Codex no implica que la solución generada sea necesariamente correcta desde el punto de vista funcional o arquitectónico.

7. **Revisa siempre los cambios automáticos**

   Después de utilizar los fixers de Sheriff o Codex:

   ```bash
   git status
   git diff
   ```

   Revisa todos los archivos modificados antes de continuar.

   Comprueba especialmente que no se hayan producido cambios no deseados en:

   * comportamiento funcional;
   * reglas de dominio;
   * contratos de API;
   * OpenAPI;
   * serialización y deserialización;
   * nombres utilizados externamente;
   * persistencia;
   * relaciones entre capas;
   * tests existentes;
   * interfaces o contratos compartidos entre back-end y front-end.

   Si una modificación automática es excesiva, incorrecta o no está clara, no debe aceptarse simplemente porque haya eliminado el error de Sheriff.

8. **Compila y ejecuta los tests del componente afectado**

   Después de aplicar y revisar las correcciones, ejecuta los mecanismos habituales de validación del proyecto.

   Por ejemplo, en un back-end Maven:

   ```bash
   mvn clean test
   ```

   o, cuando corresponda:

   ```bash
   mvn clean verify
   ```

   En el front-end, ejecuta los comandos definidos en el proyecto para:

   * lint;
   * comprobación de tipos;
   * tests;
   * build.

   Por ejemplo, según la configuración del proyecto:

   ```bash
   yarn lint
   yarn test
   yarn build
   ```

   o los comandos equivalentes disponibles.

   **No se debe considerar válida una corrección únicamente porque Sheriff o Codex hayan podido aplicarla.**

9. **Levanta la aplicación y realiza una comprobación funcional**

   Una vez que el proyecto compile y los tests sean correctos, vuelve a levantar los componentes afectados de la aplicación.

   Comprueba al menos que:

   * la aplicación inicia correctamente;
   * no aparecen nuevos errores durante la ejecución;
   * front-end y back-end continúan comunicándose correctamente cuando corresponda;
   * las funcionalidades relacionadas con los archivos modificados continúan funcionando;
   * no se han introducido regresiones evidentes.

   Si las modificaciones afectan a una funcionalidad concreta, realiza también una comprobación básica de dicha funcionalidad.

10. **Ejecuta Sheriff nuevamente**

    Después de validar las modificaciones:

    ```bash
    ./sheriff.sh
    ```

    Revisa de nuevo el resumen generado.

    Algunos errores habrán desaparecido gracias a los fixers o a Codex, mientras que otros podrán requerir intervención manual.

    También es posible que una corrección permita detectar posteriormente otros problemas que antes no podían evaluarse correctamente.

11. **Corrige manualmente los problemas restantes**

    Para los errores que continúen presentes, utiliza como referencia:

    * `referenceCode`;
    * `description`;
    * `howToSolve`;
    * fichero y ubicación indicados por Sheriff.

    Realiza manualmente las modificaciones necesarias cuando no exista un fixer o cuando la solución propuesta automáticamente no sea adecuada.

    Si una regla no se entiende, parece incorrecta para el caso concreto, genera un falso positivo o requiere una decisión de arquitectura que no esté clara, **no fuerces la corrección únicamente para hacer desaparecer el error**.

    En estos casos, consulta con el equipo responsable del proyecto o de Sheriff proporcionando, al menos:

    * `referenceCode`;
    * fichero afectado;
    * descripción del problema;
    * solución propuesta por Sheriff;
    * motivo por el que existen dudas sobre su aplicación.

12. **Repite el ciclo hasta alcanzar un estado válido**

    Después de cada conjunto relevante de modificaciones, repite el ciclo:

    **corregir → revisar `git diff` → compilar/testear → levantar y comprobar → ejecutar Sheriff nuevamente**.

    Cuando utilices mecanismos automáticos, el orden recomendado es:

    **fixer específico de Sheriff → Codex, si no existe fixer → corrección manual, si sigue siendo necesario.**

### Resultado esperado

El proceso puede considerarse finalizado cuando:

* se haya ejecutado Sheriff sobre los componentes correspondientes del proyecto;
* se hayan revisado los errores y warnings detectados;
* se hayan utilizado los fixers automáticos aplicables;
* cuando se disponga de acceso a OpenAI/Codex, se haya valorado su utilización para aquellos errores que no dispongan de fixer;
* todas las modificaciones automáticas hayan sido revisadas;
* los problemas restantes se hayan corregido manualmente o estén explícitamente justificados;
* el proyecto compile correctamente;
* los tests correspondientes sean satisfactorios;
* la aplicación pueda levantarse y realizar una comprobación funcional básica;
* una última ejecución de `sheriff.sh` permita comprobar el estado final del análisis.

### Consideraciones importantes

**Sheriff es una herramienta de ayuda al desarrollo, no un sustituto de la revisión del código.**

Un error no debe corregirse de cualquier manera únicamente para conseguir que desaparezca del análisis.

Del mismo modo, una modificación generada por un fixer o por Codex no debe aceptarse automáticamente sin entender y revisar el cambio producido.

El objetivo final debe ser que el código:

**cumpla las reglas de Sheriff + compile + supere los tests + mantenga el comportamiento esperado + respete la arquitectura del proyecto.**
