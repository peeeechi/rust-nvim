#!/bin/bash -eu

this_dir=$(dirname $0)
source $this_dir/.env
: ${TAG:="sandbox"}

echo "arg count: $#"
if [ $# = 0 ]; then
  target=$(pwd)
else
  target="${this_dir}/$1"
fi

ENVS="-e TZ=Asia/Tokyo \
      -e UID=`(id -u)` \
      -e GID=`(id -g)` \
      -e DISPLAY=${DISPLAY}"


# --mount type=bind,src=$(pwd)/.config,dst=/home/inoue/.config \
MOUNT="\
--mount type=bind,src=${target},dst=/home/inoue/ws/ \
--mount type=bind,src=./config_bk,dst=/home/inoue/.config/nvim/ \
--mount type=volume,src=nvim_cache,dst=/home/inoue/.local \
"
WORKING_DIR="-w /home/inoue/ws"

echo "${REPOSITORY}/${IMAGE}:${TAG}"

docker run --rm -it ${ENVS} ${MOUNT} ${WORKING_DIR} "${REPOSITORY}/${IMAGE}:${TAG}" /bin/bash
