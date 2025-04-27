{pkgs}:
with pkgs; [
  alejandra
  gofumpt
  (python3.withPackages
    (ps: with ps; [mdformat mdformat-gfm]))
  ruff
  stylua
  shfmt
  texlab
]
