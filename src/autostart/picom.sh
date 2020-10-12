#!/bin/sh
# ---
# This script launches the compton compositor in background.
# ---

killall picom > /dev/null 2>&1

if [ -f $HOME/.picom.conf ]; then
    /usr/bin/picom &
fi
