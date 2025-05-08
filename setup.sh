function push() {
  clear

  read -p "Clone Git?" gitclone
  mkdir -p "~/Documents/docker/postgres/sql/"
  cd ~/Documents/docker/postgres/sql/
  case "$gitclone" in
  "n" | "N" | "")
    break
    ;;
  "y")
    git clone git@github.com:gxldnn/edt.git
    ;;
  *)
    exit 1
    ;;
  esac

  cd edt/
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


mkdir -p ~/Documents/dockerpsql
mkdir -p ~/Documents/dockerpsql/sql

cat << 'EOF' > ~/Documents/dockerpsql/docker-compose.yaml


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