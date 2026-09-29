# Introduction

Kaizten Task is a lightweight execution service that runs containerized software as Docker images on demand in an asynchronous way.

It provides a REST API for submitting Docker images, manages the execution lifecycle (pull, run, capture output, etc.), register and manage datasets, and notifies clients when work completes.

It integrates with MinIO for artifact storage, MongoDB for job metadata, and Keycloak for authentication, making it easy to run reproducible algorithm runs in a secure and auditable way.