#!/bin/sh

icon_speaker="`echo -e '\U0001f50a'`"
icon_vol_mute="`echo -e '\U0001f507'`"
icon_vol_silent="`echo -e '\U0001f508'`"
icon_vol_loud="`echo -e '\U0001f509'`"
icon_battery="`echo -e '\U0001f50b'`"
# not in VLGothic. Seen in Symbola
icon_electric_plug="`echo -e '\U0001f50c'`"
icon_antenna_with_bars="`echo -e '\U0001f4f6'`"
icon_quarter_note="`echo -e '\u2669'`"
icon_eighth_note="`echo -e '\u266a'`"
icon_beamed_eighth_notes="`echo -e '\u266b'`"
icon_beamed_sixteenth_notes="`echo -e '\u266c'`"
icon_music="$icon_eighth_note"
# VLGothic has bug, U+23f4 and U+23f5 is swapped...
#icon_play_forward="`echo -e '\u23f5'`"
# U+25b6: BLACK RIGHT-POINTING TRIANGLE
# U+25b8: BLACK RIGHT-POINTING SMALL TRIANGLE
#icon_play_forward="▶"
icon_play_forward="`echo -e '\u25b8'`"
icon_pause="`echo -e '\u23f8'`"
icon_stop="`echo -e '\u23f9'`"
icon_rec="`echo -e '\u23fa'`"
icon_voltage="`echo -e '\u26a1'`"

SEP_LEFT="`echo -e '\u25b8'`"
SEP_RIGHT="`echo -e '\u25c2'`"

get_loadavg() {
	# $loadavg is in format such as '0.00 0.01 0.18'
	LOADAVG_AWK_SCRIPT='{
if($1 >= 4) {
	printf "^fg(red)"
} else if($1 >= 3) {
	printf "^fg(yellow)"
}
printf("%s^fg() ", $1);
if($2 >= 4) {
	printf "^fg(red)"
} else if($2 >= 3) {
	printf "^fg(yellow)"
}
printf("%s^fg() ", $2);
if($3 >= 3) {
	printf "^fg(yellow)"
}
printf("%s^fg()", $3);
}'
	awk "${LOADAVG_AWK_SCRIPT}" /proc/loadavg
}

BATT_ACPI_DIR="/sys/class/power_supply/CMB1"
get_batt() {
	# /sys/class/power_supply/CMB1/capacity has integer value.
	#battery_int="`cat /sys/class/power_supply/CMB1/capacity`%"
	BATT_STATUS="`cat "${BATT_ACPI_DIR}/status"`"
	#CHARGE_FULL="`cat "${BATT_ACPI_DIR}/charge_full"`"
	#CHARGE_NOW="`cat "${BATT_ACPI_DIR}/charge_now"`"
	CHARGE_PERC="`cat "${BATT_ACPI_DIR}/capacity"`"
	prefix=""
	if [ "x$BATT_STATUS" == "xDischarging" ] ; then
		if [ $CHARGE_PERC -lt 10 ] ; then
			prefix='^fg(red)'
		elif [ $CHARGE_PERC -lt 40 ] ; then
			prefix='^fg(yellow)'
		else
			prefix='^fg(green)'
		fi
		prefix="${prefix}${icon_battery}"
	else
		prefix="^fg(green)${icon_voltage}"
	fi
	echo "${prefix}${CHARGE_PERC}^fg()"
}

get_volume() {
	#read volume_real_max volume_real volume_status <<< "$(amixer sget Master | grep -e 'Limits' -e '\[[0-9]\+%\]' | sed -e 's/\s*Limits: Playback 0 - \([0-9]\+\)/\1 /' -e 's/.* Playback \([0-9]\+\).* \[\(on\|off\)\]/\1 \2/' | head -2 | tr -d '\n')"
	read volume_real_max volume_real volume_status <<< \
		"$(amixer sget Master \
			| sed -ne '/^\s*Limits:/s/\s*Limits: Playback 0 - \([0-9]\+\)/\1 / p' \
				-e '/: Playback /s/.* Playback \([0-9]\+\).* \[\(on\|off\)\]$/\1 \2/ p' \
			| head -2 | tr -d '\n')"
	if grep 'Speaker Playback Switch' -A20 '/proc/asound/card1/codec#0' | grep 'Pin-ctl' | head -1 | grep 'OUT$' >/dev/null ; then
		# speaker
		sound_output="Spk"
	else
		# headphone
		sound_output="Hph"
	fi
	if [ "x$volume_status" == "xon" ] ; then
		vol_label="$icon_vol_loud"
	else
		vol_label="$icon_vol_mute"
	fi
	volume_perc="$(echo "scale=2; $volume_real * 100 / $volume_real_max" | bc)"
	echo "${vol_label}${volume_perc}%[$sound_output]"
}

MPD_SEND="curl --max-time 1 -s telnet://localhost:6600"
get_mpd_info() {
	mpd_status="`echo -e "status\nclose" | $MPD_SEND`"
	mpd_play_state="`sed -ne '/^state:/s/^[^:]*: \(.*\)$/\1/ p' <<<"$mpd_status"`"
	if [ "x$mpd_play_state" == "xplay" ] ; then
		mpd_play_state_str="$icon_play_forward"
	else
		mpd_play_state_str="$icon_pause"
	fi
	mpd_vol="`sed -ne '/^volume:/s/^[^:]*: \(.*\)$/\1/ p' <<<"$mpd_status"`"
	mpd_song="`echo -e 'currentsong\nclose' | $MPD_SEND | sed -ne '/^Title:/s/^[^:]*: \(.*\)$/\1/ p'`"
	echo "${icon_music}[${mpd_play_state_str}:${mpd_vol}%]$speaker_icon:^fg(green)${mpd_song}^fg()"
}

get_rogybgm_info() {
	ap_mac="`iwlist wlp2s0 scan | sed -ne 's/.*Address: *\(.*\)$/\1/gp'`"
	if [ "x$ap_mac" == "x00:A0:DE:9B:87:F0" ] ; then
		# connected to SSR-NETWORK.
		echo -ne 'status\ncurrentsong\nclose' \
			| curl --max-time 1 -s 'telnet://172.16.11.82:6600' \
			| sed -ne 's/^state: *\(.*\)/\1/gp;s/^Title: *\(.*\)$/\1/p' \
			| tr '\n' '\0' | sed -e 's/\(.*\)\x0\(.*\)\x0/rogyBGM[\1]: \2/'
		echo " ${SEP_LEFT}"
	fi
}

while :; do
	# like '2012-04-23(Mon) 22:51:48+0900 (1335189108)'
	date="`LC_ALL=C date +'%F(%a) %T%z (%s)'`"

	loadavg="`get_loadavg`"
	battery="`get_batt`"
	volume="`get_volume`"
	mpd_info="`get_mpd_info`"
	rogybgm_info="`get_rogybgm_info`"

	echo -n "$rogybgm_info"
	echo -n "$mpd_info"
	echo -n " ${SEP_RIGHT} "
	echo -n "$volume"
	echo -n " ${SEP_RIGHT} "
	echo -n "$date"
	echo -n " ${SEP_RIGHT} "
	echo -n "$loadavg"
	echo -n " ${SEP_RIGHT} "
	echo -n "$battery"
	echo
	sleep 1
done
