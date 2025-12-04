#!/bin/bash

# ---
# Decreases the volume for the current sink.
# ---
function decreaseVolume() {
    setVolume 1%-
}

# ---
# Returns the icon based on the current muted status and the current volume.
# ---
function getIcon() {
    muted=$(isMuted)
    volume=$(getVolume)
    prefix="audio-volume"

    if [[ "$SINK" = "@DEFAULT_SOURCE@" ]]; then
        prefix="audio-input-microphone"
    fi

    if [[ $muted -eq 0 ]]; then
        if [[ "$SINK" = "@DEFAULT_SOURCE@" ]]; then
            echo "$prefix-muted"
        else
            echo "$prefix-off"
        fi
    elif [[ $volume -lt 30 ]]; then
        echo "$prefix-low"
    elif [[ $volume -lt 60 ]]; then
        echo "$prefix-medium"
    else
        echo "$prefix-high"
    fi
}

# ---
# Returns the volume for the provided sink.
#
# @return The volume of the current sink.
# ---
function getVolume() {
    volume=$(wpctl get-volume $SINK | sed -e "s/Volume: //g" -e "s/\[MUTED\]//g")
    volume=$(echo "scale=0; $volume*100/1" | bc)

    echo $volume
}

# ---
# Increases the volume for the current sink.
# ---
function increaseVolume() {
    setVolume 1%+
}

# ---
# Returns the muted status for the provided sink.
#
# @return The current muted status (0/1).
# ---
function isMuted() {
    wpctl get-volume $SINK | grep "MUTED" -q && echo 0 || echo 1
}

# ---
# Changes the mute/unmute volume for the current sink.
#
# @param $1 The action to execute (mute/unmute/toggle).
# ---
function mute() {
    muted=$(isMuted)
    msg="Mute: on"

    if [[ "$1" == "mute" ]] || ([[ "$1" == "toggle" ]] && [[ "$muted" -eq 1 ]]); then
        wpctl set-mute $SINK 1
    else
        msg="Mute: off"
        wpctl set-mute $SINK 0
    fi

    icon=$(getIcon $SINK)

    sendNotification "Volume" "$msg" "$icon"
}

# ---
# Displays a notification.
#
# @param $1 The notification title.
# @param $2 The notification text.
# @param $3 The notification icon.
# ---
function sendNotification() {
    local title="$1"

    if command -v dunstify &>/dev/null; then
        notify="dunstify --replace 201839192"
    else
        notify="notify-send"
    fi

    $notify "$title" "$2" --icon=$3
}

# --
# Changes the volume to the specified value.
#
# @param $1 The volume value.
# --
function setVolume() {
    wpctl set-volume -l 1 $SINK $1

    volume=$(getVolume)
    icon=$(getIcon $SINK)

    sendNotification "Volume" "$volume%" "$icon"
}

# ---
# Shows the help message and exits.
# ---
function help() {
    echo "Usage: $0 ACTION [OPTIONS]"
    echo ""
    echo "   Defines actions to check and modify the current volume"
    echo ""
    echo "Options:"
    echo "   -v, --volume       The volume to set in set action"
    echo ""
    echo "Actions:"
    echo "   help               Show this help message"
    echo "   down               Decrease the default sink's volume"
    echo "   mute               Mute or unmute the default sink's audio"
    echo "   set                Sets the volume in the default sink's audio"
    echo "   toggle             Toggle muted/unmuted status"
    echo "   unmute             Unmute the default sink's audio"
    echo "   up                 Increase the default sink's volume"

    exit
}

# ---
# Changes the volume and sends a notification.
# ---
function main() {
    SINK="@DEFAULT_AUDIO_SINK@"

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -v | --volume )
                VOLUME=$2
                shift
                ;;

            -s | --source )
                SINK="@DEFAULT_SOURCE@"
                ;;

            *)
                action=$1
                ;;
        esac

        shift
    done

    case "$action" in
        down)
            decreaseVolume
            ;;

        help)
            help
            ;;

        mute | toggle | unmute)
            mute $action
            ;;

        set)
            if [[ "$VOLUME" == "" ]]; then
                echo "Missing volume for set action";
                exit
            fi

            setVolume $VOLUME
            ;;

        up)
            increaseVolume
            ;;

    esac
}

main $@
