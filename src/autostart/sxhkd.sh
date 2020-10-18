#!/bin/sh
# ---
# This script launches the sxhkd daemon in background.
# ---

killall sxhkd > /dev/null 2>&1

# Fix clipmenu mode for rofi
export CM_LAUNCHER=rofi-script

sxhkd > /dev/null 2>&1 &
