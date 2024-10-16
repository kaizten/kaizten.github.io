# State timeline

Dado un JSON con el siguiente contenido:
```json
{
    COMPLETAR
}
```

La forma de construir un state timeline es como sigue:
1. Crear una columna con todos los instantes de tiempo. Esto es, `startTime` y `finishTime`. Esto se hace tal como sigue:
```
$reduce(services.[startTime, finishTime], $append)
```
El resultado debe ser similar a esto:
```json
[
    COMPLETAR
]
```
2. Crear una columna...