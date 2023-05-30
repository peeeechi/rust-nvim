#!/bin/bash -eu

cd $(dirname $0)
source ./.env

: ${TAG:="latest"}

ENVS="-e UID=`(id -u)` \
      -e GID=`(id -g)`"

MOUNT="\
--mount type=bind,src=$(pwd)/.config,dst=/home/inoue/.config \
--mount type=volume,src=nvim_cache,dst=/home/inoue/.local \
"

docker run --rm -it ${ENVS} ${MOUNT} "${REPOSITORY}/${IMAGE}:${TAG}" /bin/bash
