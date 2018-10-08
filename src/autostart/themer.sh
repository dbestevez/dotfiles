#!/bin/sh
# ---
# This script lauches the themer script at startup, if present. It assumes that
# the themer will be installed at $HOME/.themer.
#
# The themer script is a theme manager to configure bspwm, polybar, rofi and
# some terminal-based applications.
#
# It can be downloaded at https://github.com/dbestevez/themer.git
# ---

if [[ -f $HOME/.themer/themer ]]; then
    sh $HOME/.themer/themer
fi
