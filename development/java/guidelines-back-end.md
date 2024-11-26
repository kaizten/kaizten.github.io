# Guidelines of back-end

<!-- TOC -->

- [Structure of project](#structure-of-project)
- [Validation of entities](#validation-of-entities)
- [Value objects](#value-objects)
- [REST API](#rest-api)
  - [Validation of requests](#validation-of-requests)
  - [Tests](#tests)
    - [`DELETE resource/`](#delete-resource)
      - [Not allowed](#not-allowed)
    - [`DELETE resource/:id`](#delete-resourceid)
      - [Success](#success)
      - [Not found](#not-found)
      - [Not acceptable](#not-acceptable)
    - [`GET resource/`](#get-resource)
      - [Success](#success-1)
      - [Not acceptable](#not-acceptable-1)
      - [Unknown request parameter](#unknown-request-parameter)
      - [Request parameter `page`](#request-parameter-page)
        - [Success](#success-2)
        - [Empty](#empty)
        - [Minimum value](#minimum-value)
        - [Maximum value](#maximum-value)
      - [Request parameter `size`](#request-parameter-size)
        - [Sucess](#sucess)
        - [Empty](#empty-1)
        - [Minimum value](#minimum-value-1)
        - [Maximum value](#maximum-value-1)
      - [Required request parameters](#required-request-parameters)
        - [Success](#success-3)
        - [Not provided](#not-provided)
        - [Not found](#not-found-1)
        - [Out of domain](#out-of-domain)
    - [`GET resource/:id`](#get-resourceid)
        - [Success](#success-4)
        - [Not found](#not-found-2)
        - [Not acceptable](#not-acceptable-2)
    - [`OPTIONS resource/`](#options-resource)
      - [Success](#success-5)
    - [`OPTIONS resource/:id`](#options-resourceid)
      - [Success](#success-6)
    - [`PATCH resource/`](#patch-resource)
      - [Not Allowed](#not-allowed-1)
      - [`PATCH resource/:id`](#patch-resourceid)
        - [Not Allowed](#not-allowed-2)
    - [`POST resource/`](#post-resource)
      - [Success](#success-7)
      - [Not acceptable](#not-acceptable-3)
      - [Resource not provided](#resource-not-provided)
      - [Requested attribute not defined](#requested-attribute-not-defined)
      - [Attribute repeated](#attribute-repeated)
      - [Requested attribute empty](#requested-attribute-empty)
      - [Attribute with length lower than minimum length](#attribute-with-length-lower-than-minimum-length)
      - [Attribute with length larger than maximum length](#attribute-with-length-larger-than-maximum-length)
      - [Attribute with wrong format](#attribute-with-wrong-format)
      - [Attribute with value lower than minimum value](#attribute-with-value-lower-than-minimum-value)
      - [Attribute with value larger than maximum length](#attribute-with-value-larger-than-maximum-length)
    - [`POST resource/:id`](#post-resourceid)
      - [ID provided](#id-provided)
    - [`TRACE resource/`](#trace-resource)
      - [Not allowed](#not-allowed-3)

<!-- /TOC -->

## Structure of project

1. The back-end must be organized as follows:
- `adapter/`
  - `minio/`
  - `mongodb/`
    - `event/`
    - `repository/` 
  - `rest/`
    - `controller/`
    - `json/`
      - `validation/`
      - `serialization/`
      - `JsonFields.java`
    - `security/`
    - `utils/`
      - `APPLICATIONRestUtils.java`
    - `RestApiConfiguration.java`
  - `websocket/`
- `application/`
  - `port/`
  - `service/`
- `configuration/`
  - `ApplicationConfiguration.java`
- `domain/`
  - `entity/`
  - `factory/`
  - `validation/`
  - `valueobject/`
- `security/`
- `utils/`
  - `APPLICATIONUtils.java`
- `NAME_OF_APPLICATION.java`

## Validation of entities

Given an entity called `MyEntity` in the domain of the application, the following issues must be checked:
1. `MyEntity` is located in folder `domain/entity`.
2. There is a validator `MyEntityValidator` in folder `domain/validator`.
3. For each attribute of `MyEntity`, the following constants are defined in `MyEntityValidator`:
```java
// Name of the attribute in `MyEntity`
public static final int ATTRIBUTE_MIN_LENGTH = 1;
public static final int ATTRIBUTE_MAX_LENGTH = 1000;
public static final int ATTRIBUTE_DEFAULT_VALUE = 20;
public static final int ATTRIBUTE_MIN_VALUE = 18;
public static final int ATTRIBUTE_MAX_VALUE = 99;
public static final String ERROR_ATTRIBUTE_NOT_DEFINED = "ATTRIBUTE of MyEntity is not defined";
public static final String ERROR_ATTRIBUTE_REPEATED = "ATTRIBUTE of MyEntity is provided several times";
public static final String ERROR_ATTRIBUTE_EMPTY = "ATTRIBUTE of MyEntity cannot be empty";
public static final String ERROR_ATTRIBUTE_MIN_LENGTH = "ATTRIBUTE of MyEntity must be at least " + ATTRIBUTE_MIN_LENGTH + " characters in length";
public static final String ERROR_ATTRIBUTE_MAX_LENGTH = "ATTRIBUTE of MyEntity must be at most " + ATTRIBUTE_MAX_LENGTH + " characters in length";
public static final String ERROR_ATTRIBUTE_WRONG_FORMAT = "ATTRIBUTE of MyEntity must only contain alphanumeric characters and spaces";
public static final String ERROR_ATTRIBUTE_MIN_VALUE = "ATTRIBUTE of MyEntity must be at least " + ATTRIBUTE_MIN_VALUE;
public static final String ERROR_ATTRIBUTE_MAX_VALUE = "ATTRIBUTE of MyEntity must be at most " + ATTRIBUTE_MAX_VALUE;
...
```
It should be noted that some constants are only applicable in numeric cases. For example, this is the case of `ATTRIBUTE_MIN_LENGTH`.

## Value objects

Given a value object `ValueObject` in the domain of the application, the following issues must be checked:
1. The following constants are defined in `ValueObject.java`:
```java
// Name of the attribute in `ValueObject`
public static final int MIN_LENGTH = 1;
public static final int MAX_LENGTH = 1000;
public static final String REGULAR_EXPRESSION = "^[a-zA-Z-\\d\\s\\.-_]*$";
public static final int DEFAULT_VALUE = 20;
public static final int MIN_VALUE = 18;
public static final int MAX_VALUE = 99;
public static final String ERROR_NOT_DEFINED = "ATTRIBUTE of ValueObject is not defined";
public static final String ERROR_EMPTY = "ATTRIBUTE of ValueObject cannot be empty";
public static final String ERROR_MIN_LENGTH = "ATTRIBUTE of ValueObject must be at least " + MIN_LENGTH + " characters in length";
public static final String ERROR_MAX_LENGTH = "ATTRIBUTE of ValueObject must be at most " + MAX_LENGTH + " characters in length";
public static final String ERROR_WRONG_FORMAT = "ATTRIBUTE of ValueObject must only contain alphanumeric characters and spaces";
public static final String ERROR_MIN_VALUE = "ATTRIBUTE of ValueObject must be at least " + MIN_VALUE;
public static final String ERROR_MAX_VALUE = "ATTRIBUTE of ValueObject must be at most " + MAX_VALUE;
...
```
2. Method `private void validate(TYPE_OF_VALUE value)` is defined and called from the constructor.
3. Method `equals` is overriden.
4. Method `hashCode` is overriden.
5. Method `public static ValueObject random()` is defined.

## REST API

### Validation of requests

Given a controller of a resource `MyResource` in the REST API, the following issues must be checked:
1. A controller `MyResourceHandler` is located in folder `adapters/rest/controller`.
2. A validation of the resource, `MyResourceJsonNodeValidator`, is located in folder `adapters/rest/json/validation`.
3. For each endpoint with pagination, the following constants are defined in `MyResourceJsonNodeValidator`:
```java
// page
public static final int PAGE_DEFAULT_VALUE = 0;
public static final int PAGE_MIN_VALUE = 0;
public static final int PAGE_MAX_VALUE = Integer.MAX_VALUE - 1;
public static final String ERROR_PAGE_WRONG_FORMAT = "Value of request parameter '" + KaiztenPagination.PAGE + "'' must be numeric";
public static final String ERROR_PAGE_MIN_VALUE = "Value of request parameter '" + KaiztenPagination.PAGE + "'' must be non-negative";
public static final String ERROR_PAGE_MAX_VALUE = "Value of request parameter '" + KaiztenPagination.PAGE + "'' must be at most " + PAGE_MAX_VALUE;
// size
public static final int SIZE_DEFAULT_VALUE = 20;
public static final int SIZE_MIN_VALUE = 1;
public static final int SIZE_MAX_VALUE = 100;
public static final String ERROR_SIZE_WRONG_FORMAT = "Value of request parameter '" + KaiztenPagination.SIZE + "'' must be numeric";
public static final String ERROR_SIZE_MIN_VALUE = "Value of request parameter '" + KaiztenPagination.SIZE + "'' must be positive";
public static final String ERROR_SIZE_MAX_VALUE = "Value of request parameter '" + KaiztenPagination.SIZE + "'' must be at most " + SIZE_MAX_VALUE;
```