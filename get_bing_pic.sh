#!/bin/bash

##----------------------------------------------##
##	download and set as wallpaper				##
##	picture from bing.com                       ##
##----------------------------------------------##

sleep 2

SET_UHD=1

SITE="https://www.bing.com"

WALLS_DIR="$HOME/Pictures/backgrounds"

WALLS_DIR_FHD="$WALLS_DIR/FHD"
WALLPAPER_FHD="$WALLS_DIR_FHD/wallpaper_$(date +"%y-%m-%d").jpg"

WALLS_DIR_UHD="$WALLS_DIR/UHD"
WALLPAPER_UHD="$WALLS_DIR_UHD/wallpaper_UHD_$(date +"%y-%m-%d").jpg"

if [[ $SET_UHD -eq 1 ]]
then
	SET_DIR=$WALLS_DIR_UHD
	WALLPAPER=$WALLPAPER_UHD
else
	SET_DIR=$WALLS_DIR_FHD
	WALLPAPER=$WALLPAPER_FHD
fi

function f_isImage {
	possibleImage=$1
	
	status=`file $possibleImage |grep -c "image"`
	echo $status
}

function f_downloadWallpapers {
	pic=`curl -A "Mozilla/5.0 (Linux; Android 10; SM-G996U Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Mobile Safari/537.36" $SITE | grep -o -e '"Wallpaper":"\(\/[a-zA-Z0-9.?=_]\+1920x1200.jpg\)' | cut -c 14-`
	pic_fhd=`echo $pic | sed 's/1920x1200/1920x1080/'`
	pic_uhd=`echo $pic | sed 's/1920x1200/UHD/'`

	url="$SITE$pic_fhd"
	echo $url
	url_uhd="$SITE$pic_uhd"
	echo $url_uhd

	status_fhd=$( f_downloadWallpaper $WALLPAPER_FHD $url)
	echo "FHD wallpaper download: " $status_fhd
	status_uhd=$( f_downloadWallpaper $WALLPAPER_UHD $url_uhd)
	echo "UHD wallpaper download: " $status_uhd
}

function f_downloadWallpaper {
	wallpaper=$1
	url=$2

	status=`(wget -O $wallpaper -- $url &>/dev/null && echo OK) || echo Fail`
	
	if [[ "$status" != "OK" || ! -s $wallpaper ]]
	then
		echo "Fail"
		return
	fi
	
	isImage=$( f_isImage $wallpaper)
	if [[ isImage -eq 1 ]]
	then
		echo "OK"
	else
		rm -f $wallpaper
		echo "Fail"
	fi
}

function f_setWallpaper {
	if [[ -s $WALLPAPER ]]
	then
		cp $WALLPAPER $WALLS_DIR/login-background.jpg
		mogrify -channel RGBA -blur 0x6 $WALLS_DIR/login-background.jpg
		feh --bg-fill $WALLPAPER
	else
		feh --randomize --bg-fill $SET_DIR/*
	fi
}

if [[ ! -s $WALLPAPER ]]
then
	f_downloadWallpapers
fi

f_setWallpaper
