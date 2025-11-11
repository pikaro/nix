#!/usr/bin/env bash

if [ "${1:-}" = "-u" ]; then
    nix flake update
    shift
fi

git add flake.lock
sudo darwin-rebuild switch --flake . "$@"

if [ "${1:-}" = "-c" ]; then
    nix-env --delete-generations old
    nix-store gc --gc
    nix-collect-garbage -d
    nix-store --optimise
fi
