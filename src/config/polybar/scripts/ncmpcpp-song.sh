#!/bin/bash

# ---
# Returns album of the current song.
#
# @param $1 The current song information.
#
# @return The album of the current song.
# ---
function getAlbum() {
    echo $1 | cut -d '/' -f2 | sed -e "s/^\s\+//g" -e "s/\s\+$//g"
}

# ---
# Returns the artisg of the current song.
#
# @param $1 The current song information.
#
# @return The artist of the current song.
# ---
function getArtist() {
    echo $1 | cut -d '/' -f1 | sed -e "s/^\s\+//g" -e "s/\s\+$//g"
}

# ---
# Retuns the information of the current song from ncmpcpp.
#
# @return The information of the current song.
# ---
function getInformation() {
    if [[ ! -x `command -v ncmpcpp` ]]; then
        exit
    fi

    info=$(ncmpcpp --current-song "%a / %b / %t")

    if [[ "$info" == "" ]]; then
        exit
    fi

    echo $info
}

# ---
# Returns the title of the current song.
#
# @param $1 The current song information.
#
# @return The title of the song.
# ---
function getTitle() {
    echo $1 | cut -d '/' -f3 | sed -e "s/^\s\+//g" -e "s/\s\+$//g"
}

# ---
# Shows the help message and exits.
# ---
function help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "   Displays a notification with the current playing song"
    echo ""
    echo "Options:"
    echo "   -a, --artist       Include the artist name in the notification"
    echo "   -b, --album        Include the album title in the notification"
    echo "   -h, --help         Show this help message"

    exit
}

# ---
# Sends a notification with the current song infomation.
# ---
function main() {
    local showAlbum=false
    local showArtist=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -a | --artist )
                showArtist=true
                ;;

            -b | --album )
                showAlbum=true
                ;;

            -h | --help )
                help
                ;;

            *)
                echo "Unrecognized option $1"
                help
                ;;
        esac

        shift
    done

    local info=$(getInformation)
    local artist=$(getArtist "$info")
    local album=$(getAlbum "$info")
    local song=$(getTitle "$info")

    local title="$song"
    local text=

    if $showArtist; then
        text="$title"
        title="$artist"
    fi

    if $showAlbum; then
        if [[ "$text" = "" ]]; then
            title="$album"
            text="$song"
        else
            text="$album - $song"
        fi
    fi

    sendNotification "$title" "$text" "music-player"
}

# ---
# @param $1 The notification title.
# @param $2 The notification text.
# @param $3 The notification icon.
# ---
function sendNotification() {
    if [[ "$NOTIFICATIONS" == "no" ]]; then
        return
    fi

    local title="$1"

    if command -v dunstify &>/dev/null; then
        notify="dunstify --replace 201839192"
    else
        notify="notify-send"
    fi

    $notify "$title" "$2" --icon=$3 &
}

main $@
