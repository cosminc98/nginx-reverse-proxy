#!/bin/bash

PRIVATE_IP=$(hostname -I | cut -d " " -f1)
BUILD_DIR=./build
IMAGE_NAME="nginx-reverse-proxy"
SERVICE_NAME="reverse-proxy"