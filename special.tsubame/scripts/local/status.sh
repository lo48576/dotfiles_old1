#!/bin/sh
while true ; do
	# like '2012-04-23(Mon) 22:51:48+0900 (1335189108)'
	date="`LC_ALL='C' date +'%F(%a) %T%z (%s)'`"
	# loadavg is in format such as '0.00 0.01 0.18 '
	loadavg="`sed 's/[^ ]* [^ ]*$//' /proc/loadavg`"
	# /sys/class/power_supply/CMB1/capacity has integer value.
	#battery_int="`cat /sys/class/power_supply/CMB1/capacity`%"
	battery="batt: $(echo "scale=4; $(cat /sys/class/power_supply/CMB1/charge_now)*100/$(cat /sys/class/power_supply/CMB1/charge_full)" | bc)%"
	#read volume_perc volume_status <<< "$(amixer sget Master | grep -o '\[[0-9]\+\] \[\(on\|off\)\]' | head -1 | sed -e 's/\[\([^]]*\)\]/\1/g')"
	#volume="volume: $volume_perc [$volume_status]"
	read volume_real_max volume_real volume_status <<< "$(amixer sget Master | grep -e 'Limits' -e '\[[0-9]\+%\]' | sed -e 's/\s*Limits: Playback 0 - \([0-9]\+\)/\1 /' -e 's/.* Playback \([0-9]\+\).* \[\(on\|off\)\]/\1 \2/' | head -2 | tr -d '\n')"
	sound_output="`amixer cget name='Master Playback Switch' | grep -o 'values=\(on\|off\)' | sed -e 's/values=//'`"
	if [ "$sound_output" == "on" ] ; then
		# headphone
		sound_output="Hph"
	else
		# speaker
		sound_output="Spk"
	fi
	volume="vol: $(echo "scale=2; $volume_real * 100 / $volume_real_max" | bc)% [$volume_status][<$sound_output]"
	printf "%s | %s | %s| %s\n" "$volume" "$date" "$loadavg" "$battery"
	sleep 0.5
done
