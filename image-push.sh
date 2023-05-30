#!/bin/bash -eu

cd $(dirname $0)
source ./.env

: ${TAG:="latest"}

docker push "${REPOSITORY}/${IMAGE}:${TAG}"
