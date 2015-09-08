# WEATHER
if [ -f compiled_script.sh ]; then rm compiled_script.sh; fi

iconv -f UTF-8 -t ASCII//IGNORE get_image_loop.sh > compiled_script.sh
chmod +x compiled_script.sh

scp weather-image-error.png root@192.168.2.2:/mnt/us/kite/weather-image-error.png
scp compiled_script.sh      root@192.168.2.2:/mnt/us/kite/get_image_loop.sh

if [ -f compiled_script.sh ]; then rm compiled_script.sh; fi

# NETWORK
if [ -f network_compiled.sh ]; then rm network_compiled.sh; fi

iconv -f UTF-8 -t ASCII//IGNORE usbnetwork.sh > network_compiled.sh
chmod +x network_compiled.sh

scp network_compiled.sh root@192.168.2.2:/mnt/us/kite/usbnetwork.sh

if [ -f network_compiled.sh ]; then rm network_compiled.sh; fi

# REBOOT
if [ -f reboot_compiled.sh ]; then rm reboot_compiled.sh; fi

iconv -f UTF-8 -t ASCII//IGNORE reboot.sh > reboot_compiled.sh
chmod +x reboot_compiled.sh

scp reboot_compiled.sh root@192.168.2.2:/mnt/us/kite/reboot.sh

if [ -f reboot_compiled.sh ]; then rm reboot_compiled.sh; fi

# SHUTDOWN
if [ -f shutdown_compiled.sh ]; then rm shutdown_compiled.sh; fi

iconv -f UTF-8 -t ASCII//IGNORE shutdown.sh > shutdown_compiled.sh
chmod +x shutdown_compiled.sh

scp shutdown_compiled.sh root@192.168.2.2:/mnt/us/kite/shutdown.sh

if [ -f shutdown_compiled.sh ]; then rm shutdown_compiled.sh; fi
