#!/bin/sh

cd /mnt/us/kite

/etc/init.d/framework stop
/etc/init.d/powerd stop

while true
do
	if wget http://server/path/to/weather-script-output.png; then
		eips -c
		eips -c
		eips -g weather-script-output.png
		rm weather-script-output.png
	else
		eips -c
		eips -c
		eips -g weather-image-error.png
	fi
	sleep 10
done
