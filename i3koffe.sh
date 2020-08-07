#!/bin/bash

############################
# script for i3blocks      #
# show screenlocker status #
############################

ID=`pgrep xautolock`
ST=""

if [[ -n "$ID" ]]
then
	kill $ID
	ST="OFF"
else
	#~ xautolock -time 10 -locker ~/.config/i3/scripts/lockscreen.sh &
	i3-msg -q exec `xautolock -detectsleep -time 1 -locker "~/.config/i3/scripts/lockscreen.sh" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"` &

	ST="ON"
fi

#~ notify-send "Screenlocker $ST"
echo " $ST"
echo " $ST"
echo ""

exit 0;
