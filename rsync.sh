#!/bin/bash
set -e
src_dir="$HOME/"
dest_dir="/run/media/mark/MARK_1TB/dell"

# run rsync
rsync -a --delete \
  --filter=':- .gitignore' \
  --exclude='node_modules' \
  --exclude='.thumbnails' \
  --exclude='Downloads' \
  --exclude='.cache' \
  --exclude='.git' \
  --chmod='F-w' \
  "$src_dir" "$dest_dir"
