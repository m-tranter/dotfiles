#!/bin/bash

file=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 3 | head -n 1)
grim  "/home/mark/Downloads/temp/$file.png"
