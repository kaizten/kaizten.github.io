# Servicios

- [Servicios](#servicios)
  - [Introducción](#introducción)
  - [Características principales](#características-principales)
  - [Ejemplo ilustrativo en Java](#ejemplo-ilustrativo-en-java)
    - [Definición del puerto de salida (`VehicleRepository`)](#definición-del-puerto-de-salida-vehiclerepository)
    - [Implementación de `CreateVehicleUseCase`](#implementación-de-createvehicleusecase)
    - [Implementación de `FetchVehicleUseCase`](#implementación-de-fetchvehicleusecase)
    - [Implementación de `UpdateVehicleUseCase`](#implementación-de-updatevehicleusecase)
    - [Implementación de `DeleteVehicleUseCase`](#implementación-de-deletevehicleusecase)
    - [Explicación del código](#explicación-del-código)
      - [Principios de diseño aplicados](#principios-de-diseño-aplicados)

## Introducción

En el contexto de la **arquitectura hexagonal** (también conocida como arquitectura de puertos y adaptadores), los **servicios** son las implementaciones concretas de los casos de uso. Mientras que los casos de uso definen *qué* debe hacer la aplicación mediante interfaces (puertos de entrada), los servicios especifican *cómo* se logra ese comportamiento.

Los servicios pertenecen a la **capa de aplicación** y actúan como orquestadores que:

1. **Coordinan entidades del dominio**: Invocan métodos de las entidades para aplicar la lógica de negocio.
2. **Utilizan puertos de salida**: Dependen de interfaces (como repositorios) para interactuar con la infraestructura sin conocer los detalles de implementación.
3. **Aplican reglas de aplicación**: Implementan validaciones, políticas de idempotencia, manejo de transacciones y otras reglas que no pertenecen al dominio puro.
4. **Mantienen la independencia del dominio**: No contienen lógica de negocio compleja (que debería estar en las entidades), sino que orquestan su ejecución.

Los servicios son el punto donde la lógica de aplicación toma forma concreta, transformando las intenciones expresadas en los casos de uso en operaciones ejecutables que coordinan el dominio y la infraestructura.

## Características principales

* **Implementación de puertos de entrada**: Cada servicio implementa un único caso de uso (interfaces de Java), cumpliendo el contrato definido.
* **Dependencia de puertos de salida**: Los servicios no conocen las implementaciones concretas de bases de datos o APIs externas; solo dependen de interfaces (repositorios, gateways, etc.).
* **Orquestación sin lógica de negocio compleja**: La lógica de negocio reside en las entidades del dominio. Los servicios solo coordinan su ejecución y aplican reglas de aplicación.
* **Inyección de dependencias**: Las dependencias (puertos de salida) se inyectan mediante el constructor, facilitando la inversión de control y la testabilidad.
* **Validaciones de aplicación**: Los servicios implementan validaciones que trascienden a una única entidad (por ejemplo, verificar unicidad, chequear permisos, etc.).
* **Manejo de excepciones del dominio**: Capturan y traducen excepciones del dominio o infraestructura en respuestas apropiadas para la capa superior.
* **Transaccionalidad**: Cuando es necesario, los servicios gestionan el alcance de las transacciones, asegurando la consistencia de las operaciones.

## Ejemplo ilustrativo en Java

A continuación, se presentan las implementaciones concretas de los casos de uso CRUD para la entidad `Vehicle` definidos anteriormente. Estos servicios demuestran cómo se orquesta la lógica de aplicación en la arquitectura hexagonal.

### Definición del puerto de salida (`VehicleRepository`)

Primero, definimos el puerto de salida que los servicios utilizarán para interactuar con la capa de persistencia:

```java
import java.util.Optional;
import java.util.UUID;

/**
 * Output port for vehicle persistence operations.
 * This interface defines the contract for vehicle repository operations
 * without specifying implementation details.
 */
public interface VehicleRepository {

    /**
     * Saves a vehicle to the repository.
     * 
     * @param vehicle Vehicle to save.
     * @return The saved vehicle.
     */
    Vehicle save(Vehicle vehicle);

    /**
     * Finds a vehicle by its unique identifier.
     * 
     * @param id Identifier of the vehicle.
     * @return Optional containing the vehicle if found, empty otherwise.
     */
    Optional<Vehicle> findById(UUID id);

    /**
     * Finds a vehicle by its plate number.
     * 
     * @param plateNumber Plate number of the vehicle.
     * @return Optional containing the vehicle if found, empty otherwise.
     */
    Optional<Vehicle> findByPlateNumber(PlateNumber plateNumber);

    /**
     * Deletes a vehicle from the repository.
     * 
     * @param vehicle Vehicle to delete.
     */
    void delete(Vehicle vehicle);

    /**
     * Checks if a vehicle exists with the given plate number.
     * 
     * @param plateNumber Plate number to check.
     * @return true if a vehicle exists with the given plate number, false otherwise.
     */
    boolean existsByPlateNumber(PlateNumber plateNumber);
}
```

### Implementación de `CreateVehicleUseCase`

```java
import java.util.Optional;

/**
 * Service implementing the create vehicle use case.
 * This service orchestrates vehicle creation, ensuring business rules are met.
 */
public class CreateVehicleService implements CreateVehicleUseCase {

    public static final String VEHICLE_ALREADY_EXISTS = 
        "Vehicle with plate number %s already exists";

    private final VehicleRepository vehicleRepository;

    /**
     * Creates a new create vehicle service with the given repository.
     * 
     * @param vehicleRepository Repository for vehicle persistence operations.
     */
    public CreateVehicleService(VehicleRepository vehicleRepository) {
        if (vehicleRepository == null) {
            throw new IllegalArgumentException("Vehicle repository cannot be null");
        }
        this.vehicleRepository = vehicleRepository;
    }

    @Override
    public Vehicle create(PlateNumber plateNumber) {
        return this.create(plateNumber, null);
    }

    @Override
    public Vehicle create(PlateNumber plateNumber, VehicleColor vehicleColor) {
        // Application-level validation: check for duplicate plate numbers
        if (this.vehicleRepository.existsByPlateNumber(plateNumber)) {
            throw new VehicleAlreadyExistsException(
                String.format(VEHICLE_ALREADY_EXISTS, plateNumber)
            );
        }

        // Create the entity (domain logic is encapsulated in the entity)
        Vehicle newVehicle = new Vehicle(plateNumber, vehicleColor);

        // Persist using the output port
        return this.vehicleRepository.save(newVehicle);
    }
}
```

### Implementación de `FetchVehicleUseCase`

```java
import java.util.Optional;
import java.util.UUID;

/**
 * Service implementing the fetch vehicle use case.
 * This service retrieves vehicles from the repository.
 */
public class FetchVehicleService implements FetchVehicleUseCase {

    private final VehicleRepository vehicleRepository;

    /**
     * Creates a new fetch vehicle service with the given repository.
     * 
     * @param vehicleRepository Repository for vehicle retrieval operations.
     */
    public FetchVehicleService(VehicleRepository vehicleRepository) {
        if (vehicleRepository == null) {
            throw new IllegalArgumentException("Vehicle repository cannot be null");
        }
        this.vehicleRepository = vehicleRepository;
    }

    @Override
    public Optional<Vehicle> fetchVehicleById(UUID id) {
        if (id == null) {
            throw new IllegalArgumentException("Vehicle id cannot be null");
        }
        return this.vehicleRepository.findById(id);
    }

    @Override
    public Optional<Vehicle> fetchVehicleByPlateNumber(PlateNumber plateNumber) {
        if (plateNumber == null) {
            throw new IllegalArgumentException("Plate number cannot be null");
        }
        return this.vehicleRepository.findByPlateNumber(plateNumber);
    }
}
```

### Implementación de `UpdateVehicleUseCase`

```java
import java.util.UUID;

/**
 * Service implementing the update vehicle use case.
 * This service coordinates vehicle updates with validation.
 */
public class UpdateVehicleService implements UpdateVehicleUseCase {

    public static final String VEHICLE_NOT_FOUND = "Vehicle with id %s not found";
    public static final String PLATE_NUMBER_ALREADY_EXISTS = 
        "Another vehicle with plate number %s already exists";

    private final VehicleRepository vehicleRepository;

    /**
     * Creates a new update vehicle service with the given repository.
     * 
     * @param vehicleRepository Repository for vehicle operations.
     */
    public UpdateVehicleService(VehicleRepository vehicleRepository) {
        if (vehicleRepository == null) {
            throw new IllegalArgumentException("Vehicle repository cannot be null");
        }
        this.vehicleRepository = vehicleRepository;
    }

    @Override
    public Vehicle updateColor(UUID id, VehicleColor newColor) {
        // Retrieve the vehicle
        Vehicle vehicle = this.vehicleRepository.findById(id)
            .orElseThrow(() -> new VehicleNotFoundException(
                String.format(VEHICLE_NOT_FOUND, id)
            ));

        // Update the color (domain logic in the entity)
        vehicle.updateVehicleColor(newColor);

        // Persist the changes
        return this.vehicleRepository.save(vehicle);
    }

    @Override
    public Vehicle updatePlateNumber(UUID id, PlateNumber newPlateNumber) {
        // Retrieve the vehicle
        Vehicle vehicle = this.vehicleRepository.findById(id)
            .orElseThrow(() -> new VehicleNotFoundException(
                String.format(VEHICLE_NOT_FOUND, id)
            ));

        // Check if another vehicle already has this plate number
        Optional<Vehicle> existingVehicle = 
            this.vehicleRepository.findByPlateNumber(newPlateNumber);
        
        if (existingVehicle.isPresent() && !existingVehicle.get().getId().equals(id)) {
            throw new VehicleAlreadyExistsException(
                String.format(PLATE_NUMBER_ALREADY_EXISTS, newPlateNumber)
            );
        }

        // Update the plate number (domain logic in the entity)
        vehicle.updatePlateNumber(newPlateNumber);

        // Persist the changes
        return this.vehicleRepository.save(vehicle);
    }
}
```

### Implementación de `DeleteVehicleUseCase`

```java
import java.util.UUID;

/**
 * Service implementing the delete vehicle use case.
 * This service handles vehicle deletion from the system.
 */
public class DeleteVehicleService implements DeleteVehicleUseCase {

    public static final String VEHICLE_NOT_FOUND_BY_ID = "Vehicle with id %s not found";
    public static final String VEHICLE_NOT_FOUND_BY_PLATE = 
        "Vehicle with plate number %s not found";

    private final VehicleRepository vehicleRepository;

    /**
     * Creates a new delete vehicle service with the given repository.
     * 
     * @param vehicleRepository Repository for vehicle operations.
     */
    public DeleteVehicleService(VehicleRepository vehicleRepository) {
        if (vehicleRepository == null) {
            throw new IllegalArgumentException("Vehicle repository cannot be null");
        }
        this.vehicleRepository = vehicleRepository;
    }

    @Override
    public Vehicle deleteById(UUID id) {
        // Retrieve the vehicle to delete
        Vehicle vehicle = this.vehicleRepository.findById(id)
            .orElseThrow(() -> new VehicleNotFoundException(
                String.format(VEHICLE_NOT_FOUND_BY_ID, id)
            ));

        // Delete from repository
        this.vehicleRepository.delete(vehicle);

        // Return the deleted vehicle for auditing or confirmation
        return vehicle;
    }

    @Override
    public Vehicle deleteByPlateNumber(PlateNumber plateNumber) {
        // Retrieve the vehicle to delete
        Vehicle vehicle = this.vehicleRepository.findByPlateNumber(plateNumber)
            .orElseThrow(() -> new VehicleNotFoundException(
                String.format(VEHICLE_NOT_FOUND_BY_PLATE, plateNumber)
            ));

        // Delete from repository
        this.vehicleRepository.delete(vehicle);

        // Return the deleted vehicle for auditing or confirmation
        return vehicle;
    }
}
```

### Explicación del código

Las implementaciones anteriores demuestran cómo los servicios actúan como orquestadores en la arquitectura hexagonal, coordinando el dominio con la infraestructura sin acoplarse a detalles técnicos.

**1. Definición del puerto de salida (VehicleRepository)**

El `VehicleRepository` es una interfaz (puerto de salida) que define las operaciones de persistencia necesarias. Esta interfaz:
- Abstrae completamente los detalles de implementación (SQL, NoSQL, archivos, etc.).
- Define métodos que expresan intenciones de negocio (`findByPlateNumber`, `existsByPlateNumber`).
- Permite que los servicios dependan de abstracciones, no de implementaciones concretas.

**2. CreateVehicleService**

Este servicio implementa la creación de vehículos con las siguientes responsabilidades:

- **Inyección de dependencias**: Recibe el repositorio en el constructor, aplicando inversión de control.
- **Validación de aplicación**: Verifica que no exista un vehículo duplicado antes de crear uno nuevo. Esta es una regla de aplicación (no de dominio puro).
- **Delegación al dominio**: Utiliza el constructor de `Vehicle` para crear la entidad, delegando las validaciones de dominio.
- **Persistencia**: Utiliza el puerto de salida para persistir el vehículo sin conocer los detalles de implementación.

**3. FetchVehicleService**

Implementa las operaciones de consulta con:

- **Validación de parámetros**: Asegura que los parámetros de entrada no sean nulos.
- **Delegación directa**: Las consultas simples se delegan directamente al repositorio.
- **Manejo de opcionales**: Devuelve `Optional<Vehicle>` para expresar explícitamente la posibilidad de ausencia.

**4. UpdateVehicleService**

Este servicio coordina las actualizaciones con lógica más compleja:

- **Recuperación de entidad**: Primero obtiene el vehículo del repositorio, lanzando una excepción si no existe.
- **Validación específica**: Para la actualización de matrícula, verifica que no exista otro vehículo con la misma matrícula.
- **Delegación de lógica de dominio**: Invoca los métodos de actualización de la entidad (`updateVehicleColor`, `updatePlateNumber`), donde reside la validación de dominio.
- **Persistencia de cambios**: Guarda el vehículo modificado en el repositorio.

**5. DeleteVehicleService**

Gestiona la eliminación con:

- **Verificación de existencia**: Asegura que el vehículo exista antes de intentar eliminarlo.
- **Retorno del objeto eliminado**: Devuelve el vehículo eliminado para permitir auditoría u operaciones compensatorias.
- **Mensajes de error descriptivos**: Proporciona mensajes claros diferenciando entre búsqueda por ID o matrícula.

#### Principios de diseño aplicados

Estos servicios ejemplifican los principios fundamentales de la arquitectura hexagonal:

**1. Separación de responsabilidades**

- **Dominio**: Las entidades (`Vehicle`) contienen la lógica de negocio pura y las invariantes del dominio.
- **Aplicación**: Los servicios orquestan operaciones, aplican reglas de aplicación y coordinan el flujo.
- **Infraestructura**: Los adaptadores (implementaciones del repositorio) manejan detalles técnicos de persistencia.

**2. Inversión de dependencias (Dependency Inversion Principle)**

Los servicios dependen de abstracciones (`VehicleRepository`), no de implementaciones concretas. Esto permite:
- Cambiar la implementación de persistencia sin modificar los servicios.
- Testear los servicios usando mocks o fakes del repositorio.
- Añadir nuevas implementaciones (caché, eventos, etc.) sin impactar la lógica de aplicación.

**3. Inyección de dependencias**

Las dependencias se inyectan mediante el constructor, lo que facilita:
- **Testing**: Inyectar mocks en tests unitarios.
- **Flexibilidad**: Configurar diferentes implementaciones según el contexto.
- **Inmutabilidad**: Las dependencias se establecen en la construcción y no cambian.

**4. Validaciones en capas**

Se distinguen claramente dos tipos de validaciones:
- **Validaciones de dominio**: En las entidades (por ejemplo, matrícula no nula).
- **Validaciones de aplicación**: En los servicios (por ejemplo, unicidad de matrícula).

Esta separación mantiene el dominio puro y fácil de testear, mientras que las reglas de aplicación coordinan múltiples entidades o consultan la infraestructura.

**5. Manejo explícito de errores**

Los servicios lanzan excepciones específicas del dominio (`VehicleNotFoundException`, `VehicleAlreadyExistsException`) que:
- Expresan claramente las condiciones de error del negocio.
- Permiten a las capas superiores manejar errores de forma específica.
- Mantienen el código limpio y legible sin códigos de error mágicos.

**6. Single Responsibility Principle**

Cada servicio tiene una única responsabilidad:
- `CreateVehicleService`: Creación de vehículos.
- `FetchVehicleService`: Consulta de vehículos.
- `UpdateVehicleService`: Actualización de vehículos.
- `DeleteVehicleService`: Eliminación de vehículos.

Esta granularidad facilita el mantenimiento, testing y evolución independiente de cada operación.

**7. Testabilidad**

Gracias a la inversión de dependencias y la inyección por constructor, estos servicios son altamente testeables:

```java
// Ejemplo de test unitario
@Test
void shouldCreateVehicleSuccessfully() {
    // Arrange
    VehicleRepository mockRepository = mock(VehicleRepository.class);
    when(mockRepository.existsByPlateNumber(any())).thenReturn(false);
    when(mockRepository.save(any())).thenAnswer(i -> i.getArgument(0));
    
    CreateVehicleService service = new CreateVehicleService(mockRepository);
    PlateNumber plateNumber = new PlateNumber("ABC-1234");
    
    // Act
    Vehicle result = service.create(plateNumber);
    
    // Assert
    assertNotNull(result);
    assertEquals(plateNumber, result.getPlateNumber());
    verify(mockRepository).save(any(Vehicle.class));
}
```

Esta arquitectura garantiza que el código sea mantenible, escalable y fácil de probar, permitiendo que la aplicación evolucione sin comprometer la estabilidad o la claridad del diseño.
