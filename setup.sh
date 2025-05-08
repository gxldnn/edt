#!/bin/bash
mkdir -p ~/Documents/docker/psql/sql

cat << 'EOF' > ~/Documents/docker/psql/docker-compose.yaml
services:
  postgres:
    image: postgres:latest
    command: >
      bash -c "echo 'connect() { psql --host=localhost --username=$1 -d template1; }' >> /etc/bash.bashrc && exec docker-entrypoint.sh postgres"
    container_name: postgres_server
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: 123456
      POSTGRES_DB: template1
    ports:
      - "5432:5432"
    working_dir: /workspace/sql/
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./sql:/workspace/sql

volumes:
  pgdata:
EOF

cp /etc/skel/.bashrc ~/
cat << 'EOF' >> ~/.bashrc

function postgresdocker() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
  cd ~/Documents/dockerpsql
  docker compose down
  docker compose up -d
  id=$(docker ps | awk 'NR>1 {print $1}')
  docker exec -it $id bash
}




EOF