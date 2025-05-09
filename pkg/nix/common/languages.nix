{pkgs}:
with pkgs; [
  cargo
  go
  nodejs
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
