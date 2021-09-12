#!/bin/sh

picom &
dunst &
feh --bg-fill --randomize ~/.dotfiles/wallpapers &
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
