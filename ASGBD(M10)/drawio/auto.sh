#!/bin/bash
function ver (){

    if [[ $1 == "bases" ]];then
        clear
        echo -ne "Que base de datos quierers ver?"
        read -p "> " db
        watch -n 0.5 "psql -U isard -d $db -c '\d'"
    elif [[ $1 ==  "tabla" ]];then
        clear
        echo -ne "Que base de datos quierers ver?"
        read -p "> " db
        clear
        echo -e "Que tabla quieres ver?"
        read -p "> " table
        watch -n 0.5 "psql -U isard -d $db -c '\d $table'"
    fi
}
ver $1
