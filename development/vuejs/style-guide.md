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

3. If the view requires a "go back" button, the `goBack` prop must be provided to define the back navigation behavior. The default style for the back button includes:
   - `goBackText`: `"back"`
   - `goBackIcon`: `"mdi-arrow-left-circle"`
   - `showGoBack`: `true`

4. All form inputs **must** use components from the `@kaizten/kaizten-vue` library:
   - `InputTooltip` for text or numeric inputs with validation and tooltips.
   - `SelectTooltip` for dropdown selections.
   - `ButtonTooltip` for action buttons with hover explanations.

5. The default `variant` for all form fields must be `"outlined"`, unless there is a justified design exception.

6. Fields should always be grouped inside `<v-row>` and placed side by side using `<v-col>` to leverage Vuetify’s grid system.

7. All `InputTooltip` and `SelectTooltip` components should be aligned horizontally (side by side) whenever layout space allows, especially in desktop views, to improve visual clarity and reduce vertical scroll.

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

## Router

1. Routes must be in [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case).

## Tags

1. Language tags should always be camelCase.