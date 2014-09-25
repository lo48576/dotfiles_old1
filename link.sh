#!/bin/sh

cd "`dirname "$0"`"
DOTFILES_DIR="`pwd`"
HOSTNAME="`hostname`"

DOTFILES_COMMON="common"
DOTFILES_COMMON_LEN="`expr "${DOTFILES_COMMON}/" : '.*'`"
DOTFILES_HOST="host.${HOSTNAME}"
DOTFILES_HOST_LEN="`expr "${DOTFILES_HOST}/" : '.*'`"

git ls-files -z --full-name "${DOTFILES_COMMON}" | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_COMMON_LEN}-"`"
	src="${DOTFILES_DIR}/${src}"
	echo "${src} -> ${dst}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done

git ls-files -z --full-name "${DOTFILES_HOST}" | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_HOST_LEN}-"`"
	src="${DOTFILES_DIR}/${src}"
	echo "${src} -> ${dst}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done
