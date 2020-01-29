#!/bin/bash

##----------------------------------------------##
##	translate to LANG selected text        		##
##----------------------------------------------##

LANG=ru

TEXT=$(xclip -selection primary -o)
TRANS=$(trans -b :"$LANG" "$TEXT")
b=${TRANS//null/}
#echo $b
if [ "$b" ]; then
	notify-send "ПЕРЕВОД:" "$b"
else
	notify-send "ОШИБКА:" "Нет связи с сервисом"
fi
