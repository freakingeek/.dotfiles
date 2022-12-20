#! /bin/sh

(setxkbmap -query | grep -q "layout:\s\+us") && setxkbmap ir -option grp_led:caps || setxkbmap us -option grp_led:caps