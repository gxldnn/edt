#!/bin/bash
mkdir -p ~/Documents/docker/psql/sql
cp /etc/skel/.bashrc ~/

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

cat << 'EOF' > ~/.config/kitty/kitty.conf 
include current-theme.conf

font_family      JetBrainsMono NF
font_size 10.5

cursor_shape block
cursor_stop_blinking_after 0

scrollback_lines 2000

copy_on_select yes

mouse_hide_wait 0

select_by_word_characters @-./_~?&=%+#a

enable_audio_bell no
bell_on_tab "🔔 "


remember_window_size  no
window_border_width 1pt
draw_minimal_borders yes

window_padding_width 10

inactive_text_alpha 0.6

hide_window_decorations yes

confirm_os_window_close 0
background_opacity 0.9
tab_bar_style powerline
EOF

cat << 'EOF' > ~/.config/kitty/current-theme.conf
# The basic colors
foreground              #a5b6cf
background              #0d0f18
selection_foreground    #0d0f18
selection_background     #c296eb

# Cursor colors
cursor                  #a5b6cf
cursor_text_color       #0d0f18

# URL underline color when hovering with mouse
url_color               #86aaec

# Kitty window border colors
active_border_color     #c296eb
inactive_border_color   #3d414f
bell_border_color       #ecd3a0

# Tab bar colors
active_tab_foreground   #0d0f18
active_tab_background   #c296eb
inactive_tab_foreground #a5b6cf
inactive_tab_background #3d414f
tab_bar_background      #0d0f18

# The 16 terminal colors

# black
color0 #3d414f
color8 #3d414f

# red
color1 #dd6777
color9 #dd6777

# green
color2  #90ceaa
color10 #90ceaa

# yellow
color3  #ecd3a0
color11 #ecd3a0

# blue
color4  #86aaec
color12 #86aaec

# magenta
color5  #c296eb
color13 #c296eb

# cyan
color6  #93cee9
color14 #93cee9

# white
color7  #cbced3
color15 #cbced3
EOF

cat << 'EOF' >> ~/.bashrc

################################################
################################################

            FUNCIONES DEL INSTALLER

################################################
################################################

function postgresdocker() {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    cd ~/Documents/docker/psql/
    docker compose down
    docker compose up -d
    id=$(docker ps | awk 'NR>1 {print $1}')
    docker exec -it $id bash
}

function phpdocker() {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    cd ~/Documents/docker/php/
    docker compose down
    docker compose up -d
}

function push() {
    clear

    read -p "Clone Git?" gitclone
    cd ~/Documents/docker/psql/sql/
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
        git commit -m "Auto Push"
        git add -A
        git push
        sleep 1
        clear
    done
}

EOF
