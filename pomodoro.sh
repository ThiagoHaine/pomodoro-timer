#!/bin/bash
function timer(){
notify-send "Pomodoro" "Começando ${1}!";
TEMPO=25;
if [ "$2" != "" ]; then
TEMPO=$2;
	if [ $TEMPO -gt 50 ]; then
		dialog                                       \
  		 --title 'Erro'                              \
	         --infobox '\nTempo maximo: 50 minutos'     \
  		 0 0;
		exit;
	fi
fi
MAX=$TEMPO;
MATUAL=`date +%M`;
while [ $TEMPO -gt 0 ]
do
	I=0;
	while [ $I -lt 6 ]
	do
	GAUGE=$((100/6));
	GAUGE=$(($GAUGE*$I));
	echo $GAUGE | dialog                                  \
        --title "${1}"                      \
        --gauge "\nFaltam ${TEMPO} minutos!"   \
        8 40 0;
	sleep 10;
        I=$(($I+1));
	done
	TEMPO=$(($TEMPO-1));
done
notify-send "Pomodoro" "${1} acabou!";
}
while [ 1 ]
do
#1
timer Pomodori $1;
timer Descanso $2;
#2
timer Pomodori $1;
timer Descanso $2;
#3
timer Pomodori $1;
timer Descanso $2;
#4
timer Pomodori $1;
timer Descanso $2;
#Descanso longo
timer "Descanso Longo" $3;
done
