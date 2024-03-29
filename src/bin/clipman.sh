#!/usr/bin/bash

# ---
# Copies the provided text to the primary clipboard to be able to paste it.
# ---
function copyEntry() {
    wl-copy "$(echo "$@" | sed -e "s/↵/\n/g" -e "s/\\\\\\\/\\\/g")"
}

# ---
# Displays the list of all entries in the clipboard.
# ---
function showEntries() {
    entries=$(clipman show-history | jq | \
        sed -e "s/\\\n/↵/g" | \
        head -n -1 | tail -n +2 | \
        tac | \
        sed -e "s/^\s*\"//g" -e "s/\",$//g")

    while read -r line; do
        echo "$line"
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
