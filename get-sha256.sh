#!/usr/bin/env bash

set -euo pipefail
VERSION="$1"

usage() {
	echo "Usage: $0 <version>" >&2
	exit 2
}

if [ $# -ne 1 ]; then
	usage
fi

echo "Resolving npm tarball for it-tools-mcp@$VERSION..."
URL=$(npm view "it-tools-mcp@${VERSION}" dist.tarball 2>/dev/null || true)
if [ -z "$URL" ]; then
	echo "Error: could not find npm tarball for version $VERSION" >&2
	exit 3
fi

TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

echo "Downloading tarball: $URL"
curl -fSL "$URL" -o "$TMPFILE"

SHA256=$(shasum -a 256 "$TMPFILE" | awk '{print $1}')

echo "Version: $VERSION"
echo "URL: $URL"
echo "SHA256: $SHA256"

FORMULA="Formula/it-tools-mcp.rb"
if [ ! -f "$FORMULA" ]; then
	echo "Warning: formula file $FORMULA not found; skipping update" >&2
	exit 0
fi

echo "Updating $FORMULA with new URL, sha256, and version"

# Portable sed inplace: macOS sed requires -i ''
if [ "$(uname -s)" = "Darwin" ]; then
	sed -i '' -E "s|url \".*\"|url \"$URL\"|; s|sha256 \".*\"|sha256 \"$SHA256\"|; s|version \".*\"|version \"$VERSION\"|" "$FORMULA"
else
	sed -i -E "s|url \".*\"|url \"$URL\"|; s|sha256 \".*\"|sha256 \"$SHA256\"|; s|version \".*\"|version \"$VERSION\"|" "$FORMULA"
fi

echo "Updated $FORMULA"

exit 0

