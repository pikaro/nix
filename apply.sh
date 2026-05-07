#!/usr/bin/env bash

# shellcheck source=../dotinc/entrypoint.sh
. "${HOME}/.local/shell-include/entrypoint.sh"

# set -eEuo pipefail

SYSTEM_FLAKES=(
    "root"
    "nixpkgs"
    "nix-darwin"
    "home-manager"
)

_log "Cleaning local symlinks"
nixlink clean

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
    FLAKES="$(nix flake metadata --json |
        jq -r --argjson system "${SYSTEM_FLAKES_JSON}" '(.locks.nodes | keys -
  $system)[]' |
        tr '\n' ' ')"

    _log "Updating flakes: ${FLAKES:-none}"

    # shellcheck disable=SC2086
    nix flake update $FLAKES || { _fatal "Failed to update flakes: $FLAKES"; }
    shift
fi

if git diff --quiet flake.lock; then
    _log "No changes in flake.lock"
else
    _log "flake.lock has changed, committing the changes"
    git add flake.lock
    git commit -m "Update flake.lock"
fi

_log "Rebuilding nix-darwin configuration"
sudo darwin-rebuild switch --flake . "$@"

_log "Cleaning up brew"
brew cleanup --prune=all
_log "Deleting old profile entries"
sudo -i nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
_log "Cleaning up old nix generations"
nix-env --delete-generations old
sudo nix-env --delete-generations old
_log "Collecting nix garbage"
nix-collect-garbage -d
sudo nix-collect-garbage -d
_log "Optimising nix store"
nix-store --optimise
