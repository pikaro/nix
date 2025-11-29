{pkgs}:
with pkgs; [
  cargo
  go
  gopls
  nodejs
  pnpm
  pkgconf
  poetry
  # WARNING: python314 is broken
  (python313.withPackages
    (ps:
      with ps; [
        boto3
        customtkinter
        gitpython
        datamodel-code-generator
        mdformat
        mdformat-gfm
        mdformat-mkdocs
        mdformat-frontmatter
        pip
        pyobjc-framework-Cocoa
        tabulate
        tkinter
      ]))
  rustc
  uv
  yarn
]
