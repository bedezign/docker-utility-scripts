#!/usr/bin/env bash

echo '*** Starting DinD [Docker in Docker]'

DOCKER=$(which docker)

${DOCKER} pull docker:stable-dind
${DOCKER} create --privileged -p 172.99.0.100:2375:2375 --name docker-dind docker:stable-dind
${DOCKER} start docker-dind