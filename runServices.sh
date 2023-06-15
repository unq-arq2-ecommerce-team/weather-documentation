#!/bin/bash

# Args:
#   * -c or --clone = for clean and clone services repositories
#       example: --clone
#   * -u or --user = for add user mongo credentials user
#       example: -u cassanojoseluis
#   * -p or --pass = for add user mongo credentials password
#       example: -p sarasadfas


# var para clonar repositorios
cloneRepos=false

#Read the argument values 
while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -c|--clone) cloneRepos=true; shift;;
    esac
    shift
done

# TODO: update envs somehow in envs with credentials (maybe add line with MONGO_URL)

echo "[INFO] - cloneRepos with value: $cloneRepos"
# Evaluates
if [ ! -f "./docker-compose.yml" ]
then
    echo "[ERROR] - File ./docker-compose.yml not found"
    echo "[INFO] - Execute script at same level folder where it belongs"
    exit 1
fi

# Removes repos and clone again if apply
if [ "$cloneRepos" = true ] ; then
    echo '[INFO] - Option clone repos true'
    echo '[INFO] - Clean repos'
    rm -rf ./WeatherLoaderComponent
    rm -rf ./WeatherMetricsComponent
    echo '[INFO] - Clean repos done'

    echo '[INFO] - Cloning repos'
    git clone https://github.com/unq-arq2-ecommerce-team/WeatherLoaderComponent
    git clone https://github.com/unq-arq2-ecommerce-team/WeatherMetricsComponent
    echo '[INFO] - Cloning repos done'
fi


# Eval if exist services cloned
if [ ! -d "./WeatherLoaderComponent" ] || [ ! -d "./WeatherMetricsComponent" ]
then
    echo "[ERROR] - Step of clone services failed"
    echo "[INFO] - Please read README.md and complete step 1"
    exit 1
fi

# Eval if exists envs folder with two envs file for not broke docker-compose and load default envs
if [ ! -f "./envs/env-weather-loader-component.env" ] || [ ! -f "./envs/env-weather-metrics-component.env" ]
then
    echo "[INFO] not found envs file, creating for not break docker-compose"
    if [ ! -d "./envs" ] 
    then
        mkdir "./envs"
    fi
    > "./envs/env-weather-loader-component.env"
    > "./envs/env-weather-metrics-component.env"
    echo "WEATHER_CURRENT_TEMP_URL=http://weather-loader-component:8081/api/weather/city/{city}/temperature" >> "./envs/env-weather-metrics-component.env"
    echo "WEATHER_AVG_TEMP_URL=http://weather-loader-component:8081/api/weather/city/{city}/temperature/average" >> "./envs/env-weather-metrics-component.env"
    echo "[INFO] envs file created with some default values for docker-compose"
else
    echo "[INFO] docker-compose envs file found"
fi

echo "[INFO] - Executing docker-compose: "
# Build and instance containers with docker-compose info
docker-compose up -d --build

# Save status of last command
DOCKER_COMPOSE_STATUS=$?

if [ "$DOCKER_COMPOSE_STATUS" == "0" ]
then
    echo "[INFO] - Script runServices sucessfull"
    echo "[INFO] - Please verify if containers are running up ok in arq2"
else
    echo "[ERROR] - docker compose status returned: $DOCKER_COMPOSE_STATUS"
    echo "[ERROR] - Something when wrong when execute docker compose. Please verify your docker and try again"
fi
