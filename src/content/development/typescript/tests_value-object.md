# Tests: Value object

- [Tests: Value object](#tests-value-object)
  - [Constructor](#constructor)
    - [Valid Value](#valid-value)
    - [Not defined value](#not-defined-value)
    - [Empty value](#empty-value)
    - [Minimum length value](#minimum-length-value)
    - [Maximum length value](#maximum-length-value)
    - [Wrong Format Value](#wrong-format-value)
  - [Getters](#getters)
    - [Collection as Attribute](#collection-as-attribute)
  - [Setters](#setters)
    - [Required attributes](#required-attributes)
  - [Optional attributes](#optional-attributes)
  - [`clone()`](#clone)
  - [`equals()`](#equals)
  - [`hashCode()`](#hashcode)
  - [`toString()`](#tostring)

For a given value object <ValueObject> defined in <ValueObject>.ts in TypeScript, there should be a corresponding test file <ValueObject>.spec.ts in the tests directory. This file will contain the tests as described below, depending on the properties and their types within the value object.

## Constructor

Each constructor of the class should have at least one test for every validation criterion.

### Valid Value

* **Test name:** `constructor_validValue`
* **Issues to check:**
  * A valid value should equal a value object with that value.
* **Example:**
    ```ts
    it('constructor_validValue', () => {
        let type = AnalysisType.random();
        let date = new Date();
        let person = Person.random();
        let larva = Larva.random();
        let analysis = new Analysis(type, date, person, larva);
        expect(analysis.type).toEqual(type);
        expect(analysis.date).toEqual(date);
        expect(analysis.person).toEqual(person);
        expect(analysis.larva).toEqual(larva);
        expect(analysis.slide).toBeUndefined();
        expect(analysis.images).toEqual([]);
        expect(analysis.results).toEqual([]);
    });
    ```

### Not defined value

* **Test name:** `constructor_notDefinedValue_<ATTRIBUTE>`
* **Issues to check:**
  * A `TypeError` should be thrown when creating a value object without a value.
  * The message of the error thrown should be `<ValueObject>.ERROR_<ATTRIBUTE>_NOT_DEFINED`.
* **Example:**
    ```ts
    it('constructor_notDefinedValue_type', () => {
        let type = null;
        let date = new Date();
        let person = Person.random();
        let larva = Larva.random();
        expect(() => new Analysis(type, date, person, larva)).toThrow(TypeError);
        expect(() => new Analysis(type, date, person, larva)).toThrow(Analysis.ERROR_TYPE_NOT_DEFINED);
    });
    ```

### Empty value

* **Test name:** `constructor_emptyValue`
* **Issues to check:**
    * A `Error` should be thrown when creating a value object with an empty value.
* **Example:**
    ```ts
    it('constructor_emptyValue', () => {
        expect(() => new TrapName("")).toThrow(Error);
        expect(() => new TrapName("")).toThrow(TrapName.ERROR_EMPTY);
    });
    ```

### Minimum length value

* **Test name:** `constructor_minLengthValue`
* **Issues to check:**
  * An Error should be thrown when a value object is created with a value shorter than the minimum length.
* **Example:**
    ```ts
    it('constructor_minLengthValue', () => {
        let value = "short";
        expect(() => new TrapName(value)).toThrow(Error);
        expect(() => new TrapName(value)).toThrow(TrapName.ERROR_MIN_LENGTH);
    });
    ```

### Maximum length value

* **Test name:** `constructor_maxLengthValue`
* **Issues to check:**
  * An Error should be thrown when a value object is created with a value longer than the maximum length.
* **Example:**
    ```ts
    it('constructor_maxLengthValue', () => {
        let value = "a".repeat(TrapName.MAX_LENGTH + 1);
        expect(() => new TrapName(value)).toThrow(Error);
        expect(() => new TrapName(value)).toThrow(TrapName.ERROR_MAX_LENGTH);
    });
    ```

### Wrong Format Value

* **Test name:** `constructor_wrongFormatValue`
* **Issues to check:**
    * An Error should be thrown when creating a value object from a value with the wrong format.
* **Example:**
    ```ts
    it('constructor_wrongFormatValue', () => {
        let value = "incorrect format value";
        expect(() => new TrapName(value)).toThrow(Error);
        expect(() => new TrapName(value)).toThrow(TrapName.ERROR_WRONG_FORMAT);
    });
    ```

## Getters

### Collection as Attribute

* **Test name:** `getterCollection_<ATTRIBUTE>`
* **Issues to check:**
    * An error should be thrown when modifying the collection obtained from the object.
* **Example:***
    ```ts
    it('getterCollection_images', () => {
        let original = Analysis.random();
        let images = original.images;
        expect(() => images.push(new File())).toThrow();
    });
    ```

## Setters

### Required attributes

* **Test name:** `setter_<ATTRIBUTE>()`
* **Issues to check:**
  * A new object is obtained when setting the attribute.
  * An `Error` is thrown when setting an `undefined` or `null` value for the attribute.
* **Example:**
    ```ts
    test('setter_date', () => {
        const original = Analysis.random();
        const newDate = new Date();
        const newObject = original.setDate(newDate);
        expect(newObject).not.toBe(original);
        expect(() => original.setDate(null)).toThrowError('Date cannot be null');
    });
    ```

## Optional attributes

* **Test name:** `setter_<ATTRIBUTE>()`
* **Issues to check:**
    * A new object is obtained when setting the attribute.
* **Example:**
    ```ts
    test('setter_slide', () => {
        const original = Analysis.random();
        const newSlide = Slide.random();
        const newObject = original.setSlide(newSlide);
        expect(newObject).not.toBe(original);
    });
    ```

## `clone()`

* **Test name:** `cloneMethod()`
* **Issues to check:**
    * clone method creates a copy of the object by copying all its attributes.
* **Example:**
    ```ts
    test('cloneMethod', () => {
        const original = Comment.random();
        const cloned = original.clone();
        expect(cloned.message).toEqual(original.message);
        expect(cloned.date).toEqual(original.date);
    });
    ```

## `equals()`

* **Test name:** `equalsMethod()`
* **Issues to check:**
    * equals method returns true when the same object is referenced.
    * equals method returns false when compared with null.
    * equals method returns false when compared with an object of a different class.
    * equals method works correctly, verifying that different objects with the same values are considered equal.
* **Example:**
    ```ts
    test('equalsMethod', () => {
        const trapName1 = TrapName.random();
        const trapName2 = new TrapName(trapName1.value);
        const trapName3 = TrapName.random();
        expect(trapName1.equals(trapName1)).toBe(true);
        expect(trapName1.equals(null)).toBe(false);
        expect(trapName1.equals({} as any)).toBe(false); // Using 'as any' to simulate other class object
        expect(trapName1.equals(trapName2)).toBe(true);
        expect(trapName1.equals(trapName3)).toBe(false);
    });
    ```

## `hashCode()`

* **Test name:** `hashCodeMethod()`
* **Issues to check:**
  * `hash` method of the value object works correctly, verifying the hash codes of different objects are considered equal if their values are the same.
* **Example:**
    ```ts
    test('hashCodeMethod', () => {
        const trapName1 = TrapName.random();
        const trapName2 = new TrapName(trapName1.value);
        const trapName3 = TrapName.random();
        expect(trapName1.hash()).toEqual(trapName2.hash());
        expect(trapName1.hash()).not.toEqual(trapName3.hash());
    });
    ```

## `toString()`

* **Test name:** `toStringMethod()`
* **Issues to check:**
    * toString method returns the value stored by the value object.
* **Example:**
    ```ts
    test('toStringMethod', () => {
        const value = TrapName.generateValidValue();
        expect(new TrapName(value).toString()).toEqual(value);
    });
    ```