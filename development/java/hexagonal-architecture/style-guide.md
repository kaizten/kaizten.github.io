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
      - [Tests](#tests-2)
      - [Comments](#comments-1)
  - [REST adapter](#rest-adapter)
    - [OpenAPI documentation](#openapi-documentation)

## Domain

### Entities

#### Constructors

* Each entity must have a copy constructor.
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

#### Tests

* The tests defined for value objects defined [here](./value-object_tests.md) must be implemented.

#### Comments

* Each attribute must be documented using JavaDoc comments (`/** */`). 
* Comment of each non-static attribute must indicate if it is required, optional or computed, as follows:
   * `It is a required attribute.`
   * `It is an optional attribute.`
   * `It is a computed attribute.`

## REST adapter

### OpenAPI documentation

1. OpenAPI documentation must be available for each REST controller.