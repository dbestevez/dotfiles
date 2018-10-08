#!/bin/sh
# ---
# This script configures the keyboard to:
#    - Convert Caps_Lock to Escape when pressed alone
#    - Convert Caps_Lock to Ctrl when pressed in combination with other keys
#    - Convert Tabs to Mode_switch
#
# The configurations for Mode_switch are included in the .Xmodmap file and add
# support to use hjkl keys when Tab key pressed as arrow keys.
# ---

# Kill other xcape instances to prevent double mapping
killall xcape 2>&1 > /dev/null

# Select layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl

# Increase key repetition
xset r rate 200 60

# Alt + hjkl to Arrow Keys
xmodmap $HOME/.Xmodmap

# Caps to Ctrl and Escape
xcape -e 'Control_L=Escape'

# Tab to Mode_switch
xcape -e 'Mode_switch=Tab'
