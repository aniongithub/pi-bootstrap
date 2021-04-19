#!/bin/bash -e

# Add or remove any custom installation steps here.
# This file shows how to modify the image filesystem directly
# You can also copy files from the mounted boostrap-resources folder
# mounted at /bootstrap-resources (see config)

if [[ -z $WPA_SSID || -z $WPA_PASSPHRASE || -z $WPA_COUNTRY ]]
then
    echo "Skipping generation of wpa_supplicant.conf, one or more required Wi-Fi fields were not provided"
else
    # Generate wpa_supplicant.conf in /boot so pi will copy it and disable rfkill on startup
    echo "Generating wpa_supplicant.conf, step 2/2..."
    echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > ${BOOTFS_DIR}/wpa_supplicant.conf
    echo "update_config=1" >> ${BOOTFS_DIR}/wpa_supplicant.conf
    echo "country=${WPA_COUNTRY}" >> ${BOOTFS_DIR}/wpa_supplicant.conf
    wpa_passphrase ${WPA_SSID} ${WPA_PASSPHRASE} >> ${BOOTFS_DIR}/wpa_supplicant.conf
fi