#!/bin/bash

source ./src/utils.sh
source ./src/constants.sh

rm -rf ./build
sudo systemctl stop $SERVICE_NAME
remove_image_if_exists "nginx-reverse-proxy"
sudo rm -f /etc/systemd/system/$SERVICE_NAME.service
