#!/bin/bash

file=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 3 | head -n 1)
selection=$(hacksaw) 
shotgun -g "$selection" "/home/mark/Downloads/temp/$file.png"
shotgun -g "$selection" - | xclip -t 'image/png' -selection clipboard
