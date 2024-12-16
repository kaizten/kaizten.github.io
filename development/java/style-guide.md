# Java. Style Guide

- [Java. Style Guide](#java-style-guide)

* The source code, documentation (including source code, OpenAPI, etc.), images, and any other assets must be written in English. Additionally, the names of files must be also written in English.
* Each attribute of a value object or entity must be documented using multi-line comments (`/** */`). Additionally, optional and computed attributes must be indicated in the corresponding comments as follows:
  * `It is an optional attribute.`
  * `It is a computed attribute.`
* Defined tests must be available for each value object.
* Defined tests must be available for each enum.
* OpenAPI documentation must be available for each REST controller.
* `pom.xml` files must have the following features:
  * Tag `name` should be defined.
  * Tag `description` should be defined.
  * Tag `url` should be defined. Its value must be `https://www.kaizten.com`