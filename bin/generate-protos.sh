#!/bin/bash

set -o errexit
set -o nounset

bazel build //...

genfiles=$(bazel info bazel-genfiles)
files=$(find -L ${genfiles} -type f \( -name '*.pb.go' -or -name '*.gen.go' \) )

for src in ${files}; do
    dst=${src##${genfiles}/}
    if [ -d "$(dirname ${dst})" ]; then
        install -m 0640 ${src} ${dst}
    fi
done
