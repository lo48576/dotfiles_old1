#!/bin/sh

AMIXER="amixer sset Master"
SUMMARY="volume changed"
MESSAGE_BODY=

option="$1"
case	"$1" in
	on)
		$AMIXER on
		SUMMARY="Mute off"
		MESSAGE_BODY=
		;;
	off)
		$AMIXER off
		SUMMARY="Mute on"
		MESSAGE_BODY=
		;;
	toggle)
		$AMIXER 1+ toggle
		STATUS="$(amixer sget Master | grep -o '\[\(on\|off\)\]' | head -1)"
		if [ "$STATUS" == "[on]" ] ; then
			STATUS="off"
		else
			STATUS="on"
		fi
		SUMMARY="Mute $STATUS"
		MESSAGE_BODY=
		;;
	[0-9]*%[+-])
		$AMIXER "$option"
		MESSAGE_BODY="current: $(amixer sget Master | grep -o '[0-9]\+%' | head -1)"
		;;
	[0-9]*%)
		$AMIXER "$option"
		MESSAGE_BODY="current: $option"
		;;
esac

#notify-send --app-name="volumecontrol.sh" "$SUMMARY" "$MESSAGE_BODY"
