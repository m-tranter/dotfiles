#!/bin/bash

setxkbmap gb
xmodmap -e 'clear Lock' -e 'keycode 0x42=Escape'
