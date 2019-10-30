#!/bin/sh
# ---
# This script launches the compton compositor in background.
# ---

killall compton > /dev/null 2>&1

if [ -f $HOME/.compton.conf ]; then
    /usr/bin/compton --respect-prop-shadow &
fi
