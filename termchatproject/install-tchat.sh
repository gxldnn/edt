#!/bin/bash
clear
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[37m"
LIGHT="\e[1m"
GREENp="\e[5;32m"
REDp="\e[5;31m"
RESET="\e[0m"
TICK="\xE2\x9C\x93"
CROSS="\xE2\x9C\x98"
LOGFILE="$(pwd)/logfile.log"
ERRFILE="$(pwd)/errchat.log"

STDCOLOR="\e[96m"
ERRCOLOR="\e[91m"

function tick {
  echo -e "\r [ $GREEN$TICK$RESET ] $1"
}
function cross {
  echo -e "\r [ $RED$CROSS$RESET ] $1"
}
function debug_log() {
  if [ "$debug" = true ]; then
    echo -e "[DEBUG] $1"
  fi
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
    echo -e "\n"
    exit
    ;;
  esac
}
packets=(netcat-openbsd ncat wget curl)
for packet in "${packets[@]}"; do
  echo "Installing $packet"
  apt install -y "$packet" >>$LOGFILE 2>$ERRFILE &
  pid=$!
  wait $pid
done

scriptcontent='''#!/bin/bash
clear
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[37m"
LIGHT="\e[1m"
GREENp="\e[5;32m"
REDp="\e[5;31m"
RESET="\e[0m"
TICK="\xE2\x9C\x93"
CROSS="\xE2\x9C\x98"
LOGFILE="$(pwd)/logfile.log"
ERRFILE="$(pwd)/errchat.log"

STDCOLOR="\e[96m"
ERRCOLOR="\e[91m"
touch /tmp/nc_success

port=8888

function tick {
  echo -e "\r [ $GREEN$TICK$RESET ] $1"
}
function cross {
  echo -e "\r [ $RED$CROSS$RESET ] $1"
}
function debug_log() {
  if [ "$debug" = true ]; then
    echo -e "[DEBUG] $1"
  fi
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
    echo -e "\n"
    exit
    ;;
  esac
}
function search() {
  for ip in {100..254}; do
    nc 10.200.244.$ip $port &
    pid=$!
    sleep 0.01
    kill $pid
    echo "Attempted connection to 10.200.244.$ip on port $port, then killed process $pid."
  done
}

function tchat() {
  #############################################################
  # ROOM CREATION ENGINE

  if [ "$1" = "-c" ]; then
    echo -e "Host room created on port:{$CYAN $port $RESET}"
    nc -N -lvp $port >>$LOGFILE 2>$ERRFILE &
    pid=$!
    dot_check $pid "Waiting for someone"
    ip_connection=$(cat errchat.log | awk '/Connection received/ {print $4}')
    echo -e "Connection stablished w/ $RED$ip_connection$RESET"
    sleep 2 &
    dot_check $? "Attempting to connect"
    echo "message" | nc -q 0 $ip_connection $port >>$LOGFILE 2>$ERRFILE &
    ncat -v -l --chat -p $port >/dev/null 2>&1 &
    clear
    echo "Room Created"
    ncat localhost $port
  fi

  ###################################################
  # ROOM SEARCHING ENGINE
  if [ "$1" = "-f" ]; then
    search
    clear
    echo "Scan complete!"
    nc -N -lvp $port >>$LOGFILE 2>$ERRFILE &
    pid=$!
    dot_check $pid "Join request"
    ip_connection=$(cat errchat.log | awk '/Connection received/ {print $4}')
    echo -e "Connection stablished w/ $RED$ip_connection$RESET"
    echo -e "Connecting to room"
    ncat $ip_connection $port
  fi
}
tchat $1'''

echo -n "tchat() {
  /usr/sbin/chat.sh "$@"
}" >>/etc/bash.bashrc
echo $scriptcontent >>/usr/sbin/chat.sh
chmod +x /usr/sbin/chat.sh
$SHELL
