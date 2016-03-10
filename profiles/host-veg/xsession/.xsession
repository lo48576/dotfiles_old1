#!/bin/sh
SYSTEM_XMONAD_PATH=/usr/bin/xmonad
XTERM=xterm

cd ~

if [ -x "$SYSTEM_XMONAD_PATH" ] ; then
	XMONAD_PATH="$SYSTEM_XMONAD_PATH"
fi
if [ -x "$XMONAD_PATH" ] ; then
#	source ~/.xprofile
	export LANG="ja_JP.UTF-8"
	export XMODIFIERS="@im=uim"
	export GTK_IM_MODULE="uim"
	export QT_IM_MODULE="uim"
	# To run tmux in X session started on tmux, erase $TMUX environment variable.
	unset TMUX
	# Let java VM know about xmonad.
	# Necessary to use java gui application on XMonad.
	export _JAVA_AWT_WM_NONREPARENTING=1
	xsetroot -cursor_name left_ptr
	xrandr -s 0
	# Set keymap to dvorak layout.
	#setxkbmap -option ctrl:nocaps -layout dvorak &
	xkbcomp ~/.lifebook_keyboard_lite.xkm :0 &
	#xkbcomp ~/.lifebook_keyboard.xkb && xkbcomp ~/.lifebook_keyboard.xkm :0 &
	# Screensaver
	xscreensaver -no-splash &
	# System tray
	# If you set height less than 16px, height is automatically set to 16px.
	# trayer-srg is trayer fork which support multi monitor support
	TRAYER_BIN="`which trayer-srg`"
	if [ ! -x "${TRAYER_BIN}" ] ; then
		TRAYER_BIN="`which trayer`"
	fi
	# trayer leaves the edge of window on restart of xmonad, if "--SetPartialStrut false"
	[ -x "${TRAYER_BIN}" ] && ${TRAYER_BIN} --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype percent --width 20 --transparent true --alpha 64 --tint 0x666666 --height 20 --monitor 0 &
	# uim
	uim-xim &
	uim-toolbar-gtk-systray &
	# Applications to run in background
	# gnome-extra/polkit-gnome: "A dbus session bus service that is used to bring up authentication dialogs"
	BACKGROUND_APPLICATIONS="`which volumeicon` `which polkit-gnome-authentication-agent-1`"
	for APP in $BACKGROUND_APPLICATIONS ; do
		if [ -x "$APP" ] ; then
			"$APP" &
		fi
	done
	eval $(gnome-keyring-daemon --start --components=secrets)

	conky &
	sleep 1; conky -c ~/.conkyrc_net1 &
	exec dbus-launch --exit-with-session /usr/bin/xmonad
fi

echo "larry-xmonad-start: $XMONAD_PATH not exist. try $XTERM" >> $HOME/.xsession-errors
exec $XTERM
