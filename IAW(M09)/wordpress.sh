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
rm -r /var/www/nextcloud >>$LOGFILE 2>$ERRFILE
sleep 2
clear
screen $RED
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
#      NEXTCLOUD WEB CONF
#

wget https://wordpress.org/latest.tar.gz >>$LOGFILE 2>$ERRFILE &
dot_check $! "Downloading nextcloud tar file"
tar -xf latest.tar.bz2 >>$LOGFILE 2>$ERRFILE &
dot_check $! "Exporting files"
mv nextcloud/ /var/www/
direct_check $? "Moving nextcloud folder to /var/www"
chown www-data:www-data -R /var/www/ >>$LOGFILE 2>$ERRFILE &
clear
screen $GREEN
