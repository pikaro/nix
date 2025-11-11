{
  sysInfo,
  utils,
  ...
} @ context: {
  home = {
    stateVersion = "24.11";
    homeDirectory = "/Users/${sysInfo.user}";
    sessionPath = [
      # WARNING: Gets added BEFORE ~/.zprofile / ~/.zshrc
    ];
    shellAliases = {
      fv = "source $HOME/.local/gitbin/_fv";
    };

    # FIXME: How to COPY files which MacOS requires to be physical files instead of symlinks?
    file = utils.imp.importDir ./files context;
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

  programs = utils.imp.dirToAttrs ./programs context;
}
