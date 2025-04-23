{pkgs}:
with pkgs; [
  # FIXME: https://github.com/NixOS/nixpkgs/issues/400373
  #ansible-lint
  hadolint
  shellcheck
  yamllint
]
