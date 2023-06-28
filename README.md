# weather-documentation

Documentación de los servicios del TP Final Arquitectura II (openweathermap)

## Integrantes

- Lucas Matwiejczuk
- Alvaro Piorno
- Jose Cassano

## Documentación

[Ir a la seccion de documentación](./documents)

### Docker compose template

Se tomó de modelo este repositorio:
https://github.com/Einsteinish/Docker-Compose-Prometheus-and-Grafana

## Inicializar servicios

### Prerequisitos:

- Bash
- Git
- Docker
- Docker-compose
- MongoDB (opcional, si se tiene cluster)

### Instrucciones

1. Clonar el presente repositorio (si tira error de permisos, pedir credenciales) y ejecutar los siguientes pasos dentro de este. Es decir, en una terminal ejecutar: 

```bash
git clone https://github.com/unq-arq2-ecommerce-team/weather-documentation.git`
```

```bash
cd ./weather-documentation
```

**Opcional**: Evitar esta parte a menos que se tenga error en la seccion 3. Clonar repositorios manual si no funciona el script flag "-c" o "--clone" del bash script "runServices.sh". (Si tira error de permisos, pedir credenciales)

```bash
git clone https://github.com/unq-arq2-ecommerce-team/WeatherLoaderComponent
git clone https://github.com/unq-arq2-ecommerce-team/WeatherMetricsComponent
```

2. Modificar las envs de "./envs/env-{servicio}.env" de cada servicio con los datos correspondientes, o bien que matchee con la ruta especificada en el docker-compose (en el campo yaml "env_file"). Si estos archivos no existen el script runServices.sh los genera automaticamente, pero habria que validar si las envs son las correctas o deseadas (puertos, hosts, etc).

Recomendacion: Cambiar en envs "localhost" con el nombre del servicio del docker-compose. Ejemplo:

products-orders-service recomendacion al usar docker-compose:

```
    WEATHER_CURRENT_TEMP_URL=http://weather-loader-component:8081/api/weather/city/{city}/temperature
```

3. Ejecutar el script runServices.sh que ejecuta el docker-compose.yml (si no se ejecuto el paso 2, se pueden pasar el flag -c o --clone para clonar todos los repos, el script borra los directorios clonados si se selecciona esa opcion)

Dar permisos al script:

```bash
chmod +X ./runServices.sh
```

Sin limpiar ni clonar repos

```bash
./runServices.sh
```

Limpiar y clonar repos

```bash
./runServices.sh --clone
```

4. Una vez levantados todos los containers, se pueden ingresar a los siguientes servicios:

| Servicio                      | Endpoint                              |
| ----------------------------- | ------------------------------------- |
| WeatherLoaderService Swagger  | http://localhost:8081/docs/index.html |
| WeatherMetricsService Swagger | http://localhost:8082/docs/index.html |
| Grafana                       | http://localhost:3000                 |
| Prometheus                    | http://localhost:9090                 |

Credenciales:

```
user: admin
pass: admin
```

Nota: Si algun servicio no responde, revisar docker-compose.yml con sus puertos y salud del container.

## Ejecucion Tests de carga y métricas

En la carpeta artillery se encuentran archivos para ejecutar para los tests de carga. Es necesario instalar las dependencias y además artillery de forma global para ejercutarlos por comando.

### Docker

Estar en la carpeta del presente repositorio. Ahi ejecutar el siguiente comando (reemplazando `<test-file>` por el nombre del archivo del test deseado a ejecutar):  

```bash
docker run --rm -it -v ${PWD}:/repo artilleryio/artillery:latest run /repo/artillery/<test-file>.yml
```

### Local

```bash
npm install -g artillery
npm install
```
Luego, reemplazar `<test-file>` por el nombre del archivo del test deseado a ejecutar.
```bash
artillery run artillery/<test-file>.yml
```

