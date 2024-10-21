# State timeline

Dado un JSON con el siguiente contenido:
```json
{
    {
     "services": [
          {
               "finishTime": "2024-01-15T01:25:52Z",
               "code": "0068",
               "role": "MANAGER",
               "startTime": "2024-01-15T00:16:52Z",
               "employees": 10,
               "serviceTime": "PT1H9M"
          },
          {
               "finishTime": "2024-01-15T01:33:32Z",
               "code": "0038",
               "role": "RAMP_MANAGER",
               "startTime": "2024-01-15T00:22:32Z",
               "employees": 4,
               "serviceTime": "PT1H11M"
          },
          ...
}
```

Mediante un notebook de [JSONata](https://jsonata.org), la forma de construir un [state timeline](https://grafana.com/docs/grafana/latest/panels-visualizations/visualizations/state-timeline/) es como sigue:
1. Crear un array con todos los instantes de tiempo. Esto es, `startTime` y `finishTime`. Esto se hace tal como sigue:
```shell
$sort(reduce(services.[startTime, finishTime], $append))
```

El resultado debe ser similar a éste:
```json
[
    [
	"2024-01-15T00:16:52Z",
	"2024-01-15T00:22:32Z",
	"2024-01-15T01:25:52Z",
	"2024-01-15T01:33:32Z",
	"2024-01-15T04:15:47Z",
	"2024-01-15T04:40:47Z",
	"2024-01-15T06:27:52Z",
	"2024-01-15T07:36:52Z",
    ...
]
```

2. Crear un array donde los elementos impares recojan la información de los elementos que nos interesa visualizar como filas en el [state timeline](https://grafana.com/docs/grafana/latest/panels-visualizations/visualizations/state-timeline/) y los elementos pares sean un objeto con el valor `""`. Esto se hace tal como sigue:
```shell
$reduce(services.[
  {
    "Service "&code:
        ""&employees
  },
  {
    "Service "&code: ""
  }
  
], $append)
```

El resultado debe ser similar a éste:
```json
[
	{
		"service 0068": "10"
	},
	{
		"service 0068": ""
	},
	{
		"service 0038": "4"
	},
	{
		"service 0038": ""
	},
    ....
]
```

3. En [Grafana](https://grafana.com), añadir un [state timeline](https://grafana.com/docs/grafana/latest/panels-visualizations/visualizations/state-timeline/).

4. En la sección `Query` añadir como `Fields` los códigos en [JSONata](https://jsonata.org) descritos en los puntos anteriores. Es importante establecer en el desplegable de cada `Field` el valor `JSONata`. Finalmente comprobar que en la vista de tabla `Table view` se muestran los datos tal como se describen en los puntos anteriores.

5. En la sección `Transform data` desagregar la segunda columna de los datos.

6. En la sección `Transform data` ocultar la columna original obtenida del segundo `Field` incorporado.