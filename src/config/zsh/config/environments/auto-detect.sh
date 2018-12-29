#!/bin/bash

# Wired internet interface for polybar
export ETH=$(ifconfig | grep enp | cut -d ':' -f1)

# Battery name
export POWER=`ls /sys/class/power_supply | grep AC`

# Path to temperature source
export TMP="$(find /sys/devices -name temp1_input | head -n 1)"

# Wireless internet interface for polybar
export WLAN=$(ifconfig | grep wlp | cut -d ':' -f1)

# Monitors
export PRIMARY=
export SECONDARY=

total=$(mons | grep enabled | wc -l)
for m in `mons | grep enabled | sed "s/\s\+/ /g" | cut -d' ' -f2 | sort`; do
    case "$m" in
        eDP1 )
            SECONDARY="$PRIMARY"
            PRIMARY="$m"
            ;;
        LVDS-1 )
            SECONDARY="$PRIMARY"
            PRIMARY="$m"
            ;;
        HDMI* )
            if [[ "$PRIMARY" == "" ]] || \
                    ([[ "$PRIMARY" != "DP1" ]] && \
                    [[ "$PRIMARY" != "eDP1" ]] && \
                    [[ "$PRIMARY" != "LVDS-1" ]]); then
                SECONDARY="$PRIMARY"
                PRIMARY="$m"
            else
                SECONDARY="$m"
            fi
            ;;
        DP* )
            if [[ "$PRIMARY" != "LVDS-1" ]] && [[ "$PRIMARY" != "eDP1" ]] \
                    || ([[ "$PRIMARY" == "eDP1" ]] && [[ $total -eq 3 ]]); then
                SECONDARY="$PRIMARY"
                PRIMARY="$m"
            else
                SECONDARY="$m"
            fi
            ;;
        VGA* )
            if  [[ "$PRIMARY" == "LVDS-1" ]]; then
               SECONDARY="VGA-1"
            else
                SECONDARY="$PRIMARY";
                PRIMARY="VGA-1"
            fi
            ;;
    esac
done;
