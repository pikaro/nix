{pkgs}:
with pkgs; [
  cargo
  go
  nodejs
  pnpm
  pkgconf
  poetry
  (python313.withPackages
    (ps:
      with ps; [
        boto3
        gitpython
        # FIXME: BROKEN
        # datamodel-code-generator
        mdformat
        mdformat-gfm
        mdformat-mkdocs
        mdformat-frontmatter
        pip
        tabulate
      ]))
  rustc
  uv
  yarn
]
