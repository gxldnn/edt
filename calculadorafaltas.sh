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


function madeby(){
echo -e "$LIGHT$MAGENTA   //=======================================//$RESET"
echo -e "$LIGHT$MAGENTA  //============$CYAN GOLDNN MAKEIT$LIGHT$MAGENTA ============//$RESET"
echo -e "$LIGHT$MAGENTA //=======================================//$RESET"
echo -e "\n\n\n"
}

semanas=32

declare -a asignaturas
asignaturas=("PAX" "IAW" "ISO" "ASGBD" "GBD" "SASP" "DASP" "INGLES" "FM" "TUTO")

clear
madeby

for i in ${!asignaturas[@]}; do
	echo -e "$i) ${asignaturas[$i]}"
done

read -p "Que asignatura quieres calcular?? " choosed
clear
madeby
read -p "Quantas faltas tienes? " faltas
clear
madeby
read -p "Quantas puntualidades tienes? " punt

faltes2=$(( punt / 3 ))
faltestot=$(( faltas + faltes2 ))



case $choosed in
	0|[Pp][Aa][Xx])
		clear
		madeby
		tot=$(( 4 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en PAX\n"

	;;
	1|[Ii][Aa][Ww])
		clear
		madeby
		tot=$(( 2 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en IAW\n"
	;;
	2|[Ii][Ss][Oo])
		clear
		madeby
		tot=$(( 4 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en ISO\n"
	;;
	3|[Aa][Ss][Gg][Bb][Dd])
		clear
		madeby
		tot=$(( 1 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en ASGBD\n"
	;;
	4|[Gg][Bb][Dd])
		clear
		madeby
		tot=$(( 4 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en GBD\n"
	;;
	5|[Ss][Aa][Ss][Pp])
		clear
		madeby
		tot=$(( 1 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en SASP\n"
	;;
	6|[Dd][Aa][Ss][Pp])
		clear
		madeby
		tot=$(( 1 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en DASP\n"
	;;
	7|[Ii][Nn][Gg][Ll][Ee][Ss])
		clear
		madeby
		tot=$(( 2 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en INGLES\n"
	;;
	8|[Ff][Mm])
		clear
		madeby
		tot=$(( 2 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en FM\n"
	;;
	9|[Tt][Uu][Tt][Oo])
		clear
		madeby
		tot=$(( 1 * $semanas))
		percent=$(echo "scale=2; $faltestot * 100 / $tot" | bc)
		echo -ne "Tienes un $percent% de faltes en TUTORIA\n"
	;;
esac

