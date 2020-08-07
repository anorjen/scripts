#!/bin/bash

#_______________________________________________________________________________
#----------------- autolock script ----------------------- ---------------------

#~ -locker "~/.config/i3/scripts/screen_lock.sh && xset dpms force off"
xautolock -detectsleep \
		  -time 10 \
		  -locker "dm-tool lock && systemctl suspend" \
		  -notify 60 -notifier "notify-send -u critical -t 30000 -- 'SUSPEND in 1 minute'" &

echo 0 > ~/.xautolock_status
