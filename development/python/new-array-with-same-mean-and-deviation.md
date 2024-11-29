# Nuevo número en array para mantener media y desviación estándar

- [Nuevo número en array para mantener media y desviación estándar](#nuevo-número-en-array-para-mantener-media-y-desviación-estándar)
  - [Descripción del problema](#descripción-del-problema)
    - [Objetivo](#objetivo)
  - [Código en Python](#código-en-python)
    - [Ejemplo de ejecución](#ejemplo-de-ejecución)

## Descripción del problema

El problema consiste en generar un nuevo vector a partir de un vector original dado. Este nuevo vector debe cumplir ciertas restricciones, como tener la misma media y desviación estándar que el vector original, y debe incluir un elemento adicional.

### Objetivo

El objetivo es encontrar un nuevo vector que sea lo más parecido posible al vector original, minimizando la diferencia cuadrática entre los elementos correspondientes de ambos vectores, mientras se cumple con las restricciones de mantener la misma media y desviación estándar.


## Código en Python

```python
import numpy as np
from scipy.optimize import minimize

# Definir el vector original
x = np.array([13.1, 23.7, 3.9, 4.71, 51.5])
n = len(x)

# Calcular la media y la desviación estándar del vector original
mean_x = np.mean(x)
std_x = np.std(x, ddof=0)

# Funciones de restricción
def mean_constraint(y):
    return np.mean(y) - mean_x

def std_constraint(y):
    return np.std(y, ddof=0) - std_x

# Función objetivo: minimizar la diferencia entre los elementos del vector original y el nuevo vector
def objective(y):
    return np.sum((y[:-1] - x) ** 2)

# Valor inicial para el optimizador (el vector original con un nuevo elemento)
y0 = np.append(x, [mean_x])

# Definir las restricciones
constraints = (
    {'type': 'eq', 'fun': mean_constraint},
    {'type': 'eq', 'fun': std_constraint}
)

# Resolver el problema de optimización
result = minimize(objective, y0, constraints=constraints)

# Verificar si la optimización fue exitosa
if result.success:
    y_optimized = result.x
    print("Valor de la función objetivo:           ", result.fun)
    print("Optimalidad:                            ", result.success)
    print("Vector original:                        ", x)
    print("Media del vector original:              ", mean_x)
    print("Desviación estándar del vector original:", std_x)
    print("Nuevo vector optimizado:                ", y_optimized)
    print("Media del nuevo vector:                 ", np.mean(y_optimized))
    print("Desviación estándar del nuevo vector:   ", np.std(y_optimized, ddof=0))
else:
    print("La optimización no fue exitosa:", result.message)
```

### Ejemplo de ejecución

```shell
Valor de la función objetivo:            14.071263288812156
Optimalidad:                             True
Vector original:                         [13.1  23.7   3.9   4.71 51.5 ]
Media del vector original:               19.381999999999998
Desviación estándar del vector original: 17.576316337617506
Nuevo vector optimizado:                 [12.50041406 24.11213244  2.4223194   3.30962905 54.56550617 19.38199887]
Media del nuevo vector:                  19.381999999999998
Desviación estándar del nuevo vector:    17.576316254570898
```