#!/bin/bash

# ---
# Shows the help message and exits.
# ---
function help() {
    echo "Usage: $0 ACTION [OPTIONS]"
    echo ""
    echo "   Defines actions to check current hamster status"
    echo ""
    echo "Options:"
    echo "   -b, --inactive-bg  Configure background color for inactive status"
    echo "   -f, --inactive-fg  Configure foreground color for inactive status"
    echo ""
    echo "Actions:"
    echo "   help               Show this help message"
    echo "   notify             Send a notification with current hamster status"
    echo "   open               Open hamster"
    echo "   show               Show the hamster icon"
    echo "   stop               Stop the current hamster task"

    exit
}

# ---
# Checks if hamster is tracking a task.
# ---
function isActive() {
    command -v hamster > /dev/null 2>&1 || return 1

    if [[ "$(hamster current)" != "No activity" ]]; then
        return 0
    fi

    return 1
}

# ---
# Displays hamster information.
# ---
function main() {
    ICON="ﱔ"
    BACKGROUND_START=
    BACKGROUND_END=
    FOREGROUND_START=
    FOREGROUND_END=
    NOTIFICATIONS="yes"

    command -v bspwm > /dev/null 2>&1 || return

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b | --inactive-bg )
                BACKGROUND_START="%{B$2}"
                BACKGROUND_END="%{B-}"
                shift
                ;;

            -f | --inactive-fg )
                FOREGROUND_START="%{F$2}"
                FOREGROUND_END="%{F-}"
                shift
                ;;

            *)
                if [[ "$action" != "" ]]; then
                    echo "Unrecognized action $1"
                    exit
                fi

                action=$1
                ;;
        esac

        shift
    done

    case "$action" in
        help)
            help
            ;;

        notify)
            notify
            ;;

        open)
            open
            ;;

        show)
            show
            ;;

        stop)
            stop
            ;;
    esac
}

# ---
# Displays a notification with the current hamster task.
# ---
function notify() {
    text="Hamster not found"
    icon="error"

    if command -v hamster > /dev/null 2>&1; then
        text=$(hamster current | cut -d ' ' -f 3)
        icon="task-due"
    fi

    sendNotification "Hamster" "$text" $icon
}

# ---
# Opens hamster
# ---
function open() {
    command -v hamster > /dev/null 2>&1 || return 1

    hamster &
}

# ---
# @param $1 The notification title.
# @param $2 The notification text.
# @param $3 The notification icon.
# ---
function sendNotification() {
    local title="$1"

    if command -v dunstify &>/dev/null; then
        notify="dunstify --replace 578624254"
    else
        notify="notify-send"
    fi

    $notify "$title" "$2" --icon=$3 &
}

# ---
# Displays the current hamster status.
# ---
function show() {
    if ! $(isActive); then
        echo $BACKGROUND_START$FOREGROUND_START$ICON$FOREGROUND_END$BACKGROUND_$END
    else
        echo $ICON
    fi
}

# ---
# Stops the current task.
# ---
function stop() {
    command -v hamster > /dev/null 2>&1 || return 1

    hamster stop
}

main $@
