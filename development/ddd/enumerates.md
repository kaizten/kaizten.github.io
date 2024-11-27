# Enumerados

- [Enumerados](#enumerados)
    - [Características principales](#características-principales)
    - [Ejemplo ilustrativo en Java](#ejemplo-ilustrativo-en-java)
    - [Explicación del código](#explicación-del-código)


En el Diseño Orientado al Dominio (DDD), los enumerados (o enums) se utilizan para representar un conjunto fijo de valores relacionados que tienen significado dentro del contexto del dominio. Los enumerados son ideales para modelar conceptos que tienen un número limitado y conocido de opciones, como el estado de un pedido o los tipos de un producto. Al usar enumerados en DDD, se mejora la claridad del código y se reduce la posibilidad de errores, ya que las opciones válidas quedan claramente definidas y centralizadas.

### Características principales

1. **Definición del dominio.** Los enumerados ayudan a definir claramente un concepto del dominio, como los posibles estados de una entidad.
2. **Inmutabilidad.** Los enumerados son inmutables, lo que significa que las posibles opciones no pueden cambiar una vez definidas.
3. **Fácil de usar.** Los enumerados simplifican el uso de valores constantes en lógica de negocio.
4. **Validación automática.** Utilizar enumerados proporciona validación implícita, ya que restringe los valores posibles a los que están definidos dentro del enumerado.

### Ejemplo ilustrativo en Java

Supongamos que estamos modelando una aplicación para gestionar órdenes de compra. Cada orden puede estar en uno de los siguientes estados: `CREATED`, `SHIPPED`, `DELIVERED`, o `CANCELLED`. Este comportamiento se puede modelar utilizando un enumerado en Java, tal como se muestra a continuación:

```java
import java.util.Random;

public enum OrderStatus {

    CREATED,
    SHIPPED,
    DELIVERED,
    CANCELLED;

    public static OrderStatus fromString(String stringToCheck) {
        if (stringToCheck == null) {
            throw new IllegalArgumentException();
        }
        stringToCheck = stringToCheck.trim().toUpperCase();
        for (OrderStatus orderStatus : values()) {
            if (orderStatus.name().equals(stringToCheck)) {
                return orderStatus;
            }
        }
        throw new IllegalArgumentException();
    }

    public static int indexOf(String stringToCheck) {
        return OrderStatus
                .fromString(stringToCheck)
                .ordinal();
    }

    public static boolean isValid(String stringToCheck) {
        if (stringToCheck == null) {
            return false;
        }
        stringToCheck = stringToCheck.trim().toUpperCase();
        for (OrderStatus orderStatus : values()) {
            if (orderStatus.name().equals(stringToCheck)) {
                return true;
            }
        }
        return false;
    }

    public static OrderStatus random() {
        return values()[new Random().nextInt(values().length)];
    }
}
```

### Explicación del código

1. **Definición del enumerado**: En Java, utilizamos la palabra clave `enum` para definir el enumerado `OrderStatus`. Esto indica que `OrderStatus` solo puede tener uno de los cuatro valores definidos: `CREATED`, `SHIPPED`, `DELIVERED`, o `CANCELLED`. Cada uno de estos valores representa un estado específico de una orden en nuestro dominio.
2. **`fromString(String stringToCheck)`.** Convierte una cadena de texto en su correspondiente valor `OrderStatus`. El método realiza una búsqueda insensible a mayúsculas y minúsculas después de eliminar los espacios en blanco al principio y al final de la cadena. Si el valor de la cadena no se corresponde con ningún estado, se lanza una excepción `IllegalArgumentException`.
3. **`indexOf(String stringToCheck)`.** Retorna el índice ordinal del valor de `OrderStatus` correspondiente a la cadena pasada como argumento. Utiliza el método `fromString()` para realizar la conversión, y si la conversión falla, lanza una excepción. El índice ordinal representa la posición del valor en la declaración del enumerado.
4. **`isValid(String stringToCheck)`.** Comprueba si una cadena dada corresponde a un valor válido de `OrderStatus`. Si la cadena no se corresponde con ningún valor del enum o es nula, devuelve `false`. Si la cadena coincide con algún valor, devuelve `true`.
5. **`random()`.** Devuelve un valor aleatorio del enumerado.