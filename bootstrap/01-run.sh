#!/bin/bash -e

# Core system functionality, do not modify
# instead, add more files to this step or use 
# config to mount custom steps before/after this

# https://fabianlee.org/2019/10/05/bash-setting-and-replacing-values-in-a-properties-file-use-sed/
# Get/Set values in a file with key=value type fields

function getValue() {
    filename=$1
    thekey=$2
    defaultVal=$3
    result=$(sed -rn "s/^${thekey}=([^\n]+)$/\1/p" ${filename} | xargs)
    [ -z "${result}" ] && echo $defaultVal || echo $result
}

function setValue() {
    filename=$1
    thekey=$2
    newvalue=$3

    if ! grep -R "^[#]*\s*${thekey}=.*" $filename > /dev/null; then
        echo "$thekey=$newvalue" >> $filename
    else
        sed -ir "s/^[#]*\s*${thekey}=.*/$thekey=\"$newvalue\"/" $filename
    fi
}

# Export these functions so they're available in chroot
# https://stackoverflow.com/a/30792189/802203
export -f getValue
export -f setValue

# We need all three to be specified
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

# Custom "convenience things" that raspi-config does for us go here.

# Enable rasberry pi camera
# https://raspberrypi.stackexchange.com/a/14247/114267
if [ ! -z ENABLE_CAMERA ] && [ "$ENABLE_CAMERA" == "1" ]; then
    echo "Enabling camera..."

    export START_X=1

    # Only set GPU_MEM to min reqd. if not specified
    if [[ -z GPU_MEM ]]; then export GPU_MEM="128"; fi
fi

# Individual options
if [[ ! -z $START_X ]]
then
echo "Setting start_x..." &&\
on_chroot << EOF
setValue /boot/config.txt start_x $START_X
EOF
fi

if [[ ! -z $GPU_MEM ]]
then
echo "Setting gpu_mem..."
on_chroot << EOF
setValue /boot/config.txt gpu_mem $GPU_MEM
EOF
fi