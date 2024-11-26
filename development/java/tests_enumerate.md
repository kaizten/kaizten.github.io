# Tests: Enumerate

- [`fromString()`](#fromstring)
- [`indexOf()`](#indexof)
- [`isValid()`](#isvalid)
  - [Valid value](#valid-value)
  - [Not valid value](#not-valid-value)
- [`random()`](#random)
- [`valueOf()`](#valueof)

Given an enumerate `<Enum>` defined in `<Enum>.java`, there must be a file `<Enum>Tests.java` located in folder `test` of the Java component. This file should contain at least the tests described below depending on the methods defined in the enumerate. The following list uses the example provided [here](https://github.com/kaizten/kaizten-base/blob/main/java/example_enumerate.md) as reference to illustrate the tests.

## `fromString()`

* **Test name:** `fromString()`
* **Issues to check:**
  * An instance of the enumerate can be obtained from a valid `String` constant.
  * An `IllegalArgumentException` is thrown when the enumerate has no constant with the specified name.
  * An `IllegalArgumentException` is thrown when a `null` object is used as argument.
* **Example:**
```java
    @Test
    public void fromString() {
        final String value = KaiztenExitCode.random().name();
        KaiztenExitCode exitCode = KaiztenExitCode.fromString(value);
        assertTrue(exitCode instanceof KaiztenExitCode);
        assertThrows(
                IllegalArgumentException.class,
                () -> KaiztenExitCode.fromString(KaiztenString.random(10)));
        assertThrows(
                IllegalArgumentException.class,
                () -> KaiztenExitCode.fromString(null));
    }
```

## `indexOf()`

* **Test name:** `indexOf()`
* **Issues to check:**
  * The index of the enumerate instance can be obtained from a valid `String` constant.
  * An `IllegalArgumentException` is thrown when the enumerate has no constant with the specified name.
  * An `IllegalArgumentException` is thrown when a `null` object is used as argument.
* **Example:**
```java
    @Test
    public void indexOf() {
        final String value = KaiztenExitCode.random().name();
        int index = KaiztenExitCode.indexOf(value);
        assertTrue(0 <= index && index < KaiztenExitCode.values().length);
        assertThrows(
                IllegalArgumentException.class,
                () -> KaiztenExitCode.indexOf(KaiztenString.random(10)));
        assertThrows(
                IllegalArgumentException.class,
                () -> KaiztenExitCode.indexOf(null));
    }
```

## `isValid()`

### Valid value

* **Test name:** `isValid_validValue()`
* **Issues to check:**
  * A valid `String` is identified as an enumerate constant.
* **Example:**
```java
    @Test
    public void isValid_validValue() {
        final String value = KaiztenExitCode.random().name();
        assertTrue(KaiztenExitCode.isValid(value));
    }
```

### Not valid value

* **Test name:** `isValid_notValidValue()`
* **Issues to check:**
  * A `null` value is not identified as an enumerate constant.
  * A not valid `String` is not identified as an enumerate constant.
* **Example:**
```java
    @Test
    public void isValid_notValidValue() {
        assertFalse(KaiztenExitCode.isValid(null));
        final String value = KaiztenString.randomAlphabetic(10);
        assertFalse(KaiztenExitCode.isValid(value));
    }
```

## `random()`

* **Test name:** `random()`
* **Issues to check:**
  * A not `null` value is returned by the `random()` method.
  * An instance of the enumerate is returned by the `random()` method.
* **Example:**
```java
    @Test
    public void random() {
        KaiztenExitCode exitCode = KaiztenExitCode.random();
        assertNotNull(exitCode);
        assertTrue(exitCode instanceof KaiztenExitCode);
    }
```

## `valueOf()`

* **Test name:** `valueOf()`
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when the enumerate has no constant with the specified value.
  * An instance of the enumerate is obtained from its value.
* **Example:**
```java
    @Test
    public void valueOf() {
        assertThrows(
                IllegalArgumentException.class,
                () -> KaiztenExitCode.valueOf(-12345));
        KaiztenExitCode exitCode = KaiztenExitCode.random();                
        KaiztenExitCode obtainExitCode = KaiztenExitCode.valueOf(exitCode.code);
        assertTrue(obtainExitCode instanceof KaiztenExitCode);
    }
```