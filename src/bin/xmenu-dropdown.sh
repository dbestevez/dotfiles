#!/bin/sh

cat <<EOF | xmenu -i -p 0x30:$MENU_MONITOR | sh
ﬓ  Applications
	  Google Chrome	google-chrome-stable &
	  Firefox	firefox &
	  Thunderbird	thunderbird &
	  Kitty	kitty &
  System
	  Sound	gnome-control-center sound &
	酪  Network	gnome-control-center network &
襤  Power
	  Lock	betterlockscreen -l blur
	
	累  Reboot	reboot
	襤  Shutdown	poweroff
EOF
