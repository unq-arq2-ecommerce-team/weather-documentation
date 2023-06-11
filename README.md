# weather-documentation

Documentación de los servicios del TP Final Arquitectura 2 (openweathermap)

### Docker compose template

Se tomó de modelo este repositorio:
https://github.com/Einsteinish/Docker-Compose-Prometheus-and-Grafana

## Inicializar servicios

### Prerequisitos:

- Bash
- Git
- Docker
- Docker-compose
- MongoCLI y DB (opcional)

### Instrucciones

1. Clonar el presente repositorio y ejecutar los siguientes pasos dentro de este.

`git clone https://github.com/unq-arq2-ecommerce-team/weather-documentation.git`

`cd ./weather-documentation`

2. Modificar las envs de "./envs/env-{servicio}.env" de cada servicio con los datos correspondientes.

Recomendacion: Cambiar en envs "localhost" con "servicio". Ejemplo:

products-orders-service recomendacion al usar docker-compose:

```
    WEATHER_CURRENT_TEMP_URL=http://weather-loader-component:8081/api/weather/city/{city}/temperature
```

3. Ejecutar el script runServices.sh que ejecuta el docker-compose.yml (si no se ejecuto el paso 2, se pueden pasar el flag -c o --clone para clonar todos los repos, el script borra los directorios clonados si se selecciona esa opcion)

Dar permisos al script:

    ```chmod +X ./runServices.sh```

Sin limpiar ni clonar repos

    ```./runServices.sh```

Limpiar y clonar repos

    ```./runServices.sh --clone```

4. Una vez levantados todos los containers, dirigirse a http://localhost:3000

5. Loggear con las credenciales: `admin / admin`

### Test de carga y métricas

En la carpeta artillery se encuentran archivos para ejecutar para los tests de carga, es necesario instalar als dependencias y además artillery de forma global para ejercutarlos por comando.

```bash
npm install -g artillery
npm install
artillery run artiller/file.yml
```
