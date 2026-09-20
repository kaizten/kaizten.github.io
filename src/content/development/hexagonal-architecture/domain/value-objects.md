# Objetos valor

- [Objetos valor](#objetos-valor)
  - [Características principales](#características-principales)
  - [Ejemplo ilustrativo en Java](#ejemplo-ilustrativo-en-java)
    - [Explicación del código](#explicación-del-código)

Los **objetos valor** (value objects) son un concepto fundamental en el diseño dirigido por el dominio (**Domain-Driven Design** o DDD). Un objeto valor representa una entidad sin identidad propia dentro del dominio del negocio. En otras palabras, se trata de un conjunto de atributos que definen completamente su valor y se consideran iguales si todos sus atributos coinciden. Se diferencian de las entidades, las cuales poseen una identidad única que las distingue.

Los objetos valor son **inmutables**, lo que significa que no pueden cambiar después de ser creados. Si se necesita modificar su valor, debe crearse un nuevo objeto con los valores actualizados. Esta inmutabilidad ayuda a mantener el código más seguro, evitando efectos secundarios y facilitando el comportamiento predecible.

## Características principales

- **Sin identidad**. Dos objetos valor son iguales si sus atributos son iguales, sin importar si se refieren a objetos diferentes.
- **Inmutabilidad**. Una vez creado, su estado no pueden cambiar.
- **Composición**. Son frecuentemente utilizados para modelar atributos complejos de entidades.

## Ejemplo ilustrativo en Java

Para ilustrar cómo son los objetos valor, podemos usar un ejemplo en **Java**. Supongamos que tenemos un dominio de pedidos donde necesitamos representar una **dirección**. Una dirección puede estar compuesta por atributos como la calle, la ciudad, y el código postal. No tiene sentido darle una identidad única a una dirección, ya que lo importante es su valor completo.

A continuación, un ejemplo de cómo podría implementarse un objeto valor en Java:

```java
import java.util.Objects;
import java.util.regex.Pattern;

public final class Address {

    private static final Pattern STREET_PATTERN = Pattern.compile("^[A-Za-z0-9\s,.-]+$");
    private static final int STREET_MAX_LENGTH = 100;
    private static final String ERROR_STREET_NOT_DEFINED = "Street is not defined";
    private static final String ERROR_STREET_EMPTY = "Street cannot be empty";
    private static final String ERROR_STREET_MAX_LENGTH = "Street must be at most " + STREET_MAX_LENGTH
            + " characters in length";
    private static final String ERROR_STREET_FORMAT = "Street format is invalid";
    //
    private static final int CITY_MAX_LENGTH = 20;
    private static final Pattern CITY_PATTERN = Pattern.compile("^[A-Za-z\s.-]+$");
    private static final String ERROR_CITY_NOT_DEFINED = "City is not defined";
    private static final String ERROR_CITY_EMPTY = "City cannot be empty";
    private static final String ERROR_CITY_MAX_LENGTH = "City must be at most " + CITY_MAX_LENGTH
            + " characters in length";
    private static final String ERROR_CITY_FORMAT = "City format is invalid";
    //
    private static final Pattern POSTAL_CODE_PATTERN = Pattern.compile("^[\d]+$");
    private static final int POSTAL_CODE_LENGTH = 5;
    private static final String ERROR_POSTAL_CODE_NOT_DEFINED = "Postal code is not defined";
    private static final String ERROR_POSTAL_CODE_FORMAT = "Postal code format is invalid";
    private static final String ERROR_POSTAL_CODE_LENGTH = "Postal code must be " + POSTAL_CODE_LENGTH
            + " characters in length";
    /**
     * Street of the address.
     */
    private final String street;
    /**
     * City of the address.
     */
    private final String city;
    /**
     * Postal code of the address.
     */
    private final String postalCode;

    /**
     * It creates a new address with the street, city and postal code.
     * 
     * @param street     Street of the address.
     * @param city       City of the address.
     * @param postalCode Postal code of the address.
     */
    public Address(String street, String city, String postalCode) {
        this.validateStreet(street);
        this.validateCity(city);
        this.validatePostalCode(postalCode);
        this.street = street;
        this.city = city;
        this.postalCode = postalCode;
    }

    /**
     * Validates the street.
     * 
     * @param street Street to validate.
     */
    private void validateStreet(String street) {
        if (street == null) {
            throw new IllegalArgumentException(ERROR_STREET_NOT_DEFINED);
        }
        int length = street.length();
        if (length == 0) {
            throw new IllegalArgumentException(ERROR_STREET_EMPTY);
        }
        if (length > STREET_MAX_LENGTH) {
            throw new IllegalArgumentException(ERROR_STREET_MAX_LENGTH);
        }
        if (!STREET_PATTERN.matcher(street).matches()) {
            throw new IllegalArgumentException(ERROR_STREET_FORMAT);
        }
    }

    private void validateCity(String city) {
        if (city == null) {
            throw new IllegalArgumentException(ERROR_CITY_NOT_DEFINED);
        }
        int length = city.length();
        if (length == 0) {
            throw new IllegalArgumentException(ERROR_CITY_EMPTY);
        }
        if (length > CITY_MAX_LENGTH) {
            throw new IllegalArgumentException(ERROR_CITY_MAX_LENGTH);
        }
        if (!CITY_PATTERN.matcher(city).matches()) {
            throw new IllegalArgumentException(ERROR_CITY_FORMAT);
        }
    }

    private void validatePostalCode(String postalCode) {
        if (postalCode == null) {
            throw new IllegalArgumentException(ERROR_POSTAL_CODE_NOT_DEFINED);
        }
        if (postalCode.length() != POSTAL_CODE_LENGTH) {
            throw new IllegalArgumentException(ERROR_POSTAL_CODE_LENGTH);
        }
        if (!POSTAL_CODE_PATTERN.matcher(postalCode).matches()) {
            throw new IllegalArgumentException(ERROR_POSTAL_CODE_FORMAT);
        }
    }

    /**
     * It returns the street of the address.
     * 
     * @return Street of the address.
     */
    public String getStreet() {
        return this.street;
    }

    /**
     * It returns the city of the address.
     * 
     * @return City of the address.
     */
    public String getCity() {
        return this.city;
    }

    /**
     * It returns the postal code of the address.
     * 
     * @return Postal code of the address.
     */
    public String getPostalCode() {
        return this.postalCode;
    }

    /**
     * It returns a new address with the new street.
     * 
     * @param newStreet
     * @return New address with the new street.
     */
    public Address setStreet(String newStreet) {
        return new Address(newStreet, this.city, this.postalCode);
    }

    /**
     * It returns a new address with the new city.
     * 
     * @param newCity New city.
     * @return New address with the new city.
     */
    public Address setCity(String newCity) {
        return new Address(this.street, newCity, this.postalCode);
    }

    /**
     * It returns a new address with the new postal code.
     * 
     * @param newPostalCode New postal code.
     * @return New address with the new postal code.
     */
    public Address setPostalCode(String newPostalCode) {
        return new Address(this.street, this.city, newPostalCode);
    }

    /**
     * It returns a new address with the new street, city and postal code.
     * 
     * @param otherObject Address to compare.
     * @return True if the address is the same, false otherwise.
     */
    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (otherObject == null) {
            return false;
        }
        if (this.getClass() != otherObject.getClass()) {
            return false;
        }
        Address otherAddress = (Address) otherObject;
        return this.street.equals(otherAddress.street) &&
                this.city.equals(otherAddress.city) &&
                this.postalCode.equals(otherAddress.postalCode);
    }

    /**
     * It returns the hash code of the address.
     * 
     * @return Hash code of the address.
     */
    @Override
    public int hashCode() {
        return Objects.hash(street, city, postalCode);
    }

    /**
     * It returns the string representation of the address.
     * 
     * @return String representation of the address.
     */
    @Override
    public String toString() {
        return String.format("Address={street='%s',city='%s',postalCode='%s'}",
                this.street, this.city, this.postalCode);
    }
}
```

### Explicación del código

1. **Inmutabilidad.** Los campos `street`, `city` y `postalCode` se definen como `final`, y no hay métodos que permitan cambiar estos valores después de que se haya creado el objeto. Nótese que los setters definidos no cambian los valores de los atributos sino que crean nuevos objetos. Se proporciona una explicación de esto en el punto 4
2. **Constructor.** Valida que los campos no sean `null`, lo cual asegura la consistencia del objeto.
3. **Validación.** Se agregan métodos para validar la calle, ciudad y código postal utilizando expresiones regulares y algunas comprobaciones adicionales como la longitud de los campos, lo cual garantiza que los valores cumplan con un formato adecuado. A su vez, los mensajes de error se definen como constantes para facilitar su reutilización y mantenimiento, y son específicos para cada caso.
4. **Setters inmutables.** Los setters crean una nueva instancia de la clase `Address` con el valor actualizado, manteniendo la inmutabilidad del objeto original. Esto significa que es imposible modificar la calle, ciudad o código postal. En su lugar, se crea otro objeto con los nuevos valores, tal como se muestra a continuación:
    ```java
    Address originalAddress = new Address("123 Main St", "Springfield", "12345");
    Address updatedAddress = originalAddress.setStreet("456 Elm St");

    System.out.println(originalAddress); // Address={street='123 Main St',city='Springfield',postalCode='12345'}
    System.out.println(updatedAddress);  // Address={street='456 Elm St',city='Springfield',postalCode='12345'}
    ```
5. **`equals()` y `hashCode()`**: Estos métodos se sobrescriben para garantizar que la igualdad entre dos objetos de `Address` se base en sus valores y no en la referencia de la instancia.
6. **`toString()`.** Se proporciona una representación legible para facilitar el debug o registro de información.
