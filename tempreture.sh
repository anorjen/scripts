#!/bin/bash

##----------------------------------------------##
##	show CPU temp with colours                  ##
##----------------------------------------------##

RED='\033[0;31m'      #  ${RED}      # красный цвет знаков
YELLOW='\033[0;33m'   #  ${YELLOW}   # желтый цвет знаков
BLACK='\033[0;30m'    #  ${BLACK}    # чёрный цвет знаков
BGRED='\033[0;41m'    #  ${BGRED}    # красный цвет фона
BGYELLOW='\033[0;43m' #  ${BGYELLOW} # желтый цвет фона
NORMAL='\033[0m'      #  ${NORMAL}   # все атрибуты по умолчанию

C_WARN='\033[0;30;43m'
C_CRIT='\033[0;30;41m'
T_WARN=20;
T_CRIT=30;

T_INP=`sensors -A | grep -oP '^Core.+?  \+\K\d+' | awk '{if(k<$1) k=$1}END{print k}'`
COLOR=$NORMAL
if [[ $T_INP -ge T_WARN ]]
then
	COLOR=$C_WARN
fi

if [[ $T_INP -ge T_CRIT ]]
then
	COLOR=$C_CRIT
fi

echo -e "${COLOR}${T_INP}°C${NORMAL}"
