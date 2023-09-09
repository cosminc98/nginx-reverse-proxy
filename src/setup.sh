#!/bin/bash

source ./src/utils.sh
source ./src/constants.sh

# check dependencies
which docker > /dev/null || perr 1 "Docker not installed; run \"install_docker.sh\" first"

# CLI arguments
APP_PORT=$1

# make sure CLI arguments are valid; if not, fill them in
while [[ $(is_valid_port $APP_PORT) == "false" ]]; do
    read -p "Enter the port of the frontend application (0 < PORT <= 65535): " APP_PORT
done

# build the nginx reverse proxy docker image
mkdir -p $BUILD_DIR
pushd $BUILD_DIR
cp ../docker/* .
sed -i "s/<PRIVATE_IP>/$PRIVATE_IP/" nginx.conf
sed -i "s/<APP_PORT>/$APP_PORT/" nginx.conf
remove_image_if_exists $IMAGE_NAME
sudo docker build -t $IMAGE_NAME . --no-cache
popd

# create reverse proxy service that will keep an NGINX container alive to
# redirect requests coming on port 80 to the frontend application on the
# specified port while protecting it from excessive requests
pushd $BUILD_DIR
sed -i "s/<IMAGE_NAME>/$IMAGE_NAME/" $SERVICE_NAME.service
sudo cp $SERVICE_NAME.service /etc/systemd/system/$SERVICE_NAME.service
sudo systemctl enable $SERVICE_NAME
sudo systemctl start $SERVICE_NAME
sudo systemctl status $SERVICE_NAME
popd
