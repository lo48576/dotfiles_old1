#!/bin/sh

THEME="$( cat "$0".conf )"

DISPLAY_NUM=3
#FILENAMES="\"$( find ~/Pictures/backgrounds/${THEME}/ -print0 -type f -or -type l | shuf -z -n "${DISPLAY_NUM}" | head -c -1 | sed -e 's/\x0/" "/g' )\""
FILENAMES="$( find ~/Pictures/backgrounds/${THEME}/ -print0 -type f -or -type l | shuf -z -n "${DISPLAY_NUM}" | tr '\0' ' ' )"

feh --bg-scale ${FILENAMES}
echo ${FILENAMES}


#FILENAME="$( find ~/Pictures/backgrounds/${THEME}/ -type f -or -type l | shuf -n 1 )"
#feh --bg-scale "$FILENAME"
#echo "$FILENAME"

