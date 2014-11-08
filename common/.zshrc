# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_histfile
HISTSIZE=1000000
SAVEHIST=1000000000
# Ignore duplication command history list
setopt hist_ignore_all_dups
setopt hist_ignore_dups
# Don't remember commands which begins with whitespace
setopt hist_ignore_space
# Share command history data
setopt share_history
# Change current directory without "cd"
setopt autocd
setopt nolistbeep
#unsetopt beep
setopt beep
# Vim-like key binding
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${ZDOTDIR:-${HOME}}/.zshrc"
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# list /zfs-filesystem/.zfs/ .
# zfs snapshot is in /zfs-filesystem/.zfs/snapshot/snapshot-name/ .
# you may need following settings in /etc/sudoers:
# user ALL=(ALL) NOPASSWD: /sbin/zfs
#zstyle ':completion:*' fake-files "`sudo zfs list -rH -o mountpoint -t filesystem | tr '\n' '|'`:.zfs"
##zstyle ':completion:*:*directories' fake "`sudo zfs list -rH -o mountpoint -t filesystem | tr '\n' '|'`:.zfs"
##zstyle ':completion::complete:*:directories' fake '.zfs'
##zstyle ':completion::complete:*:dirs' fake '.zfs'
##zstyle ':completion::complete:*:dir_list' fake '.zfs'

export EDITOR=vim
# If mojibake (like '^[[0m') appears on linux tty,
#   use "-c" option with lv.
export PAGER="lv -c"
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto'

#
# PATH
#
typeset -U path

# path(foo): 条件fooにマッチするパスのみ残す。
# 条件:
#   N: NULL_GLOBオプションを設定。
#      globがマッチしない場合や存在しないパスであった場合無視する。
#   -: シンボリックリンクそのものでなく、その指す先のファイルに評価する。
#   /: ディレクトリのみを残す。

## system
path=(
	$path
	/usr/libexec(N-/)
	)

## installed to user-local directory by package manager
path=(
	# ruby gem (ruby)
	#   you can use `ruby -e 'require "rubygems"; puts Gem::bindir'` instead of whence .
	$([ -x "`whence -p gem`" ] && echo "`gem environment gemdir`/bin")(N-/)
	# rbenv (ruby)
	${HOME}/.rbenv/bin(N-/)
	# pip (python)
	$([ -x "`whence -p python`" ] && echo "`python -m site --user-base`/bin")(N-/)
	$path)
# rbenv (ruby)
eval "$(rbenv init -)"

## my files (manually installed)
path=(
	${HOME}/bin(N-/)
	${HOME}/app{,32,64}/*(N-/)
	${HOME}/scripts(N-/)
	$path)

export PATH

# for sudo
if [[ $EUID != 0 ]] ; then
	typeset -xT SUDO_PATH sudo_path
	typeset -U sudo_path
	sudo_path=(
		/usr/local/sbin(N-/)
		/usr/sbin(N-/)
		/sbin(N-/)
		)
fi
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"


## path to completion and prompts configuration
fpath=(~/.zsh/functions/Completion ~/.zsh/functions/Prompts ${fpath})


autoload -Uz compinit
# -C: skip security check (see http://zsh.sourceforge.net/Doc/Release/Completion-System.html#index-compinit )
compinit -C
# End of lines added by compinstall

# enable cache for the completions.
zstyle ':completion::complete:*' use-cache 1

#autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

:<<'#COLOR_SETTING_1'
#define 16 colors -> COL(FG|BG)16[]
for X in {0..7}; do
	COLFG16[$(( ${X} + 1 ))]=$(echo "\e[3${X}m")
	COLBG16[$(( ${X} + 1 ))]=$(echo "\e[4${X}m")
done
unset X

# define 256 colors -> COL(FG|BG)256[]
#COLORS=("00" "5F" "87" "AF" "D7" "FF")
for X in {16..255}; do
	COLFG256[${X}]=$(echo "\e[38;5;${X}m")
	COLBG256[${X}]=$(echo "\e[48;5;${X}m")
done
unset X
#COLOR_SETTING_1

# Distinguish terminal software
check_term_emulator() {
	case "${TERM}" in
		linux)
			# virtual console
			TERMINAL_EMULATOR="linux"
			;;
		screen*)
			# screen, tmux, etc...
			if [ -n "$TMUX" ] ; then
				TERMINAL_MULTIPLEXER="tmux"
				if [ -z "$COLORTERM" ] ; then
					export COLORTERM=1
				fi
			else
				TERMINAL_MULTIPLEXER="screen"
			fi
			;;
		mlterm*)
			TERMINAL_EMULATOR="mlterm"
			;;
		#yaft-256color)
		#	 yaft
		#	;;
	esac
	if [ -n "${MLTERM}" ] ; then
		# mlterm
		TERMINAL_EMULATOR="mlterm"
		export TERM_VERSION="${MLTERM}"
		export COLORTERM=1
	elif [ -n "${XTERM_VERSION}" ] ; then
		# xterm, uxterm
		TERMINAL_EMULATOR="xterm"
		export COLORTERM=1
	elif [ -n "${COLORTERM}" ] ; then
		case "${COLORTERM}" in
			gnome-terminal)
				# gnome-terminal
				TERMINAL_EMULATOR="gnome-terminal"
				;;
		esac
	fi
	export TERMINAL_EMULATOR="${TERMINAL_EMULATOR:-linux}"
	export TERMINAL_MULTIPLEXER
}
check_term_emulator

# Set $LANG and $TERM
# I can see only 16 colors when I use tty1-6,
# so 'LANG="ja_JP.UTF-8"' is not always adequate.
USER_DEFAULT_LANG_ZSHRC="ja_JP.UTF-8"
case "${TERMINAL_EMULATOR}" in
	mlterm)
		export LANG="$USER_DEFAULT_LANG_ZSHRC"
		export TERM="mlterm-256color"
		;;
	xterm)
		export LANG="$USER_DEFAULT_LANG_ZSHRC"
		export TERM="xterm-256color"
		;;
	gnome-terminal)
		export LANG="$USER_DEFAULT_LANG_ZSHRC"
		export TERM="xterm-256color"
		;;
	linux)
		export LANG="C"
		;;
	*)
		#export LANG="$USER_DEFAULT_LANG_ZSHRC"
		export LANG="C"
		;;
esac
case "${TERMINAL_MULTIPLEXER}" in
	screen*|tmux)
		# for tmux or screen
		# derive setting of parent process
		# default: C
		if [[ "$LANG" != "" && "$LANG" != "C" ]] ; then
			export LANG="$USER_DEFAULT_LANG_ZSHRC"
		fi
		;;
esac
unset USER_DEFAULT_LANG_ZSHRC

export LC_TIME="C"

case ${UID} in
0)
	export LANG="C"
	;;
esac

# Show information about terminal
show_term_basic_info()
{
	echo "terminal emulator: ${TERMINAL_EMULATOR} ${TERM_VERSION}"
	echo "terminal multiplexer: ${TERMINAL_MULTIPLEXER}"
	echo "terminal: ${TERM}"
	echo "language: ${LANG}"
}
show_term_basic_info

# auto directory pushd that you can get dirs list by cd -[tab]
#setopt auto_pushd

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# suppose to use dvorak layout at typo correction
setopt correct
setopt dvorak

# disabling execution of the last command with 'r'.
# you can do it with history or incremental search
disable r


# Set PROMPTs
prompt larry1

# Build $LS_COROLS with specific settings and print it.
ls_colors_gnu()
{
	STR_BASE='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
	PATTERN_ARCHIVE='*.tar:*.tgz:*.arj:*.taz:*.lzh:*.lzma:*.tlz:*.txz:*.zip:*.z:*.Z:*.dz:*.gz:*.lz:*.xz:*.bz2:*.bz:*.tbz:*.tbz2:*.tz:*.deb:*.rpm:*.jar:*.war:*.ear:*.sar:*.rar:*.ace:*.zoo:*.cpio:*.7z:*.rz:'
	PATTERN_IMAGE='*.jpg:*.jpeg:*.gif:*.bmp:*.pbm:*.pgm:*.ppm:*.tga:*.xbm:*.xpm:*.tif:*.tiff:*.png:*.svg:*.svgz:*.mng:*.pcx:'
	PATTERN_VIDEO='*.mov:*.mpg:*.mpeg:*.m2v:*.mkv:*.webm:*.ogm:*.mp4:*.m4v:*.mp4v:*.vob:*.qt:*.nuv:*.wmv:*.asf:*.rm:*.rmvb:*.flc:*.avi:*.fli:*.flv:*.gl:*.dl:*.xcf:*.xwd:*.yuv:*.cgm:*.emf:*.axv:*.anx:*.ogv:*.ogx:'
	PATTERN_DOCUMENT='*.pdf:*.ps:*.txt:*.patch:*.diff:*.log:*.tex:*.csv:*.doc:*.odt:*.ods:*.odp:*.odb:*.odg:*.odf:*.sgml:*.dsl:*.htm:*.html:*.xml:*.xsl:*.rnc:*.rng:*.css:*.chm:*.dvi:'
	PATTERN_SOUND='*.aac:*.au:*.flac:*.m4a:*.mid:*.midi:*.mka:*.mp3:*.mpc:*.ogg:*.ra:*.tak:*.wav:*.axa:*.oga:*.spx:*.xspf:*.wma:'
	STYLE_ARCHIVE='01;31'
	STYLE_IMAGE='01;35'
	STYLE_VIDEO='01;35'
	#STYLE_DOCUMENT='00;32'
	STYLE_DOCUMENT='00;37'
	STYLE_SOUND='00;36'
	COLOR_STR="${STR_BASE}"
	COLOR_STR="${COLOR_STR}`echo "$PATTERN_ARCHIVE" | sed "s/:/=$STYLE_ARCHIVE:/g"`"
	COLOR_STR="${COLOR_STR}`echo "$PATTERN_IMAGE" | sed "s/:/=$STYLE_IMAGE:/g"`"
	COLOR_STR="${COLOR_STR}`echo "$PATTERN_VIDEO" | sed "s/:/=$STYLE_VIDEO:/g"`"
	COLOR_STR="${COLOR_STR}`echo "$PATTERN_DOCUMENT" | sed "s/:/=$STYLE_DOCUMENT:/g"`"
	COLOR_STR="${COLOR_STR}`echo "$PATTERN_SOUND" | sed "s/:/=$STYLE_SOUND:/g"`"
	echo "$COLOR_STR"
}

# for gnu ls
export LS_COLORS="`ls_colors_gnu`"

#if [ -f ~/.dir_colors ] ; then
#	eval $(dircolors -b ~/.dir_colors)
#fi

#zstyle ':completion:*' list-colors ''
# replace ':' (colon) with ' ' (whitespace).
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# incremental search with ^P and ^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Home/End/Delete/Bksp
case "${TERMINAL_EMULATOR}" in
	gnome-terminal)
		bindkey "^?"    backward-delete-char
		bindkey "^H"    backward-delete-char
		bindkey "^[[3~" delete-char
		bindkey "^[[1~" beginning-of-line
		bindkey "^[[4~" end-of-line
		;;
	mlterm)
		bindkey "^?"    backward-delete-char
		bindkey "^H"    backward-delete-char
		bindkey "^[[3~" delete-char
		bindkey "^[OH"  beginning-of-line
		bindkey "^[OF"  end-of-line
		bindkey "^[[H"  beginning-of-line
		bindkey "^[[F"  end-of-line
		;;
esac
# test (apply all binding if possible)
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[OH"  beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF"  end-of-line


# enable to delete characters before position where you start insert mode
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# push command to stack (Esc-q at emacs binding)
# Ctrl+7 (in dvorak, Shift+7 is '&'.)
# you can use Ctrl+- (Shift+- is '_'.)
bindkey '^_' push-line
# Esc, then 'q'
bindkey -a 'q' push-line
bindkey -a 'H' run-help

# load other zsh configs if exist
#  aliases
[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias
#  functions
[ -f ~/.zshrc.mycmd ] && source ~/.zshrc.mycmd
#  host-dependent settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

cdup()
{
	# skip lines to leave old prompt
	echo ; echo
	cd ..
	zle reset-prompt
}
zle -N cdup
# cd ../ by Ctrl-6 (in US Keyboard)
# if you want to type "^^"(Ctrl-^), Ctrl-V Ctrl-6
bindkey '^^' cdup
# cd ../ by ^
# if you want to type "^", Ctrl-V ^
#bindkey '\^' cdup

# show 'time' result when a process uses more than 30 cpu time
REPORTTIME=30
TIMEFMT="job: %J
User: %U
Kernel: %S
Elapsed: %E
CPU: %P"


# zsh-syntax-highlighting
#[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.zsh/zsh-syntax-highlighting.zsh.local ] && source ~/.zsh/zsh-syntax-highlighting.zsh.local

#tmux_set_current_dir()
#{
	#[ -n "$TMUX" ] && tmux set-environment "TMUXPWD_$(tmux display -p '#D' | tr -d '%')" "$PWD"
#}

init()
{
	# fortune
	#fortune ~/Documents/fortune
	u_nyah_disabled=1
	if [[ "$LANG" != "C" ]] && [[ -z "$u_nyah_disabled" ]] ; then
		# Let's nyah!
		# u_nyah_prompt is defined in .zshrc.mycmd
		precmd_functions=($precmd_functions u_nyah_prompt)
	fi
	# tmux
	#precmd_functions=($precmd_functions tmux_set_current_dir)
}

# initialize
init

#if (which zprof >/dev/null) ; then
#	zprof | less
#fi
