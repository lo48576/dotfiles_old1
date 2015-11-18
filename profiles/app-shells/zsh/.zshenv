#zmodload zsh/zprof && zprof

# $PATH will be set by /etc/zsh/zprofile (loading /etc/profile.env which overwrites $PATH).
# Don't set PATH here.

# directory which .zprofile, .zshrc, .zlogin, .zlogout, etc... are placed in.
export ZDOTDIR="$HOME"

#export LD_LIBRARY_PATH="/usr/lib/mysql:${LD_LIBRARY_PATH}"
[[ -f "${ZDOTDIR}/.zshenv.local" ]] && source "${ZDOTDIR}/.zshenv.local"

