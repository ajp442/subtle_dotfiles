#!/usr/bin/env bash

# Pass this script an ip address or hostname, and it will take a screenshot of
# that device and download it. This script was written for taking remote
# screenshots on V4+

HOST=$1;
if ! ping -c 1 -w 2 "$HOST" >>/dev/null 2>>/dev/null; then
    echo "Unable to ping $HOST"
    exit 1
fi

FILE_NAME="screenshot_$(date '+%Y-%m-%d_%H_%M_%S').png"
REMOTE_PATH="/home/root/screenshots"
LOCAL_PATH="$HOME/Pictures"

# Make sure the path we are saving to on the device exists.
# shellcheck disable=SC2029 # We want these variable to expand on client side.
ssh "root@$HOST" "mkdir -p $REMOTE_PATH"

# Save screenshot on remote device.
echo "Saving screenshot on remote device to $REMOTE_PATH/$FILE_NAME"
# shellcheck disable=SC2029 # We want these variable to expand on client side.
ssh "root@$HOST" "export DISPLAY=:0; import -display :0 -window root '$REMOTE_PATH/$FILE_NAME'";

# Download screenshot to our local device.
echo "Downloading screenshot from remote device to $LOCAL_PATH/$FILE_NAME"
scp "root@$HOST:$REMOTE_PATH/$FILE_NAME" "$LOCAL_PATH"
