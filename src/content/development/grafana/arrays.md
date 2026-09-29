- [Arrays](#arrays)
  - [Repeticiones por valor](#repeticiones-por-valor)

# Arrays

## Repeticiones por valor

Dado un JSON, `inputfile.json`, con el siguiente contenido:
```json
"employees": {
    "individuals": [
        {
            "code": "0000",
            "roles": [
                "MANAGER",
                "RAMP_MANAGER"
            ]
        },
        {
            "code": "0001",
            "roles": [
                "AGENT",
                "MANAGER",
                "RAMP_MANAGER"
            ]
        },
        ...
```      
Se puede número de individuos que tienen cada rol de la siguiente manera:
```
$map($distinct(employees.individuals[].roles[]), function($role) {
  {
    "role": $role,
    "count": $count($role in employees.individuals[].roles[])
  }
})
```
El resultado obtenido será éste:
```json
[
  {
    "role": "AGENT",
    "count": 13
  },
  {
    "role": "MANAGER",
    "count": 13
  },
  ...
]
```