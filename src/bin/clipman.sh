#!/usr/bin/bash

# ---
# Copies the provided text to the primary clipboard to be able to paste it.
# ---
function copyEntry() {
    wl-copy "$(echo -e "$@")"
}

# ---
# Displays the list of all entries in the clipboard.
# ---
function showEntries() {
    entries=$(cat ~/.local/share/clipman.json | jq | \
        sed -e "s/\",$/\"/g" | sed -e "s/^\s\s\"//g" -e "s/\"$//g" | \
        head -n -1 | tail -n +2 | \
        tac | \
        sed -e "s/^\s*\"//g" -e "s/\",$//g")

    while read -r line; do
        echo "$line" | sed -e 's/\\"/\"/g'
    done <<< $entries
}

# ---
# Displays the list of entries or copies an entry based on the provided
# arguments.
# ---
function main() {
    # If an option provided to the script
    if [[ "$@" != "" ]]; then
        copyEntry "$@";
        exit 0;
    fi

    showEntries
}

main "$@"
