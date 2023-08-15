!/bin/bash -eu

cd $(dirname $0)
source ./.env

: ${TAG:="sandbox"}

docker push "${REPOSITORY}/${IMAGE}:${TAG}"
