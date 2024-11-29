# Nuevo número en array para mantener media y desviación estándar

- [Nuevo número en array para mantener media y desviación estándar](#nuevo-número-en-array-para-mantener-media-y-desviación-estándar)
  - [Descripción del problema](#descripción-del-problema)
    - [Objetivo](#objetivo)
  - [Código en Python](#código-en-python)
    - [Ejemplo de ejecución](#ejemplo-de-ejecución)

## Descripción del problema

Dado un vector de números, añadir un nuevo número que haga que la media y la desviación estándar resultantes sean lo más cercanas posible a la media y desviación estándar del vector original.

### Objetivo 

Minimizar la diferencia entre la media y la desviación estándar del vector original y del vector resultante.

## Código en Python

```python
import numpy as np
from scipy.optimize import minimize

def calcular_media(vector):
    return np.mean(vector)

def calcular_desviacion(vector):
    return np.std(vector, ddof=0)

def funcion_objetivo(y, vector_original, alpha):
    # Calcular el vector resultante al agregar y
    vector_nuevo = np.append(vector_original, y)
    
    # Calcular la media y desviación estándar del vector original y del nuevo
    media_original = calcular_media(vector_original)
    desviacion_original = calcular_desviacion(vector_original)
    
    media_nueva = calcular_media(vector_nuevo)
    desviacion_nueva = calcular_desviacion(vector_nuevo)
    
    # Calcular la diferencia entre las medias y las desviaciones estándar
    diferencia_media = abs(media_nueva - media_original)
    diferencia_desviacion = abs(desviacion_nueva - desviacion_original)
    
    # Función objetivo a minimizar, dando más peso a la desviación estándar
    return diferencia_media + (alpha * diferencia_desviacion ** 2)

def optimizar_valor(vector_original, alpha=1.0):
    # Punto inicial para la optimización (por ejemplo, la media del vector original)
    y_inicial = calcular_media(vector_original)
    
    # Llamar al método de optimización
    resultado = minimize(funcion_objetivo, y_inicial, args=(vector_original, alpha), method='Nelder-Mead')
    
    # Verificar si se alcanzó la solución óptima
    if resultado.success:
        mensaje_optimo = "Solución óptima encontrada."
    else:
        mensaje_optimo = "No se encontró una solución óptima."
    
    # Devolver el valor óptimo de y, el valor de la función objetivo y el mensaje de éxito
    return resultado.x[0], resultado.fun, mensaje_optimo

# Ejemplo de uso
if __name__ == "__main__":
    vector_original = np.array([10, 7, 43, 25, 15, 6, 9, 12, 18, 20])
    alpha = 10.0  # Aumentar el peso para la desviación estándar
    
    y_optimo, valor_funcion_objetivo, mensaje_optimo = optimizar_valor(vector_original, alpha)
    
    # Calcular el vector resultante
    vector_nuevo = np.append(vector_original, y_optimo)
    
    # Mostrar resultados
    print(f"Valor de la función objetivo:   {valor_funcion_objetivo}")
    print(f"Optimalidad:                    {mensaje_optimo}")
    print(f"Vector original:                {vector_original}")
    print(f"Media original:                 {calcular_media(vector_original)}")
    print(f"Desviación estándar original:   {calcular_desviacion(vector_original)}")
    print(f"Vector resultante:              {vector_nuevo}")
    print(f"Media resultante:               {calcular_media(vector_nuevo)}")
    print(f"Desviación estándar resultante: {calcular_desviacion(vector_nuevo)}")
```

### Ejemplo de ejecución

```shell
Valor de la función objetivo:   2.4050438309940247
Optimalidad:                    Solución óptima encontrada.
Vector original:                [10  7 43 25 15  6  9 12 18 20]
Media original:                 16.5
Desviación estándar original:   10.538026380684384
Vector resultante:              [10.   7.  43.  25.  15.   6.   9.  12.  18.  20.  16.5]
Media resultante:               16.5
Desviación estándar resultante: 10.04761391846569
```