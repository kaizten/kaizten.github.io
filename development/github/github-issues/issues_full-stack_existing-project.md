- [Dominio](#dominio)
  - [Objetos valor](#objetos-valor)
  - [Enumerados](#enumerados)
  - [Entidades](#entidades)
    - [Tests de entidades](#tests-de-entidades)
    - [Tests de los enumerados](#tests-de-los-enumerados)
    - [Tests de objetos valor](#tests-de-objetos-valor)
- [Aplicación](#aplicación)
  - [Casos de uso](#casos-de-uso)
  - [Adaptador REST](#adaptador-rest)
    - [DTO](#dto)

# Back-end

## Dominio

### Objetos valor

Hola, si te parece bien, vamos a ir revisando cada parte del código para que corregir cosas. 

Podemos empezar por los objetos valor del dominio. En el siguiente enlace tienes una descripción sobre cómo diseñar objetos valor y qué características deben cumplir:

[https://kaizten.github.io/development/ddd/value-objects.html](https://kaizten.github.io/development/ddd/value-objects.html)

Revisa con calma los objetos valor que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

### Enumerados

Hola, otro aspecto a revisar del dominio son los enumerados. En el siguiente enlace tienes una descripción sobre cómo diseñar enumerados y qué características deben cumplir:

[https://kaizten.github.io/development/ddd/enumerates.html](https://kaizten.github.io/development/ddd/enumerates.html)

Revisa con calma los enumerados que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

### Entidades

Hola, el elemento fundamental del dominio son las entidades. Te paso un enlace donde se describen:

[https://kaizten.github.io/development/ddd/entities.html](https://kaizten.github.io/development/ddd/entities.html)

Revisa con calma las entidades que tienes en el dominio del back-end y trata de corregirlos, tal como se indica en el enlace que te pasé.

Indícame si te surge cualquier duda.

#### Tests de entidades

Hola, las entidades del dominio deben estar testeadas para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/hexagonal-architecture/entity_tests.html) tienes una guía de los tests que debería tener cada entidad de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las entidades y plantea cualquier duda que pueda surgirte.
2. Implementa para cada entidad de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

#### Tests de los enumerados

Hola, los enumerados del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/hexagonal-architecture/enumerate_tests.html) tienes una guía de los tests que debería tener cada enumerado de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de las enumerados y plantea cualquier duda que pueda surgirte.
2. Implementa para cada enumerado de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

#### Tests de objetos valor

Hola, los objetos de valor del dominio deben estar testeados para evitar posibles errores en el funcionamiento de la aplicación. En [este enlace](https://kaizten.github.io/development/java/hexagonal-architecture/value-object_tests.html) tienes una guía de los tests que debería tener cada objeto de valor de tu dominio para tener una cierta garantía de que funciona correctamente.

**Pasos a realizar:**

1. Revisa con calma el enlace donde se describen los tests de los objetos de valor y plantea cualquier duda que pueda surgirte.
2. Implementa para cada objeto de valor de tu dominio los tests correspondientes siguiendo las indicaciones del enlace anterior.

## Aplicación

### Casos de uso

Hola, habría que ir definiendo bien y revisando los casos de uso de la aplicación. Cada caso de uso debe ser una **interfaz** con un **único método** (por lo general). Deben estar en la carpeta `application/usecase`.

Por ello, revisa que, para cada entidad, hayan casos de uso para la creación, eliminación, búsqueda y actualización. Esto es, si tienes una entidad `<ENTITY>.java`, deberías tener los siguientes casos de uso:
- `Create<ENTITY>UseCase.java`
- `Delete<ENTITY>UseCase.java`
- `Fetch<ENTITY>UseCase.java`
- `Update<ENTITY>UseCase.java`

Los servicios deben ser clases que implementen dichos casos de uso. **Debes tener un servicio por cada caso de uso.** Siguiendo el caso anterior, el servicio sería `CreateContainerService` y debería estar en la carpeta `application/service` que ya tienes creada.

Disculpa que se me olvidaban cosas jeje

Una vez creado cada caso de uso, los controladores (en `adaptar/rest`) deben usar los casos de uso. **Nunca los servicios.** Por tanto, revisa que tengan casos de uso inyectados en lugar de servicios. Por ejemplo, `ContainerController.createContainer` usa un servicio, lo cual sería incorrecto.

Por último, tendrías que ir a `ApplicationConfiguration` y cambiar esto:
```java
@Bean
public ContainerService containerService() {
    return new ContainerService();
}
```
por esto
```
@Bean
public CreateContainerUseCase createContainerUseCase() {
    return new CreateContainerService();
}
```
Con esto, obligas a que siempre se use el caso de uso (`CreateContainerUseCase`) sin conocer su implementación particular (`CreateContainerService`).

### Adaptador REST

#### DTO

Hola, los clientes que empleen el API REST definida en el back-end deberían emplear objetos de clases diferentes a las entidades del dominio para evitar el acoplamiento así como facilitar la validación de datos. Por ello, dentro del controlador `adapter/rest` crea una carpeta `dto` donde añadir [Data Transfer Objects](https://www.baeldung.com/java-dto-pattern).

**Pasos a realizar:**

1. Dentro de la carpeta del adaptador REST (`adapter/rest/dto`)), debes crear una clase `<ENTITY>PostRequestBody.java`, otra `<ENTITY>PutRequestBody.java` y otra `<ENTITY>ResponseBody.java` por cada entidad de tu dominio `<ENTITY>`. A continuación te paso un ejemplo ilustrativo para una entidad `Trap.java`:
```java
public class TrapPostRequestBody {

    private TrapName name;
    private TrapDescription description;
    private TrapType type;
    private UUID entryPoint;
    private KaiztenGeolocationPoint geolocation;
    private LocalDate installationDate;
    private LocalDate leavingDate;
    private ContactInformation contactInformation;
    private List<Comment> comments;
    private List<UUID> imageUUID;

    public LocalDate getInstallationDate() {
        return this.installationDate;
    }

    public void setInstallationDate(LocalDate installationDate) {
        this.installationDate = installationDate;
    }

    public LocalDate getLeavingDate() {
        return this.leavingDate;
    }

    public void setLeavingDate(LocalDate leavingDate) {
        this.leavingDate = leavingDate;
    }

    public TrapName getName() {
        return this.name;
    }

    public void setName(TrapName name) {
        this.name = name;
    }

    public TrapDescription getDescription() {
        return this.description;
    }

    public void setDescription(TrapDescription description) {
        this.description = description;
    }

    public ContactInformation getContactInformation() {
        return this.contactInformation;
    }

    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
    }

    public void setGeolocation(KaiztenGeolocationPoint geolocation) {
        this.geolocation = geolocation;
    }

    public KaiztenGeolocationPoint getGeolocation() {
        return this.geolocation;
    }

    public List<Comment> getComments() {
        return this.comments;
    }

    public TrapType getType() {
        return this.type;
    }

    public List<UUID> getImageUUID() {
        return this.imageUUID;
    }

    public UUID getEntryPoint() {
        return this.entryPoint;
    }

    public int getNumberOfImages() {
        return (this.hasImages()) ? this.imageUUID.size() : 0;
    }

    private boolean hasComments() {
        return this.comments != null && !this.comments.isEmpty();
    }

    public boolean hasImages() {
        return this.imageUUID != null && !this.imageUUID.isEmpty();
    }

    public boolean hasGeolocation() {
        return this.geolocation != null;
    }

    public boolean hasType() {
        return (this.type != null);
    }

    public void setEntryPoint(UUID entryPoint) {
        this.entryPoint = entryPoint;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void setImageUUID(List<UUID> images) {
        this.imageUUID = images;
    }

    public void setType(TrapType type) {
        this.type = type;
    }

    public Trap toTrap(
            FetchEntryPointUseCase fetchEntryPointUseCase,
            FetchFileUseCase fetchFileUseCase,
            JwtAuthConverter authConverter,
            Authentication authentication) {
        EntryPoint ep = fetchEntryPointUseCase.fetchEntryPointById(this.entryPoint).orElseThrow();
        JwtAuthenticationToken jwtAuthenticationToken = (JwtAuthenticationToken) authentication;
        Jwt jwt = jwtAuthenticationToken.getToken();
        String principalAttribute = authConverter.getPrincipleClaimName(jwt);
        KaiztenJWTPreferredUsername preferredUsername = new KaiztenJWTPreferredUsername(principalAttribute);
        Trap trap = new Trap(
                this.getName(),
                this.getType(),
                ep,
                this.getGeolocation(),
                preferredUsername);
        // Optional attributes:
        trap.setContactInformation(this.getContactInformation());
        trap.setDescription(this.getDescription());
        if (this.hasComments()) {
            for (Comment comment : this.comments) {
                trap.addComment(comment);
            }
        }
        if (this.hasImages()) {
            for (UUID uuid : this.imageUUID) {
                fetchFileUseCase.fetchFileById(uuid).ifPresent((image) -> {
                    trap.addImage(image);
                });
            }
        }
        trap.setInstallationDate(this.getInstallationDate());
        trap.setLeavingDate(this.getLeavingDate());
        return trap;
    }

    public String toString() {
        final String representationType = (this.hasType()) ? this.type.toString() : "null";
        final String representationGeolocation = (this.hasGeolocation()) ? this.geolocation.toString() : "null";
        final String representationImages = (this.hasImages()) ? this.imageUUID.toString() : "null";
        return "TrapPostRequestBody={" +
                "name=" + this.name + "," +
                "contactInformation=" + this.contactInformation + "," +
                "description=" + this.description + "," +
                "type=" + representationType + "," +
                "entryPoint=" + this.entryPoint + "," +
                "geolocation=" + representationGeolocation + "," +
                "images=" + representationImages + "," +
                "installationDate=" + this.installationDate + "," +
                "leavingDate=" + this.leavingDate +
                "}";
    }
}
```
y 
```java
public class TrapResponseBody {

    private UUID id;
    private TrapName name;
    private TrapDescription description;
    private TrapType type;
    private UUID entryPoint;
    private KaiztenGeolocationPoint geolocation;
    private LocalDate installationDate;
    private LocalDate leavingDate;
    private ContactInformation contactInformation;
    private List<UUID> images;
    private List<Comment> comments;
    private KaiztenJWTPreferredUsername creator;

    public Optional<LocalDate> getInstallationDate() {
        return Optional.ofNullable(this.installationDate);
    }

    public void setInstallationDate(LocalDate installationDate) {
        this.installationDate = installationDate;
    }

    public Optional<LocalDate> getLeavingDate() {
        return Optional.ofNullable(this.leavingDate);
    }

    public KaiztenJWTPreferredUsername getCreator() {
        return this.creator;
    }

    public void setLeavingDate(LocalDate leavingDate) {
        this.leavingDate = leavingDate;
    }

    public UUID getId() {
        return this.id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public TrapName getName() {
        return this.name;
    }

    public void setName(TrapName name) {
        this.name = name;
    }

    public Optional<TrapDescription> getDescription() {
        return Optional.ofNullable(this.description);
    }

    public void setDescription(TrapDescription description) {
        this.description = description;
    }

    public Optional<ContactInformation> getContactInformation() {
        return Optional.ofNullable(this.contactInformation);
    }

    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
    }

    public void setGeolocation(KaiztenGeolocationPoint geolocation) {
        this.geolocation = geolocation;
    }

    public KaiztenGeolocationPoint getGeolocation() {
        return this.geolocation;
    }

    public void setType(TrapType type) {
        this.type = type;
    }

    public TrapType getType() {
        return this.type;
    }

    public List<UUID> getImages() {
        return this.images;
    }

    public boolean hasImages() {
        return this.images != null;
    }

    public void setImages(List<UUID> images) {
        this.images = images;
    }

    public List<Comment> getComments() {
        return this.comments;
    }

    public boolean hasComments() {
        return this.comments != null && !this.comments.isEmpty();
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public UUID getEntryPoint() {
        return this.entryPoint;
    }

    public void setEntryPoint(UUID entryPoint) {
        this.entryPoint = entryPoint;
    }

    public void setCreator(KaiztenJWTPreferredUsername creator) {
        this.creator = creator;
    }

    public boolean hasDescription() {
        return this.description != null;
    }

    public boolean hasContactInformation() {
        return this.contactInformation != null;
    }

    public boolean hasInstallationDate() {
        return this.installationDate != null;
    }

    public boolean hasLeavingDate() {
        return this.leavingDate != null;
    }

    public static TrapResponseBody from(Trap trap) {
        TrapResponseBody responseBody = new TrapResponseBody();
        responseBody.id = trap.getId();
        responseBody.name = trap.getName();
        responseBody.type = trap.getType();
        responseBody.entryPoint = trap.getEntryPoint().getId();
        responseBody.geolocation = trap.getGeolocation();
        responseBody.creator = trap.getCreator();
        if (trap.hasImages()) {
            responseBody.images = new ArrayList<>(trap.getNumberOfImages());
            for (File image : trap.getImages().get()) {
                responseBody.images.add(image.getId());
            }
        }
        if (trap.hasComments()) {
            responseBody.comments = new ArrayList<>(trap.getNumberOfComments());
            for (Comment comment : trap.getComments().get()) {
                responseBody.comments.add(comment);
            }
        }
        // Optional attributes:
        trap.getDescription().ifPresent((description) -> {
            responseBody.description = description;
        });
        trap.getInstallationDate().ifPresent((installationDate) -> {
            responseBody.installationDate = installationDate;
        });
        trap.getLeavingDate().ifPresent((leavingDate) -> {
            responseBody.leavingDate = leavingDate;
        });
        trap.getContactInformation().ifPresent((contactInformation) -> {
            responseBody.contactInformation = contactInformation;
        });
        return responseBody;
    }

    public String toString() {
        final String representationComments = (this.hasComments()) ? this.comments.toString() : "null";
        final String imagesId = (this.hasImages()) ? this.images.toString() : "null";
        return "TrapResponseBody={" +
                "id=" + this.id + "," +
                "name=" + this.name + "," +
                "contactInformation=" + this.contactInformation + "," +
                "description=" + this.description + "," +
                "type=" + type + "," +
                "entryPoint=" + this.entryPoint + "," +
                "geolocation=" + geolocation + "," +
                "comments=" + representationComments + "," +
                "images=" + imagesId + "," +
                "installationDate=" + this.installationDate + "," +
                "leavingDate=" + this.leavingDate + "," +
                "creator=" + this.creator +
                "}";
    }
}
```
Fíjate en la implementación de los métodos estáticos que tienen las clases anteriores. Están diseñados para convertir el DTO correspondiente en entidad (o viceversa) así como para generar objetos aleatoriamente. También es particularmente importante en que te fijes en que se retorna `Optional` en los getters de aquellos atributos que son opcionales en la entidad.

2. Una vez creados los DTO, debes eliminar las entidades en los parámetros y los valores de retorno de los controladores creados en el adaptador. Esto significa que los controladores deben recibir DTO y devolver DTO en lugar de entidades de tu dominio. 