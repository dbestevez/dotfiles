#!/bin/bash

# Configure monitors
if [[ "$PRIMARY" != "LVDS-1" ]] && [[ "$PRIMARY" != "eDP1" ]]; then
    # Turn off built-in display
    xrandr --output eDP1 --off

    p=$(mons | grep " $PRIMARY " | cut -d':' -f1)
    s=$(mons | grep " $SECONDARY " | cut -d':' -f1)

    mons -S $p,$s:R
else
    mons -e left
fi

if [[ "$SECONDARY" == "" ]]; then
    bspc monitor $PRIMARY -d web music extra code ssh extra
else
    bspc monitor $PRIMARY   -d web  music extra
    bspc monitor $SECONDARY -d code ssh   extra
fi
