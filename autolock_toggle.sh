#!/bin/bash

#_______________________________________________________________________________
#----------------- script for i3blocks screenlocker toggle ---------------------

if [[ $BLOCK_BUTTON -eq 3 ]]
then
	ID=`cat ~/.xautolock_status`
	ST=""

	if [[ $ID -eq 0 ]]
	then
		xset s on
		xset +dpms

		xautolock -enable
		ID=1
		echo $ID > ~/.xautolock_status
	else
		xset s off
		xset -dpms

		xautolock -disable
		ID=0
		echo $ID > ~/.xautolock_status
	fi

	[[ $ID -eq 1 ]] && ST="ON" || ST="OFF"
	notify-send "Screenlocker $ST"

fi

[[ $ID -eq 1 ]] && ST="ON" || ST="OFF"
echo " $ST"
echo " $ST"
echo ""
