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
        awscli2
        # FIXME: BROKEN
        # datamodel-code-generator
        mdformat
        mdformat-gfm
        mdformat-mkdocs
        pip
        pre-commit
        tabulate
      ]))
  rustc
]
