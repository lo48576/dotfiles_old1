#!/bin/sh
SYSTEM_XMONAD_PATH=/usr/bin/xmonad
#MY_XMONAD_PATH=$HOME/.cabal/bin/xmonad
XTERM=xterm

cd ~

if [ -x "$MY_XMONAD_PATH" ] ; then
	XMONAD_PATH="$MY_XMONAD_PATH"
elif [ -x "$SYSTEM_XMONAD_PATH" ] ; then
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
	# Wallpaper setting is now in ~/.conkyrc .
#	if [ -x ~/scripts/change_wall.sh ] ; then
#		~/scripts/change_wall.sh
#	else
#		feh --bg-scale ~/Pictures/desktop-default.png
#	fi
	xrandr -s 0
	# Set keymap to dvorak layout.
	#setxkbmap -layout dvorak &
	setxkbmap -option ctrl:nocaps -layout dvorak &
	# Screensaver
	xscreensaver -no-splash &
	# System tray
	# If you set height less than 16px, height is automatically set to 16px.
	# trayer-srg is trayer fork which support multi monitor support
	TRAYER_BIN="`which trayer-srg`"
	if [ ! -x "${TRAYER_BIN}" ] ; then
		TRAYER_BIN="`which trayer`"
	fi
	[ -x "${TRAYER_BIN}" ] && ${TRAYER_BIN} --edge top --align right --SetDockType true --SetPartialStrut false --expand true --widthtype percent --width 20 --transparent true --alpha 64 --tint 0x666666 --height 20 --monitor 0 &
#	gnome-settings-daemon &
	# uim
	uim-xim &
	uim-toolbar-gtk-systray &
	# Run status bar from xmonad, not here
	# because I want to restart status bar when xmonad restarts.
#	~/scripts/local/status.sh | dzen2 -fn '7x13bold' -h 16 -ta r -y $(( $(xrandr | sed -e '/Screen 0/! d;s/Sc[^c]*current [0-9]* x \([0-9]*\).*/\1/') - 16)) &
	#xcompmgr -c &
	# Applications to run in background
	#BACKGROUND_APPLICATIONS="/usr/bin/gnome-sound-applet /usr/bin/system-config-printer-applet /usr/libexec/polkit-gnome-authentication-agent-1"
	BACKGROUND_APPLICATIONS="`which volumeicon` `which polkit-gnome-authentication-agent-1`"
	for APP in $BACKGROUND_APPLICATIONS ; do
		if [ -x "$APP" ] ; then
			$APP &
		fi
	done
	# FIXME: Sometimes .xmodmaprc settings is not applied... why?
	xmodmap ~/.xmodmaprc &
	# backlight setting
	xbacklight -step 1 -set 40

	conky &
#	sleep 1; conky -c ~/.conkyrc_ring &
	sleep 1; conky -c ~/.conkyrc_net1 &
#	mlterm &
	exec dbus-launch --exit-with-session /usr/bin/xmonad
fi
echo "larry-xmonad-start: $XMONAD_PATH not exist. try $XTERM" >> $HOME/.xsession-errors
exec $XTERM

