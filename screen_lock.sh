#!/bin/sh -e

##----------------------------------------------##
##	lock with i3lock                            ##
##  Pixellate or Blur                           ##
##----------------------------------------------##

# Take a screenshot
scrot -o /tmp/screen_locked.png

## Pixellate it 10x
# mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Blur
mogrify -channel RGBA -blur 0x6 /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -e -i /tmp/screen_locked.png
