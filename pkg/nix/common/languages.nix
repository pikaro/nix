{pkgs}:
with pkgs; [
  cargo
  go
  nodejs
  pnpm
  poetry
  python312
  (python313.withPackages
    (ps:
      with ps; [
        # FIXME: BROKEN
        # datamodel-code-generator
        mdformat
        mdformat-gfm
        mdformat-mkdocs
        pip
        tabulate
      ]))
  rustc
  uv
]
