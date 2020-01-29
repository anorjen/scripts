#!/bin/sh -e

##----------------------------------------------##
##	set off screen if screen locked             ##
##----------------------------------------------##

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
