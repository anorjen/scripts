#!/bin/bash

##----------------------------------------------##
##	download and set as wallpaper				##
##	picture from bing.com                       ##
##----------------------------------------------##

sleep 2

SITE="https://www.bing.com"

WALLS_DIR="$HOME/Pictures/backgrounds"
WALLPAPER="$WALLS_DIR/wallpaper_$(date +"%y-%m-%d").jpg"

if [[ ! -s $WALLPAPER ]]
then
	PIC=`curl $SITE | grep -o -e 'href="\(\/[a-zA-Z0-9.?=_]\+1920x1080.jpg\)' | cut -c 7-`
	URL="$SITE$PIC"
	STATUS=`(wget -O $WALLPAPER -- $URL &>/dev/null && echo OK) || echo Fail`

	if [[ "$STATUS" = "OK" ]]
	then
		cp $WALLPAPER $WALLS_DIR/login-background.jpg
		mogrify -channel RGBA -blur 0x6 $WALLS_DIR/login-background.jpg
		feh --bg-fill $WALLPAPER
	else
		feh --randomize --bg-fill ~/Pictures/backgrounds/*
	fi
else
	feh --bg-fill $WALLPAPER
fi
