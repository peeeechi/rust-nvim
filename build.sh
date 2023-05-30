#!/bin/bash -eu


cd $(dirname $0)
source ./.env

: ${TAG:="latest"}

docker image build -t "${REPOSITORY}/${IMAGE}:${TAG}" .
