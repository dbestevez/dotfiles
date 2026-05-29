#!/usr/bin/bash

# ---
# Displays the list of all entries in the clipboard.
# ---
function showEntries() {
    echo -e "󰹑  Capture screen                                           "
    echo -e "  Capture active window                                    "
    echo -e "󰩬  Capture area                                             "
    echo -e "󰹑  Capture and save screen                                  "
    echo -e "  Capture and save active window                           "
    echo -e "󰩬  Capture and save area                                    "
}

function captureActiveWindow() {
    (
        hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - - | wl-copy
    ) >/dev/null 2>&1 </dev/null &

    disown
}

function captureActiveWindowAndSave() {
    (
        sleep 0.5
        hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - ~/Pictures/screenshots/window_$(date "+%Y-%m-%d_%H:%M:%S").png
    ) >/dev/null 2>&1 </dev/null &

    disown
}

function captureArea() {
    (
        slurp | grim -g - - | wl-copy
    ) >/dev/null 2>&1 </dev/null &

    disown
}

function captureAreaAndSave() {
    (
        slurp | grim -g - ~/Pictures/screenshots/area_$(date "+%Y-%m-%d_%H:%M:%S").png
    ) >/dev/null 2>&1 </dev/null &

    disown
}

function captureScreen() {
    (
        grim -g - - | wl-copy
    ) >/dev/null 2>&1 </dev/null &

    disown
}

function captureScreenAndSave() {
    (
        sleep 0.5
        grim ~/Pictures/screenshots/screen_$(date "+%Y-%m-%d_%H:%M:%S").png
    ) >/dev/null 2>&1 </dev/null &

    disown
}

# ---
# Displays the list of entries or copies an entry based on the provided
# arguments.
# ---
function main() {
    case "$@" in
        "capture-active-window"|"  Capture active window                                    ")
            action="captureActiveWindow"
            ;;

        "capture-active-window-save"|"  Capture and save active window                           ")
            action="captureActiveWindowAndSave"
            ;;

        "capture-area"|"󰩬  Capture area                                             ")
            action="captureArea"
            ;;

        "capture-area-save"|"󰩬  Capture and save area                                    ")
            action="captureAreaAndSave"
            ;;

        "capture-screen"|"󰹑  Capture screen                                           ")
            action="captureScreen"
            ;;

        "capture-screen-save"|"󰹑  Capture and save screen                                  ")
            action="captureScreenAndSave"
            ;;

        *)
            action="showEntries"
    esac

    $action
}

main "$@"
