#!/bin/bash

# -e: exit immediately when called command exits with non-zero.
# -u: error when expanding unset variables.
set -eu

declare -r ENTRY_NAME="$1"
declare -r FILE="$2"

# grep -v '^#'
#    remove comment line (which begins with '#').
# sed -ne '/^\['"$2"'\]$/,$p'
#    print only after the target entriy ("[FOO]").
# tail -n +2
#    skip the first line (whose content is "[FOO]").
# sed -e '/^\[.*\]$/,$d'
#    remove the entry name line ("[FOO]").
(grep -v '^#' "$FILE" | sed -ne '/^\['"$ENTRY_NAME"'\]$/,$p' | tail -n +2 | sed -e '/^\[.*\]$/,$d') 2>/dev/null

# grep -v '^#'
#    remove comment line (which begins with '#').
# sed -e 's/^\[/\x0[/'
#    insert null character at beginning of each entries ("[FOO]").
#                                                    ^before here
# sed -zne '/^\['"$2"'\]\n/s/^\['"$2"'\]\n//p'
#    find the entry and remove the entry name line ("[FOO]").
# tr -d '\0'
#    remove null character (at the end of the string).
#(grep -v '^#' "$FILE" | sed -e 's/^\[/\x0[/' | sed -zne '/^\['"$ENTRY_NAME"'\]\n/s/^\['"$ENTRY_NAME"'\]\n//p' | tr -d '\0') 2>/dev/null
