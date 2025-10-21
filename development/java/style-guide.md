# Java. Style guide

- [Java. Style guide](#java-style-guide)
  - [Format](#format)
  - [File content](#file-content)
  - [Filenames](#filenames)
  - [Folder names](#folder-names)
  - [Language](#language)
  - [Attributes](#attributes)
  - [Methods](#methods)
  - [Imports](#imports)
  - [`hashCode()`](#hashcode)
  - [`equals()`](#equals)
  - [`toString()`](#tostring)
  - [`pom.xml`](#pomxml)

## Format

* Content of Java files must be formatted using 4 spaces.
* Braces must be used in block statatements (`if-else`, `for`, `while`, etc.).

## File content

* Do not define multiple classes, interfaces, records, etc. in the same file. Instead, use a file for each top-level type.
* Do not define nested types (classes, interfaces, records, etc.).

## Filenames

* Filenames must be written in English.
* The name of each Java file must be in Pascal case. Underscores are not allowed.
* The extension of each Java file must be `.java` (in lowercase).

## Folder names

* Folders must be written in English.
* No uppercase letters are allowed in folders of Java projects.
* No underscore are allowed in folders of Java projects.

## Language

* The source code, documentation (including source code, OpenAPI, etc.), images, and any other assets must be written in English.

## Attributes

* Each attribute of a Java class must be documented by Javadoc.

## Methods

* Each method of a Java class must be documented by Javadoc.

## Imports

* Imports must be sorted alphabetically.

## `hashCode()`

* `hashCode()` method must be annotated with `@Override`.
* If `equals()` is overriden, `hashCode()` must be also overriden.

## `equals()`

* `equals()` method must be annotated with `@Override`.
* Argument of `equals()` method must be called `otherObject`.

## `toString()`

* `toString()` method must be annotated with `@Override`.
* `String.format` must be used in `toString()` method.

## `pom.xml`

* `pom.xml` files must have the following features:
  * Tag `name` should be defined.
  * Tag `description` should be defined.
  * Tag `url` should be defined. Its value must be `https://www.kaizten.com`