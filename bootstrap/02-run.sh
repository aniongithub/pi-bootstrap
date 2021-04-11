#!/bin/bash -e

# Generate wpa_supplicant.conf in /boot so pi will copy it and disable rfkill on startup
echo "Generating wpa_supplicant.conf..."
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > ${BOOTFS_DIR}/wpa_supplicant.conf
echo "update_config=1" >> ${BOOTFS_DIR}/wpa_supplicant.conf
echo "country=${WPA_COUNTRY}" >> ${BOOTFS_DIR}/wpa_supplicant.conf
wpa_passphrase ${WPA_SSID} ${WPA_PASSPHRASE} >> ${BOOTFS_DIR}/wpa_supplicant.conf