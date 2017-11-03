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
function beep(){
( speaker-test -t sine -f 1000 )& pid=$! ; sleep 0.3s ; kill -9 $pid
}

while [ 1 ]
do
J=0;
while [ $J -lt 4 ]
do
timer Pomodori $1;
beep
if [ "$J" == "3" ]; then
dialog --msgbox "Pressione Enter para começar descanso longo!" 6 30;
timer "Descanso Longo" $3;
else
dialog --msgbox "Pressione Enter para começar descanso!" 6 30;
timer Descanso $2;
fi
beep;
dialog --msgbox "Pressione Enter para começar pomodori!" 6 30;
J=$(($J+1));
done
done
