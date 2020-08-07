#!/bin/bash

ID=`pgrep xautolock`

if [[ -n "$ID" ]]
then
	kill $ID
	notify-send "Screenlocker OFF"
else
	xautolock -time 10 -locker ~/.config/i3/scripts/lockscreen.sh &
	notify-send "Screenlocker ON"
fi
