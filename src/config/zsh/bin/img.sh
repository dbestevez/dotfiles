#!/bin/sh

#### Determine size of Terminal
height=`stty  size | awk 'BEGIN {FS = " "} {print $1;}'`
width=`stty  size | awk 'BEGIN {FS = " "} {print $2;}'`

dimension=$(identify -ping -format "%w,%h\n" "$1" | head -n 1)
width=$(echo "$dimension" | cut -d',' -f1)
height=$(echo "$dimension" | cut -d',' -f2)

### Display Image / offset with mutt bar
echo -e "2;3;\n0;1;240;240;$((width));$((height));0;0;0;0;$1\n4;\n3;" |  /usr/lib/w3m/w3mimgdisplay &
