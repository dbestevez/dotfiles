#!/bin/bash

PRIMARY_INDEX=$(mons | grep " $PRIMARY " | cut -d':' -f1)
SECONDARY_INDEX=$(mons | grep " $SECONDARY " | cut -d':' -f1)

mons -S $SECONDARY_INDEX,$PRIMARY_INDEX:R

bspc monitor $PRIMARY   -d web  music extra
bspc monitor $SECONDARY -d code ssh   extra
