{pkgs}:
with pkgs; [
  cargo
  go
  nodejs
  pnpm
  poetry
  (python313.withPackages
    (ps:
      with ps; [
        mdformat
        mdformat-gfm
        tabulate
      ]))
  rustc
]
