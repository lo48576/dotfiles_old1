#!/bin/sh

cd "`dirname "$0"`"
DOTFILES_DIR="`pwd`"
HOSTNAME="`hostname`"

DOTFILES_COMMON="${DOTFILES_DIR}/common"
DOTFILES_COMMON_LEN="`expr "${DOTFILES_COMMON}/" : '.*'`"
DOTFILES_HOST="${DOTFILES_DIR}/host.${HOSTNAME}"
DOTFILES_HOST_LEN="`expr "${DOTFILES_HOST}/" : '.*'`"

find "${DOTFILES_COMMON}" -print0 | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_COMMON_LEN}-"`"
	echo "${src} -> ${dst}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done

find "${DOTFILES_HOST}" -print0 | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_HOST_LEN}-"`"
	echo "${src} -> ${dst}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done
