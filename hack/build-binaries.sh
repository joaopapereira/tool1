#!/bin/bash

set -e -x -u

function get_latest_git_tag {
  git describe --tags | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+'
}

VERSION="${1:-`get_latest_git_tag`}"

# makes builds reproducible
export CGO_ENABLED=0
LDFLAGS="-X main.Version=$VERSION -buildid="


GOOS=darwin GOARCH=amd64 go build -ldflags="$LDFLAGS" -trimpath -o tool1-darwin-amd64 ./...
GOOS=darwin GOARCH=arm64 go build -ldflags="$LDFLAGS" -trimpath -o tool1-darwin-arm64 ./...
GOOS=linux GOARCH=amd64 go build -ldflags="$LDFLAGS" -trimpath -o tool1-linux-amd64 ./...
GOOS=windows GOARCH=amd64 go build -ldflags="$LDFLAGS" -trimpath -o tool1-windows-amd64.exe ./...

shasum -a 256 ./tool1-darwin-amd64 ./tool1-darwin-arm64 ./tool1-linux-amd64 ./tool1-windows-amd64.exe
