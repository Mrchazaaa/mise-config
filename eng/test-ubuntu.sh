#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

docker run --rm -it \
  --mount "type=bind,source=$repo_root,target=/workspace" \
  --workdir /workspace \
  ubuntu:24.04 \
  bash -lc '
    set -euo pipefail
    apt-get update
    apt-get install -y --no-install-recommends ca-certificates curl
    exec bash
  '
