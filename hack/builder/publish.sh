#!/usr/bin/env bash
set -ex

SCRIPT_DIR="$(
    cd "$(dirname "$BASH_SOURCE[0]")"
    pwd
)"

trap 'cleanup' EXIT

cleanup() {
    rm manifests/ -rf || true
}

. ${SCRIPT_DIR}/version.sh

cleanup

for ARCH in ${ARCHITECTURES}; do
    docker push danielhb/kubevirt-builder:${VERSION}-${ARCH}
    TMP_IMAGES="${TMP_IMAGES} danielhb/kubevirt-builder:${VERSION}-${ARCH}"
done

export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create --amend danielhb/kubevirt-builder:${VERSION} ${TMP_IMAGES}
docker manifest push danielhb/kubevirt-builder:${VERSION}
