# TypeScript. Style Guide

- [TypeScript. Style Guide](#typescript-style-guide)
  - [Filenames](#filenames)
  - [Language](#language)
  - [Tests](#tests)
  - [Entities](#entities)
  - [Enumerates](#enumerates)
  - [Value objets](#value-objets)

## Filenames

1. Filenames must be always in [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). For example, `my-kpi.ts`.
2. Filenames must be always written in English.
3. Folders should always be [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). For example, `../data-components/header-elements/..`

## Language

1. Source code, documentation, images, and any other assets must be written in English.

## Tests

1. Tests must be found in folder `.. /src/test/ ..`.

## Entities

1. Each entity must follow the rules defined for them, as can be read [read](./typescript_entity.md).
2. The tests defined for entities defined [here](./tests_entity.md) must be implemented.
3. Each attribute of an entity must be documented using multi-line comments (`/** */`). Additionally, optional and computed attributes must be indicated in the corresponding comments as follows:
  * `It is an optional attribute.`
  * `It is a computed attribute.`

## Enumerates

1. Each enumerate must follow the rules defined for them, as can be read [read](./typescript_enumerate.md).
2. The tests defined for enumerates defined [here](./tests_enumerate.md) must be implemented.

## Value objets

1. Each value object must follow the rules defined for them, as can be read [read](./typescript_value-object.md).
2. The tests defined for value objects defined [here](./tests_value-object.md) must be implemented.
3. Each attribute of a value object must be documented using multi-line comments (`/** */`). Additionally, optional and computed attributes must be indicated in the corresponding comments as follows:
  * `It is an optional attribute.`
  * `It is a computed attribute.`