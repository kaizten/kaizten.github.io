# Vue.js. Good Practices

- [Vue.js. Good Practices](#vuejs-good-practices)

1.  Always use inside v-for. Using the key attribute with the v-for directive helps your application be constant and predictable whenever you want to manipulate the data. This is necessary so that Vue can track your component state as well as have a constant reference to your different elements. An example where keys are extremely useful is when using animations or Vue transitions. Without keys, Vue will just try to make the DOM has efficient as possible. This may mean elements in the v-for may appear out of order or their behavior will be less predictable. If we have a `_unique_` key reference to each element, then we can better predict how exactly our Vue application will handle DOM manipulation.

    ```javascript
    <template>
      <!-- BAD -->
      <div v-for="product in products">{{ product }}</div>

      <!-- GOOD! -->
      <div v-for="product in products" :key="product.id">{{ product }}</div>
    </template>
    ```

2. Use [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case) for events. When it comes to emitting custom events, it’s always best to use [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). This is because in the parent component, that’s the same syntax we use to listen to that event. So for consistency across our components, and to make your code more readable, stick to using [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case) in both places.

    ```javascript
    this.$emit("close-window");

    <template>
    <popup-window @close-window='handleEvent()' />
    </template>
    ```

3. Declare props with camelCase and use [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case) in templates. This best practice simply just follows the conventions for each language. In JavaScript, camelCase is the standard and in HTML, it’s [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). Therefore, we use them accordingly. Luckily for us, VueJS converts between [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case) and camelCase for us so we don’t have to worry about anything besides actually declaring them. In JavaScript, camelCase is the standard and in HTML, it’s [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). Therefore, we use them accordingly.

    ```javascript
    <template>
      <PopupWindow title-text="hello world" />
    </template>

    <script>
    export default {
      props: {
        titleText: String,
      },
    }
    </script>
    ```

4. Data should always return a function. When declaring component data in the Options API, the data option should always return a function. If it does not, and we just simply return an object, then that data will be shared across all instances of the component.

    ```javascript
    export default {
      data() {
        // <---
        return {
          name: 'My Window',
          articles: [],
        }
      },
    }
    ```
    However, most of the time, the goal is to build reusable components, so we want each object to return a unique object. We accomplish this by returning our data object inside a function.

5. Don’t use `v-if` with `v-for` elements. It’s super tempting to want to use `v-if` with `v-for` in order to filter elements of an array.

    ```javascript
    <!--BAD-->
    <div
      v-for='product in products'
      v-if='product.price < 500'
    >
    ```
The problem with this is that VueJS prioritizes the v-for directive over the v-if directive. So under the hood, it loops through every element and THEN checks the v-if conditional. This means that even if we only want to render a few elements from a list, we’ll have to loop through the entire array. This is no good. A smarter solution would be to iterate over a computed property. The above example would look something like this. This means that even if we only want to render a few elements from a list, we’ll have to loop through the entire array.

    ```javascript
    <template>
      <div v-for="product in cheapProducts">{{ product }}</div>
    </template>

    <script>
    export default {
      computed: {
        cheapProducts: () => {
          return this.products.filter(function (product) {
            return product.price < 100
          })
        },
      },
    }
    </script>
    ```
This is good for a few reasons.
- Rendering is much more efficient because we don’t loop over every item
- The filtered list will only be re-evaluated when a dependency changes
- It helps separate our component logic from the template, making our component more readable

14. Validate your props with good definitions. This is arguably the most important best practice to follow. Why is it important? Well. It basically saves future you from current you. When designing a large scale project, it’s easy to forget exactly the exact format, type, and other conventions you used for a prop. And if you’re in a larger dev team, your coworkers aren’t mind-readers so make it clear to them how to use your components! So save everyone the hassle of having to painstakingly trace your component to determine a prop’s formatting and please just write prop validations. Check out this example from the Vue docs.

```javascript
export default {
  props: {
    status: {
      type: String,
      required: true,
      validator: function (value) {
        return (
          ['syncing', 'synced', 'version-conflict', 'error'].indexOf(value) !==
          -1
        )
      },
    },
  },
}
```

15. Stay consistent with your directive shorthand.
Vue developers is to use shorthand for directives. For example,
- `@` is short for `v-on`
- `:` is short for `v-bind`
- `#` is short for `v-slot`

It is great to use these shorthands in your Vue project. But to create some sort of convention across your project, you should either always use them or never use them. This will make your project more cohesive and readable.

16. Don’t call a method on created AND watch. A common mistake Vue developers make (or maybe it was just me) is they unnecessarily call a method in created and watch. The thought behind this is that we want to run the watch hook as soon as a component is initialized.

```javascript
<script>
// BAD!
  export default {
   created: () {
    this.handleChange()
   },
   methods: {
    handleChange() {
     // stuff happens
    }
   },
   watch () {
    property() {
     this.handleChange()
    }
   }
  }
</script>
```
However, there Vue has a built in solution for this. And it’s a property of Vue watchers that we often forget.

All we have to do is restructure our watcher a little bit and declare two properties:
- handler (newVal, oldVal) – this is our watcher method itself
- immediate: true – this makes our handler run when our instance is created

```javascript
<script>
export default {
 methods: {
  handleChange() {
   // stuff happens
  }
 },
 watch () {
  property {
   immediate: true
   handler() {
    this.handleChange()
   }
  }
 }
}
</script>
```

17. Template expressions should only have basic JavaScript expressions. It is natural to want to add as much inline functionality in your templates as possible. But this makes our template less declarative and more complex. Meaning that our template just gets extremely cluttered. For this, let’s check out another example from the Vue style guide. Look how confusing it is.

```javascript
<template>
  { { fullName
      .split(' ')
      .map(function (word) {
        return word[0].toUpperCase() + word.slice(1)
      })
      .join(' ')
  } }
</template>
```

Basically, we want everything in our template to be intuitive as to what it is displaying. To keep this, we should refactor complex expressions into appropriately named component options. Another benefit of separating out complex expressions is that it means these values can be reused.

```javascript
<template>{{ normalizedFullName }}</template>
<script>
export default {
  computed: {
    normalizedFullName: function () {
      return this.fullName
        .split(' ')
        .map(function (word) {
          return word[0].toUpperCase() + word.slice(1)
        })
        .join(' ')
    },
  },
}
</script>
```

18. Vue Single-File Components (a.k.a. `\*.vue` files, abbreviated as SFC). is a special file format that allows us to encapsulate the template, logic, and styling of a Vue component in a single file. Here's an example SFC:

```javascript
<script setup>
import { ref } from 'vue'
const greeting = ref('Hello World!')
</script>
<template>
  <p class="greeting">{{ greeting }}</p>
</template>
<style>
.greeting {
  color: red;
  font-weight: bold;
}
</style>
```

19. Patterns. Component Communication. Props and Events. Basically, vue components follow one-way data flow, that is props down (see official guide) and events up. Props are read-only data, so it's impossible to change props from child components. When props change, child components will be rerendered automatically (props are a reactive data source). Child components can only emit events to their direct parent, so that the parent component may change data, mapped to the child component's props.
```javascript
<template>
  <button @click="$emit('click');">{{ text }}</button>
</template>

<script>
export default {
  name: 'v-btn',
  props: {
    text: String,
  },
};
</script>

<template>
  <v-btn :text="buttonText" @click="handleClick"></v-btn>
</template>

<script>
export default {
  data() {
    return {
      clickCount: 0,
      buttonText: 'initial button text',
    };
  },
  methods: {
    handleClick() {
      this.buttonText = `Button clicked ${++this.clickCount}`;
      console.log('clicked', this.buttonText);
    },
  },
};
</script>
```

20. Patterns. Component Conditional Rendering. Directives (```v-if / v-else / v-else-if / v-show```).

v-if
```javascript
<h1 v-if="true">Render only if v-if condition is true</h1>
```
v-if and v-else
```javascript
<h1 v-if="true">Render only if v-if condition is true</h1>
<h1 v-else>Render only if v-if condition is false</h1>
```
v-else-if
```javascript
<div v-if="type === 'A'">Render only if `type` is equal to `A`</div>
<div v-else-if="type === 'B'">Render only if `type` is equal to `B`</div>
<div v-else-if="type === 'C'">Render only if `type` is equal to `C`</div>
<div v-else>Render if `type` is not `A` or `B` or `C`</div>
```
v-show
```javascript
<h1 v-show="true">
  Always rendered, but it should be visible only if `v-show` conditions is true
</h1>
```
If you want to conditionally render more than one element, you can use directives(```v-if / v-else / v-else-if /v-show```) on a ```<template>``` element. Notice that the ```<template>``` element is not actually rendered into the DOM. It is an invisible wrapper.
```javascript
<template v-if="true">
  <h1>All the elements</h1>
  <p>will be rendered into DOM</p>
  <p>except `template` element</p>
</template>
```

21. Patterns. Component Conditional Rendering.  Render Function or JSX. If you use render functions or JSX in your vue application, you can apply all the techniques, such as the if else and switch case statements and ternary and logical operators.

if else statement
```javascript
export default {
  data() {
    return {
      isTruthy: true,
    };
  },
  render(h) {
    if (this.isTruthy) {
      return <h1>Render value is true</h1>;
    } else {
      return <h1>Render value is false</h1>;
    }
  },
};
```
switch case statement
```javascript
import Info from './Info';
import Warning from './Warning';
import Error from './Error';
import Success from './Success';

export default {
  data() {
    return {
      type: 'error',
    };
  },
  render(h) {
    switch (this.type) {
      case 'info':
        return <Info text={text} />;
      case 'warning':
        return <Warning text={text} />;
      case 'error':
        return <Error text={text} />;
      default:
        return <Success text={text} />;
    }
  },
};
```
or you can use object map to simplify switch case
```javascript
import Info from './Info';
import Warning from './Warning';
import Error from './Error';
import Success from './Success';

const COMPONENT_MAP = {
  info: Info,
  warning: Warning,
  error: Error,
  success: Success,
};

export default {
  data() {
    return {
      type: 'error',
    };
  },
  render(h) {
    const Comp = COMPONENT_MAP[this.type || 'success'];

    return <Comp />;
  },
};
```
ternary operator
```javascript
export default {
  data() {
    return {
      isTruthy: true,
    };
  },
  render(h) {
    return (
      <div>
        {this.isTruthy ? (
          <h1>Render value is true</h1>
        ) : (
          <h1>Render value is false</h1>
        )}
      </div>
    );
  },
};
```
logical operator
```javascript
export default {
  data() {
    return {
      isLoading: true,
    };
  },
  render(h) {
    return <div>{this.isLoading && <h1>Loading ...</h1>}</div>;
  },
};
```

22. Patterns. Dynamic component. Conceptually, the ```<component>``` tag is incredibly simple. It just takes a string (or component definition) :is prop. Vue then looks up the component referenced by that string and renders it in place of the ```<component>``` tag. Don’t let the simplicity fool you though, the number of use-cases it unlocks is remarkable.

Example Usage:
```javascript
<template>
  <component :is="dynamicComponent"></component>
</template>

<script>

// Register another component to render in this one dynamically.
import Vue from 'vue';

Vue.component('some-other-component', {
  template: `<p>Wheee</p>`
});

export default {
  data() {
    return {
      dynamicComponent: `some-other-component`
    }
  }
}
</script>
```

Or simplify things by using just a component definition:

```javascript
<template>
  <component :is="dynamicComponent"></component>
</template>

<script>
export default {
  data() {
    return {
      dynamicComponent: {
        template: `<p>Wheee</p>`
      }
    }
  }
}
</script>
```

Or reactively switch components with computed properties…

```javascript
<template>
  <component :is="dynamicComponent"></component>
</template>

<script>
export default {
  props: {
    value: Boolean
  },

  computed: {
    dynamicComponent() {
      if(value) {
        return 'component-special';
      } else {
        return 'component-default';
      }
    }
  }
}
</script>
```

And, of course, you can render components passed in props or anything else accessible from the Vue instance.

Keep-alive

Right now, any component rendered with ```<component>``` will be destroyed entirely when a different component is rendered in its place, and re-created if it is re-added. This is not always ideal, which is why the ```<keep-alive>``` component was introduced.

If you wish for components rendered with the ```<component>``` tag (or rendered in conditionals) to keep from being destroyed when they’re no longer being rendered, just wrap the ```<component>``` tag in a ```<keep-alive>``` tag like so:

```javascript
<template>
  <div>
    <keep-alive>
      <component :is="dynamicComponent"></component>
    </keep-alive>
  </div>
</template>
```

23. Patterns. Functional component. A functional component is a special SFC, it is basically a component that is stateless (meaning no `script` tag). It only accepts props in order to display data. In order to make a SFC a functional one you add the the functional attribute to the `<template>` tag like this: `<template functional>`

```javascript
fp-component.vue

<template functional>
  <h1>{{ props.title }}</h1>
  <p>{{ props.description }}</p>
</template>
```
```javascript
index.vue

<template>
  <fp-component v-bind="{ title: 'FP Component', description: 'Only takes props' }" />
</template>

<script>
import FPComponent from './fp-component';

export default {
  components: {
    FPComponent
  }
}
</script>
```

The benefits of using a Functional Component over a Stateful Component:
- Faster rendering
- Lighter memory usage

24. Patterns. Renderless Component. A renderless component is basically a component that does not render any HTML to the DOM but inside provides reusable JavaScript logic abstracted into a SFC. A renderless component makes use of the Slots API in order to achieve what we want.

Renderless.vue
```javascript
<script>
export default {
  render() {
    return this.$scopedSlots.default({ name: 'John' });
  }
};
</script>
```

The only job of Renderless.vue is to provide the prop name

App.vue
```javascript
<template>
  <renderless v-slot="{ name }">
    <p>{{ name }}</p>
  </renderless>
</template>
<script>
import Renderless from './Renderless.vue';
export default {
  components: {
    Renderless,
  }
};
</script>
```

The neat thing about using a Renderless Component is that we can seperate our logic from our markup.
 
25. Patterns. Passing Props & Listeners. Sometimes, you may want to pass props and listeners to a child component without having to declare all props for the child component. You can bind $attrs and $listeners in the child component and set inheritAttrs to false (otherwise both, div and child-component will receive the attributes)

PassingProps.vue
```javascript
<template>
  <div>
    <h1>{{title}}</h1>
    <passing-props-child v-bind="$attrs" v-on="$listeners"></passing-props-child>
  </div>
</template>

<script>
import PassingPropsChild from './PassingPropsChild';
export default {
  components: {
    PassingPropsChild,
  },
  inheritAttrs: false,
  props: {
    title: {
      type: String,
      default: 'Hello, Vue!',
    },
  },
};
</script>
```

From the parent component, you can do this:

PassedProps.vue

```javascript
<template>
  <p class="demo">
    <passing-props
      title="This is from <passing-props />"
      childPropA="This is from <passing-props-child />"
      @click="handleClickPassingPropsChildComponent"
    >
    </passing-props>
  </p>
</template>

<script>
import PassingProps from './PassingProps';

export default {
  components: {
    PassingProps,
  },
  methods: {
    handleClickPassingPropsChildComponent() {
      console.log('This event comes from `<passing-props-child />`');
      alert('This event comes from `<passing-props-child />`');
    },
  },
};
</script>
```

26. Patterns. Hight order components. Higher Order Component is a function which takes as an argument a component and returns newly created component. Returned component is usually augmented with features provided by HOC (Higher Order Component). Higher Order Component is not a piece of software which can be grabbed and installed, it’s a technique which may be helpful in writing reusable and maintainable code.

Step 1. Components Setup. The artificial application I created for the purpose of this article consists of two components: `CommentsList` and `BlogPost`. Both components are rendered inside `App` component, the main component of the application.
App.vue
```javascript
<template>
  <div id="app">
    <blog-post/>
    <comments-list/>
  </div>
</template>

<script>
import CommentsList from './components/CommentsList'
import BlogPost from './components/BlogPost'export default {
  name: 'app',
  components: {
    'blog-post': BlogPost,
    'comments-list': CommentsList
  }
}
</script>
```

`CommentsList` component displays list of comments fetched from the external data source. Additionally, on mounted hook an event listener is added which listens to changes in the data source and updates comment’s list accordingly. On hook beforeDestroy the listener is removed.

components/CommentsList.vue
```javascript
<template>
    <ul>
        <li
          v-for="(comment, index) in comments"
          :key="index"
        >{{comment}}</li>
    </ul>
</template>

<script>
    import DataSource from '../store/source.js'

    export default {
        name: 'comments-list',
        data() {
            return {
                comments: DataSource.getComments()
            }
        },
        methods: {
            handleChange() {
                this.comments = DataSource.getComments()
            }
        },
        mounted() {
            DataSource.addChangeListener(this.handleChange)
        },
        beforeDestroy() {
            DataSource.removeChangeListener(this.handleChange)
        }
    }
</script>
```

`BlogPost` component displays a blog post content. Similarly as CommentsList , it fetches its data from the external data source and updates the post’s content on every change in external data source.
components/BlogPost.vue
```javascript
<template>
    <div>
        {{blogPost}}
    </div>
</template>

<script>
    import DataSource from '../store/source.js'

    export default {
        data() {
            return {
                blogPost: DataSource.getBlogPost()
            }
        },
        methods: {
            handleChange() {
                this.blogPost = DataSource.getBlogPost()
            }
        },
        mounted() {
            DataSource.addChangeListener(this.handleChange)
        },
        beforeDestroy() {
            DataSource.removeChangeListener(this.handleChange)
        }
    }
</script>
```

`BlogPost` and `CommentsList` components share four functionalities:
- Fetch the data from the external data source (in this case from DataSource ) inside mounted hook
- Update the data on every update in the external data source
- Add the change listener to the data source
- Remove the change listener from the data source

In order to avoid code repetitions the shared logic between `BlogPost` and `CommentsList` can be extracted to Higher Order Component.

Step 2. Higher Order Component. In this step I’ll move the duplicated code to Higher Order Component called withSubscription. Higher Order Component is a function that takes a component as an argument and returns a new component. Let’s write it in Vue

hocs/withSubscription.js
```javascript
import Vue from 'vue'
import CommentsList from '~/components/CommentsList.vue'const withSubscription = (component) => {
  return Vue.component('withSubscription', {
    render(createElement) {
      return createElement(component)
    } 
  }
}const CommentsListWithSubscription = withSubscription(CommentsList)
```

At this point Higher Order Component doesn’t do much. It simply takes a component and creates a new component that renders the passed component. Next step is to implement shared logic in it. I need to add mounted , beforeDestroy hooks and handleChange method which will be called upon every update.
hocs/withSubscription.js
```javascript
import DataSource from '../store/source'
import Vue from 'vue'

const withSubscription = (component) => {
    return Vue.component('withSubscription', {
        render(createElement) {
            return createElement(component)
        },
        methods: {
            handleChange() {
            }
        },
        mounted() {
            DataSource.addChangeListener(this.handleChange)
        },
        beforeDestroy() {
            DataSource.removeChangeListener(this.handleChange)
        }
    })
}
export default withSubscription
```

Now the new component returned by the Higher Order Component has required lifecycle hooks. The `handleChange` method is left empty. Both components havehandleChange method, however, this method has slightly different implementation in each component. Higher Order Component can accept more than one argument. Currently, withSubscription accepts only component as an argument. In order to call custom logic inside `handleChange` second argument is needed. The second argument is the method which should be called on every data source change. Passed method returns updated data which has to be passed down to the newly created component as a prop.

hocs/withSubscription.js
```javascript
import DataSource from '../store/source'
import Vue from 'vue'
const withSubscription = (component, selectData) => {return Vue.component('withSubscription', {
        render(createElement, context) {
            return createElement(component, {
               props: {
                  content: this.fetchedData
               }
            })
        },
        data() {
            return {
                fetchedData: null
            }
        },
        methods: {
            handleChange() {
                this.fetchedData = selectData(DataSource)
            }
        },
        mounted() {
            DataSource.addChangeListener(this.handleChange)
        },
        beforeDestroy() {
            DataSource.removeChangeListener(this.handleChange)
        }
    })
}
export default withSubscription
```

The usage of Higher Order Component inside `App.vue` looks as follows
App.vue
```javascript
<template>
  <div id="app">
    <blog-post/>
    <comments-list/>
  </div>
</template>

<script>
import CommentsList from './components/CommentsList'
import BlogPost from './components/BlogPost'
import withSubscription from './hocs/withSubscription'const BlogPostWithSubscription = withSubscription(BlogPost, (DataSource) => {
  return DataSource.getBlogPost()
})
const CommentsListWithSubscription = withSubscription(CommentsList, (DataSource) => DataSource.getComments())

export default {
  name: 'app',
  components: {
    'blog-post': BlogPostWithSubscription,
    'comments-list': CommentsListWithSubscription
  }
}
</script>
```

And here is the code of `BlogPost` and `CommentsList`
components/BlogPost.vue
```javascript
<template>
    <div>
        {{content}}
    </div>
</template>
<script>
    export default {
        props: ['content']
    }
</script>
```
components/CommentsList.vue
```javascript
<template>
    <ul>
        <li v-for="(comment, index) in content" :key="index">{{comment}}</li>
    </ul>
</template>

<script>
    export default {
        name: 'comments-list',
        props: ['content']
    }
</script>
```

It all looks very nice but there is one missing piece. What if I need to pass a blog post ID to BlogPost ? Or what if I need to emit an event from BlogPost to App component? With current implementation it won’t work.

Step 3. Handling Props and Events in Higher Order Component. Firstly, let’s change a bit the implementation of the getBlogPost method in DataSource . It needs to take the post’s id as an argument in order to know which post to fetch and return. Since the actual getBlogPost call happens inside `BlogPost` component it makes sense to pass as a prop the desired blog post id and make use of it when the getBlogPost method is called. In order to do so I need to do two things: pass theid prop from the App component down to the BlogPost component and change the function I pass to the Higher Order Component so it accepts the second argument — the props it has to pass down further to the `BlogPost`.
App.vue
```javascript
<template>
  <div id="app">
    <blog-post :id="1"/>
  </div>
</template>
<script>
import BlogPost from './components/BlogPost'
import withSubscription from './hocs/withSubscription'const BlogPostWithSubscription = withSubscription(BlogPost, (DataSource, props) => {
  return DataSource.getBlogPost(props.id)
})export default {
  name: 'app',
  components: {
    'blog-post': BlogPostWithSubscription
  }
}
</script>
```
components/BlogPost.vue
```javascript
<template>
    <div>
        {{content}}
    </div>
</template>
<script>
    export default {
        props: ['content', 'id']
    }
</script>
```
Now, I need to update the Higher Order Component so it knows how to pass down the props to the component it renders.

hocs/withSubscription.js
```javascript
import DataSource from '../store/source'
import Vue from 'vue'
const withSubscription = (component, selectData) => {
    const originalProps = component.props || [];

    return Vue.component('withSubscription', {
        render(createElement) {
            return createElement(component, {
                props: {
                    ...originalProps,
                    content: this.fetchedData
                }
            })
        },
        props: [...originalProps],
        data() {
            return {
                fetchedData: null
            }
        },
        methods: {
            handleChange() {
                this.fetchedData = selectData(DataSource, this.$props)
            }
        },
        mounted() {
            DataSource.addChangeListener(this.handleChange)
        },
        beforeDestroy() {
            DataSource.removeChangeListener(this.handleChange)
        }
    })
}
export default withSubscription
```

First thing which is added to HOC is reading the original props from the component it renders. Those properties are saved inside originalProps constant. In Vue a component has to to define which props it accepts. The withSubscription has to accept the same props as the component it renders in order to be able to pass them down to it later. That’s done with this line of code:

```javascript
return Vue.component('withSubscription', {
    ...
    props: [...originalProps], # <= this line
    ...
}
```

The last piece which was updated is the selectData function call inside thehandleChange method. The second argument was added — the props of the Higher Order Component — `this.$props`. The `$props` property is a Vue Component instance property available since Vue version 2.2. I covered passing down the props to a child component, the last piece missing is events emission from a child component up to its parent. Let’s add event listener inside App.vue component and something that emits an event inside `BlogPost.vue`.

App.vue
```javascript
<template>
  <div id="app">
    <blog-post :id="1" @click="onClick"/>
  </div>
</template>---# components/BlogPost.vue<template>
    <div>
        <button @click="$emit('click', 'aloha')">CLICK ME!</button>
        {{data}}
    </div>
</template><script>
    export default {
        props: ['data', 'id']
    }
</script>
```

It’s important to remember that I don’t render BlogPost directly inside App , there is a middleman — the withSubscription HOC. In order to pass down event listeners to rendered component I need to add one line of code inside the Higher Order Component.

hocs/withSubscription.js

```javascript
return Vue.component('withSubscription', {
    ...
    on: {...this.$listeners} # <= this line,
})
```
Similarly as with `this.$props`, there is an instance property `$listener` which contains the parent-scope v-on event listeners.

27. Provider/Consumer. The Provider/Consumer pattern is very simple, it aims at separating stateful logic from the presentation. We need two components to create this pattern.

Provider.vue

```javascript
<template>
  <div>
    <slot v-bind="{ state, actions }" />
  </div>
</template>

<script>
export default {
  computed: {
    state() {
      return {
        label: 'button',
      };
    },
    actions() {
      return {
        click: this.click,
      };
    },
  },
  methods: {
    click() {
      console.log('Clicked');
    },
  },
}
</script>
```

Provider.vue is responsible for containing all the stateful logic, we are successfully separating it from the presentation. We are making use of the Slots API as a data provider.

Consumer.vue
```javascript
<template functional>
  <div>
    <p>{{ props.state.label }}</p>
    <button @click="props.actions.click">CLICK</button>
  </div>
</template>
```

`Consumer.vue` is responsible for containing the presentation, note that we are using a Functional Component.

App.vue

```javascript
<template>
  <provider v-slot="{ state, actions }">
    <consumer v-bind="{ state, actions }" />
  </provider>
</template>
<script>
import Provider from './Provider.vue';
import Consumer from './Consumer.vue';
export default {
  components: {
    Provider,
    Consumer,
  },
};
</script>
```

This pattern provides a neat way of allowing us to compose clean and decoupled components. 

28. Patterns. Dependency injection. Vue supports provide/inject mechanism to provide object into all its descendants, regardless of how deep the component hierarchy is, as long as they are in the same parent chain. Notice that provide and inject bindings are not reactive, unless you pass down an observed object.

```javascript
<parent-component>
  <child-component>
    <grand-child-component></grand-child-component>
  </child-component>
</parent-component>
```
With the above example component hierarchy, in order to derive data from parent-component, you should pass down data(object) as props to child-component and grand-child-component. However, if parent-component provide data(object), grand-child-component can just define inject provided object from parent-component.

Provide/Inject. You can also use vue-property-decorator's @Provide, @Inject

ThemeProvider.vue
```javascript
<script>
export default {
  provide: {
    theme: {
      primaryColor: '#3eaf7c',
      secondaryColor: '#1FA2FF'
    },
  },
  render(h) {
    return this.$slots.default[0];
  },
};
</script>
```

ThemeButton.vue
```javascript
<template>
  <button class="btn" :style="{ color: '#fff', backgroundColor: (primary && theme.primaryColor) || (secondary && theme.secondaryColor)  }">
    <slot></slot>
  </button>
</template>
<script>
export default {
  inject: {
    theme: {
      default: {},
    },
  },
  props: {
    primary: {
      type: Boolean,
      default: false,
    },
    secondary: {
      type: Boolean,
      default: false,
    },
  },
};
</script>
```

```javascript
<theme-provider>
  <p class="demo">
    <button class="btn">Normal Button</button>
    <theme-button secondary>Themed Button</theme-button>
  </p>
</theme-provider>
```