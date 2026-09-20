# Tests: REST API

- [`DELETE resource/`](#delete-resource)
  - [Not allowed](#not-allowed)
- [`DELETE resource/:id`](#delete-resourceid)
  - [Success](#success)
  - [Not found](#not-found)
  - [Not acceptable](#not-acceptable)
- [`GET resource/`](#get-resource)
  - [Success](#success-1)
  - [Not acceptable](#not-acceptable-1)
  - [Unknown request parameter](#unknown-request-parameter)
  - [Request parameter `page`](#request-parameter-page)
    - [Success](#success-2)
    - [Empty](#empty)
    - [Minimum value](#minimum-value)
    - [Maximum value](#maximum-value)
  - [Request parameter `size`](#request-parameter-size)
    - [Sucess](#sucess)
    - [Empty](#empty-1)
    - [Minimum value](#minimum-value-1)
    - [Maximum value](#maximum-value-1)
  - [Required request parameters](#required-request-parameters)
    - [Success](#success-3)
    - [Not provided](#not-provided)
    - [Not found](#not-found-1)
    - [Out of domain](#out-of-domain)
- [`GET resource/:id`](#get-resourceid)
    - [Success](#success-4)
    - [Not found](#not-found-2)
    - [Not acceptable](#not-acceptable-2)
- [`OPTIONS resource/`](#options-resource)
  - [Success](#success-5)
- [`OPTIONS resource/:id`](#options-resourceid)
  - [Success](#success-6)
- [`PATCH resource/`](#patch-resource)
  - [Not Allowed](#not-allowed-1)
  - [`PATCH resource/:id`](#patch-resourceid)
    - [Not Allowed](#not-allowed-2)
- [`POST resource/`](#post-resource)
  - [Success](#success-7)
  - [Not acceptable](#not-acceptable-3)
  - [Resource not provided](#resource-not-provided)
  - [Requested attribute not defined](#requested-attribute-not-defined)
  - [Attribute repeated](#attribute-repeated)
  - [Requested attribute empty](#requested-attribute-empty)
  - [Attribute with length lower than minimum length](#attribute-with-length-lower-than-minimum-length)
  - [Attribute with length larger than maximum length](#attribute-with-length-larger-than-maximum-length)
  - [Attribute with wrong format](#attribute-with-wrong-format)
  - [Attribute with value lower than minimum value](#attribute-with-value-lower-than-minimum-value)
  - [Attribute with value larger than maximum length](#attribute-with-value-larger-than-maximum-length)
- [`POST resource/:id`](#post-resourceid)
  - [ID provided](#id-provided)
- [`TRACE resource/`](#trace-resource)
  - [Not allowed](#not-allowed-3)


In the source code, there must be a file with the following `<RESOURCE><VERB>Test.java` for each resource and [HTTP verb](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods).

## `DELETE resource/`

### Not allowed

* **Test name:** `delete_methodNotAllowed()`
* **Description:** it checks verb `DELETE` cannot be used.
* **Request:**
  * Verb: `DELETE`
  * Path: `resource/`
  * Headers:
    * `Accept`: `MediaType.APPLICATION_JSON`
    * `Content-Type`: `MediaType.APPLICATION_JSON`
* **Response:**
  * Status: `405`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: `MediaType.APPLICATION_JSON`
  * Body:
    * Content:
      * `status`: `HttpStatus.METHOD_NOT_ALLOWED.value()`
      * `error`: `ApiError.ERROR_METHOD_NOT_ALLOWED`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `ApiError.MESSAGE_DELETE_NOT_SUPPORTED`
    * Check any other property is included in the body

## `DELETE resource/:id`

### Success

* **Test name:** `deleteId_success()`
* **Description:** it deletes the resource.
* **Request:**
  * Verb: `DELETE`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: `MediaType.APPLICATION_JSON`
    * `Content-Type`: `MediaType.APPLICATION_JSON`
* **Response:**
  * Status: `200`
  * Headers:
    * `Content-Type`: `MediaType.APPLICATION_JSON`
  * Body: JSON with the resource deleted

### Not found

* **Test name:** `deleteId_notFound()`
* **Description:** the resource to delete is not found.
* **Request:**
  * Verb: `DELETE`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: `MediaType.APPLICATION_JSON`
    * `Content-Type`: `MediaType.APPLICATION_JSON`
* **Response:**
  * Status: `404`
  * Headers:
    * `Content-Type`: `MediaType.APPLICATION_JSON`
  * Body:
    * Content:
      * `status`: `404`
      * `error`: `ApiError.ERROR_NOT_FOUND`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `ApiError.MESSAGE_NOT_FOUND`
    * Check any other property is included in the body

### Not acceptable

* **Test name:** `deleteId_notAcceptable()`
* **Description:** `Accept` request HTTP header with a value different to `application/json` is not accepted.
* **Request:**
  * Verb: `DELETE`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: `MediaType.APPLICATION_XML`
* **Response:**
  * Status: `406`
  * Headers:
    * `Content-Type`: `MediaType.APPLICATION_JSON`
  * Body:
    * Content:
      * `status`: `406`
      * `error`: `ApiError.ERROR_NOT_ACCEPTABLE`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `ApiError.MESSAGE_NOT_ACCEPTABLE`
    * Check any other property is included in the body

## `GET resource/`

### Success

* Test name: `get_success()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

### Not acceptable

* Test name: `get_notAcceptable()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_XML
* Response:
  * Status: `406`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `406`
      * `error`: ApiError.ERROR_NOT_ACCEPTABLE
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: ApiError.MESSAGE_NOT_ACCEPTABLE
    * Check any other property is included in the body

### Unknown request parameter

It is required to check the endpoint doest not consider unknown request parameters. This means, these parameters are discarded and the result of the request is the same as when these unknown parameters are not provided (see [Success](#success-1)).

* Test name: `get_unknownParameters()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

### Request parameter `page` 

#### Success

It is required to check the endpoint reports the right resources when setting a correct value of request parameter `page`. That is, when the value of `page` is in `[minValueOfPage, maxValueOfPage]`, where `minValueOfPage` and `maxValueOfPage` are defined by the REST API.

* Test name: `get_pageOk()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Request parameters:
    * `page`: Random value in [`PAGE_MIN_VALUE`..`PAGE_MAX_VALUE`]
    * `size`: Random value in [`SIZE_MIN_VALUE`..`SIZE_MAX_VALUE`]
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Empty

It is required to check the endpoint reports resources using the default value of request parameter `page` when no value is set. That is, when `page=` is set in the request, `PAGE_DEFAULT_VALUE` must be used.

* Test name: `get_pageEmpty()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Request parameters:
    * `page`: Empty
    * `size`: Random value in [`SIZE_MIN_VALUE`..`SIZE_MAX_VALUE`]
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Minimum value

It is required to check the endpoint reports resources using the minimum value of request parameter `page` when a lower value than the minimum value is set. That is, `page=value`, where `value < PAGE_MIN_VALUE`. This request must be similar to `page=PAGE_MIN_VALUE`.

* Test name: `get_pageMinimumValue()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: `PAGE_MIN_VALUE + 1`
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: `PAGE_MIN_VALUE`
    * `Total-Count`: Number of resources
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON 
  * Body:
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Maximum value

It is required to check the endpoint reports resources using the maximum value of request parameter `page` when a larger value than the maximum value is set. That is, `page=value`, where `value > PAGE_MAX_VALUE`. This request must be similar to `page=PAGE_MAX_VALUE`.

* Test name: `get_pageMaximumValue()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: `PAGE_MAX_VALUE + 1`
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: `PAGE_MAX_VALUE`
    * `Total-Count`: Number of resources
  * Body:
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

### Request parameter `size` 

#### Sucess

It is required to check the endpoint reports the right resources when setting a correct value of request parameter `size`. That is, when the value of `size` is in `[SIZE_MIN_VALUE, SIZE_MAX_VALUE]`, where `SIZE_MIN_VALUE` and `SIZE_MAX_VALUE` are defined by the REST API.

* Test name: `get_sizeOk()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Empty

It is required to check the endpoint reports resources using the default value of request parameter `size` when no value is set. That is, when `size=` is set in the request.

* Test name: `get_sizeEmpty()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Minimum value

It is required to check the endpoint reports resources using the minimum value of request parameter `size` when a lower value than the minimum value is set. That is, `size=value`, where `size < minValueOfSize`. This request must be similar to `size=minValueOfSize`.

* Test name: `get_sizeMinimumValue()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: `SIZE_MIN_VALUE`
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body:
    * JSON with the resource

#### Maximum value

It is required to check the endpoint reports resources using the minimum value of request parameter `size` when a larger value than the maximum value is set. That is, `size=value`, where `value > maxValueOfSize`. This request must be similar to `size=maxValueOfSize`.

* Test name: `get_sizeMaximumValue()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: `SIZE_MAX_VALUE`
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body:
    * JSON with the resource

### Required request parameters

#### Success

* Test name: `get_requiredRequestParameters_success()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
    * `Pagination-Count`: Number of pages
    * `Pagination-Size`: Size of pages
    * `Pagination-Page`: Number of page provided
    * `Total-Count`: Number of resources
  * Body: 
    * Content:
      * JSON with all the resources.
    * The list is composed of all the resources of the requested types.
    * The number of resources is that expected.
    * Each resource has the required fields.

#### Not provided

* Test name: `get_requiredRequestParameters_notProvided()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
    * Check any other property is included in the body

#### Not found

* Test name: `get_requiredRequestParameters_notFound()`
* Request:
  * Verb: `GET`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `404`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `404`
      * `error`: `"Not found"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Not found"`
    * Check any other property is included in the body

#### Out of domain

There must be a tests checking out of domain values in the request.

* Test name: `get_requiredRequestParameters_outOfDomain()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
    * Check any other property is included in the body

## `GET resource/:id`

#### Success

* Test name: `getId_success()`
* Request:
  * Verb: `GET`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: 
    * Content:
      * JSON with the resource

#### Not found

* Test name: `getId_notFound()`
* Request:
  * Verb: `GET`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `404`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: HttpStatus.NOT_FOUND.value()
      * `error`: ApiError.ERROR_NOT_FOUND
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: ApiError.MESSAGE_NOT_FOUND
    * Check any other property is included in the body

#### Not acceptable

* Test name: `getId_notAcceptable()`
* Request:
  * Verb: `GET`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_XML
* Response:
  * Status: `406`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: HttpStatus.NOT_ACCEPTABLE.value()
      * `error`: ApiError.ERROR_NOT_ACCEPTABLE
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: ApiError.MESSAGE_NOT_ACCEPTABLE
    * Check any other property is included in the body

## `OPTIONS resource/`

### Success

* Test name: `options_success()`
* Request:
  * Verb: `OPTIONS`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: Empty

## `OPTIONS resource/:id`

### Success

* Test name: `optionsId_success()`
* Request:
  * Verb: `OPTIONS`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
* Response:
  * Status: `200`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: Empty

## `PATCH resource/`

### Not Allowed

* Test name: `patch_methodNotAllowed()`
* Request:
  * Verb: `PATCH`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `405`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: HttpStatus.METHOD_NOT_ALLOWED.value()
      * `error`: `"Method Not Allowed"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Request method 'PATCH' not supported"`
    * Check any other property is included in the body

### `PATCH resource/:id`

#### Not Allowed

* Test name: `patchId_methodNotAllowed()`
* Request:
  * Verb: `PATCH`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `405`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `405`
      * `error`: `"Method Not Allowed"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Request method 'PATCH' not supported"`
    * Check any other property is included in the body

## `POST resource/`

### Success

It is required to check the endpoint creates the resource when this is correct.

* Test name: `post_success()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format.
* Response:
  * Status: `201`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: 
    * Content:
      * JSON with the resource created.
    * The resource must have the structure expected.

### Not acceptable

It is required to check the endpoint does not accept to request in formats different to JSON.

* Test name: `post_accept_notAcceptable()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_XML
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format.
* Response:
  * Status: `406`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `406`
      * `error`: `"Not acceptable"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Could not find acceptable representation"`
    * Check any other property is included in the body

### Resource not provided

It is required to check the endpoint does not accept requests with empty bodies.

* Test name: `post_resource_notProvided()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: Empty
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"The resource cannot be read"`
    * Check any other property is included in the body

### Requested attribute not defined

It is required to check the requested attribute of the entity is provided.

* Test name: `post_<ATTRIBUTE>_notDefined()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is not provided.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_NOT_DEFINED` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute repeated

It is required to check the attribute is not provided several times in the request.

* Test name: `post_<ATTRIBUTE>_repeated()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: Empty
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_REPEATED` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Requested attribute empty

It is required to check the requested attribute of the entity is not empty. This is only applicable when empty values are not allowed.

* Test name: `post_<ATTRIBUTE>_empty()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is defined in the request but empty.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_EMPTY` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute with length lower than minimum length

It is required to check the attribute of the entity has a length of at least `ATTRIBUTE_MIN_LENGTH` (see [Validation of entities](#validation-of-entities)) characters. This is only applicable when the length of the attribute is representative. For example, the name of a user.

* Test name: `post_<ATTRIBUTE>_minimumLenght()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is provided in the request but with a length lower than the minimum length.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_MIN_LENGTH` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute with length larger than maximum length

It is required to check the attribute of the entity has at most `ATTRIBUTE_MAX_LENGTH` (see [Validation of entities](#validation-of-entities)) characters. This is only applicable when the length of the attribute is representative. For example, the name of a user.

* Test name: `post_<ATTRIBUTE>_maximumLenght()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is provided in the request but with a length larger than the maximum length.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_MAX_LENGTH` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute with wrong format

It is required to check the attribute of the entity has not a wrong format. This depends on the type of the attribute. For example, only digits must be allowed in numeric attributes.

* Test name: `post_<ATTRIBUTE>_wrongFormat()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is provided in the request but with a wrong format.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_WRONG_FORMAT` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute with value lower than minimum value

It is required to check the attribute of the entity has a value of at least `ATTRIBUTE_MIN_VALUE` (see [Validation of entities](#validation-of-entities)) characters. This is only applicable when the value of the attribute is representative. For example, the age of a user must be greater than `18`.

* Test name: `post_<ATTRIBUTE>_minimumValue()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is provided in the request but with a value lower than the minimum value.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_MIN_VALUE` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

### Attribute with value larger than maximum length

It is required to check the attribute of the entity has a value of at most `ATTRIBUTE_MAX_VALUE` (see [Validation of entities](#validation-of-entities)) characters. This is only applicable when the value of the attribute is representative. For example, the age of a user must be equals or lower than `99`.

* Test name: `post_<ATTRIBUTE>_maximumValue()`
* Request:
  * Verb: `POST`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Resource to create in JSON format. The corresponding attribute is provided in the request but with a value larger than the maximum value.
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
      * `details`: `ERROR_ATTRIBUTE_MAX_VALUE` (ver [Validation of entities](#validation-of-entities))
    * Check any other property is included in the body

## `POST resource/:id`

### ID provided

* Test name: `post_id_provided()`
* Request:
  * Verb: `POST`
  * Path: `resource/:id`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body: Empty
* Response:
  * Status: `400`
  * Headers:
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: `400`
      * `error`: `"Bad request"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Bad request"`
    * Check any other property is included in the body

## `TRACE resource/`

### Not allowed

* Test name: `trace_methodNotAllowed()`
* Request:
  * Verb: `TRACE`
  * Path: `resource/`
  * Headers:
    * `Accept`: MediaType.APPLICATION_JSON
    * `Content-Type`: MediaType.APPLICATION_JSON
* Response:
  * Status: `405`
  * Headers:
    * `Allow`: List of methods allowed by the REST API
    * `Content-Type`: MediaType.APPLICATION_JSON
  * Body:
    * Content:
      * `status`: HttpStatus.METHOD_NOT_ALLOWED.value()
      * `error`: `"Method Not Allowed"`
      * `path`: PATH
      * `timestamp`: ISO_LOCAL_DATE_TIME
      * `message`: `"Request method 'TRACE' not supported"`
    * Check any other property is included in the body