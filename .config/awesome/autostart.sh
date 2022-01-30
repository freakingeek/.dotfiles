#!/bin/sh

picom --experimental-backends &
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &