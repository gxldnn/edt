#!/bin/bash

mkdir -p /Docments/dockerpsql/docker-compose.yaml

echo "services:
  postgres:
    image: postgres:latest
    command: >
      bash -c "echo 'connect() { psql --host=localhost --username=\$1 -d template1; }' >> /etc/bash.bashrc && exec docker-entrypoint.sh postgres"
    container_name: postgres_server
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: 123456
      POSTGRES_DB: template1
    ports:
      - "5432:5432"
    working_dir: /workspace/sql/edt/ASGBD(M10)/
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./sql:/workspace/sql

volumes:
  pgdata:



" >> /Documents/dockerpsql/docker-compose.yaml
echo "
function postgresdocker() {
  docker stop $(docker ps -a -q)
  docker remove $(docker ps -a -q)
  cd ~/Documents/docker/postgres
  docker compose down
  docker compose up -d
  id=$(docker ps | awk 'NR>1 {print $1}')
  docker exec -it $id bash
}
" >> ~/.bashrc