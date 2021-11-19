#!/bin/sh

dunst &
np-applet &
light-locker &
picom --experimental-backends &
feh --bg-fill ~/.local/share/backgrounds/03.jpg
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
