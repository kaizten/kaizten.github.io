# Tests: Entity

- [Tests: Entity](#tests-entity)
  - [Constructor](#constructor)
    - [Right](#right)
    - [Undefined required attribute](#undefined-required-attribute)
  - [Copy constructor](#copy-constructor)
    - [Valid value](#valid-value)
    - [Not defined value](#not-defined-value)
  - [`clone()`](#clone)
  - [`equals()`](#equals)
  - [`hashCode()`](#hashcode)
  - [State modifier](#state-modifier)
  - [`toString()`](#tostring)

Given an entity `<Entity>` defined in `<Entity>.java`, there must be a file `<Entity>Tests.java` located in folder `test` of the Java component. This file should contain at least the tests described below depending on the methods defined in the entity.

## Constructor

There must be at least one test for each validation criterion used in each constructor of the class. 

### Right

* **Test name:** `constructor_right()`
* **Issues to check:**
  * Attribute values in the entity's state are equal to those set using the constructor.
  * Default values are assigned to all the attributes that are not required in the constructor. For example, `null` values are assigned to optional attributes not set in the constructor.
  * Attribute values are set for computed attributes. For example, the identifier of the entity.
* **Example:**
```java
    @Test
    void constructor_right() {
        EntryPointName name = EntryPointName.random();
        Island island = Island.random();
        KaiztenJWTPreferredUsername creator = KaiztenJWTPreferredUsername.random();
        EntryPoint entryPoint = new EntryPoint(name, island, creator);
        // Required attributes:
        assertEquals(name, entryPoint.getName());
        assertEquals(island, entryPoint.getIsland());
        assertEquals(creator, entryPoint.getCreator());
        // Computed attributes:
        assertNotNull(entryPoint.getId());
        assertNotNull(entryPoint.getCreationTimestamp());
        // Optional attributes:
        assertTrue(entryPoint.getDescription().isEmpty());
        assertTrue(entryPoint.getAreas().isEmpty());
        assertTrue(entryPoint.getComments().isEmpty());
    }
```

### Undefined required attribute

* **Test name:** `constructor_<ATTRIBUTE>_undefined()` 
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when creating an object with `ATTRIBUTE = null`, where `ATTRIBUTE` is a required attribute.
  * The message of the exception thrown is `<Entity>.ERROR_<ATTRIBUTE>_UNDEFINED`.
* **Example:**
```java
    @Test
    void constructor_name_undefined() {
        EntryPointName name = null;
        Island island = Island.random();
        KaiztenJWTPreferredUsername creator = KaiztenJWTPreferredUsername.random();
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new EntryPoint(name, island, creator));
        assertEquals(EntryPoint.ERROR_NAME_UNDEFINED, exception.getMessage());
    }
```

## Copy constructor

The following tests must be defined for the copy constructor of the entity. 

### Valid value

* **Test name:** `copyConstructor_right()`
* **Issues to check:**
  * Attribute values of the copy are equal to those in the original entity, but the identifier of the entity.
* **Example:**
```java
@Test
    void copyConstructor_right() {
        EntryPoint original = EntryPoint.random();
        EntryPoint copy = new EntryPoint(original);
        assertNotEquals(original.getId(), copy.getId());
        assertEquals(original.getName(), copy.getName());
        assertEquals(original.getIsland(), copy.getIsland());
        assertEquals(original.getCreator(), copy.getCreator());
        assertEquals(original.getDescription(), copy.getDescription());
        assertEquals(original.getAreas(), copy.getAreas());
        assertEquals(original.getComments(), copy.getComments());
        assertEquals(original.getCreationTimestamp(), copy.getCreationTimestamp());
    }
```

### Not defined value

* **Test name:** `copyConstructor_undefined()` 
* **Issues to check:**
  * An `IllegalArgumentException` is thrown when copying an object with the argument `null`.
  * The message of the exception thrown is `<Entity>.ERROR_<ATTRIBUTE>_UNDEFINED`.
* **Example:**
```java
    @Test
    void copyConstructor_undefined() {
        EntryPoint original = null;
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> new EntryPoint(original));
        assertEquals(EntryPoint.ERROR_ENTRY_POINT_UNDEFINED, exception.getMessage());
    }
```

## `clone()`

* **Test name:** `cloneMethod()`
* **Issues to check:**
  * The object resulting from the `clone` method has a different identifier than the original object.
  * The `clone` method creates a copy of the object by copying all its attributes.
* **Example:**
```java
    @Test
    void cloneMethod() {
        EntryPoint original = EntryPoint.random();
        EntryPoint cloned = (EntryPoint) original.clone();
        assertNotEquals(original.getId(), cloned.getId());
        assertEquals(original.getName(), cloned.getName());
        assertEquals(original.getIsland(), cloned.getIsland());
        assertEquals(original.getCreator(), cloned.getCreator());
        assertEquals(original.getDescription(), cloned.getDescription());
        assertEquals(original.getAreas(), cloned.getAreas());
        assertEquals(original.getComments(), cloned.getComments());
        assertEquals(original.getCreationTimestamp(), cloned.getCreationTimestamp());
    }
```

## `equals()`

* **Test name:** `equalsMethod()`
* **Issues to check:**
  * `equals` method returns `true` when the same object is used because the identifier is the same.
  * `equals` method returns `false` when `null` object is used because they must have different identifiers.
  * `equals` method returns `false` when an object of other class is used.
  * `equals` method of the object works correctly. The test checks different objects are considered as not equal because their identifiers must be different.
* **Example:**
```java
    @Test
    void equalsMethod() {
        EntryPoint entryPoint1 = EntryPoint.random();
        EntryPoint entryPoint2 = new EntryPoint(
            entryPoint1.getName(),
            entryPoint1.getIsland(), 
            entryPoint1.getCreator());
        EntryPoint entryPoint3 = EntryPoint.random();
        assertTrue(entryPoint1.equals(entryPoint1));
        assertFalse(entryPoint1.equals(null));
        assertFalse(entryPoint1.equals(Integer.valueOf(0)));
        assertNotEquals(entryPoint1, entryPoint2);
        assertNotEquals(entryPoint1.getId(), entryPoint2.getId());
        assertNotEquals(entryPoint1, entryPoint3);
        assertNotEquals(entryPoint1.getId(), entryPoint3.getId());
    }
```

## `hashCode()`

* **Test name:** `hashCodeMethod()` 
* **Issues to check:**
  * The hash code of a given object is consistent. That is, `hashCode` returns the same value for a given object.
  * The hash codes of different objects are different.
* **Example:**
```java
    @Test
    void hashCodeMethod() {
        EntryPoint entryPoint1 = EntryPoint.random();
        EntryPoint entryPoint2 = new EntryPoint(entryPoint1.getName(), entryPoint1.getIsland(), entryPoint1.getCreator());
        EntryPoint entryPoint3 = EntryPoint.random();
        assertEquals(entryPoint1.hashCode(), entryPoint1.hashCode());
        assertNotEquals(entryPoint1.hashCode(), entryPoint2.hashCode());
        assertNotEquals(entryPoint1.hashCode(), entryPoint3.hashCode());
    }
```

## State modifier

* **Test name:** `<METHOD>_<CHANGE_IN_STATE>`
* **Issues to check:**
  * The state of the entity keeps the correct value after calling a modifier method. 
  * Exceptions thrown.
  * Returned value.
* **Example:**
```java
    @Test
    void addComment_valid() {
        EntryPoint entryPoint = EntryPoint.random();
        Comment comment = Comment.random();
        entryPoint.addComment(comment);
        assertTrue(entryPoint.hasComments());
        assertEquals(1, entryPoint.getComments().get().size());
        assertEquals(comment, entryPoint.getComments().get().get(0));
    }
```

## `toString()`

* **Test name:** `toStringMethod()`
* **Issues to check:**
  * `toString` method returns a complete representation of of the entity's state. The resulting `String` must follow the structure `<Entity>={ATTRIBUTE1=VALUE,ATTRIBUTE2=VALUE,...}`. `null` values must be shown in optional attributes when not set.
* **Example:**
```java
    @Test
    void toStringMethod() {
        EntryPoint entryPoint = EntryPoint.random();
        String expectedValue = String.format(
                "EntryPoint={id=%s,name=%s,description=%s,island=%s,areas=%s,comments=%s,creationTimestamp=%s,creator=%s}",
                entryPoint.getId(),
                entryPoint.getName(),
                (entryPoint.hasDescription()) ? entryPoint.getDescription().get() : null,
                entryPoint.getIsland(),
                (entryPoint.hasAreas()) ? entryPoint.getAreas().get() : null,
                (entryPoint.hasComments()) ? entryPoint.getComments().get() : null,
                entryPoint.getCreationTimestamp(),
                entryPoint.getCreator());
        assertEquals(
                expectedValue,
                entryPoint.toString());
    }
```