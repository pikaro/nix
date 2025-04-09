{
  sysInfo,
  inputs,
  utils,
  ...
} @ context: {
  home = {
    stateVersion = "24.11";
    homeDirectory = "/Users/${sysInfo.user}";
    sessionPath = [
      "$HOME/.bin"
      "$HOME/.local/bin"
      "$HOME/.local/gitbin"
    ];
    shellAliases = {
      fv = "source $HOME/.local/gitbin/_fv";
    };

    file = {
      ".config/kitty".source = "${inputs.kitty}";
      ".config/nvim".source = "${inputs.nvim}";
      ".local/gitbin".source = "${inputs.dotbin}";
      ".local/include".source = "${inputs.dotinc}";
      ".inputrc".source = "${inputs.dotconf}/.inputrc";
      "Library/Keyboard Layouts/USCustom.keylayout".source = "${inputs.keyboard}/USCustom.keylayout";
      "Library/Keyboard Layouts/USCustom.icns".source = "${inputs.keyboard}/USCustom.icns";
    };
  };

  xdg = {
    configFile = {
      "nixpkgs/config.nix".text = ''
        {
          allowUnfree = true;
          allowUnfreePredicate = pkg: true;
        }
      '';
    };
  };

  programs = utils.dirToAttrs ./programs context;
}
