#!/usr/bin/env bash

if [ "${1:-}" = "-u" ]; then
    nix flake update
    shift
fi
git add flake.lock
darwin-rebuild switch --flake . "$@"
