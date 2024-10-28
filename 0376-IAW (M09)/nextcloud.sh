#!/bin/bash
# Script bien bellako made by goldn

###################################
##
##      COLORS && MoRE
##
cd
LOGFILE=$(pwd)/nextcloud/logfile.log
ERRFILE=$(pwd)/nextcloud/errfile.err
mkdir -p $(pwd)/nextcloud
touch $LOGFILE
touch $ERRFILE

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[37m"
RESET="\e[0m"

TICK="\xE2\x9C\x93"
CROSS="\xE2\x9C\x98"
function tick {
  echo -e "\r [ $GREEN$TICK$RESET ] $1"
}
function cross {
  echo -e "\r [ $RED$CROSS$RESET ] $1"
}

function dot_check {
  echo -n $2
  dots=0

  while kill -0 $1 2>/dev/null; do
    if [ $dots -ge 4 ]; then
      echo -ne "\b\b\b\b\b         \b\b\b\b\b\b\b\b\b\b\b\b"
      dots=0
    fi
    echo -ne " ."
    ((dots++))
    sleep 0.5
  done

  wait $1
  direct_check $? "$2"
}

function direct_check {
  case $1 in
  0)
    printf "\r%-35s%s [ $GREEN$TICK$RESET ] done.\n" "$2" ""
    ;;
  *)
    printf "\r%-35s%s [ $RED$CROSS$RESET ]̉̉\n Check the error at: $ERRFILE " "$2" ""
    exit
    ;;
  esac
}
function screen {
  echo -ne "  _  _ _____  _______ ___ _    ___  _   _ ___ \n"
  echo -ne "  | \\| | __\\ \\/ /_   _/ __| |  / _ \\| | | |   \\ \n"
  echo -ne "  |.\\\` | _| >  <  | || (__| |_| (_) | |_| | |) |\n"
  echo -ne "  |_|\_|___/_/\\_\\ |_| \\___|____\\___/ \\___/|___/\n "
}

clear
screen
apt update >>$LOGFILE 2>$ERRFILE &
dot_check $! "Updating repos"
apt upgrade >>$LOGFILE 2>$ERRFILE &
dot_check $! "Upgrading repos"

# For que instala todos los php y apache
packets=(apache2 php php-ctype php-curl php-xml php-gd php-mbstring php-json php-posix php-zip php-pgsql php-mysql)
for packet in "${packets[@]}"; do
  echo -e "$RED Installing nextcloud requirements"
  echo "Installing $packet"
  apt install -y "$packet" >>$LOGFILE 2>$ERRFILE &
  pid=$!
  wait $pid
done
pid=""

# Descarga de nextcloud oficial
wget https://download.nextcloud.com/server/releases/latest.tar.bz2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Downloading nextcloud tar file"
tar -xf latest.tar.bz2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Exporting files"
mv nextcloud/ /var/www/
direct_check $? "Moving nextcloud folder to /var/www"
echo "<VirtualHost *:443>
  DocumentRoot /var/www/nextcloud/
  ServerName  $domain

  <Directory /var/www/nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews

    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
" >>/etc/apache2/sites-available/nextcloud.conf
direct_check $? "Applying nextcloud conf"
ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/
direct_check $? "Creating SymLink"

a2ensite nextcloud.conf
direct_check $? "Enabling site"
a2enmod ssl
direct_check $? "Enabling ssl"
a2ensite default-ssl
direct_check $? "Enabling default-ssl"
systemctl restart apache2
dot_check $! "Restarting apache2"
clear
screen
echo "\n\n$GREEN done."
