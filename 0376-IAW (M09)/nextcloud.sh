#!/bin/bash
# Script bien bellako made by goldn

###################################
##
##      COLORS && MoRE
##
cd
LOGFILE=logfile.log
ERRFILE=errfile.err
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
  echo -ne "   _  _ _____  _______ ___ _    ___  _   _ ___ \n"
  echo -ne "  | \\| | __\\ \\/ /_   _/ __| |  / _ \\| | | |   \\ \n"
  echo -ne "  |.\\\` | _| >  <  | || (__| |_| (_) | |_| | |) |\n"
  echo -ne "  |_|\_|___/_/\\_\\ |_| \\___|____\\___/ \\___/|___/\n "
}

clear
screen
echo -e "Removing old nextcloud"
rm -r /var/www/nextcloud >>$LOGFILE 2>$ERRFILE
rm -r /etc/apache2/sites-enabled/nextcloud.conf >>$LOGFILE 2>$ERRFILE
rm -r /etc/apache2/sites-available/nextcloud.conf >>$LOGFILE 2>$ERRFILE
clear
screen
echo -e "$RED Installing nextcloud requirements$RESET"

# For que instala todos los php y apache
packets=(apache2 php php-ctype php-curl php-xml php-dom php-fileinfo php-gd php-json php-mbstring php-posix php-simplexml php-xmlreader php-xmlwriter php-zip php-pgsql php-mysql php-intl php-ldap php-ftp php-imap php-bcmath php-gmp php-exif php-apcu php-memcached php-redis)

for packet in "${packets[@]}"; do
  echo -e "Installing $GREEN$packet$RESET"
  apt install -y "$packet" >>$LOGFILE 2>$ERRFILE &
  pid=$!
  wait $pid
done
pid=""
clear
screen

##################################
#
#      NEXTCLOUD WEB CONF
#
wget https://download.nextcloud.com/server/releases/latest.tar.bz2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Downloading nextcloud tar file"
tar -xf latest.tar.bz2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Exporting files"
mv nextcloud/ /var/www/
direct_check $? "Moving nextcloud folder to /var/www"
chown www-data:www-data -R /var/www/ >>$LOGFILE 2>$ERRFILE &
dot_check $! "Giving privileges to www-data"
echo -e "<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/nextcloud
	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
rm -rf /etc/apache2/sites-enabled/000-default.conf
ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf
a2enmod ssl >>$LOGFILE 2>$ERRFILE &
direct_check $? "Enabling ssl"
a2ensite default-ssl >>$LOGFILE 2>$ERRFILE &
direct_check $? "Enabling default-ssl"
systemctl restart apache2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Restarting apache2"


##################################
#
#	SQL CONFIGURATION
#


clear
screen
echo -e "$RED Configuing SQL-BBDD"
mysql -u root -e "CREATE USER '$user'@'localhost' IDENTIFIED BY '$passwd';"
direct_check $? "Creating user $user"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $dbname CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
direct_check $? "Creating database $dbname"
mysql -u root -e "GRANT ALL PRIVILEGES ON $dbname.* TO '$user'@'localhost';"
direct_check $? "Granting privileges to $user"
mysql -u root -e "FLUSH PRIVILEGES;"
direct_check $? "Quiting"
sleep 20
clear
screen
echo -e "\n$GREEN done.$RESET"
