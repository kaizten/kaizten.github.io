# Java. Style Guide

- [Java. Style Guide](#java-style-guide)
  - [Filenames](#filenames)
  - [Language](#language)
  - [Entities](#entities)
    - [Constructors](#constructors)
    - [Tests](#tests)
    - [Comments](#comments)
  - [Enumerates](#enumerates)
    - [Tests](#tests-1)
  - [Value objects](#value-objects)
    - [Tests](#tests-2)
    - [Comments](#comments-1)
  - [OpenAPI documentation](#openapi-documentation)
  - [`pom.xml`](#pomxml)

## Filenames

1. Filenames must be written in English.
2. Folders must be written in English.

## Language

1. The source code, documentation (including source code, OpenAPI, etc.), images, and any other assets must be written in English.

## Entities

1. Each entity must follow the rules defined for them, as can be read [here](./java_entity.md).

### Constructors

1. Each entity must have a restore constructor to be used exclusively by databases. The parameters of the restore constructor must be the same and provided in the same order as the attributes of the entity.
2. The restore constructor must be commented with `Restore constructor`.
3. The restore constructor must be documented using JavaDoc comments (`/** */`).

### Tests

1. The tests defined for entities defined [here](./tests_entity.md) must be implemented.

### Comments

1. Each attribute must be documented using JavaDoc comments (`/** */`). 
2. Comment of each non-static attribute must indicate if it is required, optional or computed, as follows:
   * `It is a required attribute.`
   * `It is an optional attribute.`
   * `It is a computed attribute.`

## Enumerates

1. Each enumerate must follow the rules defined for them, as can be read [here](./java_enumerate.md).

### Tests

1. The tests defined for enumerates defined [here](./tests_enumerate.md) must be implemented.

## Value objects

1. Each value object must follow the rules defined for them, as can be read [here](./java_value-object.md).

### Tests

1. The tests defined for value objects defined [here](./tests_value-object.md) must be implemented.

### Comments

1. Each attribute must be documented using JavaDoc comments (`/** */`). 
2. Comment of each non-static attribute must indicate if it is required, optional or computed, as follows:
   * `It is a required attribute.`
   * `It is an optional attribute.`
   * `It is a computed attribute.`

## OpenAPI documentation

1. OpenAPI documentation must be available for each REST controller.

## `pom.xml`

1. `pom.xml` files must have the following features:
  * Tag `name` should be defined.
  * Tag `description` should be defined.
  * Tag `url` should be defined. Its value must be `https://www.kaizten.com`