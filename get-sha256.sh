#!/usr/bin/env bash

set -euo pipefail
VERSION="${1}"
URL=$(npm view it-tools-mcp@"$VERSION" dist.tarball)
curl -sL "$URL" | shasum -a 256 | awk '{print $1}'