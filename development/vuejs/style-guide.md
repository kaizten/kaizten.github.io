# Vue.js. Style Guide

- [Vue.js. Style Guide](#vuejs-style-guide)
  - [Filenames](#filenames)
  - [Components](#components)
  - [Views](#views)
  - [Router](#router)
  - [Tags](#tags)

The style guide we follow for the TypeScript programming language is the Google TypeScript style guide. This style guide can be found at the following URL: [Vue.js Style Guide](https://vuejs.org/style-guide/).

Additionally, below we outline basic considerations that all code implemented in a `.vue` file must meet.

## Filenames

1. Filenames must be written in English.
2. Folders must be written in English.
3. Filenames of Single-File Components should always be PascalCase. For example, `MyFooter.vue`.
4. Folders should always be [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). For example, `../data-components/header-elements/..`

## Components

1. Each component must be named `<NAME>.vue`, where `<NAME>` is the selected name for the component.
2. The name of each component must be in Pascal case.
3. Each view must be located in folder `../vuejs/components/..`
4. The components used must be 99% within [kaizten-vue](https://github.com/kaizten/kaizten-vue) library. That is, the number of files in the `components` folder should tend to `0`, with a few exceptions.
5. Each component containing a form must include a data model. Read [this](view-model.md) for more information.

## Views

1. Each view must be named `<NAME>View.vue`, where `<NAME>` is the selected name for the view.
2. The name of each view must be in Pascal case.
3. Each view must be located in folder `../vuejs/views/..`
4. For each CRUD (Create, Read, Update, and Delete) operation of any entity , there must be a corresponding view in Vue whose file should be named using the format `EntityName+OperationName+View.vue` (for instance, `TaskCreateView.vue`, `TaskReadView.vue`, `TaskUpdateView.vue`,...). In other words, there cannot be a view for both creating and updating, or for creating, updating, and reading.
5. Each view containing a form must include a data model. Read [this](view-model.md) for more information.

## Router

1. Routes must be in [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case).

## Tags

1. Language tags should always be camelCase.