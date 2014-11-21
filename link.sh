#!/bin/sh

cd "`dirname "$0"`"
DOTFILES_DIR="`pwd`"
HOSTNAME="`hostname`"

DOTFILES_COMMON="common"
DOTFILES_COMMON_LEN="`expr "${DOTFILES_COMMON}/" : '.*'`"
#DOTFILES_HOST="host.${HOSTNAME}"
DOTFILES_HOST="`readlink "host.${HOSTNAME}"`"
DOTFILES_HOST="${DOTFILES_HOST:-host.${HOSTNAME}}"
DOTFILES_HOST_LEN="`expr "${DOTFILES_HOST}/" : '.*'`"

LINK_TARGETS_FILE="${DOTFILES_DIR}/.link_targets"


# remove old links
:>>"${LINK_TARGETS_FILE}"
xargs -0 -a "${LINK_TARGETS_FILE}" rm -f --
:>"${LINK_TARGETS_FILE}"


#make new links

git ls-files -z --full-name "${DOTFILES_COMMON}" | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_COMMON_LEN}-"`"
	src="${DOTFILES_DIR}/${src}"
	echo "${src} -> ${dst}"
	echo -en "${dst}\0" >>"${LINK_TARGETS_FILE}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done

git ls-files -z --full-name "${DOTFILES_HOST}" | while read -d $'\0' src ; do
	dst="${HOME}`echo "${src}" | cut -b "${DOTFILES_HOST_LEN}-"`"
	src="${DOTFILES_DIR}/${src}"
	echo "${src} -> ${dst}"
	echo -en "${dst}\0" >>"${LINK_TARGETS_FILE}"
	mkdir -p "`dirname "${dst}"`"
	ln -sf "${src}" "${dst}"
done
