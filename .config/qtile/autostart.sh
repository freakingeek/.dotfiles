#!/bin/sh

dunst &
picom --experimental-backends &
feh --bg-fill --randomize ~/.dotfiles/wallpapers &
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
