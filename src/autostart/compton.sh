#!/bin/sh
# ---
# This script launches the compton compositor in background.
# ---

killall compton

compton --respect-prop-shadow &
