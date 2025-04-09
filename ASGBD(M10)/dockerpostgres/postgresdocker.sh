
function postgresdocker() {
  docker stop $(docker ps -a -q)
  docker remove $(docker ps -a -q)
  cd ~/Documents/docker/postgres
  docker compose down
  docker compose up -d
  id=$(docker ps | awk 'NR>1 {print $1}')
  docker exec -it $id bash
}
