#!/usr/bin/env bash

set -eEuo pipefail

SYSTEM_FLAKES=(
    "root"
    "nixpkgs"
    "nix-darwin"
    "home-manager"
)

_log() {
    if [[ ! -t 0 ]]; then
        MSG="$1: $(cat /dev/stdin)"
    else
        MSG="$1"
    fi
    printf "[%s] %s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$MSG" >/dev/stderr
}

_log "Updating nix channels"

if [ "${1:-}" = "-u" ]; then
    git pull
    _log "Updating all flakes"
    nix flake update
    shift
fi

if [ "${1:-}" = "-U" ]; then
    git pull
    SYSTEM_FLAKES_JSON="$(printf '%s\n' "${SYSTEM_FLAKES[@]}" | jq -R . | jq -s .)"
    nix flake metadata --json |
        jq -r --argjson system "${SYSTEM_FLAKES_JSON}" '(.locks.nodes | keys - $system)[]' | tr '\n' ' ' |
        tee >(_log "Updating flakes") |
        xargs nix flake update
    shift
fi

CLEANUP=0
if [ "${1:-}" = "-c" ]; then
    CLEANUP=1
    shift
fi

if git diff --quiet flake.lock; then
    _log "No changes in flake.lock"
else
    _log "flake.lock has changed, committing the changes"
    git commit -am "Update flake.lock"
fi

_log "Rebuilding nix-darwin configuration"
sudo darwin-rebuild switch --flake . "$@"

if [ "${CLEANUP}" -eq 1 ]; then
    _log "Cleaning up brew"
    brew cleanup --prune=all
    _log "Cleaning up old nix generations"
    nix-env --delete-generations old
    _log "Collecting nix garbage"
    nix-collect-garbage -d
    _log "Optimising nix store"
    nix-store --optimise
fi
