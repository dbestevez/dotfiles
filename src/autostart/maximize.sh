#/bin/sh
# ---
# Some applications in bspwm are not maximized by default and always require an
# extra action to maximize them.
#
# This script automatically maximizes all windows in the list.
# ---

# The list of applications to handle
applications="Chrome Chromium"

# Parse applications for sed command
applications=$(echo $applications | sed -e "s/\s\+/\\\|/g")

while true; do
    windows=$(wmctrl -l | grep "$applications" | cut -d ' ' -f 1)

    for window in $windows; do
        wmctrl -ir $window -b add,maximized_vert,maximized_horz
    done

    sleep 10
done &
