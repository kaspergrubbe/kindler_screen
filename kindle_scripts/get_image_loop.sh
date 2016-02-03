#!/bin/sh

cd /mnt/us/kite

/etc/init.d/framework stop
/etc/init.d/powerd stop

while true
do
	if wget http://server/path/to/script-output.png; then
		eips -c
		eips -c
		eips -g script-output.png
		rm script-output.png
	else
		eips -c
		eips -c
		eips -g image_unavailable.png
	fi
	sleep 10
done
