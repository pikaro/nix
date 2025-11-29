{inputs, ...}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/shell-include".source = "${inputs.dotinc}";
  ".inputrc".source = "${inputs.dotconf}/.inputrc";

  ".aider.model.settings.yml".text = ''
    - name: aider/extra_params
      extra_params:
        extra_headers:
          Editor-Version: vscode/42
  '';
  ".aider.conf.yml".text = ''
    model: github_copilot/gpt-5
    editor-model: github_copilot/gpt-5
    weak-model: github_copilot/gpt-5-mini
    show-model-warnings: false
  '';

  ".config/karabiner/karabiner.json".source = "${inputs.dotconf}/karabiner.json";
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

  ".platformio/clangd".text = ''
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
}
