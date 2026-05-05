{inputs, ...}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".config/sketchybar".source = "${inputs.sketchybar}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/shell-include".source = "${inputs.dotinc}";
  ".inputrc".source = "${inputs.dotconf}/.inputrc";
  ".config/ruff/ruff.toml".source = "${inputs.dotconf}/ruff.toml";

  ".config/karabiner/karabiner.json".source = "${inputs.dotconf}/karabiner.json";
  ".config/aerospace/aerospace.toml".source = "${inputs.dotconf}/aerospace.toml";

  ".mdformat.toml".text = ''
    wrap=80
    extensions=["gfm", "mkdocs", "frontmatter"]
  '';

  ".clang-format".text = ''
    ---
    BasedOnStyle: LLVM
    IndentWidth: 4
    ColumnLimit: 80
  '';

  ".platformio/.clangd".text = ''
    CompileFlags:
      Add:
        - -w
      Remove:
        - -Wall
        - -Wextra
        - -Wshadow
        - -Wshadow-field
        - -fno-shrink-wrap
        - -fno-tree-switch-conversion
        - -fstrict-volatile-bitfields
        - -mdisable-hardware-atomics
    Diagnostics:
      Suppress: ['.*']
      UnusedIncludes: None
      ClangTidy:
        Remove:
          - '*'
  '';

  ".copilot-tools.json".text = ''
    {
      "shell": [
        "ls",
        "grep",
        "rg",
        "sed",
        "awk",
        "bat",
        "cat",
        "git"
      ]
    }
  '';
}
