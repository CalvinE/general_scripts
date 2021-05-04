# https://hub.docker.com/_/couchdb
docker container run -d --name test_couchdb -p 5984:5984 -e COUCHDB_USER=root -e COUCHDB_PASSWORD=password couchdb:3.1.1