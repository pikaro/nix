{
config,
  inputs,
  sysInfo,
  ...
}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".config/agents".source = "${inputs.agents}";
  ".config/sketchybar".source = "${inputs.sketchybar}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/shell-include".source = "${inputs.dotinc}";
  ".inputrc".source = "${inputs.dotconf}/.inputrc";
  ".config/ruff/ruff.toml".source = "${inputs.dotconf}/ruff.toml";

  # Source from ~/.config/agents mounted above
  ".codex/hooks.json".source = config.lib.file.mkOutOfStoreSymlink "/Users/${config.home.username}/.config/agents/hooks.json";
  ".codex/rules".source = config.lib.file.mkOutOfStoreSymlink "/Users/${sysInfo.user}/.config/agents/rules";

  ".config/qman/qman.conf".text = ''
    [misc]
    groff_path=/opt/homebrew/bin/groff
    system_type=darwin
    apropos_path=/usr/local/bin/fakeapropos
    whatis_path=/usr/local/bin/fakewhatis
  '';

  ".config/karabiner/karabiner.json".source = "${inputs.dotconf}/karabiner.json";
  ".config/aerospace/aerospace.toml".source = "${inputs.dotconf}/aerospace.toml";

  ".gnupg/gpg-agent.conf".text = ''
    pinentry-program /opt/homebrew/bin/pinentry-touchid
  '';

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
