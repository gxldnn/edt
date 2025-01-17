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


inppasswd() {
    while true; do
        unset passwd
        unset passwd2

        echo -n "Password: "
        stty -echo
        PROMPT=""
        CHARCOUNT=0

        while IFS= read -p "$PROMPT" -r -s -n 1 CHAR; do
            if [[ $CHAR == $'\0' ]]; then
                break
            fi
            if [[ $CHAR == $'\177' ]]; then
                if [ $CHARCOUNT -gt 0 ]; then
                    CHARCOUNT=$((CHARCOUNT-1))
                    PROMPT=$'\b \b'
                    passwd="${passwd%?}"
                else
                    PROMPT=''
                fi
            elif [[ $CHAR == $'\n' ]]; then
                break
            else
                CHARCOUNT=$((CHARCOUNT+1))
                PROMPT='*'
                passwd+="$CHAR"
            fi
        done
        echo

        echo -n "Type it again: "
        PROMPT=""
        CHARCOUNT=0

        while IFS= read -p "$PROMPT" -r -s -n 1 CHAR; do
            if [[ $CHAR == $'\0' ]]; then
                break
            fi
            if [[ $CHAR == $'\177' ]]; then
                if [ $CHARCOUNT -gt 0 ]; then
                    CHARCOUNT=$((CHARCOUNT-1))
                    PROMPT=$'\b \b'
                    passwd2="${passwd2%?}"
                else
                    PROMPT=''
                fi
            else
                CHARCOUNT=$((CHARCOUNT+1))
                PROMPT='*'
                passwd2+="$CHAR"
            fi
        done
        echo
        stty echo

        if [[ "$passwd" == "$passwd2" ]]; then
            echo "Password match."
            break
        else
            echo "Password didn't match. Try again."
        fi
    done
}


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
echo -ne "$1 __      __________ __________________ ____________________  _______   _______
/  \\    /  \\_____  \\\\______   \\\\______ \\\\______   \\\\_   _____// /  _____/ /  _____/
\\   \\\/\\/   //   |   \\|       _/|    |  \\|       _/|    __)_ \\_____  \\ \\_____  \\ 
 \\        //    |    \\    |   \\|    \`   \\    |   \\|        \\/        \\/        \\
  \\__/\\  / \\_______  /____|_  /_______  /____|_  /_______  /_______  /_______  /
       \\/          \\/       \\/        \\/       \\/        \\/        \\/        \\/$RESET\n"

}


clear
screen $RED
echo -e "Removing old wordpress"
rm -r /var/www/wordpress >>$LOGFILE 2>$ERRFILE
sleep 1
clear
screen $RED
echo -e "\n"
read -p "What domain do you want for your wordpress?: " domain
echo -e "$RED Installing wordpress requirements$RESET"



# For que instala todos los php y apache
packets=(apache2 mariadb-server php php-ctype php-curl php-xml php-dom php-fileinfo libapache2-mod-php php-gd php-json php-mbstring php-posix php-simplexml php-xmlreader php-xmlwriter php-zip php-pgsql php-mysql php-intl php-ldap php-ftp php-imap php-bcmath php-gmp php-exif php-apcu php-memcached php-redis)

for packet in "${packets[@]}"; do
  echo -e "Installing $GREEN$packet$RESET"
  apt install -y "$packet" >>$LOGFILE 2>$ERRFILE &
  pid=$!
  wait $pid
done
pid=""
clear
screen $RED


##################################
#
#      WORDPRESS DOWNLOAD
#

wget https://wordpress.org/latest.tar.gz >>$LOGFILE 2>$ERRFILE &
dot_check $! "Downloading wordpress tar file"
tar -zxvf latest.tar.gz >>$LOGFILE 2>$ERRFILE &
dot_check $! "Exporting files"
mv wordpress/ /var/www/
direct_check $? "Moving wordpress folder to /var/www"
rm -rf latest.tar.gz
direct_check $? "Removing tar file"
sleep 1
chown www-data:www-data -R /var/www/ >>$LOGFILE 2>$ERRFILE &
direct_check $? "Giving privileges to www-data"
sleep 2
clear
screen $RED

echo -e "$RED Setting an HTTPS default configuration$RESET"

##################################
#
#      WORDPRESS WEB CONF


echo -e "<VirtualHost *:443>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www/wordpress
	ServerName janpress.net

	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined
	SSLEngine on
	SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
	SSLCertificateKeyFile   /etc/ssl/private/ssl-cert-snakeoil.key

	<FilesMatch \"\.(?:cgi|shtml|phtml|php)\$ \">
		SSLOptions +StdEnvVars
	</FilesMatch>
	<Directory /usr/lib/cgi-bin>
		SSLOptions +StdEnvVars
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/default-ssl.conf

rm -rf /etc/apache2/sites-enabled/default-ssl.conf
phpv=$(php -v | awk '/PHP/{print substr($2, 1, 3)}' | tr -d "(c)" | grep  "8")
a2ensite 000-default.conf >>$LOGFILE 2>$ERRFILE &
direct_check $? "Enabling default page"
a2dismod mpm_event >>$LOGFILE 2>$ERRFILE
a2enmod php$phpv >>$LOGFILE 2>$ERRFILE
a2enmod ssl >>$LOGFILE 2>$ERRFILE &
direct_check $? "Enabling ssl"
a2ensite default-ssl >>$LOGFILE 2>$ERRFILE &
direct_check $? "Enabling default-ssl"
systemctl restart apache2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Restarting apache2"


##################################
#
#	SQL DATABASE CONF
#

clear
screen $RED

echo -e "Please provide the following:\n"
echo -e "Username"
read -p "> " user
clear
screen $RED
echo -e "Please provide the following:\n"
inppasswd
clear
screen $RED
echo -e "Please provide the following:\n"
echo -e "Database Name"
read -p "> " dbname
clear
screen $RED

echo -e "$RED Configuing SQL-BBDD$RESET"
mysql -u root -e "CREATE USER '$user'@'localhost' IDENTIFIED BY '$passwd';"
direct_check $? "Creating user $user"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $dbname CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
direct_check $? "Creating database $dbname"
mysql -u root -e "GRANT ALL PRIVILEGES ON $dbname.* TO '$user'@'localhost';"
direct_check $? "Granting privileges to $user"
mysql -u root -e "FLUSH PRIVILEGES;"
direct_check $? "Quiting"
clear
screen $GREEN
ip = $(ip a | awk '/inet.*global/ {print $2}' | cut -d/ -f1)
echo -e "\nFor access to your wordpress via IP go to: '$BLUE$ip$RESET'"
echo -e "\nFor access to your wordpress via domain go to: '$GREEN$domain$RESET"





