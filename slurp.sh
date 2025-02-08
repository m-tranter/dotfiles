#!/bin/bash

file=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 3 | head -n 1)
selection=$(slurp -d) 
grim -g "$selection" "/home/mark/Downloads/temp/$file.png"
grim -g "$selection" - | wl-copy 
