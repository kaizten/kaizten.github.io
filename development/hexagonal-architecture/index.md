# Arquitectura hexagonal

- [Arquitectura hexagonal](#arquitectura-hexagonal)
  - [Introducción](#introducción)
    - [Esquema general](#esquema-general)
    - [Ventajas](#ventajas)
  - [Capa de dominio](#capa-de-dominio)
    - [Entidades](#entidades)
    - [Objetos de valor](#objetos-de-valor)
    - [Enumerados](#enumerados)
  - [Capa de aplicación](#capa-de-aplicación)
    - [Casos de uso.](#casos-de-uso)
    - [Servicios](#servicios)
    - [Repositorios](#repositorios)
  - [Capa de adaptadores](#capa-de-adaptadores)
    - [API REST](#api-rest)
    - [MongoDB](#mongodb)
    - [TimeScale](#timescale)
  - [Configuración](#configuración)

## Introducción

La arquitectura hexagonal es un enfoque de diseño de software que busca aislar la lógica central del negocio de las dependencias externas, como bases de datos, interfaces de usuario o servicios externos (correo electrónico, pasarelas de pago, autenticación de usuarios, etc.). Su objetivo principal es crear aplicaciones más flexibles, escalables y fáciles de probar, permitiendo que la lógica de negocio se mantenga independiente de los detalles técnicos.

En esta arquitectura, la lógica del negocio reside en el núcleo de la aplicación, mientras que las interacciones con el mundo exterior se gestionan a través de adaptadores, garantizando que el núcleo se mantenga limpio y enfocado exclusivamente en las reglas de negocio.

### Esquema general

La imagen siguiente muestra un esquema general de cómo se organiza una aplicación con arquitectura hexagonal:

![Esquema general de arquitectura hexagonal](https://kaizten.github.io/images/hexagonal-architecture_overview.png)

En las siguientes secciones se exponen las principales capas de la arquitectura hexagonal que vamos a implementar.

### Ventajas

La arquitectura hexagonal proporciona varias ventajas que hacen interesante su aplicación en diversidad de proyectos de desarrollo de software:

- *Desacoplamiento.* Permite separar la lógica de negocio de las capas externas (interfaces, almacenamiento, APIs externas), lo que facilita la evolución del sistema sin romper el núcleo de la aplicación.
- *Testabilidad.* Al estar la lógica de negocio desacoplada, es más fácil escribir pruebas unitarias y pruebas de integración, ya que se pueden simular (mockear) las dependencias externas.
- *Flexibilidad.* Facilita la adición de nuevas interfaces o adaptadores sin afectar la lógica interna. Por ejemplo, cambiar de una base de datos SQL a una NoSQL o exponer una [API REST](https://es.wikipedia.org/wiki/Transferencia_de_Estado_Representacional) y [GraphQL](https://graphql.org) al mismo tiempo.
- *Mantenibilidad.* Al dividir las responsabilidades claramente en capas, el sistema se vuelve más fácil de entender, mantener y extender.

## Capa de dominio

La capa de dominio contiene las entidades y objetos valor que representan la lógica central del negocio. Esta capa no conoce nada sobre las capas externas y se enfoca exclusivamente en las reglas y procesos que gobiernan el sistema.

### Entidades

Son objetos que tienen una identidad única y un ciclo de vida. Ejemplo: `Pedido`, `Cliente`. Los atributos de las entidades son generalmente objetos de valor, que son descritos a continuación. 

En [este enlace](./domain/entities.md) puedes encontrar una descripción completa de cómo funcionan.

### Objetos de valor

Son objetos inmutables cuya identidad depende de los valores de sus atributos y no de su lugar en la memoria de la máquina. Ejemplo: `Dirección`, `Moneda`. Generalmente, son objetos empleados como tipo de los atributos de las entidades.

En [este enlace](./domain/value-objects.md) puedes encontrar una descripción completa de cómo funcionan.

### Enumerados

Objetos inmutables que pueden tomar un valor de un conjunto preestablecido.

En [este enlace](./domain/enumerates.md) puedes encontrar una descripción completa de cómo funcionan.

## Capa de aplicación

La capa de aplicación es la encargada de coordinar las operaciones del sistema. Se centra en qué se debe hacer, sin preocuparse de los detalles técnicos de cómo se hace. Los componentes principales en esta capa son los casos de uso, servicios y repositorios.

### Casos de uso.

Representan la lógica que resuelve tareas específicas. Son la entrada principal a la lógica de negocio. En [este enlace](./application/use-cases.md) puedes encontrar una descripción sobre cómo crear casos de uso.

### Servicios

Los servicios son la implementación concreta de los casos de uso. En [este enlace](./application/services.md) puedes encontrar una descripción sobre cómo crear servicios.

### Repositorios

Son interfaces que proporcionan acceso a la capa de dominio, ocultando detalles de almacenamiento.

## Capa de adaptadores

La capa de adaptadores es el punto de entrada y salida de la aplicación. Esta capa incluye adaptadores como controladores HTTP, conectores de bases de datos, y otros componentes que interactúan con agentes externos. Los adaptadores transforman las solicitudes del mundo exterior (donde está el usuario de la aplicación) en algo que el núcleo de la aplicación pueda entender y viceversa.

### API REST

xxx

### MongoDB

xxx

### TimeScale

xxx

## Configuración

Por último, en la imagen superior aparece un elemento adicional llamado `Configuration` que es un componente general y trasversal a toda la aplicación destinado a configurar la misma y conectar cada elemento de la forma oportuna.