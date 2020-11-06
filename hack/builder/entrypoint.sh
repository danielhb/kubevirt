#!/usr/bin/env bash
set -e
set -o pipefail

echo "(debug) entrypoint, before create_bazel_cache_rcs"

if [[ "$KUBEVIRT_CREATE_BAZELRCS" == "true" ]]; then
    /create_bazel_cache_rcs.sh
fi

source /etc/profile.d/gimme.sh
export GOPATH="/root/go"
eval "$@"
