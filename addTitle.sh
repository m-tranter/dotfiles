#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
for f in `find . -type f`  
do 
    type="$(file -b $f)"
    if [ "${type%%,*}" == "PDF document" ]; then
      title=`exiftool -Title $f` 
      if [ -z "$title" ]
      then
        title=${f##*/}
        title=${title%.*}
        exiftool -Title="$title" "$f"
        rm "${f}_original"
        echo "$title"
      else
        rm $f
      fi
    fi
done
IFS="$OIFS"

