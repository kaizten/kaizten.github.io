# Tests: Value object

- [Tests: Value object](#tests-value-object)
  - [Constructor](#constructor)
    - [Valid value](#valid-value)
    - [Not defined value](#not-defined-value)
    - [Empty value](#empty-value)
    - [Minimum length value](#minimum-length-value)
    - [Maximum length value](#maximum-length-value)
    - [Wrong format value](#wrong-format-value)
  - [Getters](#getters)
    - [Collection as attribute](#collection-as-attribute)
  - [Setters](#setters)
    - [Required attributes](#required-attributes)
    - [Optional attributes](#optional-attributes)
  - [`clone()`](#clone)
  - [`equals()`](#equals)
  - [`hashCode()`](#hashcode)
  - [`toString()`](#tostring)

Given a value object `<ValueObject>` defined in `<ValueObject>.java`, there must be a file `<ValueObject>Tests.java` located in folder `test` of the Java component. This file should contain at least the tests described below depending on the properties and their types defined in the value object.

## Constructor

There must be at least one test for each validation criterion used in each constructor of the class. 

### Valid value

* **Test name:** `constructor_validValue()`
* **Issues to check:**
  * A valid value is equal to a value object with that value.
  * Default values are set to all the attributes not required in the constructor. For example, `null` values in optional attributes not set in the constructor.
  * Attribute values are set for computed attributes. For example, attribute to store the creation date of the object.
* **Example:**
```java
    @Test
    void constructor_validValue() {
        AnalysisType type = AnalysisType.random();
        LocalDate date = LocalDate.now();
        Person person = Person.random();
        Larva larva = Larva.random();
        Analysis analysis = new Analysis(type, date, person, larva);
        assertEquals(type, analysis.getType());
        assertEquals(date, analysis.getDate());
        assertEquals(person, analysis.getPerson());
        assertEquals(larva, analysis.getLarva());
        assertTrue(analysis.getSlide().isEmpty());
        assertTrue(analysis.getImages().isEmpty());
        assertTrue(analysis.getResults().isEmpty());
    }
```

### Not defined value

* **Test name:** `constructor_notDefinedValue_<ATTRIBUTE>()` 
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when creating an object with `ATTRIBUTE = null`, where `ATTRIBUTE` is a required attribute.
  * The message of the exception thrown is `<ValueObject>.ERROR_<ATTRIBUTE>_NOT_DEFINED`.
* **Example:**
```java
    @Test
    void constructor_notDefinedValue_type() {
        AnalysisType type = null;
        LocalDate date = LocalDate.now();
        Person person = Person.random();
        Larva larva = Larva.random();
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new Analysis(type, date, person, larva));
        assertEquals(Analysis.ERROR_TYPE_NOT_DEFINED, exception.getMessage());
    }
```

### Empty value

* **Test name:** `constructor_emptyValue()`
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when creating an object with an empty value. This is only posible when the value is not a basic type.
  * The message of the exception thrown is `<ValueObject>.ERROR_EMPTY`.
* **Example:**
```java
    @Test
    void constructor_emptyValue() {
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new TrapName(""));
        assertEquals(TrapName.ERROR_EMPTY, exception.getMessage());
    }
```

### Minimum length value

* **Test name:** `constructor_minLengthValue()`
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when creating an object with a value with a length shorter than the minimum length set by the value object.
  * The message of the exception thrown is `<ValueObject>.ERROR_MIN_LENGTH`.
* **Example:**
```java
    @Test
    void constructor_minLengthValue() {
        String value = KaiztenString.randomAlphabetic(TrapName.MIN_LENGTH - 1);
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new TrapName(value));
        assertEquals(TrapName.ERROR_MIN_LENGTH, exception.getMessage());
    }
```

### Maximum length value

* **Test name:** `constructor_maxLengthValue`
* **Issues to check:** 
  * An `IllegalArgumentException` is thrown when creating an object with a value with a length larger than the maximum length set by the value object.
  * The message of the exception thrown is `<ValueObject>.ERROR_MAX_LENGTH`.
* **Example:**
```java
    @Test
    void constructor_maxLengthValue() {
        final String value = KaiztenString.randomAlphabetic(TrapName.MAX_LENGTH + 1);
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new TrapName(value));
        assertEquals(TrapName.ERROR_MAX_LENGTH, exception.getMessage());
    }
``` 

### Wrong format value

* **Test name:** `constructor_wrongFormatValue` 
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when creating an object from a value with wrong format. For example, a given regular expression not fulfilled.
  * The message of the exception thrown is `<ValueObject>.ERROR_WRONG_FORMAT`.
* **Example:**
```java
    @Test
    void constructor_wrongFormatValue() {
        final String value = TrapName.generateInvalidValue();
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new TrapName(value));
        assertEquals(TrapName.ERROR_WRONG_FORMAT, exception.getMessage());
    }
```

## Getters

### Collection as attribute

* **Test name:** `getterCollection_<ATTRIBUTE>()`
* **Issues to check:**
  * An `UnsupportedOperationException` is thrown when modifying the collection obtained from the object.
* **Example:**
```java
    @Test
    void getterCollection_images() {
        Analysis original = Analysis.random();
        List<File> images = original.getImages();
        assertThrows(
                UnsupportedOperationException.class,
                () -> images.remove(0));
    }
```

## Setters

### Required attributes

* **Test name:** `setter_<ATTRIBUTE>()`
* **Issues to check:**
  * A new object is obtained when setting the attribute.
  * An `IllegalArgumentException` is thrown when setting a `null` value for the attribute.
* **Example:**
```java
    @Test
    void setter_date() {
        Analysis original = Analysis.random();
        LocalDate newDate = LocalDate.now();
        Analysis newObject = original.setDate(newDate);
        assertNotSame(newObject, original);
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> original.setDate(null));
        assertEquals(Analysis.ERROR_DATE_NOT_DEFINED, exception.getMessage());
    }
```

### Optional attributes

* **Test name:** `setter_<ATTRIBUTE>()`
* **Issues to check:**
  * A new object is obtained when setting the value of the attribute.
* **Example:**
```java
    @Test
    void setter_slide() {
        Analysis original = Analysis.random();
        Slide newSlide = Slide.random();
        Analysis newObject = original.setSlide(newSlide);
        assertNotSame(newObject, original);
    }
```

## `clone()`

* **Test name:** `cloneMethod()`
* **Issues to check:**
  * `clone` method creates a copy of the object by copying all its attributes.
* **Example:**
```java
    @Test
    void cloneMethod() {
        Comment original = Comment.random();
        Comment cloned = (Comment) original.clone();
        assertEquals(original.getMessage(), cloned.getMessage());
        assertEquals(original.getDate(), cloned.getDate());
    }
```

## `equals()`

* **Test name:** `equalsMethod()`
* **Issues to check:**
  * `equals` method returns `true` when the same object is used.
  * `equals` method returns `false` when `null` object is used.
  * `equals` method returns `false` when an object of other class is used.
  * `equals` method of the value object works correctly. The test checks different objects are considered as equal if their values are the same.
* **Example:**
```java
    @Test
    void equalsMethod() {
        TrapName trapName1 = TrapName.random();
        TrapName trapName2 = new TrapName(trapName1.getValue());
        TrapName trapName3 = TrapName.random();
        assertEquals(trapName1, trapName1);
        assertNotEquals(trapName1, null);
        assertNotEquals(trapName1, Integer.valueOf(0));
        assertEquals(trapName1, trapName2);
        assertNotEquals(trapName1, trapName3);
    }
```

## `hashCode()`

* **Test name:** `hashCodeMethod()` 
* **Issues to check:** 
  * `hashCode` method of the value object works correctly. The test checks the hash codes of different objects are considered equals if their values are the same.
* **Example:**
```java
    @Test
    void hashCodeMethod() {
        TrapName trapName1 = TrapName.random();
        TrapName trapName2 = new TrapName(trapName1.getValue());
        TrapName trapName3 = TrapName.random();
        assertEquals(trapName1.hashCode(), trapName2.hashCode());
        assertNotEquals(trapName1.hashCode(), trapName3.hashCode());
    }
```

## `toString()`

* **Test name:** `toStringMethod()`
* **Issues to check:** 
  * `toString` method returns the value stored by the object value.
* **Example:**
```java
    @Test
    void toStringMethod() {
        final String value = TrapName.generateValidValue();
        assertEquals(
                value,
                new TrapName(value).toString());
    }
```