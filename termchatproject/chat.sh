#!/bin/bash


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

function dot_check {
    echo -n $2
    dots=0

    while kill -0 $1 2>/dev/null; do
        if [ $dots -ge 4 ]; then
            echo -ne "\b\b\b\b\b         \b\b\b\b\b\b\b\b\b\b\b\b"
            dots=0
        fi
        echo -ne  " ."
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




function send (){
	if  [ "$1" = "-c" ]; then
		echo -e "Host room created on port:{$CYAN 9999 $RESET}"
		nc -N -lvp 9999 >> $LOGFILE 2>$ERRFILE &
		pid=$!
		dot_check $pid "Waiting for someone"
	fi
}
send -c
