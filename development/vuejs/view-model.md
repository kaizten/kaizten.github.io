# Modelo de vista

- [Modelo de vista](#modelo-de-vista)
  - [Ejemplo ilustrativo](#ejemplo-ilustrativo)
    - [Explicación del código](#explicación-del-código)

Cada una de las vistas donde exista un formulario para añadir o modificar datos, debe tener su propio modelo de datos. Esto es, una clase de [TypeScript](https://www.typescriptlang.org) que recoja todos los datos a añadir o modificar a través de dicho formulario.

## Ejemplo ilustrativo

En base a lo anterior, supongamos que existe una vista `VehicleAddView.vue` destinada a añadir vehículos a la aplicación bajo desarrollo a través de un formulario. En este formulario, el usuario introduce lo siguiente:
- Número de la matrícula
- Capacidad del vehículo en términos de número de asientos 
- Nombre del conductor. Este campo es opcional en el formulario.

Por tanto, para esta vista su modelo de datos sería `adapter/vuejs/views/data-model/vehicle-add-view-data-model.ts` y su contenido, tal como sigue:

```ts
import type { EmployeeName } from '../value-object/employee-name';
import type { VehicleCapacity } from '../value-object/vehicle-capacity';
import type { VehicleNumberPlate } from '../value-object/vehicle-number-plate';

export class VehicleAddViewDataModel {

  /**
   * Number plate of the vehicle.
   */
  public numberPlate: string;
  /**
   * Number of seats in the vehicle.
   */
  public capacity: number;
  /**
   * Driver of the vehicle. It is an optional attribute.
   */
  public driver?: string;

  constructor(
    numberPlate: string,
    capacity: number,
    driver?: string
  ) {
    this.validate<string>(
      numberPlate,
      Vehicle.ERROR_NUMBER_PLATE_NOT_DEFINED
    );
    this.validate<number>(
      capacity,
      Vehicle.ERROR_CAPACITY_NOT_DEFINED
    );
    this.numberPlate = numberPlate;
    this.capacity = capacity;
    this.driver = driver;
  }

  private validate<T>(
    attribute: T | undefined,
    errorMessage: string
  ): asserts attribute is T {
    if (attribute === undefined || attribute === null) {
      throw new Error(errorMessage);
    }
  }

  static externalValidateNumberPlate(value: string): boolean | string {
    try {
      new VehicleNumberPlate(value);
      return true;
    } catch (error: any) {
      return error.message;
    }
  }

  static externalValidateCapacity(value: number): boolean | string {
    try {
      new VehicleCapacity(value);
      return true;
    } catch (error: any) {
      return error.message;
    }
  }

  static externalValidateDriver(value: string): boolean | string {
    try {
      new EmployeeName(value);
      return true;
    } catch (error: any) {
      return error.message;
    }
  }

  static random(): VehicleAddViewDataModel {
    const numberPlate: = VehicleNumberPlate.random().getValue();
    const capacity: = VehicleCapacity.random().getValue();
    const driver: = EmployeeName.random().getValue();
    return new VehicleAddViewDataModel(numberPlate, capacity, driver);
  }

  static toVehicle(vehicleAdd: VehicleAddViewDataModel): Vehicle {
    return new Vehicle(
      new VehicleNumberPlate(vehicleAdd.numberPlate),
      new VehicleCapacity(vehicleAdd.capacity),
      vehicleAdd.driver ? new EmployeeName(vehicleAdd.driver) : undefined
    );
  }
}
```

### Explicación del código

1. El modelo de datos para la vista tiene atributos básicos de tipo `string` o `number`. Estos son los tipos que se pueden definir en los campos de texto del formulario. 
2. Se incluye un método de validación denominado `externalValidate` + `<NOMBRE_ATRIBUTO>.ts` por cada atributo `<NOMBRE_ATRIBUTO>` del modelo de datos. Este método debe devolver `boolean` indicando si el parámetro recibido puede parsearse como el objeto valor correspondiente al atributo o `string` indicando el mensaje de error en el caso en que la validación no haya podido producirse.
3. Se incluye un método `random` que genera una instancia del modelo de datos de la clase. Esto es, `VehicleAddViewDataModel`.
4. Se incluye un método `to<NOMBRE_ENTIDAD`.ts` que permite transformar el modelo de datos a la entidad `<NOMBRE_ENTIDAD>` correspondiente.