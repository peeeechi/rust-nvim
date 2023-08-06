#!/bin/bash -eu

this_dir=$(dirname $0)
source $this_dir/.env
: ${TAG:="sandbox"}

call_dir=$(pwd)
echo "arg count: $#"
if [ $# = 0 ]; then
  target=$call_dir
else
  target="${call_dir}/$1"
fi

ENVS="-e TZ=Asia/Tokyo \
      -e UID=`(id -u)` \
      -e GID=`(id -g)`"

# --mount type=bind,src=$(pwd)/.config,dst=/home/inoue/.config \
MOUNT="\
--mount type=bind,src=${target},dst=/home/inoue/ws/ \
--mount type=bind,src=${call_dir}/config_bk,dst=/home/inoue/.config/nvim/ \
--mount type=volume,src=nvim_cache,dst=/home/inoue/.local \
"
WORKING_DIR="-w /home/inoue/ws"

docker run --rm -it ${ENVS} ${MOUNT} ${WORKING_DIR} "${REPOSITORY}/${IMAGE}:${TAG}" /bin/bash
