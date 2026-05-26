{inputs, ...}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".config/codex".source = "${inputs.codex}";
  ".config/sketchybar".source = "${inputs.sketchybar}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/shell-include".source = "${inputs.dotinc}";
  ".inputrc".source = "${inputs.dotconf}/.inputrc";
  ".config/ruff/ruff.toml".source = "${inputs.dotconf}/ruff.toml";

  ".codex/hooks.json".source = "${inputs.codex}/hooks.json";
  ".codex/rules".source = "${inputs.codex}/rules";

  ".config/qman/qman.conf".text = ''
    [misc]
    groff_path=/opt/homebrew/bin/groff
    system_type=darwin
    apropos_path=/usr/local/bin/fakeapropos
    whatis_path=/usr/local/bin/fakewhatis
  '';

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
