## Control y mejora de la calidad del código con Sheriff

Hemos desarrollado una herramienta denominada `Sheriff` para comprobar automáticamente el cumplimiento de diferentes reglas de calidad, estilo y arquitectura en los componentes de software de nuestros proyectos.

Sheriff realiza comprobaciones sobre código Java, TypeScript, Vue y otros elementos del proyecto. Entre otras cuestiones, comprueba aspectos relacionados con documentación, formato y estructura del código, uso correcto de `@Override`, uso de llaves en estructuras de control, imports, reglas de arquitectura hexagonal, entidades y value objects, OpenAPI, ESLint, componentes Vue, traducciones, tests, etc.

Además de detectar problemas, **Sheriff dispone actualmente de mecanismos de corrección automática (`fixers`) para una parte de los errores que reporta**. Por tanto, el objetivo de este issue no es únicamente ejecutar Sheriff y corregir manualmente sus resultados, sino utilizar los fixers disponibles siempre que sea posible y validar posteriormente que las modificaciones realizadas son correctas.

### Procedimiento

1. **Parte de un estado controlado del repositorio.**

   Antes de comenzar, comprueba el estado del repositorio:

   ```bash
   git status
   ```

   Es recomendable no tener cambios locales no relacionados con este trabajo, ya que Sheriff puede modificar automáticamente archivos del proyecto y posteriormente será necesario revisar claramente qué cambios ha realizado.

2. **Ejecuta inicialmente `sheriff.sh`.**

   Desde la raíz del proyecto:

   ```bash
   ./sheriff.sh
   ```

   El script comprobará también si existe una versión más reciente de la imagen Docker de Sheriff y la actualizará cuando corresponda.

   La ejecución puede tardar cierto tiempo, especialmente en proyectos grandes o durante determinados análisis TypeScript. En ejecuciones posteriores Sheriff mantiene información sobre los archivos previamente analizados y normalmente vuelve a analizar únicamente los archivos nuevos o modificados.

3. **Revisa el resultado inicial de Sheriff.**

   Comprueba los errores y warnings encontrados, prestando especial atención a:

   * `referenceCode`;
   * archivo afectado;
   * descripción del problema;
   * indicación proporcionada en `howToSolve`;
   * disponibilidad o no de un fixer automático.

   No empieces corrigiendo manualmente todos los problemas sin comprobar antes cuáles puede resolver Sheriff automáticamente.

4. **Consulta los fixers disponibles cuando sea necesario.**

   Puedes obtener el listado de reglas para las que Sheriff dispone de mecanismos de corrección mediante:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --list
   ```

5. **Aplica los fixers automáticos disponibles.**

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

   Sheriff intentará aplicar automáticamente únicamente aquellas correcciones para las que exista un fixer disponible. Los errores que no dispongan de fixer deberán revisarse posteriormente de forma manual.

   Si se quiere aplicar únicamente un determinado tipo de corrección, puede utilizarse `--fixers` indicando el `referenceCode` correspondiente:

   ```bash
   docker run --rm \
     -v "$(pwd):/data" \
     kaizten/sheriff:latest \
     fix --fix \
     --uri file:/data \
     --component back-end \
     --fixers <REFERENCE_CODE>
   ```

   Cuando exista un número elevado de modificaciones, es preferible aplicar y validar las correcciones por grupos antes que aceptar un conjunto grande de cambios sin revisarlo.

6. **Revisa siempre los cambios realizados automáticamente.**

   Después de ejecutar los fixers:

   ```bash
   git status
   git diff
   ```

   Un fixer automatiza una transformación conocida, pero sus cambios deben ser revisados igualmente.

   Comprueba especialmente que no se haya alterado accidentalmente comportamiento funcional, contratos de API, serialización/deserialización, nombres utilizados externamente, reglas de dominio o tests existentes.

7. **Compila y ejecuta los tests del componente afectado.**

   Después de aplicar las correcciones, ejecuta los mecanismos habituales de validación del proyecto.

   Por ejemplo, en un back-end Maven:

   ```bash
   mvn clean test
   ```

   o, cuando corresponda:

   ```bash
   mvn clean verify
   ```

   En el front-end ejecuta los comandos de lint, tests y build definidos por el proyecto.

   **No se debe considerar válida una corrección únicamente porque Sheriff haya podido aplicarla.**

8. **Levanta la aplicación y realiza una comprobación funcional básica.**

   Una vez que el proyecto compile y los tests sean correctos, vuelve a levantar los componentes afectados de la aplicación.

   Comprueba al menos que:

   la aplicación inicia correctamente; no aparecen nuevos errores en ejecución; las funcionalidades relacionadas con los archivos modificados continúan funcionando; y no se han introducido regresiones evidentes.

9. **Ejecuta Sheriff de nuevo.**

   Después de validar las modificaciones:

   ```bash
   ./sheriff.sh
   ```

   Revisa nuevamente el resumen.

   Algunos errores podrán haber desaparecido como consecuencia de los fixers y otros deberán corregirse manualmente. También es posible que una modificación deje al descubierto una nueva regla que antes no podía evaluarse.

10. **Corrige los problemas restantes y repite el ciclo.**

    Para los errores sin fixer automático, utiliza la información de `description` y `howToSolve` proporcionada por Sheriff y realiza la corrección manualmente.

    Después de cada conjunto de correcciones relevantes, repite el ciclo:

    **corregir → revisar cambios → compilar/testear → levantar y comprobar → ejecutar Sheriff de nuevo**.

    Si una regla de Sheriff no se entiende, parece incorrecta para el caso concreto o su fixer produce una modificación dudosa, no fuerces la corrección. Coméntalo en el issue indicando el `referenceCode`, el fichero afectado y el resultado obtenido para que podamos revisarlo.

### Resultado esperado

El issue se considerará terminado cuando se haya ejecutado Sheriff sobre los componentes del proyecto, se hayan utilizado y revisado los fixers automáticos aplicables, los problemas restantes se hayan corregido manualmente o estén explícitamente justificados, el proyecto compile y supere sus tests, la aplicación pueda levantarse correctamente y una última ejecución de `sheriff.sh` confirme el estado final del análisis.

**Importante:** no se trata simplemente de conseguir que desaparezcan los mensajes de Sheriff. Las modificaciones realizadas deben mantener el comportamiento y la arquitectura correctos del software.
