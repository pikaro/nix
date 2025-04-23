{inputs, ...}: {
  ".config/kitty".source = "${inputs.kitty}";
  ".config/nvim".source = "${inputs.nvim}";
  ".local/gitbin".source = "${inputs.dotbin}";
  ".local/include".source = "${inputs.dotinc}";
  ".inputrc".source = "${inputs.dotconf}/.inputrc";
  ".mdformat.toml".text = ''
    wrap=80
    extensions=["gfm"]
  '';
}
