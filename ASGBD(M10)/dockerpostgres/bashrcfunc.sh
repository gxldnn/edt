function push() {
  cd ~/Documents/docker/postgres/sql/edt/
  git config --global pull.rebase false
  git pull
  clear
  while [[ true ]]; do
    git commit -m "Docker Push"
    git add -A
    git push
    sleep 1
    clear
  done
}

function postgresdocker() {
  cd ~/Documents/docker/postgres
  docker compose down
  docker compose up -d
  id=$(docker ps | awk 'NR>1 {print $1}')
  docker exec -it $id bash
}
