import simpy

# Parameters:
SIMULATION_TIME = 30

class IdentifiableResource:
    def __init__(self, env, capacity, identifiers):
        """
        Crea un recurso con identificadores individuales.
        
        :param env: Entorno de SimPy.
        :param capacity: Capacidad total del recurso.
        :param identifiers: Lista de identificadores únicos para cada unidad del recurso.
        """
        self.env = env
        self.capacity = capacity
        self.identifiers = identifiers
        self.resource = simpy.Resource(env, capacity)
        self.available = list(identifiers)  # Copia de los identificadores disponibles
        self.active_requests = {}  # Mapea identificadores con solicitudes activas

    def request(self):
        """Solicita un recurso y obtiene su identificador."""
        with self.resource.request() as req:
            yield req
            # Asignar un identificador único al recurso solicitado
            resource_id = self.available.pop(0)
            self.active_requests[resource_id] = req  # Guardar solicitud activa
            return resource_id

    def release(self, resource_id):
        """Libera un recurso usando su identificador."""
        if resource_id in self.active_requests:
            req = self.active_requests.pop(resource_id)
            self.available.append(resource_id)
            self.available.sort()  # Opcional: Mantener orden
            self.resource.release(req)  # Liberar la solicitud
        else:
            raise ValueError(f"El recurso {resource_id} no está en uso.")

# Ejemplo de uso
def proceso(env, res, name):
    print(f'{env.now}: {name} intentando acceder al recurso.')
    resource_id = yield from res.request()
    print(f'{env.now}: {name} ha obtenido el recurso {resource_id}.')
    yield env.timeout(2)  # Usar el recurso por 2 unidades de tiempo
    res.release(resource_id)
    print(f'{env.now}: {name} ha liberado el recurso {resource_id}.')

# Simulación
env = simpy.Environment()
identifiers = ['R1', 'R2', 'R3']  # Identificadores únicos
res = IdentifiableResource(env, capacity=3, identifiers=identifiers)

env.process(proceso(env, res, 'Proceso 1'))
env.process(proceso(env, res, 'Proceso 2'))
env.process(proceso(env, res, 'Proceso 3'))
env.run(until=SIMULATION_TIME)