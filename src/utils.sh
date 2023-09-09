#!/bin/bash

function perr () {
    echo $2
    exit $1
}

function is_integer () {
    INTEGER=$1
    if [[ $INTEGER =~ ^([+-]?[1-9][0-9]*|0)$ ]]; then
        echo "true"
    else
        echo "false"
    fi
}

function is_integer_in_range () {
    INTEGER=$1
    MIN=$2
    MAX=$3
    if [[ $(is_integer $INTEGER) == "false" ]]; then
        echo "false"
    elif ((INTEGER > MAX || INTEGER < MIN)); then
        echo "false"
    else
        echo "true"
    fi
}

function is_valid_port () {
    PORT=$1
    echo $(is_integer_in_range $1 1 65535)
}

function remove_image_if_exists() {
    IMAGE_NAME=$1
    if [[ "$(sudo docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
        echo "Could not delete \"$IMAGE_NAME\" as that image does not exist"
        return
    fi
    # remove docker containers associated with this image
    sudo docker rm -f $(sudo docker ps -a -q --filter="ancestor=$IMAGE_NAME") 2>&- || echo "Found no containers for this image"
    # remove the image itself, now that it no longer has any active containers
    sudo docker rmi $IMAGE_NAME
    echo "Successfully deleted the \"$IMAGE_NAME\" image"
}
