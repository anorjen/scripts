#!/bin/bash

#_______________________________________________________________________________
#----------------- script for i3blocks microphone toggle -----------------------

MIXER="pulse"
SCONTROL="Capture"
STEP="${1:-5%}"

case $BLOCK_BUTTON in
  3) amixer -q -D $MIXER sset $SCONTROL toggle ;;  # right click, mute/unmute
  4) amixer -q -D $MIXER sset $SCONTROL ${STEP}+ cap ;; # scroll up, increase
  5) amixer -q -D $MIXER sset $SCONTROL ${STEP}- cap ;; # scroll down, decrease
esac

statusLine=$(amixer get Capture | tail -n 1)
status=$(echo "${statusLine}" | grep -wo "on")
volume=$(echo "${statusLine}" | tr -d 'a-zA-Z:[]%' | awk -F ' ' '{print $2}')

if [[ "${status}" == "on" ]]; then
  echo "${volume}%"
  echo "${volume}%"
  echo ""
else
  echo "OFF"
  echo "OFF"
  echo ""
fi
