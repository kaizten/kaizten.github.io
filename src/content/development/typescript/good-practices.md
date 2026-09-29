# TypeScript. Good Practices

- [TypeScript. Good Practices](#typescript-good-practices)
  - [Coupling and SOLID](#coupling-and-solid)

1. Use meaningful and pronounceable variable names.

    **Bad:**
    ```javascript
    const yyyymmdstr = moment().format("YYYY/MM/DD");
    ```
    **Good:**
    ```javascript
    const currentDate = moment().format("YYYY/MM/DD");
    ```

2. Use the same vocabulary for the same type of variable

    **Bad:**

    ```javascript
    getUserInfo();
    getClientData();
    getCustomerRecord();
    ```

    **Good:**

    ```javascript
    getUser();
    ```

3. Use searchable names. We will read more code than we will ever write. It's important that the code we do write is readable and searchable.

    **Bad:**
    ```javascript
    // What the heck is 86400000 for?
    setTimeout(blastOff, 86400000);
    ```
    **Good:**
    ```javascript
    // Declare them as capitalized named constants.
    const MILLISECONDS_PER_DAY = 60 * 60 * 24 * 1000; //86400000;
    setTimeout(blastOff, MILLISECONDS_PER_DAY);
    ```
4. Use explanatory variables

    **Bad:**
    ```javascript
    const address = "One Infinite Loop, Cupertino 95014";
    const cityZipCodeRegex = /^[^,\\]+[,\\\s]+(.+?)\s*(\d{5})?$/;
    saveCityZipCode(
      address.match(cityZipCodeRegex)[1],
      address.match(cityZipCodeRegex)[2]
    );
    ```
    **Good:**
    ```javascript
    const address = "One Infinite Loop, Cupertino 95014";
    const cityZipCodeRegex = /^[^,\\]+[,\\\s]+(.+?)\s*(\d{5})?$/;
    const [_, city, zipCode] = address.match(cityZipCodeRegex) || [];
    saveCityZipCode(city, zipCode);
    ```
5. Explicit is better than implicit

    **Bad:**
    ```javascript
    const locations = ["Austin", "New York", "San Francisco"];
    locations.forEach(l => {
      doStuff();
      doSomeOtherStuff();
      // ...
      // ...
      // ...
      // Wait, what is `l` for again?
      dispatch(l);
    });
    ```
    **Good:**
    ```javascript
    const locations = ["Austin", "New York", "San Francisco"];
    locations.forEach(location => {
      doStuff();
      doSomeOtherStuff();
      // ...
      // ...
      // ...
      dispatch(location);
    });
    ```
6. If your class/object name tells you something, don't repeat that in your variable name

    **Bad:**
    ```javascript
    const Car = {
      carMake: "Honda",
      carModel: "Accord",
      carColor: "Blue"
    };
    function paintCar(car, color) {
      car.carColor = color;
    }
    ```
    **Good:**
    ```javascript
    const Car = {
      make: "Honda",
      model: "Accord",
      color: "Blue"
    };
    function paintCar(car, color) {
      car.color = color;
    }
    ```
7. Function arguments (3 or fewer ideally)

    **Bad:**
    ```javascript
    function createMenu(title, body, buttonText, cancellable) {
      // ...
    }
    createMenu("Foo", "Bar", "Baz", true);

    ```
    **Good:**
    ```javascript
    function createMenu({ title, body, buttonText, cancellable }) {
      // ...
    }
    createMenu({
      title: "Foo",
      body: "Bar",
      buttonText: "Baz",
      cancellable: true
    });
    ```
8.  Functions should do one thing

    **Bad:**
    ```javascript
    function emailClients(clients) {
      clients.forEach(client => {
        const clientRecord = database.lookup(client);
        if (clientRecord.isActive()) {
          email(client);
        }
      });
    }
    ```
    **Good:**
    ```javascript
    function emailActiveClients(clients) {
      clients.filter(isActiveClient).forEach(email);
    }
    function isActiveClient(client) {
      const clientRecord = database.lookup(client);
      return clientRecord.isActive();
    }
    ```
9.  Function names should say what they do

    **Bad:**
    ```javascript
    function addToDate(date, month) {
      // ...
    }
    const date = new Date();
    // It's hard to tell from the function name what is added
    addToDate(date, 1);
    ```
    **Good:**
    ```javascript
    function addMonthToDate(month, date) {
      // ...
    }
    const date = new Date();
    addMonthToDate(1, date);
    ```
10. Remove duplicate code

    **Bad:**
    ```javascript
    function showDeveloperList(developers) {
      developers.forEach(developer => {
        const expectedSalary = developer.calculateExpectedSalary();
        const experience = developer.getExperience();
        const githubLink = developer.getGithubLink();
        const data = {
          expectedSalary,
          experience,
          githubLink
        };

        render(data);
      });
    }
    function showManagerList(managers) {
      managers.forEach(manager => {
        const expectedSalary = manager.calculateExpectedSalary();
        const experience = manager.getExperience();
        const portfolio = manager.getMBAProjects();
        const data = {
          expectedSalary,
          experience,
          portfolio
        };

        render(data);
      });
    }
    ```
    **Good:**
    ```javascript
    function showEmployeeList(employees) {
      employees.forEach(employee => {
        const expectedSalary = employee.calculateExpectedSalary();
        const experience = employee.getExperience();
        const data = {
          expectedSalary,
          experience
        };
        switch (employee.type) {
          case "manager":
            data.portfolio = employee.getMBAProjects();
            break;
          case "developer":
            data.githubLink = employee.getGithubLink();
            break;
        }
        render(data);
      });
    }
    ```
**13. Don't use flags as function parameters**

**Bad:**
```javascript
function createFile(name, temp) {
  if (temp) {
    fs.create(`./temp/${name}`);
  } else {
    fs.create(name);
  }
}
```
**Good:**
```javascript
function createFile(name) {
  fs.create(name);
}
function createTempFile(name) {
  createFile(`./temp/${name}`);
}
```
**14. Favor functional programming over imperative programming**

**Bad:**
```javascript
const programmerOutput = [
  {
    name: "Uncle Bobby",
    linesOfCode: 500
  },
  {
    name: "Suzie Q",
    linesOfCode: 1500
  },
  {
    name: "Jimmy Gosling",
    linesOfCode: 150
  },
  {
    name: "Gracie Hopper",
    linesOfCode: 1000
  }
];
let totalOutput = 0;
for (let i = 0; i < programmerOutput.length; i++) {
  totalOutput += programmerOutput[i].linesOfCode;
}
```
**Good:**
```javascript
const programmerOutput = [
  {
    name: "Uncle Bobby",
    linesOfCode: 500
  },
  {
    name: "Suzie Q",
    linesOfCode: 1500
  },
  {
    name: "Jimmy Gosling",
    linesOfCode: 150
  },
  {
    name: "Gracie Hopper",
    linesOfCode: 1000
  }
];
const totalOutput = programmerOutput.reduce(
  (totalLines, output) => totalLines + output.linesOfCode,
  0
);
```
**15. Encapsulate conditionals**

**Bad:**
```javascript
if (fsm.state === "fetching" && isEmpty(listNode)) {
  // ...
}
```
**Good:**
```javascript
function shouldShowSpinner(fsm, listNode) {
  return fsm.state === "fetching" && isEmpty(listNode);
}
if (shouldShowSpinner(fsmInstance, listNodeInstance)) {
  // ...
}
```
**16. Avoid negative conditionals**

**Bad:**
```javascript
function isDOMNodeNotPresent(node) {
  // ...
}
if (!isDOMNodeNotPresent(node)) {
  // ...
}
```
**Good:**
```javascript
function isDOMNodePresent(node) {
  // ...
}
if (isDOMNodePresent(node)) {
  // ...
}
```
**17. Remove dead code**

**Bad:**
```javascript
function oldRequestModule(url) {
  // ...
}
function newRequestModule(url) {
  // ...
}
const req = newRequestModule;
inventoryTracker("apples", req, "www.inventory-awesome.io");
```
**Good:**
```javascript
function newRequestModule(url) {
  // ...
}
const req = newRequestModule;
inventoryTracker("apples", req, "www.inventory-awesome.io");
```

**18. Use correct data type annotation (avoid ‘any’)**

**19. Use ‘let’ instead of ‘var’.** The let statement is used to declare a local variable in TypeScript. It's similar to the var keyword, but it has some restrictions in scoping compared to the var keyword. A variable declared in a block with let is only available for use within that block. The var keyword cannot be block-scoped, which means it can be accessed outside a particular block (represented by {}) but not outside of the function it’s defined in. You can redeclare and update var variables. It's a best practice to avoid using the var keyword.

**20. Use ‘const’ for constants**

**21. Use tuples for fixed length arrays**

**Bad:**
```javascript
let marks: number[] = [1, 2, 3];
marks = []; // success
marks = [1]; // success
marks = [1, 2, 3, 4, 5]; // success
```
**Good:**
```javascript
let marks:[number, number] = [1, 2]; // tuple of 2 number values
marks = [10, 20]; // success
marks = [1]; // syntax error
marks = [1, 2, 3, 4, 5] // syntax error
```

**22. Use access modifiers for class members.** TS comes with access modifiers for properties of a class, while classes are always public. You can create public, protected or private properties.

```javascript
class Employee {
  protected name: string;
  private salary: number;
  
  constructor(name: string, salary: number) {
    this.name = name;
    this.salary = salary
  }

  public getSalary(){
    return salary
  }
```
Here, you cannot access the salary unless you use the getSalary method.
```javascript
class Developer extends Employee{  viewDetails(){
    console.log(this.salary); // error: property 'name' is private
    console.log(this.getSalary()); // success
  }
}
```
But you can access the name through a sub class.
```javascript
class Developer extends Employee{
  viewDetails(){
    console.log(this.name);
  }
}
```

**23. Avoid unnecessary comments**

**24. Use enums.** You can use enums to define a set of named constants and define standards that can be reused in your code base. We recommend that you export your enums one time at the global level, and then let other classes import and use the enums. Assume that you want to create a set of possible actions to capture the events in your code base. TypeScript provides both numeric and string-based enums. The following example uses an enum.
```javascript
enum EventType {
    Create,
    Delete,
    Update
}
class InfraEvent {
    constructor(event: EventType) {
        if (event === EventType.Create) {
            // Call for other function
            console.log(`Event Captured :${event}`);
        }
    }
}

let eventSource: EventType = EventType.Create;
const eventExample = new InfraEvent(eventSource)
```

**25. Use interfaces.** An interface is a contract for the class. If you create a contract, then your users must comply with the contract. In the following example, an interface is used to standardize the props and ensure that callers provide the expected parameter when using this class.
```javascript
import { Stack, App } from "aws-cdk-lib";
import { Construct } from "constructs";

interface BucketProps {
    name: string;
    region: string;
    encryption: boolean;

}

class S3Bucket extends Stack {
    constructor(scope: Construct, props: BucketProps) {
        super(scope);
        console.log(props.name);

    }
}
const app = App();
const myS3Bucket = new S3Bucket(app, {
    name: "amzn-s3-demo-bucket",
    region: "us-east-1",
    encryption: false
})
```
Some properties can only be modified when an object is first created. You can specify this by putting readonly before the name of the property, as the following example shows.
```javascript
interface Position {
    readonly latitude: number;
    readonly longitute: number;
}
```

**26. Extend interfaces.** Extending interfaces reduces duplication, because you don't have to copy the properties between interfaces. Also, the reader of your code can easily understand the relationships in your application.
```javascript
 interface BaseInterface{
    name: string;
  }
  interface EncryptedVolume extends BaseInterface{
      keyName: string;
  }
  interface UnencryptedVolume extends BaseInterface {
      tags: string[];
  }
```

**27. Avoid empty interfaces.** We recommend that you avoid empty interfaces due to the potential risks they create. In the following example, there's an empty interface called BucketProps. The myS3Bucket1 and myS3Bucket2 objects are both valid, but they follow different standards because the interface doesn’t enforce any contracts. The following code will compile and print the properties but this introduces inconsistency in your application.

```javascript
interface BucketProps {}
class S3Bucket implements BucketProps {
    constructor(props: BucketProps){
        console.log(props);
    }
}
const myS3Bucket1 = new S3Bucket({
    name: "amzn-s3-demo-bucket",
    region: "us-east-1",
    encryption: false,
});
const myS3Bucket2 = new S3Bucket({
    name: "amzn-s3-demo-bucket",
});
```

**28. Use destructuring on properties.** Destructuring, introduced in ECMAScript 6 (ES6), is a JavaScript feature that gives you the ability to extract multiple pieces of data from an array or object and assign them to their own variables.
```javascript
const object = {
    objname: "obj",
    scope: "this",
};

const oName = object.objname;
const oScop = object.scope;

const { objname, scope } = object;
```

**29. Use factories.** In an Abstract Factory pattern, an interface is responsible for creating a factory of related objects without explicitly specifying their classes. For example, you can create a Lambda factory for creating Lambda functions. Instead of creating a new Lambda function within your construct, you're delegating the creation process to the factory. For more information on this design pattern, see Abstract Factory in TypeScript in the Refactoring.Guru documentation (https://refactoring.guru/design-patterns/abstract-factory/typescript/example).

**30. Use utility types** Utility types in TypeScript are predefined type functions that perform transformations and operations on existing types. This helps you create new types based on existing types. For example, you can change or extract properties, make properties optional or required, or create immutable versions of types. By using utility types, you can define more precise types and catch potential errors at compile time.

***Partial<Type>***

Partial marks all members of an input type Type as optional. This utility returns a type that represents all subsets of a given type. The following is an example of Partial.
```javascript
interface Dog {
  name: string;
  age: number;
  breed: string;
  weight: number;
}

let partialDog: Partial<Dog> = {};
```

***Required<Type>***

Required does the opposite of Partial. It makes all members of an input type Type non-optional (in other words, required). The following is an example of Required.
```javascript
interface Dog {
  name: string;
  age: number;
  breed: string;
  weight?: number;
}

let dog: Required<Dog> = { 
  name: "scruffy",
  age: 5,
  breed: "labrador",
  weight 55 // "Required" forces weight to be defined
};
```

**31. Error handling. Don't ignore caught errors**

**Bad:**
```javascript
try {
  functionThatMightThrow();
} catch (error) {
  console.log(error);
}
```
**Good:**
```javascript
try {
  functionThatMightThrow();
} catch (error) {
  // One option (more noisy than console.log):
  console.error(error);
  // Another option:
  notifyUserOfError(error);
  // Another option:
  reportErrorToService(error);
  // OR do all three!
}
```
**32. Error handling. Don't ignore rejected promises**

**Bad:**
```javascript
getdata()
  .then(data => {
    functionThatMightThrow(data);
  })
  .catch(error => {
    console.log(error);
  });
```
**Good:**
```javascript
getdata()
  .then(data => {
    functionThatMightThrow(data);
  })
  .catch(error => {
    // One option (more noisy than console.log):
    console.error(error);
    // Another option:
    notifyUserOfError(error);
    // Another option:
    reportErrorToService(error);
    // OR do all three!
  });
```

**33. Use ```===``` Instead of ```==```**

**34. Use Template Literals.** Strings that we create with double or single quotes have a lot of limitations. You might want to replace some of your strings with template literals to make working with them a lot easier. Template literals are created using the backtick character (`), and they offer many advantages. You can put expressions inside them or create multi-line strings.
```javascript
let person = 'Monty';
let fruits = 'apples';
let activity = 'playing games';
let day = 'Monday';
let sentence1 = person + ' will be eating ' + fruits + ' and ' + activity + ' on ' + day + '.';
console.log(sentence1);
// Output: Monty will be eating apples and playing games on Monday.
let sentence2 = `${person} will be eating ${fruits} and ${activity} on ${day}.`;
console.log(sentence2);
// Output: Monty will be eating apples and playing games on Monday.
```
As you can see, we did not have to constantly move in and out of our template literal, as we had to with a regular string literal created with single or double quotes. This reduces the chances of any typing-related errors and helps us write cleaner code.

**35. Use the Spread Operator.** Have you ever been in a situation where you wanted to pass all the items of an array as individual elements to some other function or you wanted to insert all the values from one array into another? The spread operator (...) allows us to do exactly that. Here is an example:
```javascript
let people = ["adam", "monty", "andrew"]
let more_people = ["james", "jack", ...people, "sajal"]
console.log(more_people)
// Output: Array(6) [ "james", "jack", "adam", "monty", "andrew", "sajal" ]
```

**36. Be Careful With for ... in Statements.** When looping through items in an object, you might find that you retrieve method functions or other inherited properties as well. In order to work around this, always wrap your code in an if statement which filters with hasOwnProperty.
```javascript
for (key in object) {
   if (object.hasOwnProperty(key) {
      ...then do something...
   }
}
```

**37. Quickly Assign Variable Values With Destructuring.** We've already learned about the spread operator in JavaScript earlier in the article. Destructuring is somewhat similar in the sense that it also unpacks values stored inside arrays. The difference is that we can assign these unpacked values to unique variables. The syntax is similar to creating an array using the [] shorthand. However, this time the brackets go on the left side of the assignment operator. Here is an example:
```javascript
let [person, fruit, , day] = ['Monty', 'apple', 'reading', 'tomorrow'];
var sentence = `${person} will eat an ${fruit} ${day}.`;
console.log(sentence);
// Output: Monty will eat an apple tomorrow.
```

**38. Use Arrow Functions.** They come with a slew of benefits. To begin with, they make the functional elements of JavaScript more appealing to the eye and easier to write. Take a look at how we would implement a filter without arrow functions:
```javascript
const nums = [1,2,3,4,5,6,7,8];
const even_nums = nums.filter( function (num) { return num%2 == 0; } )
```
Here, the callback function we pass to the filter returns true for any even number. Arrow functions make this much more readable and concise though: 
```javascript
const nums = [1,2,3,4,5,6,7,8];
const even_nums = nums.filter(num => num%2 == 0)
```
Another notable benefit of arrow functions is that they do not define a scope, instead being within the parent scope. This prevents many of the issues that can occur when using the this keyword. There are no bindings for this in the arrow functions. this has the same value inside the arrow function as it does in the parent scope. However, this means arrow functions can't be used as constructors or methods.

**39. Run Promises in Parallel.** It is preferable to run your asynchronous tasks in parallel as it can make your app much faster and more responsive. If your tasks don't rely on the results from one another, simply wrap them in Promise.all and run them in parallel. It is really great to combine async / await and Promise.all, but you must be careful to think through what parts happen sequentially and what parts happen in parallel. Here's an example of fetching the text from an array of URLs concurrently with Promise.all and await.

```javascript
const urls = ["https://en.wikipedia.org/wiki/Canada", "https://en.wikipedia.org/wiki/Nigeria", "https://en.wikipedia.org/wiki/Vietnam"]
const countryInfo = await Promise.all(urls.map( async url =>
  const resp = await fetch(url);
  return resp.text();
}));
```
This will map the URLs in the array to an array of async functions. Each async function will fetch the text from the URL and return it. Since this is an async function, it is actually a Promise. Promise.all will wait on those promises and return the array of text that they loaded when they are all complete.

## Coupling and SOLID

**1. Loose coupling vs tight coupling.** Loose coupling, where you have minimal interdependence between components or modules of a system, is a sign of a well-structured application. When high-level modules depend on abstractions, it promotes loose coupling, making it easier to change the implementation of the low-level modules without affecting the high-level modules. On the other hand, a tightly coupled system, where components are dependent on one another, is not ideal.

**Bad:**
```javascript
class UserService {
  repository = new UserRepository();  // Tight coupling

  save(user: User) {
    this.repository.save(user);
  }
}
class UserRepository {
  save(user: User) {
    // Save the user to the database
  }
}
function saveUser(user: User) {
  const repository = new UserRepository();  // Tight coupling
  repository.save(user);
}
class UserRepository {
  save(user: User) {
    // Save the user to the database
  }
}
```
**Good:**
```javascript
// High-level module
class UserService {
  constructor(private repository: UserRepository) {}

  save(user: User) {
    this.repository.save(user);
  }
}
// Abstraction (interface)
interface UserRepository {
  save(user: User): void;
}
// Implementation of the abstraction
class UserRepositoryImpl implements UserRepository {
  save(user: User) {
    // Save the user to the database
  }
}
// The UserService depends on the abstraction, not the implementation
const userService = new UserService(new UserRepositoryImpl());
// Example 2: Using dependency injection to achieve loose coupling
class UserService {
  constructor(private repository: UserRepository) {}

  save(user: User) {
    this.repository.save(user);
  }
}
class UserRepository {
  save(user: User) {
    // Save the user to the database
  }
}
// The UserRepository is injected into the UserService
const userService = new UserService(new UserRepository());
```
**2. SOLID. Single Responsibility Principle (SRP)**

**Bad:**
```javascript
class UserSettings {
  constructor(user) {
    this.user = user;
  }
  changeSettings(settings) {
    if (this.verifyCredentials()) {
      // ...
    }
  }
  verifyCredentials() {
    // ...
  }
}
```
**Good:**
```javascript
class UserAuth {
  constructor(user) {
    this.user = user;
  }
  verifyCredentials() {
    // ...
  }
}
class UserSettings {
  constructor(user) {
    this.user = user;
    this.auth = new UserAuth(user);
  }
  changeSettings(settings) {
    if (this.auth.verifyCredentials()) {
      // ...
    }
  }
}
```
**3. SOLID. Open/Closed Principle (OCP)**, software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification. you should allow users to
add new functionalities without changing existing code.

**Bad:**
```javascript
class AjaxAdapter extends Adapter {
  constructor() {
    super();
    this.name = "ajaxAdapter";
  }
}
class NodeAdapter extends Adapter {
  constructor() {
    super();
    this.name = "nodeAdapter";
  }
}
class HttpRequester {
  constructor(adapter) {
    this.adapter = adapter;
  }
  fetch(url) {
    if (this.adapter.name === "ajaxAdapter") {
      return makeAjaxCall(url).then(response => {
        // transform response and return
      });
    } else if (this.adapter.name === "nodeAdapter") {
      return makeHttpCall(url).then(response => {
        // transform response and return
      });
    }
  }
}
function makeAjaxCall(url) {
  // request and return promise
}
function makeHttpCall(url) {
  // request and return promise
}
```
**Good:**
```javascript
class AjaxAdapter extends Adapter {
  constructor() {
    super();
    this.name = "ajaxAdapter";
  }
  request(url) {
    // request and return promise
  }
}
class NodeAdapter extends Adapter {
  constructor() {
    super();
    this.name = "nodeAdapter";
  }
  request(url) {
    // request and return promise
  }
}
class HttpRequester {
  constructor(adapter) {
    this.adapter = adapter;
  }
  fetch(url) {
    return this.adapter.request(url).then(response => {
      // transform response and return
    });
  }
}
```
**4. SOLID. Liskov Substitution Principle (LSP).** If S is a subtype of T, then objects of type T may be replaced with objects of type S (i.e., objects of type S may substitute objects of type T) without altering any of the desirable properties of that program (correctness, task performed, etc.). If you have a parent class and a child class, then the base class and child class can be used interchangeably without getting incorrect results. For example, mathematically, a square is a rectangle, but if you model it using the "is-a" relationship via inheritance, you quickly get into trouble.

**Bad:**
```javascript
class Rectangle {
  constructor() {
    this.width = 0;
    this.height = 0;
  }
  setColor(color) {
    // ...
  }
  render(area) {
    // ...
  }
  setWidth(width) {
    this.width = width;
  }
  setHeight(height) {
    this.height = height;
  }
  getArea() {
    return this.width * this.height;
  }
}
class Square extends Rectangle {
  setWidth(width) {
    this.width = width;
    this.height = width;
  }

  setHeight(height) {
    this.width = height;
    this.height = height;
  }
}
function renderLargeRectangles(rectangles) {
  rectangles.forEach(rectangle => {
    rectangle.setWidth(4);
    rectangle.setHeight(5);
    const area = rectangle.getArea(); // BAD: Returns 25 for Square. Should be 20.
    rectangle.render(area);
  });
}
const rectangles = [new Rectangle(), new Rectangle(), new Square()];
renderLargeRectangles(rectangles);
```
**Good:**
```javascript
class Shape {
  setColor(color) {
    // ...
  }
  render(area) {
    // ...
  }
}
class Rectangle extends Shape {
  constructor(width, height) {
    super();
    this.width = width;
    this.height = height;
  }
  getArea() {
    return this.width * this.height;
  }
}
class Square extends Shape {
  constructor(length) {
    super();
    this.length = length;
  }
  getArea() {
    return this.length * this.length;
  }
}
function renderLargeShapes(shapes) {
  shapes.forEach(shape => {
    const area = shape.getArea();
    shape.render(area);
  });
}
const shapes = [new Rectangle(4, 5), new Rectangle(4, 5), new Square(5)];
renderLargeShapes(shapes);
```
**5. SOLID. Interface Segregation Principle (ISP).** Clients should not be forced to depend upon interfaces that they do not use. In other words, it’s better to have smaller, focused interfaces rather than large, monolithic ones.

**Bad:**
```javascript
interface Shape {
    area(): number;
    perimeter(): number;
}
class Rectangle implements Shape {
    constructor(private width: number, private height: number) {}
    area(): number {
        return this.width * this.height;
    }
    perimeter(): number {
        return 2 * (this.width + this.height);
    }
}
class Circle implements Shape {
    constructor(private radius: number) {}
    area(): number {
        return Math.PI * this.radius * this.radius;
    }
    perimeter(): number {
        return 2 * Math.PI * this.radius;
    }
}
class SquareAreaCalculator {
    calculate(square: Shape): number {
        return square.area();
    }
}
```
**Good:**
```javascript
interface Area {
    area(): number;
}
interface Perimeter {
    perimeter(): number;
}
class Rectangle implements Area, Perimeter {
    constructor(private width: number, private height: number) {}
    area(): number {
        return this.width * this.height;
    }
    perimeter(): number {
        return 2 * (this.width + this.height);
    }
}
class Circle implements Area, Perimeter {
    constructor(private radius: number) {}
    area(): number {
        return Math.PI * this.radius * this.radius;
    }
    perimeter(): number {
        return 2 * Math.PI * this.radius;
    }
}
class SquareAreaCalculator {
    calculate(square: Area): number {
        return square.area();
    }
}
```

**Bad:**
```javascript
interface MediaPlayer {
    playAudio(): void;
    playVideo(): void;
    showLyrics(): void;
}
```
**Good:**
```javascript
interface AudioPlayer {
    playAudio(): void;
}
interface VideoPlayer {
    playVideo(): void;
}
interface LyricsDisplay {
    showLyrics(): void;
}
```
**6. SOLID. Dependency Inversion Principle (DIP).** High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend upon details. Details should depend on abstractions. The dependency inversion principle is a design principle that states that high-level modules should depend on abstractions rather than concrete implementations. This helps decouple the high-level and low-level modules, making it easier to change the low-level ones without affecting the high-level ones.

```javascript
// High-level module
class ShoppingCartService {
  constructor(private paymentProcessor: PaymentProcessor) {}
  checkout(cart: ShoppingCart) {
    return this.paymentProcessor.processPayment(cart);
  }
}
// Low-level module
class PaymentProcessor {
  processPayment(cart: ShoppingCart) {
    // Process the payment for the items in the shopping cart
  }
}
// Abstraction
interface PaymentProcessor {
  processPayment(cart: ShoppingCart): boolean;
}
// Implementation of the abstraction
class StripePaymentProcessor implements PaymentProcessor {
  processPayment(cart: ShoppingCart): boolean {
    // Use the Stripe API to process the payment for the items in the shopping cart
  }
}
// Now the ShoppingCartService depends on the abstraction, not the implementation
const shoppingCartService = new ShoppingCartService(new StripePaymentProcessor());
```
In this example, the ```ShoppingCartService``` class is a high-level module that provides a more abstract interface for checking out shopping carts. It depends on the ```PaymentProcessor``` class, a low-level module, to process the payment for the items in the shopping cart. However, rather than depending on the concrete ```PaymentProcessor``` class, it depends on the ```PaymentProcessor``` interface, which is an abstraction. This decouples the ```ShoppingCartService``` from the ```PaymentProcessor``` implementation and allows you to easily change the implementation of the ```PaymentProcessor``` without affecting the ```ShoppingCartService```.