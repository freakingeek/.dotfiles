#! /bin/sh

(setxkbmap -query | grep -q "layout:\s\+us") && setxkbmap ir || setxkbmap us