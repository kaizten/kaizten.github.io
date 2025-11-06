# Java. Hexagonal architecture. Style Guide

- [Java. Hexagonal architecture. Style Guide](#java-hexagonal-architecture-style-guide)
  - [Domain](#domain)
    - [Entities](#entities)
      - [Constructors](#constructors)
      - [Tests](#tests)
      - [Comments](#comments)
    - [Enumerates](#enumerates)
      - [Tests](#tests-1)
    - [Value objects](#value-objects)
      - [Attributes](#attributes)
      - [Tests](#tests-2)
      - [Comments](#comments-1)
  - [Application](#application)
    - [Use cases](#use-cases)
    - [Services](#services)
    - [Repositories](#repositories)
  - [REST adapter](#rest-adapter)
    - [OpenAPI documentation](#openapi-documentation)

## Domain

### Entities

* Do not use `Cloneable`. Instead, use the copy constructor to obtain a copy of an entity.

#### Constructors

* Each entity must have a copy constructor.
* Each `public` constructor must have at least the required attributes as arguments. Attributes declared as `final` can be ommited as argument because are initialized in the constructor by definition.
* Each entity must have a restore constructor to be used exclusively by databases. The parameters of the restore constructor must be the same and provided in the same order as the attributes of the entity.
* The restore constructor must be commented with `Restore constructor`.
* The restore constructor must be documented using JavaDoc comments (`/** */`).

#### Tests

* The tests defined for entities defined [here](./entity_tests.md) must be implemented.

#### Comments

* Each attribute must be documented using JavaDoc comments (`/** */`). 
* Comment of each non-static attribute must indicate if it is required, optional or computed, as follows:
   * `It is a required attribute.`
   * `It is an optional attribute.`
   * `It is a computed attribute.`

### Enumerates

#### Tests

* The tests defined for enumerates defined [here](./enumerate_tests.md) must be implemented.

### Value objects

#### Attributes

* Required attributes must be declared as `final`.
* `Optional` cannot be used as type of attributes.

#### Tests

* The tests defined for value objects defined [here](./value-object_tests.md) must be implemented.

#### Comments

* Each attribute must be documented using JavaDoc comments (`/** */`). 
* Comment of each non-static attribute must indicate if it is required, optional or computed, as follows:
   * `It is a required attribute.`
   * `It is an optional attribute.`
   * `It is a computed attribute.`

## Application

### Use cases

* Arguments of use cases must be value objects.
* Return values of use cases must be value objects.

### Services

* Do not use annotation `@Service`.

### Repositories

* Do not use annotation `@Repository`.

## REST adapter

### OpenAPI documentation

1. OpenAPI documentation must be available for each REST controller.