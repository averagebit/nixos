#!/usr/bin/env bash

[[ -z "${VCAM_IP}" ]] && read -rp "ADB IP: " VCAM_IP
[[ -z "${VCAM_DEVICE}" ]] && read -rp "VCAM Device: " VCAM_DEVICE

read -rp "ADB Connection Port: " VCAM_CONNECT_PORT
if ! adb connect "${VCAM_IP}:${VCAM_CONNECT_PORT}"; then
    read -rp "ADB Pair Port: " VCAM_PAIR_PORT
    adb pair "${VCAM_IP}:${VCAM_PAIR_PORT}"
    adb connect "${VCAM_IP}:${VCAM_CONNECT_PORT}"
fi

exec scrcpy --tcpip --v4l2-sink=/dev/"${VCAM_DEVICE}" --no-video-playback
