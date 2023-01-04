#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

sudo dhcpcd &
xsetroot -solid \#333333 
xsetroot -cursor_name left_ptr
xbindkeys
xset s off
xset -dpms
xset s noblank
kbdrate -d 400 -r 25
setxkbmap gb
xmodmap -e 'clear Lock' -e 'keycode 0x42=Escape'
xmodmap -e "keycode 108 = Alt_L"
xmodmap -e "keycode 135 = Delete"
numlockx 
batti.sh &
evilwm -app xclock/XClock -s &
exec xclock -brief -bg \#333333 -fg \#00AF00 -padding 2 -bw 0 -g +1287+2
