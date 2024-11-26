# Tests: Entity

- [Constructor](#constructor)
  - [Valid value](#valid-value)
  - [Not defined value](#not-defined-value)
- [`clone()`](#clone)
- [`equals()`](#equals)
- [`hashCode()`](#hashcode)
- [State modifier](#state-modifier)
- [`toString()`](#tostring)

Given an entity `Entity` defined in `Entity.ts`, there must be a file `EntityTests.ts` located in the `test` folder of the TypeScript component.
This file should contain at least the tests described below depending on the methods defined in the entity.

## Constructor

* **Test name:** `constructor_validValue()`
* **Issues to check:**
  * Attribute values in the entity's state are equal to those set using the constructor.
  * Default values are assigned to all the attributes that are not required in the constructor. For example, `undefined` values are assigned to optional attributes not set in the constructor.
* **Example:**
```ts
import { Entity } from "../src/Entity";

describe('Entity Constructor', () => {
  test('constructor_validValue', () => {
    const entity = new Entity({ requiredAttribute: 'value' });
    expect(entity.requiredAttribute).toBe('value');
    expect(entity.optionalAttribute).toBeUndefined();
  });
  test('constructor_notDefinedValue', () => {
    expect(() => new Entity({})).toThrowError('requiredAttribute is required');
  });
});
```

// `clone()`
describe('Entity Clone', () => {
  test('clone_createsDeepCopy', () => {
    // Issues to check:
    // 1. Cloned entity should have the same attribute values as the original.
    // 2. Changing the cloned entity should not affect the original entity.
    // Example:
    const entity = new Entity({ requiredAttribute: 'value' });
    const clonedEntity = entity.clone();
    expect(clonedEntity.requiredAttribute).toBe(entity.requiredAttribute);
    clonedEntity.requiredAttribute = 'newValue';
    expect(entity.requiredAttribute).toBe('value');
  });
});

// `equals()`
describe('Entity Equals', () => {
  test('equals_identicalEntities', () => {
    // Issues to check:
    // 1. Two entities with the same attribute values should be considered equal.
    // Example:
    const entity1 = new Entity({ requiredAttribute: 'value' });
    const entity2 = new Entity({ requiredAttribute: 'value' });
    expect(entity1.equals(entity2)).toBe(true);
  });

  test('equals_differentEntities', () => {
    // Issues to check:
    // 1. Two entities with different attribute values should not be considered equal.
    // Example:
    const entity1 = new Entity({ requiredAttribute: 'value1' });
    const entity2 = new Entity({ requiredAttribute: 'value2' });
    expect(entity1.equals(entity2)).toBe(false);
  });
});

// `hashCode()`
describe('Entity HashCode', () => {
  test('hashCode_sameAttributes', () => {
    // Issues to check:
    // 1. Entities with the same attribute values should have the same hash code.
    // Example:
    const entity1 = new Entity({ requiredAttribute: 'value' });
    const entity2 = new Entity({ requiredAttribute: 'value' });
    expect(entity1.hashCode()).toBe(entity2.hashCode());
  });
});

// State modifier
describe('Entity State Modifier', () => {
  test('stateModifier_changesStateCorrectly', () => {
    // Issues to check:
    // 1. The state modifier method should correctly modify the entity's state.
    // Example:
    const entity = new Entity({ requiredAttribute: 'value' });
    entity.modifyState('newValue');
    expect(entity.requiredAttribute).toBe('newValue');
  });
});

// `toString()`
describe('Entity ToString', () => {
  test('toString_returnsStringRepresentation', () => {
    // Issues to check:
    // 1. The `toString()` method should return a string representation of the entity.
    // Example:
    const entity = new Entity({ requiredAttribute: 'value' });
    expect(entity.toString()).toBe('Entity: { requiredAttribute: value }');
  });
});