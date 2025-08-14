#!/usr/bin/env bash

echo "Running markdown-link-check tool using it's docker image..."
docker run -v .:/tmp:ro --rm -i ghcr.io/tcort/markdown-link-check:stable -q --config /tmp/.markdown-link-check.json /tmp/