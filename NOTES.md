# Tap to Click
You should create this file `/etc/X11/xorg.conf.d/50-synaptics.conf` with content below:

```sh
Section "InputClass"
  Identifier "touchpad"
  Driver "synaptics"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "TapButton1" "1"
  Option "TapButton2" "3" # Open context menu
  Option "NaturalScrolling" "true"
EndSection
```