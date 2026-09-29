# TypeScript. SOLID principles

- [TypeScript. SOLID principles](#typescript-solid-principles)

1. Loose coupling vs tight coupling. Loose coupling, where you have minimal interdependence between components or modules of a system, is a sign of a well-structured application. When high-level modules depend on abstractions, it promotes loose coupling, making it easier to change the implementation of the low-level modules without affecting the high-level modules. On the other hand, a tightly coupled system, where components are dependent on one another, is not ideal.

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

2. Single Responsibility Principle (SRP)

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
3. Open/Closed Principle (OCP), software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification. you should allow users to
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

5. Interface Segregation Principle (ISP). Clients should not be forced to depend upon interfaces that they do not use. In other words, it’s better to have smaller, focused interfaces rather than large, monolithic ones.

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

6. SOLID. Dependency Inversion Principle (DIP). High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend upon details. Details should depend on abstractions. The dependency inversion principle is a design principle that states that high-level modules should depend on abstractions rather than concrete implementations. This helps decouple the high-level and low-level modules, making it easier to change the low-level ones without affecting the high-level ones.

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