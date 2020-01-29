#!/bin/sh -e

##----------------------------------------------##
## set random wallpaper from PATH               ##
##----------------------------------------------##

PATH="~/Pictures/backgrounds/"

feh --randomize --bg-fill ${PATH}*
