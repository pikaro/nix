{inputs, ...}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/include".source = "${inputs.dotinc}";
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
    extensions=["gfm", "mkdocs"]
  '';

  ".clang-format".text = ''
    ---
    BasedOnStyle: LLVM
    IndentWidth: 4
  '';
}
