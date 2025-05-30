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

### Layout and form components

To ensure consistent structure and appearance across views:

1. All views **must** use the `BasicLayout` component from `@kaizten/kaizten-vue` as the outer structure. This component includes:
   - A top `subtitle-section` for the view's title.
   - A `v-toolbar` with customizable title and optional "go back" button.
   - A central content area via `<slot />`.

2. Views must import `BasicLayout` and wrap all main content inside it.

3. The `title` prop passed to `BasicLayout` must **always** match:
   - The label shown in the left-side navigation menu.
   - The name of the subfolder in the domain structure associated with the entity.
   - For instance, if the menu item is **"Traps"**, then the URL will be `/traps`, the domain folder should be `traps`, and the `BasicLayout` title should be `"Traps"`.

4. If the view requires a "go back" button, the `goBack` prop must be provided to define the back navigation behavior. The default style for the back button includes:
   - `goBackText`: `"back"`
   - `goBackIcon`: `"mdi-arrow-left-circle"`
   - `showGoBack`: `true`

5. All form inputs **must** use components from the `@kaizten/kaizten-vue` library:
   - `InputTooltip` for text or numeric inputs with validation and tooltips.
   - `SelectTooltip` for dropdown selections.
   - `ButtonTooltip` for action buttons with hover explanations.

6. The default `variant` for all form fields must be `"outlined"`, unless there is a justified design exception.

7. Fields should always be grouped inside `<v-row>` and placed side by side using `<v-col>` to leverage Vuetify’s grid system.

8. All `InputTooltip` and `SelectTooltip` components should be aligned horizontally (side by side) whenever layout space allows, especially in desktop views, to improve visual clarity and reduce vertical scroll.

Example usage:

```vue
<template>
  <BasicLayout
    :title="$t('trapManagement')"
    :toolbar-title="$t('createTrap')"
    :go-back="() => router.back()"
  >
    <v-form>
      <v-row>
        <v-col cols="12" sm="6">
          <InputTooltip
            :data="name"
            :text="$t('name')"
            :tooltip="$t('nameTooltip')"
            counter="100"
            :rules="[v => !!v || $t('requiredField')]"
            variant="outlined"
            @updateData="val => name = val"
          />
        </v-col>
        <v-col cols="12" sm="6">
          <SelectTooltip
            :selected="selectedType"
            :text="$t('type')"
            :tooltip="$t('typeTooltip')"
            :items="trapTypes"
            :rules="[v => !!v || $t('requiredField')]"
            variant="outlined"
            @updateData="val => selectedType = val"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="d-flex justify-end">
          <ButtonTooltip
            :text="$t('save')"
            :tooltip="$t('saveTrapTooltip')"
            icon="mdi-content-save"
            @eventclick="onSave"
          />
        </v-col>
      </v-row>
    </v-form>
  </BasicLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import BasicLayout from '@kaizten/kaizten-vue'

const { t } = useI18n()
const router = useRouter()

const name = ref('')
const selectedType = ref('')
const trapTypes = [
  { title: t('ovitrap'), key: 'OVITRAP' },
  { title: t('bgSentinel'), key: 'BG-SENTINEL' },
  { title: t('cdc'), key: 'CDC' },
]

function onSave() {

}
</script>
```


9. The following icons from the **Material Design Icons (mdi)** library must be used consistently for standard actions throughout the application:

| Action   | Icon Name              | Preview |
|----------|------------------------|---------|
| Create   | `mdi-plus-circle`      | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/plus-circle.svg" height="24"> |
| Remove   | `mdi-delete`           | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/delete.svg" height="24"> |
| Edit     | `mdi-pencil`           | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/pencil.svg" height="24"> |
| Read     | `mdi-information-variant` | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/information-variant.svg" height="24"> |
| Save     | `mdi-content-save`     | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/content-save.svg" height="24"> |
| Import   | `mdi-import`           | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/import.svg" height="24"> |
| Export   | `mdi-export`           | <img src="https://cdn.jsdelivr.net/npm/@mdi/svg/svg/export.svg" height="24"> |

These icons must be applied in **ButtonTooltip** and similar components to ensure visual consistency and intuitive recognition of actions.

10. In views used to **list or display** entities —i.e., URLs such as `/traps`, `/devices`, etc.—:
   - Action buttons like **Create**, **Edit**, **Delete**, etc. must be placed **inside** the `BasicLayout`, specifically **within** the `v-card` that includes the `toolbar-title`.
   - These buttons **must not override or replace the `v-toolbar` slot** of `BasicLayout`.

11. In **CRUD operation views** —such as `/traps/create`, `/devices/update`, etc.—:
    - All action buttons must be placed **at the bottom of the form**.
    - Actions with **positive intent** (e.g., Create, Update, Save) must be aligned **to the right**.
    - Actions with **negative or neutral intent** (e.g., Clear Form, Cancel) must be aligned **to the left**.

12. For **all CRUD operation views** (i.e., Create, Update, Delete), the `goBack` button in `BasicLayout` must be **enabled and visible**.
    - The URL structure must follow the pattern `/entity/operation`. For example:
      - `/traps/create`
      - `/devices/update`
      - `/users/delete`

## Router

1. Routes must be in [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case).

## Tags

1. Language tags should always be camelCase.