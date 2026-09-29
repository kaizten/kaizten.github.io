# Vue.js. SOLID Principles

- [Vue.js. SOLID Principles](#vuejs-solid-principles)

SOLID principles are a set of guidelines to write maintainable and scalable code. They are not limited to certain programming languages or technologies and can be applied to any kind of software development, including front-end development.

1.Single Responsibility Principle (SRP). It always feels right to write a single class/function that takes up the entire burden of business logic. The problem with this approach is that your code will become unpredictable, the technical term is “not maintainable”. Suppose you have a highly complex class with multiple responsibilities, and you need to make a slight change to one of these functionalities. How are you gonna be able to track the effects of this change throughout the entire behavior of this class? This is where the SRP rule comes into play. If you limit each class to a single responsibility, you no longer have to worry about the consequences of a needed change within that class, as you will have a much easier time understanding the effects of this change in your class.

Consider the following example:

    ```javascript
    <template>
      <div>
        <ProductList :products="products" @product-selected="handleProductSelected" />
        <ProductFilter :categories="categories" @category-selected="handleCategorySelected" />
        <ProductDetail v-if="selectedProduct" :product="selectedProduct" />
      </div>
    </template>
    <script setup>
    import { ref } from "vue";
    const products = ref([])
    const categories = ref([])
    const selectedProduct = ref(null)
    const handleProductSelected = (product) => {
      selectedProduct.value = product;
    };
    const handleCategorySelected = (category) => {
      // Filter products by category
    };
    </script>
    ```
As you can see, there are three different components with their own single responsibility: ```ProductList```, ```ProductFilter```, and ```ProductDetail```.

-```ProductList``` component is responsible for displaying a list of products and emitting a ```product-selected``` event when a product is selected.
-```ProductFilter``` component is responsible for displaying a list of categories and emitting a ```category-selected``` event when a category is selected.
-```ProductDetail``` component is responsible for displaying detailed information about a selected product.

By separating the responsibilities into separate components, the code is easier to understand, maintain, and test. Each component can be tested in isolation, and changes to one component won’t affect the other components.

1.  Open/Closed Principle (OCP). Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification. This principle basically states that you should allow users to add new functionalities without changing existing code. Suppose you have a component that displays a list of items, and you want to add the ability to sort the items. With the Open/Closed Principle in mind, you could extend the component’s behavior without modifying its code by creating a composable that adds the sorting functionality.

Here is our List.vue component:
```javascript
<template>
  <ul>
    <li v-for="item in items" :key="item.id">{{ item.text }}</li>
  </ul>
</template>

<script setup>
defineProps({
  items: Array
})
</script>
```
Here is the composable (useSorting.js):
```javascript
import { ref, onMounted } from 'vue'

export const useSorting = (items) => {
  const sortOrder = ref('ascending')
  const sortedItems = ref([])
  
  function toggleSortOrder () {
    sortOrder.value = sortOrder.value === 'ascending' ? 'descending' : 'ascending'
  }

  onMounted(() => {
    sortedItems.value = items.value.sort((a, b) => {
      if (sortOrder.value === 'ascending') {
        return a.text.localeCompare(b.text)
      } else {
        return b.text.localeCompare(a.text)
      }
    })
  })

  return { sortOrder, sortedItems, toggleSortOrder }
}
```
And the App component that uses the list component and adds the sorting functionality to it using the useSorting composable:
```javascript
<template>
  <div>
    <button @click="toggleSortOrder">Toggle sort order</button>
    <List :items="sortedItems"/>
  </div>
</template>

<script setup>
import useSorting from './useSorting.js'

const items: [
  { id: 1, text: 'Item 1' },
  { id: 2, text: 'Item 2' },
  { id: 3, text: 'Item 3' }
]

const { sortOrder, sortedItems, toggleSortOrder } = useSorting(items)
</script>
```
This demonstrates the Open/Closed Principle, as the behavior of the List component is extended through the addition of new code, rather than modification of its original code.

Basically, we don’t actually implement this principle ourselves. The component-based architecture of Vue and its reactive data system provides a natural way of following the Open/Closed principle in our code.

31. Liskov Substitution Principle (LSP). Despite its rather scary name, this principle simply states that objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program. Here is an example of how this principle can be applied to Vue components. In this example, we have a component that displays a form with a submit button (Form.vue):
```javascript
<template>
  <form @submit.prevent="submit">
    <slot />
    <button type="submit">Submit</button>
  </form>
</template>

<script setup>
function submit() {
  console.log('Form submitted!')
}
</script>
```
Here’s a subclass that extends the base component and adds two text fields:
```javascript
<template>
  <Form>
    <input type="text" v-model="username" />
    <input type="text" v-model="password" />
  </Form>
</template>

<script setup>
const username = ref('')
const password = ref('')
</script>
```
In this subclass, we have added two text fields for the user to enter their username and password. The subclass can be used in place of the base component without affecting the overall functionality of the application. When the form is submitted, the submit method from the base component will still be called, and the message will still be logged to the console. By following the Liskov Substitution Principle in this way, the development of the UI can become more flexible and scalable, making it easier to maintain and extend the application over time. Just like the Open/Closed principle, the Liskov substitution principle is also something that is already integrated into the architecture of Vue and we make use of it without knowing what it is actually called.

32. Interface Segregation Principle (ISP). This principle states that clients should not be forced to depend on methods that they do not use. In other words, it’s better to have smaller, more specific interfaces that are tailored to the needs of each client, rather than one large interface that includes methods that are not relevant to all clients. This helps to reduce the coupling between different parts of a system and can make it easier to maintain and modify the code over time. ISP is one of the key reasons why components are used in Vue (or any other component-based framework). It gives us the ability to break down complex structures into smaller components with simpler behaviors and singular responsibilities. 

Consider the following example :
```javascript
<template>
  <div>
    <Filter @change="setFilter" />
    <List :items="filteredItems" @select="selectItem" />
    <ItemDetail v-if="selectedItem" :item="selectedItem" @close="deselectItem" />
  </div>
</template>
<script setup>
import { reactive, toRefs } from 'vue'
const state = reactive({
  items: [...], // an array of items
  filter: '',
  selectedItem: null
})
const filteredItems = computed(() => {
  return state.items.filter(item => item.name.includes(state.filter))
})
function setFilter(filter) {
  state.filter = filter
}
function selectItem(item) {
  state.selectedItem = item
}
function deselectItem() {
  state.selectedItem = null
}
const { items, filter, selectedItem } = toRefs(state)
</script>
```
Imagine if you wanted to handle filtering, listing, and displaying the details of an item in a single component. You end up with a fat component that changing a small part of is gonna cause other changes which are not easy to track.

33. Dependency Inversion Principle (DIP). This principle states that high-level modules should not depend on low-level modules, but instead both should depend on abstractions. Abstractions should not depend on details, but details should depend on abstractions. This helps to create loosely coupled and more maintainable code.

A web application normally consists of four parts: database, back-end, API, and front-end. This partitioning of a web application is already an example of DIP. For instance, in the context of DIP, an API defines the contract between two parts of a web application, namely front-end and back-end. Front-end components do not rely on the specific detail of data stored in a database, they simply contact a back-end service via predefined instructions and methods of an API. Then the stored data will be modified accordingly, which means details are depending on abstractions.

Now let’s get back to Vue itself. Committing to the component-based architecture of Vue is already a way of following DIP. We create reusable components to define how the data is going to be displayed to users. Another example is the usage of props in Vue. We use them to pass down data in components. So props themselves are the implementation of DIP, because they act as a contract between two components in order to change the way data is displayed to users. Services in Vue are also a great example of following DIP. Vue components make use of services to access data, maybe modify them upon reception, and finally display them to users.