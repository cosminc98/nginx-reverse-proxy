<img src="https://www.vectorlogo.zone/logos/nginx/nginx-ar21.svg">

## Description
This repo contains all necessary requirements to setup an NGINX reverse proxy
which protects frontend servers from denial of service attacks by limiting the
number of requests per IP. It can also be used to route different paths in the
domain to different frontend applications.

## Usage
Create the NGINX image and start the service that runs a docker container with
that image.
```bash
make setup
```

Remove the build directory, the generated image, and stop the NGINX service.
```bash
make clean
```