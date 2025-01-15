#!/bin/bash

remoteScreenshot () 
{ 
    HOST=${1:-"root@192.168.0.10"};
    IMG="${2:-"/home/root/screenshots/screenshot_$(date '+%Y-%m-%d_%H_%M_%S').png"}";
    echo "Saving screenshot as $IMG";
    ssh "$HOST" "export DISPLAY=0:0; import -display 0:0 -window root '$IMG'";
    echo "Downloading ${IMG} to ~/Pictures/";
    scp "${HOST}:${IMG//\ /\\\ }" ~/Pictures/
}

remoteScreenshot $1 $2
