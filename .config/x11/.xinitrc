#!/bin/sh

# dunst &
# feh --bg-fill --randomize ~/.dotfiles/wallpapers &
# gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

exec qtile start
