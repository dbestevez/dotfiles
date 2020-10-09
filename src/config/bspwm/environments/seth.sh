#!/bin/bash

PRIMARY_INDEX=$(mons | grep " $PRIMARY " | cut -d':' -f1)
SECONDARY_INDEX=$(mons | grep " $SECONDARY " | cut -d':' -f1)

mons -S $SECONDARY_INDEX,$PRIMARY_INDEX:R

bspc monitor $PRIMARY   -d 1 2 3
bspc monitor $SECONDARY -d 4 5 6
