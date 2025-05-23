#!/bin/bash

image_name=$(docker inspect --format='{{.Config.Image}}' ${HOSTNAME})
container_name=$(docker inspect --format='{{.Name}}' ${HOSTNAME})

# Rename image
docker tag ${image_name} ${container_name#/}:0.1.0 >> .devcontainer/logs.log

# Remove old image tag
docker rmi ${image_name} >> .devcontainer/logs.log