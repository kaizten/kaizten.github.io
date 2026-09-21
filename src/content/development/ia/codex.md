# Codex

## ¿Qué es Codex?

**Codex** es el agente de programación de OpenAI. Está pensado para trabajar directamente con proyectos de software: puede explorar una base de código, escribir y modificar archivos, corregir errores, ejecutar comandos y tests, revisar cambios e implementar funcionalidades.

Puedes utilizarlo desde la aplicación de ChatGPT/Codex, el terminal mediante **Codex CLI**, el IDE o la web.

## Plan mode

El modo **Plan** sirve para analizar una tarea **antes de modificar el código**.

Es especialmente útil cuando la tarea es compleja o afecta a varias partes del proyecto. Codex puede investigar el repositorio, identificar los archivos relevantes y proponerte un plan de implementación que puedes revisar antes de continuar.

En la aplicación puedes iniciarlo con:

```text
/plan
```

Por ejemplo:

```text
/plan

Quiero añadir autenticación con Google.
Analiza el proyecto y dime qué cambios habría que realizar.
```

La idea es sencilla:

**Investigar → Diseñar el plan → Revisarlo → Implementar**

## Build mode

**Build** se utiliza cuando quieres que Codex pase a la acción.

En este modo puedes pedirle directamente que implemente una funcionalidad, corrija un bug, refactorice código o ejecute las pruebas necesarias.

Por ejemplo:

```text
Añade autenticación con Google siguiendo el sistema
de autenticación existente.

Ejecuta los tests al terminar y corrige cualquier error.
```

Codex puede inspeccionar el proyecto, modificar los archivos necesarios y utilizar las herramientas disponibles para verificar que el resultado funciona.

Una práctica útil para tareas grandes es utilizar primero **Plan** y, una vez revisado el enfoque, continuar con **Build**.

## Ver el consumo

El consumo de Codex depende de factores como el **modelo utilizado, el tamaño del contexto, la complejidad de la tarea, el razonamiento y las herramientas utilizadas**.

Desde una sesión activa de **Codex CLI** puedes consultar el estado con:

```text
/status
```

También puedes consultar el uso desde **Configuración → Uso** de ChatGPT o desde el panel de **Uso y facturación** de Codex, cuando esté disponible para tu cuenta.

Dependiendo del plan, allí podrás ver información como el uso disponible, créditos consumidos y cuándo se restablecen los límites.

> Una tarea larga que necesite explorar muchos archivos, ejecutar herramientas y realizar varias iteraciones normalmente consumirá más recursos que una consulta pequeña.
