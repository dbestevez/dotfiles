#!/bin/bash
# ---
# This script launches the clipmenu daemon in background.
# ---

ps aux | grep clipmenu | grep bash | \
    sed -e "s/\s\+/ /g" | cut -d ' ' -f 2 | \
    xargs kill -9

systemctl --user import-environment DISPLAY

clipmenud &
