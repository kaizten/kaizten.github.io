# Tests: Form

- [Prerequisites](#prerequisites)
  - [Example form component](#example-form-component)
- [Initial rendering](#initial-rendering)
- [Data input handling](#data-input-handling)
  - [Text](#text)
  - [Select](#select)
  - [Checkbox](#checkbox)
  - [Radio buttons](#radio-buttons)
  - [Date](#date)
- [Validation](#validation)
  - [Required fields](#required-fields)
  - [Format validation](#format-validation)
- [Submit button](#submit-button)
  - [Enable and disable submit button](#enable-and-disable-submit-button)
  - [Submit data](#submit-data)
- [Reset form](#reset-form)


## Prerequisites

Make sure you have Vue Test Utils for Vue 3 installed:

```bash
npm install @vue/test-utils@next
```

### Example form component

We'll use a simple form component for testing that includes text input, select, checkbox, radio buttons, date input, and submit/reset buttons:

```vue
<template>
  <form @submit.prevent="submitForm">
    <input v-model="formData.textField" type="text" required />
    <select v-model="formData.selectedOption">
      <option disabled value="">Select an option</option>
      <option value="option1">Option 1</option>
      <option value="option2">Option 2</option>
    </select>
    <input v-model="formData.isChecked" type="checkbox" />
    <input v-model="formData.selectedRadio" type="radio" value="radio1" />
    <input v-model="formData.selectedRadio" type="radio" value="radio2" />
    <input v-model="formData.selectedDate" type="date" />
    <button :disabled="!isValidForm" type="submit">Submit</button>
    <button type="reset" @click="resetForm">Reset</button>
  </form>
</template>

<script lang="ts">
import { defineComponent, reactive, computed } from 'vue';

export default defineComponent({
  name: 'ExampleFormComponent',
  setup() {
    const formData = reactive({
      textField: '',
      selectedOption: '',
      isChecked: false,
      selectedRadio: '',
      selectedDate: '',
    });

    const isValidForm = computed(() => {
      return formData.textField !== '' && formData.selectedOption !== '';
    });

    const submitForm = () => {
      // Logic for form submission
    };

    const resetForm = () => {
      formData.textField = '';
      formData.selectedOption = '';
      formData.isChecked = false;
      formData.selectedRadio = '';
      formData.selectedDate = '';
    };

    return {
      formData,
      isValidForm,
      submitForm,
      resetForm,
    };
  },
});
</script>
```

## Initial rendering

Check that the form and all necessary elements render correctly.

```js
import { mount } from '@vue/test-utils';
import ExampleFormComponent from '@/components/ExampleFormComponent.vue';

describe('ExampleFormComponent.vue', () => {
  test('renders the form properly', () => {
    const wrapper = mount(ExampleFormComponent);
    
    expect(wrapper.find('form').exists()).toBe(true);
    expect(wrapper.find('input[type="text"]').exists()).toBe(true);
    expect(wrapper.find('select').exists()).toBe(true);
    expect(wrapper.find('input[type="checkbox"]').exists()).toBe(true);
    expect(wrapper.find('input[type="radio"]').exists()).toBe(true);
    expect(wrapper.find('input[type="date"]').exists()).toBe(true);
  });
});
```

## Data input handling

### Text input

Verify that the user can type into a text field and that the component's model is updated accordingly.

```js
test('input_text_updates_model', async () => {
  const wrapper = mount(ExampleFormComponent);
  const input = wrapper.find('input[type="text"]');
  
  await input.setValue('New text');
  expect(wrapper.vm.formData.textField).toBe('New text');
});
```

### Select

Verify that selecting a value in a ```<select>``` element updates the component’s state correctly.

```js
test('select_option_updates_model', async () => {
  const wrapper = mount(ExampleFormComponent);
  const select = wrapper.find('select');
  
  await select.setValue('option2');
  expect(wrapper.vm.formData.selectedOption).toBe('option2');
});
```

### Checkbox

Verify that checking and unchecking a checkbox updates the model correctly.

```js
test('checkbox_updates_model', async () => {
  const wrapper = mount(ExampleFormComponent);
  const checkbox = wrapper.find('input[type="checkbox"]');
  
  await checkbox.setChecked(true);
  expect(wrapper.vm.formData.isChecked).toBe(true);
  
  await checkbox.setChecked(false);
  expect(wrapper.vm.formData.isChecked).toBe(false);
});
```

### Radio buttons

Verify that selecting a radio button updates the model.

```js
test('radio_button_updates_model', async () => {
  const wrapper = mount(ExampleFormComponent);
  const radio = wrapper.find('input[type="radio"][value="radio1"]');
  
  await radio.setChecked();
  expect(wrapper.vm.formData.selectedRadio).toBe('radio1');
});
```

### Date input

Verify that selecting a date updates the model correctly.

```js
test('date_input_updates_model', async () => {
  const wrapper = mount(ExampleFormComponent);
  const dateInput = wrapper.find('input[type="date"]');
  
  await dateInput.setValue('2024-09-16');
  expect(wrapper.vm.formData.selectedDate).toBe('2024-09-16');
});
```

## Validation

### Required fields

Verify that required fields cannot be submitted if left empty.

```js
test('required_fields_show_error', async () => {
  const wrapper = mount(ExampleFormComponent);
  
  await wrapper.find('form').trigger('submit.prevent');
  
  expect(wrapper.vm.isValidForm).toBe(false);
});
```

### Format validation

If your form has a field that requires specific format validation (like an email field), ensure the form detects incorrect formats.

```js
test('invalid_format_shows_error', async () => {
  const wrapper = mount(ExampleFormComponent);
  const emailInput = wrapper.find('input[type="email"]');
  
  await emailInput.setValue('invalid-email');
  await wrapper.find('form').trigger('submit.prevent');
  
  // Assuming you have an email validator
  expect(wrapper.vm.errors.emailField).toBe('Invalid email format');
});
```

## Submit button

### Enable and disable submit button

Verify that the submit button is disabled when the form is invalid.

```js
test('submit_button_disabled_when_invalid', async () => {
  const wrapper = mount(ExampleFormComponent);
  
  const submitButton = wrapper.find('button[type="submit"]');
  expect(submitButton.attributes('disabled')).toBe('disabled');
  
  await wrapper.setData({ formData: { textField: 'Valid text', selectedOption: 'option1' } });
  expect(submitButton.attributes('disabled')).toBeUndefined();
});
```

### Submit data

Verify that submitting the form triggers the correct method.

```js
test('submits_form_successfully', async () => {
  const wrapper = mount(ExampleFormComponent);
  
  wrapper.vm.submitForm = jest.fn();
  await wrapper.setData({ formData: { textField: 'Valid text', selectedOption: 'option1' } });
  await wrapper.find('form').trigger('submit.prevent');
  
  expect(wrapper.vm.submitForm).toHaveBeenCalled();
});
```

## Reset form

Verify that clicking the reset button clears the form fields.

```js
test('resets_form', async () => {
  const wrapper = mount(ExampleFormComponent);
  
  await wrapper.setData({ formData: { textField: 'Valid text', selectedOption: 'option1' } });
  await wrapper.find('button[type="reset"]').trigger('click');
  
  expect(wrapper.vm.formData.textField).toBe('');
  expect(wrapper.vm.formData.selectedOption).toBe('');
});
```

