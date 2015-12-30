#!/bin/bash

# -e: exit immediately when called command exits with non-zero.
# -u: error when expanding unset variables.
set -eu

usage() {
	cat <<-__EOF__ >&2
		Usage: install.sh [-n] [-h]
		    -h     print this help and exit
		    -n     print files to be installed, but not remove or copy any files
		    -u     only uninstall previously installed links, not install current files

		If -h and other option is specified simultaneously, options other than -h is ignored.
	__EOF__
}

finish() {
	# Check leakage with
	# grep -o 'TEMPFILE_[A-Z_]*' install.sh | sort -u
	local RET="$?"
	[ -n "${TEMPFILE_CHECKED_PKGS:-}" ] && rm -f "${TEMPFILE_CHECKED_PKGS}"
	[ -n "${TEMPFILE_CONFLICT_LIST:-}" ] && rm -f "${TEMPFILE_CONFLICT_LIST}"
	[ -n "${TEMPFILE_INSTALL_FILELIST:-}" ] && rm -f "${TEMPFILE_INSTALL_FILELIST}"
	[ -n "${TEMPFILE_NEXT_PKGS_TO_CHECK:-}" ] && rm -f "${TEMPFILE_NEXT_PKGS_TO_CHECK}"
	[ -n "${TEMPFILE_PACKAGES:-}" ] && rm -f "${TEMPFILE_PACKAGES}"
	[ -n "${TEMPFILE_PACKAGES_YET:-}" ] && rm -f "${TEMPFILE_PACKAGES_YET}"
	[ -n "${TEMPFILE_PACKAGE_DEPENDENCIES:-}" ] && rm -f "${TEMPFILE_PACKAGE_DEPENDENCIES}"
	[ -n "${TEMPFILE_USER_SELECTED_PKGS:-}" ] && rm -f "${TEMPFILE_USER_SELECTED_PKGS}"
	return "$RET"
}
trap finish EXIT

declare -i DRYRUN=0
declare -i UNINSTALL_ONLY=0
while getopts hnu OPT ; do
	case "$OPT" in
		h)
			# help
			usage
			exit
			;;
		n)
			# dry-run
			DRYRUN=1
			;;
		u)
			# uninstall
			UNINSTALL_ONLY=1
			;;
		'?')
			usage
			exit 1
			;;
	esac
done

cd "$(dirname "$0")"
declare -r DOTFILES_DIR_ABS="`pwd`"
declare -r PROFILES_DIR="${DOTFILES_DIR_ABS}/profiles"
declare -r VAR_DIR="${DOTFILES_DIR_ABS}/var"
declare -r DEST_DIR="${HOME}"
declare -r PROFILE_FILE="${VAR_DIR}/profiles"
declare -r LINK_TARGETS_FILE="${VAR_DIR}/.link_targets"

# Packages to be installed
declare TEMPFILE_PACKAGES="$(mktemp)"
# Dependencies of packages
declare TEMPFILE_PACKAGE_DEPENDENCIES="$(mktemp)"

# User selected packages
declare TEMPFILE_USER_SELECTED_PKGS="$(mktemp)"
helpers/get_entries.sh "DEPEND" "$PROFILE_FILE" \
	| grep -v '^$' \
	>"$TEMPFILE_USER_SELECTED_PKGS"

#
# Dependency resolution
#
# Packages to resolve dependencies.
declare PACKAGES_YET="$(cat "$TEMPFILE_USER_SELECTED_PKGS")"
# Tempfile to hold PACKAGES_YET temporarily.
declare TEMPFILE_PACKAGES_YET="$(mktemp)"
while [ -n "$PACKAGES_YET" ] ; do
	while read PKG ; do
		PKG_FILE_PATH="${PROFILES_DIR}/${PKG}.profile"
		echo "$PKG" >>"$TEMPFILE_PACKAGES"
		echo -n "$PKG: "
		if [ \! -f "$PKG_FILE_PATH" ] ; then
			# foo.profile doesn't exist.
			echo -e "[\e[1;31mERROR\e[0m] file does not exist: $(printf '%q' "$PKG_FILE_PATH")" >&2
			exit 2
		fi
		helpers/get_entries.sh "DEPEND" "$PKG_FILE_PATH" \
			| tee -a "$TEMPFILE_PACKAGES_YET" \
			| tr '\n' ' ' \
			| sed -e 's/\s\s*/ /g'
		echo
	done <<<"${PACKAGES_YET}" >>"$TEMPFILE_PACKAGE_DEPENDENCIES"
	# get lines which are only in $TEMPFILE_PACKAGES_YET .
	sed -i '/^$/d' "$TEMPFILE_PACKAGES_YET"
	sort -u "$TEMPFILE_PACKAGES_YET" -o "$TEMPFILE_PACKAGES_YET"
	sort -u "$TEMPFILE_PACKAGES" -o "$TEMPFILE_PACKAGES"
	PACKAGES_YET="$(comm -13 "$TEMPFILE_PACKAGES" "$TEMPFILE_PACKAGES_YET")"
	:>"$TEMPFILE_PACKAGES_YET"
done
rm -r "$TEMPFILE_PACKAGES_YET"
unset -v TEMPFILE_PACKAGES_YET
unset -v PACKAGES_YET

sort -u "$TEMPFILE_PACKAGE_DEPENDENCIES" -o "$TEMPFILE_PACKAGE_DEPENDENCIES"

#
# List up files to be installed
#
# Files to be installed
declare TEMPFILE_INSTALL_FILELIST="$(mktemp)"
# Format of the every line of $TEMPFILE_INSTALL_FILELIST is
# 'filename//package\0'.
# Line separator is '\0' (NUL character), column separator is '//'.
# Note that 'filename' field (output of `find` command) doesn't contain '//'.
while read PKG ; do
	PKG_DIR="${PROFILES_DIR}/${PKG}"
	if [ -d "$PKG_DIR" ] ; then
		pushd "$PKG_DIR" >/dev/null
		# -P : don't follow symlink.
		find -P . \( -type f -o -type l \) -print0 \
			| sed -ze 's:$://'"$PKG"':'
		popd >/dev/null
	fi
done <"$TEMPFILE_PACKAGES" >>"$TEMPFILE_INSTALL_FILELIST"

#
# Check file conflicts
#
# Checked (printed) packages.
declare TEMPFILE_CHECKED_PKGS="$(mktemp)"
# Next packages to check (maybe not checked).
declare TEMPFILE_NEXT_PKGS_TO_CHECK="$(mktemp)"
# Conflict files.
declare TEMPFILE_CONFLICT_LIST="$(mktemp)"
sed -ze 's!//.*$!!' "$TEMPFILE_INSTALL_FILELIST" \
	| sort -z \
	| uniq -zd \
	| tee "$TEMPFILE_CONFLICT_LIST" \
	| while read -rd $'\0' CONFLICT_FILE ; do
		# Inside this loop is executed for each conflict file.
		# Clear tempfile which maybe used in previous iteration of this loop.
		:>"$TEMPFILE_CHECKED_PKGS"
		:>"$TEMPFILE_NEXT_PKGS_TO_CHECK"
		echo -en '\e[1;31mfile conflict\e[0m:' >&2
		echo "$(printf '%q' "${CONFLICT_FILE}")" >&2
		PKGS="$( \
			grep -zZF "$CONFLICT_FILE//" "$TEMPFILE_INSTALL_FILELIST" \
				| sed -ze 's!^.*//!!' \
				| tr '\0' '\n' \
			)"
		echo -e "required by: \e[1;33m$(tr '\n' ' ' <<<"$PKGS")\e[0m"
		# Print dependency chain.
		while [ -n "$PKGS" ] ; do
			# 'A <- B C' indicates "A is required by B and C."
			# '[user selected]' indicates the package (A) is specified at $PROFILE_FILE .
			while read PKG ; do
				# Inside this loop is executed for each related packages.
				echo -n "    $PKG" >&2
				# Find packages which depends on $PKG .
				DEPENDS="$(grep -e ':.*\s'"$PKG"'\(\s.*\)\?$' "$TEMPFILE_PACKAGE_DEPENDENCIES" | sed -e 's/:.*$//')"
				if grep -e '^'"$PKG"'$' "$TEMPFILE_USER_SELECTED_PKGS" ; then
					echo -en " \e[1;32m[user selected]\e[0m" >&2
				fi
				if [ -n "$DEPENDS" ] ; then
					echo -n " <- $(tr '\n' ' ' <<<"$DEPENDS")" >&2
					# Append only when $DEPEND exists in order not to add empty line.
					echo "$DEPENDS" >>"$TEMPFILE_NEXT_PKGS_TO_CHECK"
				fi
				echo >&2
				echo "$PKG"
			done <<<"$PKGS" >>"$TEMPFILE_CHECKED_PKGS"
			sort -u "$TEMPFILE_CHECKED_PKGS" -o "$TEMPFILE_CHECKED_PKGS"
			sort -u "$TEMPFILE_NEXT_PKGS_TO_CHECK" -o "$TEMPFILE_NEXT_PKGS_TO_CHECK"
			# Remove already checked packages from $TEMPFILE_NEXT_PKGS_TO_CHECK 
			# Note that $PKGS shouldn't have empty line.
			PKGS="$(comm -13 "$TEMPFILE_CHECKED_PKGS" "$TEMPFILE_NEXT_PKGS_TO_CHECK")"
		done
	done
rm -f "$TEMPFILE_USER_SELECTED_PKGS"
unset -v TEMPFILE_USER_SELECTED_PKGS
if [ -s "$TEMPFILE_CONFLICT_LIST" ] ; then
	# There are conflict(s).
	echo -e '\e[1;31mInstall aborted.\e[0m' >&2
	# Temporary files were to be deleted by EXIT signal handler (`finish` function).
	exit 1
fi

rm -f "$TEMPFILE_CONFLICT_LIST"
unset -v TEMPFILE_CONFLICT_LIST
rm -f "$TEMPFILE_NEXT_PKGS_TO_CHECK"
unset -v TEMPFILE_NEXT_PKGS_TO_CHECK
rm -f "$TEMPFILE_CHECKED_PKGS"
unset -v TEMPFILE_CHECKED_PKGS

rm -f "$TEMPFILE_PACKAGE_DEPENDENCIES"
unset -v TEMPFILE_PACKAGE_DEPENDENCIES
rm -f "$TEMPFILE_PACKAGES"
unset -v TEMPFILE_PACKAGES


#
# Remove previously installed files
#
if [ "$DRYRUN" -eq 0 ] ; then
	[ -f "$LINK_TARGETS_FILE" ] && xargs -0 -a "$LINK_TARGETS_FILE" rm -f --
	:>"$LINK_TARGETS_FILE"
elif [ -f "$LINK_TARGETS_FILE" ] ; then
	# dry-run
	xargs -0a "$LINK_TARGETS_FILE" -I'{}' bash -c 'echo "$(printf "%q" "{}")"' | xargs echo rm -f --
fi

#
# Install files
#
if [ "$UNINSTALL_ONLY" -eq 1 ] ; then
	exit
fi
while read -rd $'\0' DEST_REL <&3 && read -rd $'\0' PROF_REL <&4 ; do
	SRC_FILE="${PROFILES_DIR}/${PROF_REL}"
	DEST_FILE="${DEST_DIR}/${DEST_REL}"
	[ "$DRYRUN" -eq 0 ] && mkdir -p "$(dirname "$DEST_FILE")"
	if [ -d "$DEST_FILE" ] ; then
		echo -e "[\e[1;33mWARNING]\e[0m] $(printf '%q' "$DEST_FILE") is not created because a directory with the same name exists"
	else
		if [ "$DRYRUN" -eq 0 ] ; then
			ln -sf "$SRC_FILE" "$DEST_FILE" \
				|| echo -e "\e[1;31mfailed to create\e[0m: $(printf '%q' "${DEST_FILE}")"
			echo "$(printf '%q' "$DEST_REL")"
			echo -n "${DEST_FILE}" >>"$LINK_TARGETS_FILE"
			echo -en '\0' >>"$LINK_TARGETS_FILE"
		else
			# dry-run
			echo "ln -sf $(printf '%q' "$SRC_FILE") $(printf '%q' "$DEST_FILE")"
		fi
	fi
done \
	3< <(sed -ze 's!^\./\(.*\)//.*$!\1!' "$TEMPFILE_INSTALL_FILELIST") \
	4< <(sed -ze 's!^\./\(.*\)//\(.*\)$!\2/\1!' "$TEMPFILE_INSTALL_FILELIST")

rm -f "$TEMPFILE_INSTALL_FILELIST"
unset -v TEMPFILE_INSTALL_FILELIST
