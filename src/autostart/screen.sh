#!/bin/sh
# ---
# This script prevents screen to turn off when idle.
# ---

xset -dpms
xset s noblank
xset s off

xrandr --output HDMI-1 --mode 3840x2160 --scale 1 --dpi 144
