#!/bin/bash

# ---
# Decreases the volume for the current sink.
# ---
function decreaseVolume() {
    local sink=$(getSink)
    local volume=$(getVolume "$sink")
    local newVolume=$((volume - STEP))

    setVolume $newVolume
}

# ---
# Returns the name for the provided sink.
#
# @param $1 The sink index.
#
# @return The name for the sink.
# --
function getName() {
    pactl list sinks short | awk -v sink="$1" '{ if ($1 == sink) {print $2} }'
}

# ---
# Returns the current sink. It will show a notification and exit the script
# when pulseaudio returns an error.
#
# @return The current sink.
# ---
function getSink() {
    local sink=

    if pulseaudio --check; then
        sink=$(pacmd list-sinks | awk '/\* index:/{print $3}')
    fi

    if [[ "$sink" == "" ]]; then
        sendNotification "Volume" "Unable to get sink"
        exit
    fi

    echo $sink
}

# ---
# Returns the list of sink inputs based on the current sink index.
#
# @param $1 The sink index.
#
# @return The list of sink inputs.
# ---
function getInputs() {
    pacmd list-sink-inputs | grep -B 4 "sink: $1 " | awk '/index:/{print $2}'
}

# ---
# Returns the volume for the provided sink.
#
# @param $1 The sink index.
#
# @return The volume of the current sink.
# ---
function getVolume() {
    pacmd list-sinks | grep -A 15 'index: '"$1"'' | grep 'volume:' \
        | grep -E -v 'base volume:' | awk -F : '{print $3; exit}' \
        | grep -o -P '.{0,3}%' | sed 's/.$//' | tr -d ' '
}

# ---
# Increases the volume for the current sink.
# ---
function increaseVolume() {
    local sink=$(getSink)
    local volume=$(getVolume "$sink")
    local newVolume=$(($(getVolume "$sink") + STEP))

    setVolume $newVolume
}

# ---
# Returns the muted status for the provided sink.
#
# @param $1 The sink index.
#
# @return The current muted status (yes/no).
# ---
function isMuted() {
    pacmd list-sinks | grep -A 15 "index: $1" | awk '/muted/ {print $2; exit}'
}

# ---
# Listens for changes and updates the output for the bar.
#
# Note: This is faster than having the script on an interval.
# ---
function listen() {
    local firstRun=0

     pactl subscribe 2>/dev/null | {
        while true; do
            {
                # If this is the first time just continue and print the current
                # state. Otherwise wait for events. This is to prevent the
                # module being empty until an event occurs.
                if [ $firstRun -eq 0 ]; then
                    firstRun=1
                else
                    read -r event || break
                    # Avoid double events
                    if ! echo "$event" | grep -e "on card" -e "on sink" -e "on server"; then
                        continue
                    fi
                fi
            } &>/dev/null
            show
        done
    }
}

# ---
# Changes the mute/unmute volume for the current sink.
#
# @param $1 The action to execute (mute/unmute/toggle).
# ---
function mute() {
    sink=$(getSink)
    muted=$(isMuted $sink)

    if [[ "$1" == "mute" ]] || ([[ "$1" == "toggle" ]] && [[ "$muted" == "no" ]]); then
        pactl set-sink-mute "$sink" "yes"
        sendNotification "Volume" "Mute: on" "audio-volume-low"
        return
    fi

    pactl set-sink-mute "$sink" "no"
    sendNotification "Volume" "Mute: off" "audio-volume-high"
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

    $notify "$title" "$2" --icon=$3 &
}

# --
# Changes the volume to the specified value.
#
# @param $1 The volume value.
# --
function setVolume() {
    local sink=$(getSink)
    local volume=$(getVolume "$sink")

    if [ "$1" -le "$MAX_VOL" ] && [ "$1" -ge "0" ]; then
        volume=$1
    fi

    pactl set-sink-volume "$sink" "$volume%"
    sendNotification "Volume" "$volume%" "audio-volume-high"
}

# ---
# Synchronizes the volume between sinks with the volume of the current sink.
# ---
function synchronize() {
    if [[ "$AUTOSYNC" = "no" ]]; then
        return
    fi

    local sink=$(getSink)
    local volume=$(getVolume "$sink")
    local inputs=$(getInputs "$sink")

    for input in $inputs; do
        pactl set-sink-input-volume "$input" "$volume%"
    done
}

function show() {
    sink=$(getSink)
    volume=$(getVolume "$sink")
    muted=$(isMuted "$sink")

    # Fixed volume icons over max volume
    local iconsLen=${#VOLUME_ICONS[@]}
    if [ "$iconsLen" -ne 0 ]; then
        local volSplit=$((MAX_VOL / iconsLen))
        for i in $(seq 1 "$iconsLen"); do
            if [ $((i * volSplit)) -ge "$volume" ]; then
                volIcon="${VOLUME_ICONS[$((i-1))]}"
                break
            fi

            volIcon=""
        done
    else
        volIcon=""
    fi

    # Showing the formatted message
    if [ "$muted" = "yes" ]; then
        echo "$MUTED_BACKGROUND_START$MUTED_FOREGROUND_START$MUTED_ICON$MUTED_FOREGROUND_END$MUTED_BACKGROUND_END"
    else
        echo "${volIcon}"
    fi
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
    echo "   -b, --muted-bg     Configure background color for muted status"
    echo "   -f, --muted-fg     Configure foreground color for muted status"
    echo "   -s, --step         Configure the step for up/down actions"
    echo ""
    echo "Actions:"
    echo "   help               Show this help message"
    echo "   listen             Listen for PulseAudio and update the output"
    echo "   down               Decrease the default sink's volume"
    echo "   mute               Mute or unmute the default sink's audio"
    echo "   show               Show the volume icon"
    echo "   toggle             Toggle muted/unmuted status"
    echo "   unmute             Unmute the default sink's audio"
    echo "   up                 Increase the default sink's volume"

    exit
}

# ---
# Changes the volume and sends a notification.
# ---
function main() {
    STEP=5
    MAX_VOL=100
    VOLUME=0
    VOLUME_ICONS=( "" "" "" )
    MUTED_ICON="ﱝ"
    MUTED_BACKGROUND_START=
    MUTED_BACKGROUND_END=
    MUTED_FOREGROUND_START=
    MUTED_FOREGROUND_END=

    # Environment & global constants for the script

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b | --muted-bg )
                MUTED_BACKGROUND_START="%{B$2}"
                MUTED_BACKGROUND_END="%{B-}"
                shift
                ;;

            -f | --muted-fg )
                MUTED_FOREGROUND_START="%{F$2}"
                MUTED_FOREGROUND_END="%{F-}"
                shift
                ;;

            -s | --step )
                STEP=$1
                shift
                ;;

            -v | --volume )
                VOLUME=$2
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
        down)
            decreaseVolume
            synchronize
            ;;

        help)
            help
            ;;

        listen)
            listen
            ;;

        mute | toggle | unmute)
            mute $action
            synchronize
            ;;

        set)
            setVolume $VOLUME
            ;;

        show)
            show
            ;;

        up)
            increaseVolume
            synchronize
            ;;

    esac
}

main $@
