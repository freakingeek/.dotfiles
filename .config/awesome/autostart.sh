#!/bin/sh

nm-applet &
picom --experimental-backends &
feh --bg-fill ~/.local/share/backgrounds/lonely-fish.png &
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
