#!/bin/sh

HOST="localhost"
PORT="6600"

#SEND="curl -s telnet://${HOST}:${PORT}"
SEND="curl --max-time 1 -s telnet://${HOST}:${PORT}"

send_cmd() {
	echo -e "$@\nclose"
	echo -e "$@\nclose" | $SEND
}

# $1: parameter (volume, repeat, etc...)
get_status() {
	PARAM="$1"
	#send_cmd status | sed -e "/^${PARAM}:/!d" -e 's/^[^:]*: //'
	send_cmd status | sed -ne "/^${PARAM}:/s/^[^:]*: // p"
}

toggle_pause() {
	STATE="`get_status state`"
	if [ "x${STATE}" == "xplay" ] ; then
		send_cmd pause 1
	else
		send_cmd pause 0
	fi
}

set_volume() {
	CURRENT="`get_status volume`"
	NEXT="${CURRENT}"
	case	"$1" in
		'+'[1-9]|'+'[0-9][0-9]|'-'[1-9]|'-'[0-9][0-9])
			NEXT="$(( ${CURRENT} $1 ))"
			;;
		[0-9]|[0-9][0-9]|100)
			NEXT="$2"
			;;
		*)
			echo "invalid parameter: $1" >&2
	esac
	send_cmd setvol ${NEXT}
}

set_play_status() {
	case	"$1" in
		pause)
			send_cmd pause 1
			;;
		stop)
			send_cmd stop
			;;
		play)
			send_cmd play
			;;
	esac
}

play() {
	case	"$1" in
		next)
			send_cmd next
			;;
		prev|previous)
			send_cmd previous
			;;
	esac
}

case	"$1" in
	get_volume)
		get_status volume
		;;
	set_volume)
		set_volume "$2"
		;;
	toggle_pause)
		toggle_pause
		;;
	set_play_status)
		set_play_status "$2"
		;;
	play)
		play "$2"
		;;
esac

