# How it works

- [How it works](#how-it-works)
	- [Write source code](#write-source-code)
	- [Create Docker image](#create-docker-image)
	- [Obtain JWT](#obtain-jwt)
	- [Register operation](#register-operation)
	- [Register datasets](#register-datasets)
	- [Request execution of operation](#request-execution-of-operation)
	- [Enqueue of task](#enqueue-of-task)
	- [Execution of task](#execution-of-task)
	- [Check task status](#check-task-status)

High-level architecture diagram showing clients, Keycloak (auth), the Kaizten Task API/execution engine, MinIO (artifacts) and MongoDB (metadata), with the main data and notification flows.

![Kaizten Task architecture](schema.png)

## Write source code

The developer writes source code in their favourite programming language. 

## Create Docker image

The code is packaged into a container image using Docker. This Docker image can be optionally publishes to a container registry (Docker Hub) so the Kaizten Task engine can pull and run it.

## Obtain JWT

The developer obtains an access token from Keycloak by authenticating with their username and password (for example by POSTing credentials to Keycloak's token endpoint). The returned access token must be included in subsequent API requests as a Bearer token in the `Authorization` header (`Authorization: Bearer <access_token>`).

## Register operation

The developer submits an operation via HTTP `POST` to `/v1/operatoins` with a JSON payload that includes the full name of the Docker image.

## Register datasets

Required datasets for an operation must be uploaded to a MinIO (S3-compatible) bucket and referenced as objects in the operation request. Store each dataset as a separate object with a clear key (for example: `bucket-name/path/to/dataset.csv`). The operation payload should include the bucket name and object key(s) or pre-signed URLs so the execution engine can access the data. Ensure the objects are readable by the service (proper bucket policy, object ACL or credentials). Use object metadata (content-type, schema, version) when helpful. For reference and convenience the API exposes data listing endpoints (for example `GET /v1/data`) to enumerate available buckets and objects.

## Request execution of operation

To execute a registered operation the client submits a run request to the API.

## Enqueue of task

The execution engine of Kaizten Task schedules the run, pulls the Docker image (if required), creates a container with configured volumes and environment, and queues the execution.

## Execution of task

When computational resources are available, the first task in the queue is executed. Standard output, error streams and any output artifacts are captured. Upon completion (`SUCCESS` or `FAILURE`), Kaizten Task updates the Task status and optionally `POST`s a result summary to the provided `responseURL`.

## Check task status

Clients can poll task status via API endpoints or receive push notifications via webhook.