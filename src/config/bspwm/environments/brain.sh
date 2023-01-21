#!/bin/bash

PRIMARY_INDEX=$(mons | grep " $PRIMARY " | cut -d':' -f1)
SECONDARY_INDEX=$(mons | grep " $SECONDARY " | cut -d':' -f1)

if [[ "$PRIMARY_INDEX" == "" ]]; then
    export PRIMARY="eDP-1"
    export SECONDARY=""

    PRIMARY_INDEX=$SECONDARY_INDEX
fi

mons -O $PRIMARY_INDEX
bspc monitor $PRIMARY -d 1 2 3 4 5 6
