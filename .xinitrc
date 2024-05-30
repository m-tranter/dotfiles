#!/bin/sh
userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xsetroot -solid \#333333 
setxkbmap gb
xmodmap -e 'clear Lock' -e 'keycode 0x42=Escape'
xmodmap -e 'keycode 135 = grave'
.screenlayout/one.sh
exec i3 
