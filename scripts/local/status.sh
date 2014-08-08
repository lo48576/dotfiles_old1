#!/bin/sh
while true ; do
	# like '2012-04-23(Mon) 22:51:48+0900 (1335189108)'
	date="`LC_ALL='C' date +'%F(%a) %T%z (%s)'`"
	# loadavg is in format such as '0.00 0.01 0.18 '
	loadavg="`cat /proc/loadavg | sed 's/[^ ]* [^ ]*$//'`"
	# /sys/class/power_supply/CMB1/capacity has integer value.
	#battery="`cat /sys/class/power_supply/CMB1/capacity`%"
	battery="batt: $(echo "scale=4; $(cat /sys/class/power_supply/CMB1/charge_now)*100/$(cat /sys/class/power_supply/CMB1/charge_full)" | bc)%"
	printf "%s | %s| %s\n" "$date" "$loadavg" "$battery"
	sleep 0.5
done
