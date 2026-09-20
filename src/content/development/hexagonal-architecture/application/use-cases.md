# Casos de uso

- [Casos de uso](#casos-de-uso)
  - [Introducción](#introducción)
  - [Características principales](#características-principales)
  - [Ejemplo ilustrativo en Java](#ejemplo-ilustrativo-en-java)
    - [Explicación del código](#explicación-del-código)
      - [Principios de diseño aplicados](#principios-de-diseño-aplicados)

## Introducción

Los casos de uso encapsulan la lógica de aplicación que coordina entidades y puertos (interfaces) para lograr un objetivo de negocio. 

Un caso de uso no sabe nada de frameworks, bases de datos o UI; sólo expresa qué debe suceder bajo ciertas reglas. Esto facilita que la aplicación sea mantenible, testeable y evolutiva.

## Características principales

* **Independencia de infraestructura:** Los casos de uso dependen de interfaces (puertos), no de implementaciones concretas.
* **Modelado explícito del negocio:** La intención de cada operación (crear, consultar, actualizar, eliminar) queda expresada como una unidad autocontenida.
* **Orquestación y validación:** Aquí viven las reglas de aplicación (por ejemplo, validaciones, invariantes, políticas de idempotencia).
* **Testabilidad:** Al depender de puertos, los tests sustituyen adaptadores (mocks/fakes) para verificar la lógica.
* **Composición:** Casos de uso sencillos (CRUD) pueden combinarse para flujos más ricos.

## Ejemplo ilustrativo en Java

A continuación, se muestran casos de uso muy básico de tipo CRUD para una entidad `Vehicle.java` (ubicada en nuestra capa de dominio).

Primero, veamos la definición de la entidad `Vehicle`:

```java
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

public class Vehicle {

    public static final String PLATE_NUMBER_NOT_DEFINED = "Plate number not defined";
    /**
     * Identifier of the vehicle. It is a computed attribute.
     */
    private final UUID id;
    /**
     * Plate number of the vehicle. It is a required attribute.
     */
    private PlateNumber plateNumber;
    /**
     * Color of the vehicle. It is an optional attribute.
     */
    private VehicleColor vehicleColor;

    /**
     * Creates a new vehicle with the given plate number.
     * 
     * @param plateNumber Plate number of the vehicle.
     */
    public Vehicle(PlateNumber plateNumber) {
        this(plateNumber, null);
    }

    /**
     * Creates a new vehicle with the given plate number and color.
     * 
     * @param plateNumber  Plate number of the vehicle.
     * @param vehicleColor Color of the vehicle.
     */
    public Vehicle(PlateNumber plateNumber, VehicleColor vehicleColor) {
        this.validatePlateNumber(plateNumber);
        this.id = UUID.randomUUID();
        this.plateNumber = plateNumber;
        this.vehicleColor = vehicleColor;
    }

    /**
     * Validates the plate number.
     * 
     * @param plateNumber Plate number to validate.
     */
    private void validatePlateNumber(PlateNumber plateNumber) {
        if (plateNumber == null) {
            throw new IllegalArgumentException(PLATE_NUMBER_NOT_DEFINED);
        }
    }

    /**
     * Gets the identifier of the vehicle.
     * 
     * @return Identifier of the vehicle.
     */
    public UUID getId() {
        return this.id;
    }

    /**
     * Gets the plate number of the vehicle.
     * 
     * @return Plate number of the vehicle.
     */
    public PlateNumber getPlateNumber() {
        return this.plateNumber;
    }

    /**
     * Updates the plate number of the vehicle.
     * 
     * @param plateNumber New plate number.
     */
    public void updatePlateNumber(PlateNumber plateNumber) {
        this.validatePlateNumber(plateNumber);
        this.plateNumber = plateNumber;
    }

    /**
     * Gets the color of the vehicle.
     * 
     * @return Color of the vehicle.
     */
    public Optional<VehicleColor> getVehicleColor() {
        return Optional.ofNullable(this.vehicleColor);
    }

    /**
     * Updates the color of the vehicle.
     * 
     * @param vehicleColor New color.
     */
    public void updateVehicleColor(VehicleColor vehicleColor) {
        this.vehicleColor = vehicleColor;
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (otherObject == null) {
            return false;
        }
        if (getClass() != otherObject.getClass()) {
            return false;
        }
        final Vehicle otherVehicle = (Vehicle) otherObject;
        return Objects.equals(this.id, otherVehicle.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return String.format(
                "Vehicle={id=%s, plateNumber=%s, vehicleColor=%s}",
                this.id, this.plateNumber, this.vehicleColor);
    }
}
```

Una vez vista la implementación de nuestros vehículos (`Vehicle.java`) vamos a definir casos de uso tipo CRUD (*Create*, *Read*, *Update* y *Delete*) para esta entidad. En este sentido, tenemos un primer caso de uso que permite crear un vehículo a partir de sus características:

```java
public interface CreateVehicleUseCase {

    Vehicle create(PlateNumber plateNumber);

    Vehicle create(PlateNumber plateNumber, VehicleColor vehicleColor);
}
```
A continuación, se muestra cómo crea un vehículo existente:

```java
public interface FetchVehicleUseCase {

    Optional<Vehicle> fetchVehicleById(UUID id);

    Optional<Vehicle> fetchVehicleByPlateNumber(PlateNumber plateNumber);
}
```

El siguiente caso de uso permite actualizar los atributos de un vehículo:

```java
public interface UpdateVehicleUseCase {

    Vehicle updateColor(UUID id, VehicleColor newColor);

    Vehicle updatePlateNumber(UUID id, PlateNumber newPlateNumber);
}
```

Por último, tenemos el caso de uso para eliminar un vehículo del sistema:

```java
public interface DeleteVehicleUseCase {

    Vehicle deleteById(UUID id);

    Vehicle deleteByPlateNumber(PlateNumber plateNumber);
}
```

### Explicación del código

Los ejemplos anteriores ilustran los cuatro casos de uso fundamentales del patrón CRUD aplicados a la entidad `Vehicle`. Cada interfaz representa un puerto de entrada (input port) en la arquitectura hexagonal, definiendo contratos claros entre la capa de aplicación y las capas superiores (como controladores REST o interfaces gráficas).

**1. `CreateVehicleUseCase`**

Este caso de uso define dos métodos sobrecargados para crear vehículos:
- El primer método acepta únicamente la matrícula (`PlateNumber`), lo que permite crear un vehículo con los valores por defecto para el resto de atributos opcionales.
- El segundo método acepta además el color del vehículo (`VehicleColor`), ofreciendo mayor flexibilidad en la creación.

La sobrecarga de métodos proporciona una API más ergonómica, adaptándose a diferentes escenarios de uso sin comprometer la claridad del dominio.

**2. `FetchVehicleUseCase`**

Define dos estrategias de consulta para recuperar vehículos:
- `fetchVehicleById`: Busca un vehículo por su identificador único (`UUID`), que es el identificador técnico de la entidad.
- `fetchVehicleByPlateNumber`: Busca por la matrícula, que es un identificador natural del dominio.

Ambos métodos devuelven un `Optional<Vehicle>`, expresando explícitamente la posibilidad de que el vehículo no exista. Esto obliga a los clientes del caso de uso a manejar correctamente la ausencia de resultados, evitando errores de tipo `NullPointerException`.

**3. `UpdateVehicleUseCase`**

Proporciona métodos granulares para actualizar atributos específicos del vehículo:
- `updateColor`: Modifica únicamente el color del vehículo identificado por su UUID.
- `updatePlateNumber`: Actualiza la matrícula del vehículo.

Esta aproximación granular (un método por atributo) tiene varias ventajas:
- **Intención explícita**: Cada operación expresa claramente qué aspecto del vehículo se modifica.
- **Validaciones específicas**: Cada método puede aplicar reglas de negocio particulares al atributo que actualiza.
- **Menor acoplamiento**: Los clientes no necesitan conocer toda la estructura del vehículo, solo el atributo que desean modificar.

**4. `DeleteVehicleUseCase`**

Ofrece dos formas de eliminar un vehículo:
- `deleteById`: Eliminación por identificador técnico.
- `deleteByPlateNumber`: Eliminación por identificador natural del dominio.

Ambos métodos devuelven el `Vehicle` eliminado, lo que permite:
- Confirmar qué entidad se eliminó exactamente.
- Implementar patrones como "soft delete" o auditoría.
- Realizar operaciones compensatorias si fuera necesario.

#### Principios de diseño aplicados

Estos casos de uso ejemplifican varios principios clave de la arquitectura hexagonal:

1. **Separación de preocupaciones**: Los casos de uso solo expresan qué debe suceder, sin especificar cómo se implementa la persistencia, validación o cualquier detalle técnico.

2. **Inversión de dependencias**: Los casos de uso dependerán de puertos (interfaces como `VehicleRepository`), no de implementaciones concretas. Las implementaciones concretas (adaptadores) dependerán de estos contratos.

3. **Expresividad del dominio**: Los nombres de métodos y tipos (`PlateNumber`, `VehicleColor`) reflejan el lenguaje ubicuo del dominio, facilitando la comunicación entre desarrolladores y expertos del negocio.

4. **Testabilidad**: Al estar desacoplados de la infraestructura, estos casos de uso son fácilmente testeables mediante mocks o fakes de los puertos que requieren.

5. **Evolución controlada**: Los cambios en la implementación (por ejemplo, cambiar de base de datos SQL a NoSQL) no afectan a los casos de uso, siempre que los adaptadores respeten los contratos definidos por los puertos.
