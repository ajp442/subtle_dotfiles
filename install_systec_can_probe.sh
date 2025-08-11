#!/usr/bin/env bash

set -x

SYSWORXX_SOCKETCAN_DRIVER_DOWNLOAD_LINK="https://www.systec-electronic.com/media/default/Redakteur/produkte/Interfaces_Gateways/sysWORXX_USB_CANmodul_Series/Downloads/SO-1139-systec_can.tar.bz2"

curl --location "$SYSWORXX_SOCKETCAN_DRIVER_DOWNLOAD_LINK" --output driver.tar.bz2
tar -xjvf driver.tar.bz2
cd systec_can-v*

INSTALLED_VERSION=""
if dkms status | grep --silent systec_can; then
    INSTALLED_VERSION="$(dkms status | tee /dev/stderr | grep systec_can | cut -d ',' -f1)"
fi
if [[ -n "$INSTALLED_VERSION" ]]; then
    echo "Removing '$INSTALLED_VERSION'"
    sudo dkms remove "$INSTALLED_VERSION" --all
    sudo rm -rf /usr/src/systec_can*
fi
sudo dkms install .
dkms status
