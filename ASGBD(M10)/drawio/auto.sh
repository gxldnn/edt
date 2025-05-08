#!/bin/bash
function ver (){

    if [[ $1 == "items" ]];then
        clear
        echo -ne "Que base de datos quieres ver?"
        read -p "> " db
        watch -n 0.5 "psql -U isard -d $db -c '\d'"
    elif [[ $1 ==  "table" ]];then
        clear
        echo -ne "Que base de datos quieres ver?"
        read -p "> " db
        clear
        echo -e "Que tabla quieres ver?"
        read -p "> " table
        watch -n 0.5 "psql -U isard -d $db -c '\d $table'"
    elif [[ $1 == "-h" ]];then
        echo -n "Do ""auto.sh items"" to see objets from a database\n"
        echo -n "Do ""auto.sh table"" to see a specific table from a database"
    fi
}
ver $1

