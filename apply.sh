#!/usr/bin/env bash

SYSTEM_FLAKES=(
    "root"
    "nixpkgs"
    "nix-darwin"
    "home-manager"
)

if [ "${1:-}" = "-u" ]; then
    nix flake update
    shift
fi

if [ "${1:-}" = "-U" ]; then
    SYSTEM_FLAKES_JSON="$(printf '%s\n' "${SYSTEM_FLAKES[@]}" | jq -R . | jq -s .)"
    echo "${SYSTEM_FLAKES_JSON}" >&2
    nix flake metadata --json |
        jq -r --argjson system "${SYSTEM_FLAKES_JSON}" '(.locks.nodes | keys - $system)[]' |
        xargs nix flake update
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
