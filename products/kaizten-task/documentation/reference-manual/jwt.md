# JSON Web Token (JWT)

- [JSON Web Token (JWT)](#json-web-token-jwt)
  - [Overview](#overview)
  - [Obtaining a JSON Web Token](#obtaining-a-json-web-token)
    - [Example](#example)
  - [Using the obtained JSON Web Token](#using-the-obtained-json-web-token)
  - [Refresh tokens and expiration](#refresh-tokens-and-expiration)

## Overview

Kaizten Task uses [Keycloak](https://www.keycloak.org) as the identity provider and relies on OAuth2 / OpenID Connect access tokens (JSON Web Tokens - JWT) for API authentication and authorization.

Kaizten Task accepts a Bearer access token in the `Authorization` header on protected endpoints. Tokens are issued by Keycloak and contain standard claims (iss, sub, aud, exp, iat) plus additional realm- or client-specific claims that may carry roles and other attributes. The backend validates the token signature and common claims before allowing access.

## Obtaining a JSON Web Token

A JSON Web Token (JWT) can be obtained as follows:
```bash
curl -X POST "<KEYCLOAK_URL>:<KEYCLOAK_PORT>/realms/<REALM>/protocol/openid-connect/token" \
	-H "Content-Type: application/x-www-form-urlencoded" \
	-d "grant_type=password&client_id=<CLIENT_ID>&username=<USERNAME>&password=<PASSWORD>"
```
In this case, the following elements must be replaced:
- `<KEYCLOAK_URL>`. URL of the Keycloak service.
- `<KEYCLOAK_PORT>`. Port of the Keycloak service.
- `<REALM>`. Real of the application.
- `<CLIENT_ID>`. Identifier of the client.
- `<USERNAME>`. Username registered in Keycloak.
- `<PASSWORD>`. Password of the username registered in Keycloak.

### Example

## Using the obtained JSON Web Token

Once a JWT has been obtained, it must be used in each request to the REST API of Kaizten Task. That is, include the token in requests as a Bearer token:

```bash
curl -X POST https://your-kaizten-host/v1/algorithms/BAP \
	-H "Authorization: Bearer <access_token>" \
	-H "Content-Type: application/json" \
	-d '{ "name": "BAP1", "responseURL": "http://127.0.0.1:5000/receive" }'
```

## Refresh tokens and expiration

Access tokens are short-lived. Use the returned `refresh_token` with the token endpoint to obtain a new access token (password grant flow) or request a new client-credentials token in automated clients. Respect `expires_in` to avoid rejected requests.