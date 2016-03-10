#!/bin/sh
SYSTEM_XMONAD_PATH=/usr/bin/xmonad
XTERM=xterm

cd ~

if [ -x "$SYSTEM_XMONAD_PATH" ] ; then
	XMONAD_PATH="$SYSTEM_XMONAD_PATH"
fi
if [ -x "$XMONAD_PATH" ] ; then
	xrandr -s 0
	# Applications to run in background
	# gnome-extra/polkit-gnome: "A dbus session bus service that is used to bring up authentication dialogs"
	BACKGROUND_APPLICATIONS="`which polkit-gnome-authentication-agent-1`"
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
