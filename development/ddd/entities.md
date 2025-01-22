# Entidades

- [Entidades](#entidades)
  - [Características principales](#características-principales)
  - [Ejemplo ilustrativo en Java](#ejemplo-ilustrativo-en-java)
    - [Explicación del código](#explicación-del-código)

En el contexto de Domain-Driven Design (DDD), las **entidades** son uno de los bloques fundamentales para modelar el dominio de un sistema. Una entidad representa un objeto que tiene una **identidad única** y es identificable independientemente de sus atributos o estado. Este concepto es clave en aplicaciones donde es esencial diferenciar objetos no solo por su contenido, sino también por su continuidad a lo largo del tiempo.

Las entidades se utilizan para capturar aspectos esenciales de un dominio, garantizando que los cambios en su estado o comportamiento sean consistentes y reflejen adecuadamente las reglas de negocio.

## Características principales

1. **Identidad única**. Cada entidad debe tener un identificador único, como un `UUID`, que la distinga de otras entidades.
2. **Estado mutable**. Las entidades pueden cambiar su estado a lo largo de su ciclo de vida.
3. **Persistencia**. Generalmente, las entidades se almacenan en bases de datos, manteniendo su identidad y estado.
4. **Relevancia en el dominio**. Solo deben modelarse como entidades aquellos objetos que tienen una importancia significativa en el dominio.
5. **Enfocadas en comportamientos**. Las entidades no solo contienen datos; también encapsulan lógica y comportamientos relacionados con el dominio.

## Ejemplo ilustrativo en Java

A continuación, se presenta un ejemplo simple de una entidad en DDD. El dominio elegido es el de una aplicación de gestión de pedidos.

```java
import java.util.Objects;

public class Order {

    public static final String CUSTOMER_NOT_DEFINED = "Customer not defined";
    /**
     * Identifier of the order. It is a computed attribute.
     */
    private final UUID id;
    /**
     * Customer of the order. It is a required attribute.
     */
    private Customer customer;
    /**
     * Quantity of the order. It is an optional attribute.
     */
    private Quantity quantity;

    public Pedido(Customer customer, Quantity quantity) {
        this.validateCustomer(customer);
        this.id = UUID.randomUUID();
        this.customer = customer;
        this.quantity = quantity;
    }

    private void validateCustomer(Customer customer) {
        if (customer == null) {
            return IllegalArgumentException(CUSTOMER_NOT_DEFINED);
        }
    }

    public UUID getId() {
        return this.id;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public void updateCustomer(Customer customer) {
        this.validateCustomer(customer)
        this.customer = customer;
    }

    public Optional<Quantity> getQuantity() {
        return this.quantity;
    }

    public void updateQuantity(Quantity quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (o == null || getClass() != otherObject.getClass()) {
            return false;
        }
        Order otherOrder = (Order) otherObject;
        return Objects.equals(this.id, otherOrder.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return String.format("Order={id=%s, customer=%s, quantity=%s}",
                this.id, this.customer, this.quantity);
    }
}
```

### Explicación del código

1. **Identidad**. El campo `id` es el identificador único de la entidad `Order`. Es inmutable, lo que garantiza que cada instancia de `Order` pueda ser identificada de manera inequívoca.
2. **Objetos de valor como atributos**. Cada atributo de la entidad es un objeto de valor. De esta manera, la entidad no debe preocuparse de la lógica de validación.
3. **Tipos de atributos**. Los atributos de la entidad pueden ser:
   - **Computados**. Se generan automáticamente.
   - **Requeridos**. Se necesitan para que la entidad sea consistente. Por ello, no pueden ser nulos.
   - **Opcionales**. Pueden ser nulos. Los métodos getters deben devolver un `Optional` del atributo.
4. **Estado mutable**. Los atributos `customer` y `quantity` son mutables. El nombre del cliente puede cambiar con el método `updateCustomer`, y el monto total del pedido se puede actualizar mediante `updateQuantity`.
5. **Validación de reglas de negocio**. En el constructor y en cada método que actualice un atributo de la clase se incluyen verificaciones para garantizar que los datos sean consistentes (por ejemplo, evitar clientes vacíos o cantidades nulas).
6. **Sobrescritura de `equals` y `hashCode`**- Estos métodos se sobrescriben para asegurar que dos objetos `Order` se consideren iguales si tienen el mismo `id`.
7. **Encapsulación de lógica**. La lógica relacionada con la actualización de la cantidad se encuentra dentro de la entidad, en lugar de estar dispersa en el código de aplicación.