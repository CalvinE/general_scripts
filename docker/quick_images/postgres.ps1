# https://hub.docker.com/_/postgres
docker volume create postgres
# This expects a named volume called postgres to exist.
docker container run -p 5432:5432 -e POSTGRES_PASSWORD=password1 -e POSTGRES_USER=pgadmin -e PGDATA=/var/lib/postgresql/data --rm --name postgres -v postgres:/var/lib/postgresql/data postgres:latest