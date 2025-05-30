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
        datamodel-code-generator
        mdformat
        mdformat-gfm
        pip
        tabulate
      ]))
  rustc
]
