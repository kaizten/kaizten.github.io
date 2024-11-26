# Vue.js

- [Vue.js](#vuejs)
  - [Basics](#basics)
  - [SOLID](#solid)

## Basics

The style guide we follow for the TypeScript programming language is the Google TypeScript style guide. This style guide can be found at the following URL: [Vue.js Style Guide](https://vuejs.org/style-guide/).

Additionally, below we outline basic considerations that all code implemented in a `.vue` file must meet:

**1. Each component or view must have its own .vue file.**

**2. The components used by the views must be 99% within kaizten-vue library.**, meaning the number of files in the components folder should tend to 0, with a few exceptions.

**3. Filenames of Single-File Components should always be PascalCase.**

**4. Folders should always be kebab-case.**

**5. Language tags should always be camelCase.**

**6. For each CRUD (Create, Read, Update, and Delete) operation of any entity** , there must be a corresponding view in Vue whose file should be named using the format `EntityName+OperationName+View.vue` (for instance, `TaskCreateView.vue`, `TaskReadView.vue`, `TaskUpdateView.vue`,...). In other words, there cannot be a view for both creating and updating, or for creating, updating, and reading.

**7. The source code, documentation, images, and any other assets must be written in English.** Additionally, the names of files must also be written in English.

**8. Each attribute of a value object or entity must be documented using multi-line comments.** Additionally, optional and computed attributes must be indicated in the corresponding comments.

**9. Always use inside v-for.** Using the key attribute with the v-for directive helps your application be constant and predictable whenever you want to manipulate the data. This is necessary so that Vue can track your component state as well as have a constant reference to your different elements. An example where keys are extremely useful is when using animations or Vue transitions. Without keys, Vue will just try to make the DOM has efficient as possible. This may mean elements in the v-for may appear out of order or their behavior will be less predictable. If we have a `_unique_` key reference to each element, then we can better predict how exactly our Vue application will handle DOM manipulation.

```javascript
<template>
  <!-- BAD -->
  <div v-for="product in products">{{ product }}</div>

  <!-- GOOD! -->
  <div v-for="product in products" :key="product.id">{{ product }}</div>
</template>
```

**10. Use kebab-case for events.** When it comes to emitting custom events, it’s always best to use kebab-case. This is because in the parent component, that’s the same syntax we use to listen to that event. So for consistency across our components, and to make your code more readable, stick to using kebab-case in both places.

```javascript
this.$emit("close-window");

<template>
<popup-window @close-window='handleEvent()' />
</template>
```

**11. Declare props with camelCase and use kebab-case in templates.** This best practice simply just follows the conventions for each language. In JavaScript, camelCase is the standard and in HTML, it’s kebab-case Therefore, we use them accordingly. Luckily for us, VueJS converts between kebab-case and camelCase for us so we don’t have to worry about anything besides actually declaring them. In JavaScript, camelCase is the standard and in HTML, it’s kebab-case Therefore, we use them accordingly.

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

**12. Data should always return a function.** When declaring component data in the Options API, the data option should always return a function. If it does not, and we just simply return an object, then that data will be shared across all instances of the component.

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

**13. Don’t use v-if with v-for elements.** It’s super tempting to want to use v-if with v-for in order to filter elements of an array.

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

**14. Validate your props with good definitions.** This is arguably the most important best practice to follow. Why is it important? Well. It basically saves future you from current you. When designing a large scale project, it’s easy to forget exactly the exact format, type, and other conventions you used for a prop. And if you’re in a larger dev team, your coworkers aren’t mind-readers so make it clear to them how to use your components! So save everyone the hassle of having to painstakingly trace your component to determine a prop’s formatting and please just write prop validations. Check out this example from the Vue docs.

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

**15. Stay consistent with your directive shorthand.**
Vue developers is to use shorthand for directives. For example,
- @ is short for v-on:
- : is short for v-bind
- \# is short for v-slot
It is great to use these shorthands in your Vue project. But to create some sort of convention across your project, you should either always use them or never use them. This will make your project more cohesive and readable.

**16. Don’t call a method on created AND watch.** A common mistake Vue developers make (or maybe it was just me) is they unnecessarily call a method in created and watch. The thought behind this is that we want to run the watch hook as soon as a component is initialized.

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

**17. Template expressions should only have basic JavaScript expressions.** It’s natural to want to add as much inline functionality in your templates as possible. But this makes our template less declarative and more complex. Meaning that our template just gets extremely cluttered. For this, let’s check out another example from the Vue style guide.Look how confusing it is.

```javascript
<template>
  {{
    fullName
      .split(' ')
      .map(function (word) {
        return word[0].toUpperCase() + word.slice(1)
      })
      .join(' ')
  }}
</template>
```

Basically, we want everything in our template to be intuitive as to what it is displaying. To keep this, we should refactor complex expressions into appropriately named component options. Another benefit of separating out complex expressions is that it means these values can be reused.

```javascript
<template>{{ normalizedFullName }}</template>
<script>
export default {
  // The complex expression has been moved to a computed property
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

**18. Vue Single-File Components (a.k.a. \*.vue files, abbreviated as SFC).** is a special file format that allows us to encapsulate the template, logic, and styling of a Vue component in a single file. Here's an example SFC:

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

**19. Patterns. Component Communication. Props and Events.** Basically, vue components follow one-way data flow, that is props down (See official guide) and events up. Props are read-only data, so it's impossible to change props from child components. When props change, child components will be rerendered automatically (props are a reactive data source). Child components can only emit events to their direct parent, so that the parent component may change data, mapped to the child component's props.
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

**20. Patterns. Component Conditional Rendering. Directives (```v-if / v-else / v-else-if / v-show```).**

**v-if**
```javascript
<h1 v-if="true">Render only if v-if condition is true</h1>
```
**v-if and v-else**
```javascript
<h1 v-if="true">Render only if v-if condition is true</h1>
<h1 v-else>Render only if v-if condition is false</h1>
```
**v-else-if**
```javascript
<div v-if="type === 'A'">Render only if `type` is equal to `A`</div>
<div v-else-if="type === 'B'">Render only if `type` is equal to `B`</div>
<div v-else-if="type === 'C'">Render only if `type` is equal to `C`</div>
<div v-else>Render if `type` is not `A` or `B` or `C`</div>
```
**v-show**
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

**21. Patterns. Component Conditional Rendering.  Render Function or JSX.** If you use render functions or JSX in your vue application, you can apply all the techniques, such as the if else and switch case statements and ternary and logical operators.

**if else statement**
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
**switch case statement**
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
or you can use object map to simplify **switch case**
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
**ternary operator**
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
**logical operator**
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

**22. Patterns. Dynamic component.** Conceptually, the ```<component>``` tag is incredibly simple. It just takes a string (or component definition) :is prop. Vue then looks up the component referenced by that string and renders it in place of the ```<component>``` tag. Don’t let the simplicity fool you though, the number of use-cases it unlocks is remarkable.

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

**Keep-alive**

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

**23. Patterns. Functional component.** A functional component is a special SFC, it is basically a component that is stateless (meaning no `script` tag). It only accepts props in order to display data. In order to make a SFC a functional one you add the the functional attribute to the `<template>` tag like this: `<template functional>`

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

**24. Patterns. Renderless Component.** A renderless component is basically a component that does not render any HTML to the DOM but inside provides reusable JavaScript logic abstracted into a SFC. A renderless component makes use of the Slots API in order to achieve what we want.

**Renderless.vue**
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

**App.vue**
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
 
**25. Patterns. Passing Props & Listeners.** Sometimes, you may want to pass props and listeners to a child component without having to declare all props for the child component. You can bind $attrs and $listeners in the child component and set inheritAttrs to false (otherwise both, div and child-component will receive the attributes)

**PassingProps.vue**
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

**PassedProps.vue**

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

**26. Patterns. Hight order components.** Higher Order Component is a function which takes as an argument a component and returns newly created component. Returned component is usually augmented with features provided by HOC (Higher Order Component). Higher Order Component is not a piece of software which can be grabbed and installed, it’s a technique which may be helpful in writing reusable and maintainable code.

**Step 1. Components Setup.** The artificial application I created for the purpose of this article consists of two components: `CommentsList` and `BlogPost`. Both components are rendered inside `App` component, the main component of the application.
**App.vue**
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

**components/CommentsList.vue**
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
**components/BlogPost.vue**
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

**Step 2. Higher Order Component.** In this step I’ll move the duplicated code to Higher Order Component called withSubscription. Higher Order Component is a function that takes a component as an argument and returns a new component. Let’s write it in Vue

**hocs/withSubscription.js**
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
**hocs/withSubscription.js**
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

**hocs/withSubscription.js**
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
**App.vue**
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
**components/BlogPost.vue**
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
**components/CommentsList.vue**
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

**Step 3. Handling Props and Events in Higher Order Component.** Firstly, let’s change a bit the implementation of the getBlogPost method in DataSource . It needs to take the post’s id as an argument in order to know which post to fetch and return. Since the actual getBlogPost call happens inside `BlogPost` component it makes sense to pass as a prop the desired blog post id and make use of it when the getBlogPost method is called. In order to do so I need to do two things: pass theid prop from the App component down to the BlogPost component and change the function I pass to the Higher Order Component so it accepts the second argument — the props it has to pass down further to the `BlogPost`.
**App.vue**
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
**components/BlogPost.vue**
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

**hocs/withSubscription.js**
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

**App.vue**
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

**hocs/withSubscription.js**

```javascript
return Vue.component('withSubscription', {
    ...
    on: {...this.$listeners} # <= this line,
})
```
Similarly as with `this.$props`, there is an instance property `$listener` which contains the parent-scope v-on event listeners.

**27. Provider/Consumer.** The Provider/Consumer pattern is very simple, it aims at separating stateful logic from the presentation. We need two components to create this pattern.

**Provider.vue**

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

**Consumer.vue**
```javascript
<template functional>
  <div>
    <p>{{ props.state.label }}</p>
    <button @click="props.actions.click">CLICK</button>
  </div>
</template>
```

`Consumer.vue` is responsible for containing the presentation, note that we are using a Functional Component.

**App.vue**

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

**28. Patterns. Dependency injection.** Vue supports provide/inject mechanism to provide object into all its descendants, regardless of how deep the component hierarchy is, as long as they are in the same parent chain. Notice that provide and inject bindings are not reactive, unless you pass down an observed object.

```javascript
<parent-component>
  <child-component>
    <grand-child-component></grand-child-component>
  </child-component>
</parent-component>
```
With the above example component hierarchy, in order to derive data from parent-component, you should pass down data(object) as props to child-component and grand-child-component. However, if parent-component provide data(object), grand-child-component can just define inject provided object from parent-component.

**Provide/Inject.** You can also use vue-property-decorator's @Provide, @Inject

**ThemeProvider.vue**
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

**ThemeButton.vue**
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

## SOLID

SOLID principles are a set of guidelines to write maintainable and scalable code. They are not limited to certain programming languages or technologies and can be applied to any kind of software development, including front-end development.

**29. Single Responsibility Principle (SRP).** It always feels right to write a single class/function that takes up the entire burden of business logic. The problem with this approach is that your code will become unpredictable, the technical term is “not maintainable”. Suppose you have a highly complex class with multiple responsibilities, and you need to make a slight change to one of these functionalities. How are you gonna be able to track the effects of this change throughout the entire behavior of this class? This is where the SRP rule comes into play. If you limit each class to a single responsibility, you no longer have to worry about the consequences of a needed change within that class, as you will have a much easier time understanding the effects of this change in your class.

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

**30. Open/Closed Principle (OCP).** Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification. This principle basically states that you should allow users to add new functionalities without changing existing code. Suppose you have a component that displays a list of items, and you want to add the ability to sort the items. With the Open/Closed Principle in mind, you could extend the component’s behavior without modifying its code by creating a composable that adds the sorting functionality.

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

**31. Liskov Substitution Principle (LSP).** Despite its rather scary name, this principle simply states that objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program. Here is an example of how this principle can be applied to Vue components. In this example, we have a component that displays a form with a submit button (Form.vue):
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

**32. Interface Segregation Principle (ISP).** This principle states that clients should not be forced to depend on methods that they do not use. In other words, it’s better to have smaller, more specific interfaces that are tailored to the needs of each client, rather than one large interface that includes methods that are not relevant to all clients. This helps to reduce the coupling between different parts of a system and can make it easier to maintain and modify the code over time. ISP is one of the key reasons why components are used in Vue (or any other component-based framework). It gives us the ability to break down complex structures into smaller components with simpler behaviors and singular responsibilities. 

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

**33. Dependency Inversion Principle (DIP).** This principle states that high-level modules should not depend on low-level modules, but instead both should depend on abstractions. Abstractions should not depend on details, but details should depend on abstractions. This helps to create loosely coupled and more maintainable code.

A web application normally consists of four parts: database, back-end, API, and front-end. This partitioning of a web application is already an example of DIP. For instance, in the context of DIP, an API defines the contract between two parts of a web application, namely front-end and back-end. Front-end components do not rely on the specific detail of data stored in a database, they simply contact a back-end service via predefined instructions and methods of an API. Then the stored data will be modified accordingly, which means details are depending on abstractions.

Now let’s get back to Vue itself. Committing to the component-based architecture of Vue is already a way of following DIP. We create reusable components to define how the data is going to be displayed to users. Another example is the usage of props in Vue. We use them to pass down data in components. So props themselves are the implementation of DIP, because they act as a contract between two components in order to change the way data is displayed to users. Services in Vue are also a great example of following DIP. Vue components make use of services to access data, maybe modify them upon reception, and finally display them to users.