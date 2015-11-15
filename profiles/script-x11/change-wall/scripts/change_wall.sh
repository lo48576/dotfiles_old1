#!/bin/sh

THEME="$( cat "$0".conf )"

DISPLAY_NUM=3
FILENAMES="$( find ~/Pictures/backgrounds/${THEME}/ \( -type f -o -type l \) -print0 | shuf -z -n "${DISPLAY_NUM}" | tr '\0' ' ' )"

feh --bg-scale ${FILENAMES}
echo ${FILENAMES}
