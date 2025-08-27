#!/bin/bash

remoteScreenshot () 
{ 
    HOST=${1:-"root@192.168.0.10"};
    FILE_NAME="screenshot_$(date '+%Y-%m-%d_%H_%M_%S').png"
    IMG="${2:-"/home/root/screenshots/screenshot_${FILE_NAME}"}";
    echo "Saving screenshot as $IMG";
    ssh "$HOST" "export DISPLAY=0:0; import -display 0:0 -window root '$IMG'";
    echo "Downloading ${IMG} to ~/Pictures/${FILE_NAME}";
    scp "${HOST}:${IMG//\ /\\\ }" ~/Pictures/
}

remoteScreenshot $1 $2
