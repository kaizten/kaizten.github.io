# Tests: Enumerate

- [Tests: Enumerate](#tests-enumerate)
  - [`fromString()`](#fromstring)
  - [\`indexOf()\`\`](#indexof)
  - [`isValid()`](#isvalid)
  - [`random()`](#random)
  - [`valueOf()`](#valueof)

Given an enumerate `<Enum>` defined in `<enum>.ts`, there must be a file `<enum->tests.ts` located in folder test of the TypeScript component. This file should contain at least the tests described below depending on the methods defined in the enumerate. The following list uses the example provided [here](https://github.com/kaizten/kaizten-base/blob/main/java/example_enumerate.md) as reference to illustrate the tests.

## `fromString()`

* **Test name:** `fromString()`
* **Issues to check:**
  * An instance of the enumerate can be obtained from a valid `String` constant.
  * An `IllegalArgumentException` is thrown when the enumerate has no constant with the specified name.
  * An `IllegalArgumentException` is thrown when a `null` object is used as argument.
* **Example:**
  ```ts
  describe('ExitCode Enum', () => {
    test('fromString() - should return enum instance from valid string', () => {
      const value = 'SUCCESS';
      const exitCode = ExitCode.fromString(value);
      expect(exitCode).toBe(ExitCode.SUCCESS);
    });

    test('fromString() - should throw error for invalid string', () => {
      expect(() => ExitCode.fromString('INVALID_CODE')).toThrow('IllegalArgumentException');
    });

    test('fromString() - should throw error for null value', () => {
      expect(() => ExitCode.fromString(null as any)).toThrow('IllegalArgumentException');
    });
  });
  ```

## `indexOf()``

* **Test name:** `fromString()`
* **Issues to check:**
  * An instance of the enumerate can be obtained from a valid `String` constant.
  * An `IllegalArgumentException` is thrown when the enumerate has no constant with the specified name.
  * An `IllegalArgumentException` is thrown when a `null` object is used as argument.
* **Example:**
  ```ts
  test('indexOf() - should return index of enum constant', () => {
    const value = 'SUCCESS';
    const index = ExitCode.indexOf(value);
    expect(index).toBeGreaterThanOrEqual(0);
  });

  test('indexOf() - should throw error for invalid string', () => {
    expect(() => ExitCode.indexOf('INVALID_CODE')).toThrow('IllegalArgumentException');
  });

  test('indexOf() - should throw error for null value', () => {
    expect(() => ExitCode.indexOf(null as any)).toThrow('IllegalArgumentException');
  });
  ```

## `isValid()`

  ```ts
  test('isValid() - should return true for valid enum string', () => {
    const value = 'SUCCESS';
    expect(ExitCode.isValid(value)).toBe(true);
  });

  test('isValid() - should return false for null value', () => {
    expect(ExitCode.isValid(null as any)).toBe(false);
  });

  test('isValid() - should return false for invalid string', () => {
    expect(ExitCode.isValid('INVALID_CODE')).toBe(false);
  });
  ```

## `random()`

  ```ts
  test('random() - should return a valid enum constant', () => {
    const exitCode = ExitCode.random();
    expect(exitCode).not.toBeNull();
    expect(Object.values(ExitCode)).toContain(exitCode);
  });
  ```

## `valueOf()`

  ```ts
  test('valueOf() - should throw error for invalid value', () => {
    expect(() => ExitCode.valueOf('INVALID_CODE')).toThrow('IllegalArgumentException');
  });

  test('valueOf() - should return enum instance from valid value', () => {
    const exitCode = ExitCode.SUCCESS;
    const obtainedExitCode = ExitCode.valueOf('SUCCESS');
    expect(obtainedExitCode).toBe(exitCode);
  });
  ```