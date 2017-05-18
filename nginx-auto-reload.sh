#!/bin/bash
# Check inotify-tools is installed or not
pacman -Ssq| grep inotify-tools
if [ $? -ne 0 ]
then
        echo "Installing inotify-tools, please wait..."
        pacman -S inotify-tools
fi
while true
do
        inotifywait --exclude .swp -e create -e modify -e delete -e move  /etc/nginx        # Check NGINX Configuration Test
        # Only Reload NGINX If NGINX Configuration Test Pass
        nginx -t
        if [ $? -eq 0 ]
        then
                echo "Reloading Nginx Configuration"
                systemctl restart nginx.service
        fi
done
