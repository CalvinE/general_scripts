# https://hub.docker.com/_/mongo
docker volume create mongodb
docker volume create mongodbconfig
# This expects a named volume called mongodb and mongodbconfig to exist.
docker container run -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password1 --rm --name mongo -v mongodb:/data/db -v mongodbconfig:/data/configdb  mongo:latest

# This expects a named volume called mongodb to exist (Does not mount the config directory).
docker container run -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password1 --rm --name mongo -v mongodb:/data/db  mongo:latest