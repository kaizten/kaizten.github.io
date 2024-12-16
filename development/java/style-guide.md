# Java. Style Guide

- [Java. Style Guide](#java-style-guide)
  - [Filenames](#filenames)
  - [Language](#language)
  - [Entities](#entities)
  - [Enumerates](#enumerates)
  - [Value objects](#value-objects)
  - [OpenAPI documentation](#openapi-documentation)
  - [`pom.xml`](#pomxml)

## Filenames

1. Filenames must be written in English.
2. Folders must be written in English.

## Language

1. The source code, documentation (including source code, OpenAPI, etc.), images, and any other assets must be written in English.

## Entities

1. Each entity must follow the rules defined for them, as can be read [here](./java_entity.md).
2. The tests defined for entities defined [here](./tests_entity.md) must be implemented.
3. Each attribute of an entity must be documented using multi-line comments (`/** */`). Additionally, optional and computed attributes must be indicated in the corresponding comments as follows:
     * `It is an optional attribute.`
     * `It is a computed attribute.`

## Enumerates

1. Each enumerate must follow the rules defined for them, as can be read [here](./java_enumerate.md).
2. The tests defined for enumerates defined [here](./tests_enumerate.md) must be implemented.

## Value objects

1. Each value object must follow the rules defined for them, as can be read [here](./java_value-object.md).
2. The tests defined for value objects defined [here](./tests_value-object.md) must be implemented.
3. Each attribute of a value object must be documented using multi-line comments (`/** */`). Additionally, optional and computed attributes must be indicated in the corresponding comments as follows:
     * `It is an optional attribute.`
     * `It is a computed attribute.`

## OpenAPI documentation

1. OpenAPI documentation must be available for each REST controller.

## `pom.xml`

1. `pom.xml` files must have the following features:
  * Tag `name` should be defined.
  * Tag `description` should be defined.
  * Tag `url` should be defined. Its value must be `https://www.kaizten.com`