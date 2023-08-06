#!/bin/bash -eu


cd $(dirname $0)
source ./.env

is_force=''
while getopts fh OPT
do
  case "$OPT" in
    f) is_force="--no-cache"
    ;;
    h) echo "Usage: build.sh [OPTIONS]"
       echo "Options:"
       echo "  -f"
       echo "     force rebuild"
       exit 1
    ;;
    *) 
    ;;
  esac
done

: ${TAG:="sandbox"}

docker image build -f ./Dockerfile.sand $is_force -t "${REPOSITORY}/${IMAGE}:${TAG}" .
